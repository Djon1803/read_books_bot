from aiogram import Bot, Router, F
from aiogram.filters import Command
from aiogram.types import (
    Message,
    CallbackQuery,
    ContentType,
    FSInputFile,
    ReplyKeyboardRemove,
)

import logging

logger = logging.getLogger(__name__)

from keyboards.wisdom import get_inline_btns_wisdom

from db.db import DB_Books, DB_Users, User
from wisdoms.wisdom import DB_Wisdom, Page
from asyncio import sleep

from os import remove
from os.path import exists, abspath

from services.book import prepare_text, get_part_text


from config_data.config import Config, load_config

from random import randint

import datetime

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на команду "/wisdom"
# и отправлять пользователю первую страницу книги с кнопками пагинации
@router.message(Command(commands="wisdom"))
async def process_beginning_command(message: Message, user: User):
    keyboards = get_inline_btns_wisdom(user)
    await message.answer(text=user.lexicon.lexicon["wisdom"], reply_markup=keyboards)


@router.message(Command(commands="getwisdom"))
async def process_beginning_command(message: Message, user: User, maktub: DB_Wisdom):

    page = maktub.get_page(randint(1, 5))
    if page:
        photo_file = FSInputFile(path=abspath(page.photo))
        await message.answer_photo(photo=photo_file, caption=page.text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для скачивания
@router.callback_query(lambda callback: callback.data.startswith("wisdom_false"))
async def process_load_book(callback: CallbackQuery, user: User, books: DB_Books):
    user.book_wisdom = False
    keyboards = get_inline_btns_wisdom(user)
    await callback.answer()
    await callback.message.edit_text(
        text=user.lexicon.lexicon["wisdom"], reply_markup=keyboards
    )


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для выбора
@router.callback_query(lambda callback: callback.data.startswith("wisdom_true"))
async def process_select_book(
    callback: CallbackQuery, user: User, books: DB_Books, users: DB_Users
):
    user.book_wisdom = True
    keyboards = get_inline_btns_wisdom(user)
    await callback.answer()
    await callback.message.edit_text(
        text=user.lexicon.lexicon["wisdom"], reply_markup=keyboards
    )


def seconds_until(hour: int, minute: int = 0, second: int = 0):
    now = datetime.datetime.now()
    target_time = now.replace(hour=hour, minute=minute, second=second, microsecond=0)

    # если целевое время уже прошло сегодня — переходим на завтра
    if target_time <= now:
        target_time += datetime.timedelta(days=1)

    delta = target_time - now
    return int(delta.total_seconds())




async def daily_notification_page(bot: Bot, users: DB_Users, maktub: DB_Wisdom):
    message_max_len = 4096
    while True:
        await sleep(seconds_until(11, 0, 0))
        for user in users.users:
            await sleep(1)

            if user.book_wisdom:
                number_page = user.page_number_book_wisdom
                if number_page:
                    number_page += 1
                else:
                    number_page = 1

                page = maktub.get_page(number_page)

                if number_page == len(maktub.pages):
                    number_page = None

                user.page_number_book_wisdom = number_page

                photo_file = FSInputFile(path=abspath(page.photo))
                text = page.text
                first_text, len_text = get_part_text(text, 0, 1024)

                await bot.send_photo(
                    chat_id=user.id,
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
        users.save()
