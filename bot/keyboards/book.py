from aiogram.types import (
    KeyboardButton,
    ReplyKeyboardMarkup,
    ReplyKeyboardRemove,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import Book, User
from bot.callback_factory.book import (
    DelBookCallbackFactory,
    LoadBookCallbackFactory,
    SelectBookCallbackFactory,
)


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_books(
    user: User,
    books: list[Book],
    lexicon: dict[str, str],
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = [
        [
            InlineKeyboardButton(
                text=book.name,
                callback_data=SelectBookCallbackFactory(id=book.id).pack(),
            )
        ]
        for book in books
    ]

    lst.append(
        [
            InlineKeyboardButton(
                text=lexicon["edit_button"], callback_data="edit_books"
            ),
            InlineKeyboardButton(
                text=lexicon["download_button"], callback_data="load_books"
            ),
        ]
    )

    lst.append(
        [
            InlineKeyboardButton(
                text=lexicon["cancel"],
                callback_data="cancel",
            ),
        ],
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_del_books(
    user: User,
    books: list[Book],
    lexicon: dict[str, str],
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = [
        [
            InlineKeyboardButton(
                text=f"{lexicon['del']} {book.name}",
                callback_data=DelBookCallbackFactory(id=book.id).pack(),
            ),
        ]
        for book in books
    ]
    lst.append(
        [
            InlineKeyboardButton(
                text=lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_load_books(
    user: User,
    books: list[Book],
    lexicon: dict[str, str],
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = [
        [
            InlineKeyboardButton(
                text=f"{lexicon['download']} {book.name}",
                callback_data=LoadBookCallbackFactory(id=book.id).pack(),
            ),
        ]
        for book in books
    ]
    lst.append(
        [
            InlineKeyboardButton(
                text=lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# формирование инлайн клавиатуры для чтения книг
def get_keyboard_close_addbook(
    lexicon: dict[str, str],
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок

    btn = InlineKeyboardButton(
        text=f"{lexicon["cancel"]}",
        callback_data="cancel_addbook_button_data",
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[[btn]])
    return keyboard


# формирование инлайн клавиатуры для чтения книг
def get_keyboard_input_access(
    lexicon: dict[str, str],
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btn_public = InlineKeyboardButton(
        text=lexicon["access_general_button"],
        callback_data="addbook_public",
    )
    btn_private = InlineKeyboardButton(
        text=lexicon["access_personal_button"],
        callback_data="addbook_private",
    )
    btn_cancel = InlineKeyboardButton(
        text=f"{lexicon["cancel"]}",
        callback_data="cancel_addbook_button_data",
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(
        inline_keyboard=[[btn_public, btn_private], [btn_cancel]]
    )
    return keyboard
