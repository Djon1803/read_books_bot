from aiogram.filters import BaseFilter
from aiogram.types import Message

from db.db import User


class IsAddBookInputName(BaseFilter):
    async def __call__(self, message: Message, user: User) -> bool:
        return hasattr(user, "add_book") and user.add_book.get("name", None) == None


class IsAddBookInputAuthor(BaseFilter):
    async def __call__(self, message: Message, user: User) -> bool:
        return (
            hasattr(user, "add_book")
            and user.add_book.get("name", None) != None
            and user.add_book.get("author", None) == None
        )


class IsAddBookInputAccess(BaseFilter):
    async def __call__(self, message: Message, user: User) -> bool:
        return (
            hasattr(user, "add_book")
            and user.add_book.get("name", None) != None
            and user.add_book.get("author", None) != None
            and user.add_book.get("access", None) == None
        )


class IsCancelAddBook(BaseFilter):
    async def __call__(self, message: Message, user: User) -> bool:
        return message.text == user.lexicon.lexicon["cancel_add_book_button"]
