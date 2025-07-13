from aiogram.types import Message
from db.db import Book, DB_Books, User, DB_Users

import logging

logger = logging.getLogger(__name__)


def get_user(user_id: int, username: str | None, books: DB_Books, users: DB_Users):
    user = users.get_user(user_id)
    if not user:
        book_id = books.books[0].id if books.books else None
        print(user_id, username, books.get_book(book_id).name)
        user = User(user_id, username, book_id, "RU", False, [], [], {str(book_id): 1})
        users.add(user)
        users.save()
        logger.info("New user: %s", user)
    return user
