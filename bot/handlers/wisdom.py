from aiogram import Bot, Router, F
from aiogram.filters import Command
from aiogram.types import (
    Message,
    CallbackQuery,
    ContentType,
    FSInputFile,
    ReplyKeyboardRemove,
)
from aiogram.exceptions import TelegramForbiddenError, TelegramBadRequest

import logging

logger = logging.getLogger(__name__)

from bot.keyboards.wisdom import get_inline_btns_wisdom

from db.db import User, UserDAO, BookDAO, Book, Page, PageDAO
from asyncio import sleep

from os import remove
from os.path import exists, abspath

from bot.services.book import prepare_text, get_part_text


from config.config import Config, load_config

import datetime

from psycopg_pool import AsyncConnectionPool
from psycopg import AsyncConnection

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на команду "/wisdom"
# и отправлять пользователю первую страницу книги с кнопками пагинации
@router.message(Command(commands="wisdom"))
async def process_beginning_command(
    message: Message,
    user: User,
    lexicon: dict[str, str],
    conn: AsyncConnection,
):
    keyboards = get_inline_btns_wisdom(user, lexicon)
    await message.answer(text=lexicon["wisdom"], reply_markup=keyboards)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для скачивания
@router.callback_query(lambda callback: callback.data.startswith("wisdom_false"))
async def process_load_book(
    callback: CallbackQuery,
    user: User,
    lexicon: dict[str, str],
    conn: AsyncConnection,
):
    user.enable_wisdom = False
    await UserDAO(conn).update(user)
    keyboards = get_inline_btns_wisdom(user)
    await callback.answer()
    await callback.message.edit_text(text=lexicon["wisdom"], reply_markup=keyboards)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для выбора
@router.callback_query(lambda callback: callback.data.startswith("wisdom_true"))
async def process_select_book(
    callback: CallbackQuery,
    user: User,
    lexicon: dict[str, str],
    conn: AsyncConnection,
):
    user.enable_wisdom = True
    keyboards = get_inline_btns_wisdom(user)
    await callback.answer()
    await callback.message.edit_text(text=lexicon["wisdom"], reply_markup=keyboards)


def seconds_until(hour: int, minute: int = 0, second: int = 0):
    now = datetime.datetime.now()
    target_time = now.replace(hour=hour, minute=minute, second=second, microsecond=0)

    # если целевое время уже прошло сегодня — переходим на завтра
    if target_time <= now:
        target_time += datetime.timedelta(days=1)

    delta = target_time - now
    return int(delta.total_seconds())



async def daily_notification_page(
    bot: Bot, db_pool: AsyncConnectionPool, time: list[int, int, int]
):
    if db_pool is None:
        logger.error("Database pool is not provided in middleware data.")
        raise RuntimeError("Missing db_pool in middleware context.")

    async with db_pool.connection() as connection:
        try:
            async with connection.transaction():
                    users: list[User] = await UserDAO(connection).get_all()
                    message_max_len = 4096
                    while True:
                        await sleep(seconds_until(*time))
                        for user in users:

                            await sleep(1)

                            if user.enable_wisdom:
                                book: Book = await BookDAO(connection).get_by_id(user.selected_wisdom)
                                if not book:
                                    continue

                                number_page = user.page_selected_wisdom
                                if number_page:
                                    number_page += 1
                                else:
                                    number_page = 1

                                if number_page == book.count_pages:
                                    number_page = None

                                page: Page = await PageDAO(connection).get_by_id(book.id, number_page)

                                photo_file = FSInputFile(path=abspath(page.photo))
                                text = page.text
                                first_text, len_text = get_part_text(text, 0, 1024)

                                try:
                                    await bot.send_photo(
                                        chat_id=user.user_id,
                                        photo=photo_file,
                                        caption=first_text,
                                        parse_mode="HTML",
                                    )
                                    if len(text) > 1024:
                                        text = text[len_text:]
                                        pages = prepare_text(text, message_max_len)
                                        for i in pages:
                                            await bot.send_message(
                                                chat_id=user.id, text=pages[i], parse_mode="HTML"
                                            )

                                    user.page_selected_wisdom = number_page

                                except TelegramForbiddenError:
                                    # Пользователь заблокировал бота или запретил сообщения
                                    user.enable_wisdom = False
                                    logging.warning(f"Bot blocked by user {user.id}. Wisdom disabled.")

                                except TelegramBadRequest as e:
                                    # Например, чат не найден
                                    logging.error(f"Failed to send message to {user.id}: {e}")
                                    user.enable_wisdom = False

                                except Exception as e:
                                    # Любые другие непредвиденные ошибки
                                    logging.exception(
                                        f"Unexpected error sending wisdom to {user.id}: {e}"
                                    )

                            await UserDAO(connection).update(user)
        except Exception as e:
            logger.exception("Transaction rolled back due to error: %s", e)
            raise


