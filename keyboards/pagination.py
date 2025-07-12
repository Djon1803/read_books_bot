from aiogram.types import (
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import Book, User


# формирование инлайн клавиатуры для чтения книг
def get_inline_read_book(user: User, book: Book, index: int) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btn_back = InlineKeyboardButton(
        text=user.lexicon.lexicon["page_back"], callback_data="page_back"
    )
    btn_middle = InlineKeyboardButton(
        text=str(index) + "/" + str(book.count_pages), callback_data="page_add_mark"
    )
    btn_next = InlineKeyboardButton(
        text=user.lexicon.lexicon["page_next"], callback_data="page_next"
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[[btn_back, btn_middle, btn_next]])
    return keyboard
