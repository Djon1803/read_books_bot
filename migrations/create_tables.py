import asyncio
import logging
import os
import sys

from db.connection import get_pg_connection
from config.config import Config, load_config
from psycopg import AsyncConnection, Error


config: Config = load_config()

logging.basicConfig(
    level=logging.getLevelName(level=config.log.level),
    format=config.log.format,
)

logger = logging.getLogger(__name__)

if sys.platform.startswith("win") or os.name == "nt":
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())


async def main():
    connection: AsyncConnection | None = None

    try:
        connection = await get_pg_connection(
            db_name=config.db.name,
            host=config.db.host,
            port=config.db.port,
            user=config.db.user,
            password=config.db.password,
        )
        async with connection:
            async with connection.transaction():
                base_dir = os.path.dirname(__file__)
                sql_path = os.path.join(base_dir, "create_tables.sql")
                with open(sql_path, encoding="utf-8") as f:
                    sql = f.read()
                    await connection.execute(sql)
                logger.info("Tables `users` and `activity` and `books` and `pages_books` were successfully created")
    except Error as db_error:
        logger.exception("Database-specific error: %s", db_error)
    except Exception as e:
        logger.exception("Unhandled error: %s", e)
    finally:
        if connection:
            await connection.close()
            logger.info("Connection to Postgres closed")


asyncio.run(main())
