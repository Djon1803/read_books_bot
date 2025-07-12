from aiogram import Router, F
from aiogram.types import Message, CallbackQuery

from db.db import Book, DB_Books, User, DB_Users
from services.services import get_user

# Инициализируем роутер уровня модуля
router = Router()


@router.message()
async def handle_other_message(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
    text = user.lexicon.lexicon['unknown_command']
    await message.answer(text=text)


# Вывод списка книг
@router.callback_query(F.data.in_(["cancel"]))
async def process_cancel(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)
    await callback.answer()
    await callback.message.edit_text(text=user.lexicon.lexicon['cancel_text'])


# Ловит все остальные callback
@router.callback_query()
async def handle_other_callback(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    print(callback.data)