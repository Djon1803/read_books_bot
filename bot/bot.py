import asyncio

import logging

import psycopg_pool
from aiogram import Bot, Dispatcher
from aiogram.client.default import DefaultBotProperties
from aiogram.enums import ParseMode
from aiogram.fsm.storage.memory import MemoryStorage

from bot.handlers.admin import router as admin_router
from bot.handlers.settings import router as settings_router
from bot.handlers.user import router as user_router
from bot.handlers.book import router as book_router
from bot.handlers.mark import router as mark_other
from bot.handlers.wisdom import router as wisdom_router, daily_notification_page
from bot.handlers.other import router as wisdom_other

from locales.translator import get_translations
from bot.middlewares.database import DataBaseMiddleware
from bot.middlewares.user import UserMiddleware
from bot.middlewares.language import TranslatorMiddleware, LangSettingsMiddleware
from bot.middlewares.shadow_ban import ShadowBanMiddleware
from bot.middlewares.statistics import ActivityCounterMiddleware
from db.connection import get_pg_pool
from config.config import Config
from redis.asyncio import Redis
from psycopg import AsyncConnection

logger = logging.getLogger(__name__)


async def on_startup(bot: Bot, conn: AsyncConnection, time: list[int, int, int]):
    # Создание
    asyncio.create_task(daily_notification_page(bot=bot, conn=conn, time=time))


# Функция конфигурирования и запуска бота
async def main(config: Config) -> None:
    logger.info("Starting bot...")
    # Инициализируем хранилище
    storage = MemoryStorage()

    # Инициализируем бот и диспетчер
    bot = Bot(
        token=config.bot.token,
        default=DefaultBotProperties(parse_mode=ParseMode.HTML),
    )
    dp = Dispatcher(storage=storage)

    # Создаём пул соединений с Postgres
    db_pool: psycopg_pool.AsyncConnectionPool = await get_pg_pool(
        db_name=config.db.name,
        host=config.db.host,
        port=config.db.port,
        user=config.db.user,
        password=config.db.password,
    )

    # Получаем словарь с переводами
    translations = get_translations()
    # формируем список локалей из ключей словаря с переводами
    locales = list(translations.keys())

    # Подключаем роутеры в нужном порядке
    logger.info("Including routers...")
    dp.include_routers(
        settings_router,
        admin_router,
        user_router,
        book_router,
        mark_other,
        wisdom_router,
        wisdom_other,
    )

    # Подключаем миддлвари в нужном порядке
    logger.info("Including middlewares...")
    dp.update.middleware(DataBaseMiddleware())
    dp.update.middleware(UserMiddleware())
    dp.update.middleware(ShadowBanMiddleware())
    dp.update.middleware(ActivityCounterMiddleware())
    dp.update.middleware(LangSettingsMiddleware())
    dp.update.middleware(TranslatorMiddleware())

    async with db_pool.connection() as connection:
        try:
            async with connection.transaction():
                await on_startup(bot=bot, conn=connection, time=[9, 0, 0])
        except Exception as e:
            logger.exception("Transaction rolled back due to error: %s", e)
            raise

    # Запускаем поллинг
    try:
        await dp.start_polling(
            bot,
            db_pool=db_pool,
            translations=translations,
            locales=locales,
            admin_ids=config.bot.admin_ids,
        )
    except Exception as e:
        logger.exception(e)
    finally:
        # Закрываем пул соединений
        await db_pool.close()
        logger.info("Connection to Postgres closed")
