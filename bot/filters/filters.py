from aiogram.filters import BaseFilter

from aiogram.types import CallbackQuery, Message
from psycopg import AsyncConnection

from bot.enums.roles import UserRole
from db.db import User


class LocaleFilter(BaseFilter):
    async def __call__(self, callback: CallbackQuery, locales: list):
        if not isinstance(callback, CallbackQuery):
            raise ValueError(
                f"LocaleFilter: expected `CallbackQuery`, got `{type(callback).__name__}`"
            )
        return callback.data in locales


class UserRoleFilter(BaseFilter):
    def __init__(self, *roles: str | UserRole):
        if not roles:
            raise ValueError("At least one role must be provided to UserRoleFilter.")

        self.roles = frozenset(
            UserRole(role) if isinstance(role, str) else role
            for role in roles
            if isinstance(role, (str, UserRole))
        )

        if not self.roles:
            raise ValueError("No valid roles provided to `UserRoleFilter`.")

    async def __call__(self, event: Message | CallbackQuery, user: User) -> bool:
        user_tg = event.from_user
        if not user_tg:
            return False

        role = user.role
        if role is None:
            return False

        return role in self.roles