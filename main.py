import asyncio
import logging

from aiogram import Bot, Dispatcher
from config_data.config import Config, load_config
from handlers import other, user_handlers
from keyboards.menu_commands import set_main_menu
from db.db import DB_Books, DB_Users
# Инициализируем логгер
logger = logging.getLogger(__name__)

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

    # Сохраняем готовую книгу и "базу данных" в `workflow_data`
    dp.workflow_data.update(books=books, users=users)

    # Настраеваем кнопку Menu старт
    await set_main_menu(bot)

    # Регистриуем роутеры в диспетчере
    dp.include_router(user_handlers.router)
    dp.include_router(other.router)

    # Пропускаем накопившиеся апдейты и запускаем polling
    await bot.delete_webhook(drop_pending_updates=True)
    await dp.start_polling(bot)


if __name__ == '__main__':
    asyncio.run(main())
