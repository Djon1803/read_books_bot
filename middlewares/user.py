from typing import Any, Awaitable, Callable

from aiogram import BaseMiddleware
from aiogram.types import TelegramObject, User as AiUser
from services.services import get_user, User as MyUser, DB_Books, DB_Users


class UserMiddleware(BaseMiddleware):
    async def __call__(
        self,
        handler: Callable[[TelegramObject, dict[str, Any]], Awaitable[Any]],
        event: TelegramObject,
        data: dict[str, Any],
    ) -> Any:
        io_user: AiUser = event.from_user
        user_id: int = io_user.id
        username: str | None = io_user.username
        users: DB_Users = data["users"]
        books: DB_Books = data["books"]
        my_user: MyUser = get_user(user_id, username, books, users)
        data["user"] = my_user

        return await handler(event, data)
