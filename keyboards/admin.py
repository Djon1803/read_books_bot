from aiogram.types import (
    KeyboardButton,
    ReplyKeyboardMarkup,
    ReplyKeyboardRemove,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from callback_factory.book import (
    DelBookCallbackFactory,
    LoadBookCallbackFactory,
    SelectBookCallbackFactory,
)

from callback_factory.admin import (
    AdminEditUserCallbackFactory,
    SetWisdomCallbackFactory,
    SetlanguageCallbackFactory,
)

from db.db import Book, DB_Books, User, DB_Users


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_admin_tools(user: User) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = []

    lst.append(
        [
            InlineKeyboardButton(
                text=f'{user.lexicon.lexicon["edit"]} {user.lexicon.lexicon["admin_users"]}',
                callback_data="admin_users",
            )
        ]
    )

    # lst.append(
    #     [
    #         InlineKeyboardButton(
    #             text=f'{user.lexicon.lexicon["edit"]} {user.lexicon.lexicon["admin_books"]}',
    #             callback_data="admin_books",
    #         )
    #     ]
    # )

    # lst.append(
    #     [
    #         InlineKeyboardButton(
    #             text=f'{user.lexicon.lexicon["edit"]} {user.lexicon.lexicon["admin_wisdoms"]}',
    #             callback_data="admin_wisdoms",
    #         )
    #     ]
    # )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_users(users: DB_Users) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = []

    for user in users.users:
        lst.append(
            [
                InlineKeyboardButton(
                    text=f"{user.username}, id: {user.id}",
                    callback_data=AdminEditUserCallbackFactory(user_id=user.id).pack(),
                )
            ]
        )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_admin_edit_user(admin: User, user: User) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = []

    key = None
    if user.book_wisdom:
        key = "select"
    else:
        key = "not_selected"

    lst.append(
        [
            InlineKeyboardButton(
                text=f"{admin.lexicon.lexicon[key]} Мудрость дня",
                callback_data=SetWisdomCallbackFactory(
                    user_id=user.id, value=not user.book_wisdom
                ).pack(),
            )
        ]
    )

    value = None
    if user.language == "RU":
        value = "EN"
    else:
        value = "RU"

    key = None
    if user.language == "RU":
        key = "ru"
    else:
        key = "en"

    lst.append(
        [
            InlineKeyboardButton(
                text=f"{admin.lexicon.lexicon[key]}",
                callback_data=SetlanguageCallbackFactory(
                    user_id=user.id, value=value
                ).pack(),
            )
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard
