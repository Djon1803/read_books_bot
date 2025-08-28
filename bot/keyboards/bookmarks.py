from aiogram.types import (
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import User, Book, Mark, MarkDAO, Page, PageDAO

from bot.callback_factory.mark import DelMarkCallbackFactory, ShowMarkCallbackFactory
from psycopg import AsyncConnection


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_marks(
    user: User,
    books: list[Book],
    marks: list[Mark],
    lexicon: dict[str, str],
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btns = []
    for mark in marks:
        book: Book = None
        for b in books:
            if b.id == mark.book_id:
                book = b
                break

        if book:
            temp = [
                InlineKeyboardButton(
                    text=f"{book.name} - стр.: {mark.number_page}",
                    callback_data=ShowMarkCallbackFactory(
                        book_id=mark.book_id, number_page=mark.number_page
                    ).pack(),
                )
            ]
            btns.append(temp)

    btns.append(
        [
            InlineKeyboardButton(
                text=lexicon["edit_button"],
                callback_data="edit_marks",
            ),
            InlineKeyboardButton(
                text=lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*btns])
    return keyboard


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_del_marks(
    user: User,
    books: list[Book],
    marks: list[Mark],
    lexicon: dict[str, str],
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок

    btns = []
    for mark in marks:
        book: Book = None
        for b in books:
            if b.id == mark.book_id:
                book = b
                break

        if book:
            temp = [
                InlineKeyboardButton(
                    text=f'{lexicon["del"]} {book.name} - стр.:  {mark.number_page}',
                    callback_data=DelMarkCallbackFactory(
                        book_id=mark.book_id, number_page=mark.number_page
                    ).pack(),
                )
            ]
            btns.append(temp)

    btns.append(
        [
            InlineKeyboardButton(
                text=lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*btns])
    return keyboard
