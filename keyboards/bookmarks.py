from aiogram.types import (
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import DB_Books, User


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_marks(
    user: User, books: DB_Books, marks: list[dict]
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btns = []
    for i, mark in enumerate(marks):
        book = books.get_book(mark["book_id"])
        if book:
            temp = [
                InlineKeyboardButton(
                    text=f'{book.name} [{mark["number_page"]}] - {book.get_page(mark["number_page"])[:100]}',
                    callback_data=f'show_page:book_id={mark["book_id"]}&number_page={mark["number_page"]}',
                )
            ]
            btns.append(temp)
        else:
            del marks[i]
    btns.append(
        [
            InlineKeyboardButton(
                text=user.lexicon.lexicon["edit_button"],
                callback_data="edit_marks",
            ),
            InlineKeyboardButton(
                text=user.lexicon.lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*btns])
    return keyboard


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_del_marks(
    user: User, books: DB_Books, marks: list[dict]
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок

    btns = []
    for i, mark in enumerate(marks):
        book = books.get_book(mark["book_id"])
        if book:
            temp = [
                InlineKeyboardButton(
                    text=f'{user.lexicon.lexicon['del']} {book.name} [{mark["number_page"]}] - {book.get_page(mark["number_page"])[:100]}',
                    callback_data=f'del_mark:book_id={mark["book_id"]}&number_page={mark["number_page"]}',
                )
            ]
            btns.append(temp)
        else:
            del marks[i]

    btns.append(
        [
            InlineKeyboardButton(
                text=user.lexicon.lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*btns])
    return keyboard
