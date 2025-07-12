from aiogram.types import Message
from db.db import Book, DB_Books, User, DB_Users


# Внесение в базу и получение из базы пользователя
def get_user(message: Message, books: DB_Books, users: DB_Users):
    user_id = message.from_user.id
    username = message.from_user.username
    user = users.get_user(user_id)
    if not user:
        book_id = books.books[0].id if books.books else None
        print(user_id, username, books.get_book(book_id).name)
        user = User(user_id, username, book_id, 1, False, [], [], {book_id: 1})
        users.add(user)
    return user