from aiogram.types import (
    KeyboardButton,
    ReplyKeyboardMarkup,
    ReplyKeyboardRemove,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import Book, User, DB_Books, DB_Users


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_books(user: User, books: list[Book]) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = [
        [
            InlineKeyboardButton(
                text=book.name, callback_data="select_book=" + str(book.id)
            )
        ]
        for book in books
    ]

    lst.append(
        [
            InlineKeyboardButton(
                text=user.lexicon.lexicon["edit_button"], callback_data="edit_books"
            ),
            InlineKeyboardButton(
                text=user.lexicon.lexicon["download_button"], callback_data="load_books"
            ),
        ]
    )

    lst.append(
        [
            InlineKeyboardButton(
                text=user.lexicon.lexicon["cancel"],
                callback_data="cancel",
            ),
        ],
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_del_books(user: User, books: list[Book]) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = [
        [
            InlineKeyboardButton(
                text=f"{user.lexicon.lexicon['del']} {book.name}",
                callback_data=f"del_book={book.id}",
            ),
        ]
        for book in books
    ]
    lst.append(
        [
            InlineKeyboardButton(
                text=user.lexicon.lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_load_books(user: User, books: list[Book]) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = [
        [
            InlineKeyboardButton(
                text=f"{user.lexicon.lexicon['download']} {book.name}",
                callback_data=f"load_book={book.id}",
            ),
        ]
        for book in books
    ]
    lst.append(
        [
            InlineKeyboardButton(
                text=user.lexicon.lexicon["cancel"],
                callback_data="cancel",
            ),
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# формирование инлайн клавиатуры для чтения книг
def get_keyboard_close_addbook(
    user: User,
) -> ReplyKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btn = KeyboardButton(text=user.lexicon.lexicon['cancel_add_book_button'])

    # Создаем объект инлайн-клавиатуры
    keyboard = ReplyKeyboardMarkup(
        keyboard=[[btn]], resize_keyboard=True, one_time_keyboard=True
    )

    return keyboard


# формирование инлайн клавиатуры для чтения книг
def get_keyboard_input_access(
    user: User,
) -> ReplyKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btn_1 = KeyboardButton(text=user.lexicon.lexicon['access_general_button'])
    btn_2 = KeyboardButton(text=user.lexicon.lexicon['access_personal_button'])

    # Создаем объект инлайн-клавиатуры
    keyboard = ReplyKeyboardMarkup(
        keyboard=[[btn_1, btn_2]], resize_keyboard=True, one_time_keyboard=True
    )
    return keyboard
