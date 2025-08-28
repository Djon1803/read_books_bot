import logging
from typing import Any, Awaitable, Callable

from aiogram import BaseMiddleware
from aiogram.types import TelegramObject, Update, User
from db.db import User as User_db, UserDAO, Book, BookDAO
from psycopg import AsyncConnection

from config.config import Config, load_config

config: Config = load_config()

logger = logging.getLogger(__name__)


class UserMiddleware(BaseMiddleware):
    async def __call__(
        self,
        handler: Callable[[TelegramObject, dict[str, Any]], Awaitable[Any]],
        event: Update,
        data: dict[str, Any],
    ) -> Any:
        user: User = data.get("event_from_user")

        if user is None:
            return await handler(event, data)

        conn: AsyncConnection = data.get("conn")
        if conn is None:
            logger.error("Database connection not found in middleware data.")
            raise RuntimeError("Missing database connection for shadow ban check.")

        user_dao = UserDAO(conn=conn)
        user_db: User_db = await user_dao.get_by_id(user.id)
        if not user_db:
            book_dao = BookDAO(conn=conn)
            book: Book = await book_dao.get_by_name(config.default_book)

            book_id = None
            if book:
                book_id = book.id

            user_db = User_db(
                id=0,
                created_at="",
                user_id=user.id,
                username=user.username,
                selected_book=book_id,
            )
            user_db = await user_dao.create(user_db)

        data['user'] = user_db
        return await handler(event, data)
