from aiogram.filters import BaseFilter
from aiogram.types import CallbackQuery, Message

from services.services import get_user
from db.db import DB_Books, DB_Users, User


class IsAddBookInputName(BaseFilter):
    async def __call__(
        self, message: Message, books: DB_Books, users: DB_Users
    ) -> bool:
        user = get_user(message, books, users)
        return hasattr(user, "add_book") and user.add_book.get("name", None) == None


class IsAddBookInputAuthor(BaseFilter):
    async def __call__(
        self, message: Message, books: DB_Books, users: DB_Users
    ) -> bool:
        user = get_user(message, books, users)
        return (
            hasattr(user, "add_book")
            and user.add_book.get("name", None) != None
            and user.add_book.get("author", None) == None
        )


class IsAddBookInputAccess(BaseFilter):
    async def __call__(
        self, message: Message, books: DB_Books, users: DB_Users
    ) -> bool:
        user = get_user(message, books, users)
        return (
            hasattr(user, "add_book")
            and user.add_book.get("name", None) != None
            and user.add_book.get("author", None) != None
            and user.add_book.get("access", None) == None
        )


class IsCancelAddBook(BaseFilter):
    async def __call__(
        self, message: Message, books: DB_Books, users: DB_Users
    ) -> bool:
        user = get_user(message, books, users)
        return message.text == user.lexicon.lexicon["cancel_add_book_button"]
