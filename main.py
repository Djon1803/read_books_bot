import asyncio
import logging

from aiogram import Bot, Dispatcher
from config_data.config import Config, load_config
from handlers import admin, user, book, mark, wisdom, other
from keyboards.menu_commands import set_main_menu
from db.db import DB_Books, DB_Users
from wisdoms.wisdom import DB_Wisdom, Page
from middlewares.user import UserMiddleware

# Инициализируем логгер
logger = logging.getLogger(__name__)


async def on_startup(bot: Bot, users, maktub):
    # Создание 
    asyncio.create_task(wisdom.daily_notification_page(bot, users=users, maktub=maktub))


# Функция конфигурирования и запуска бота
async def main() -> None:

    # Загружаем конфиг в переменную config
    config: Config = load_config()

    # Задаём базовую конфигурацию логирования
    logging.basicConfig(
        level=logging.getLevelName(level=config.log.level),
        format=config.log.format,
    )
    # Выводим в консоль информацию о начале запуска бота
    logger.info("Starting bot")

    # Инициализируем бот и диспетчер
    bot = Bot(token=config.tg_bot.token)
    dp = Dispatcher()

    # Подготавливаем базу данных
    logger.info("Preparing book")
    books = DB_Books(config.books_db)
    users = DB_Users(config.users_db)
    logger.info("Total books: %d", len(books.books))
    logger.info("Total users: %d", len(users.users))

    maktub = DB_Wisdom("wisdoms/Paulo Coelho Maktub/book.json")

    # Здесь будем регистрировать миддлвари
    dp.message.outer_middleware(UserMiddleware())
    dp.callback_query.outer_middleware(UserMiddleware())

    # Сохраняем готовую книгу и "базу данных" в `workflow_data`
    dp.workflow_data.update(books=books, users=users, maktub=maktub)

    # Настраеваем кнопку Menu старт
    await set_main_menu(bot)

    # Регистриуем роутеры в диспетчере
    dp.include_router(admin.router)
    dp.include_router(user.router)
    dp.include_router(book.router)
    dp.include_router(mark.router)
    dp.include_router(wisdom.router)
    dp.include_router(other.router)

    # Пропускаем накопившиеся апдейты и запускаем polling
    await bot.delete_webhook(drop_pending_updates=True)
    await on_startup(bot=bot, users=users, maktub=maktub)
    await dp.start_polling(bot)


if __name__ == "__main__":
    asyncio.run(main())
