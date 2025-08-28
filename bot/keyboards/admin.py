from aiogram.types import (
    KeyboardButton,
    ReplyKeyboardMarkup,
    ReplyKeyboardRemove,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from bot.callback_factory.book import (
    DelBookCallbackFactory,
    LoadBookCallbackFactory,
    SelectBookCallbackFactory,
)

from bot.callback_factory.admin import (
    AdminEditUserCallbackFactory,
    SetWisdomCallbackFactory,
    SetlanguageCallbackFactory,
)

from db.db import User


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_admin_tools(user: User, lexicon: dict) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = []

    lst.append(
        [
            InlineKeyboardButton(
                text=f'{lexicon["edit"]} {lexicon["admin_users"]}',
                callback_data="admin_users",
            )
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_users(users: list[User]) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = []

    for user in users:
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
def get_inline_btns_admin_edit_user(
    admin: User, user: User, lexicon: dict
) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = []

    key = None
    if user.enable_wisdom:
        key = "select"
    else:
        key = "not_selected"

    lst.append(
        [
            InlineKeyboardButton(
                text=f"{lexicon[key]} Мудрость дня",
                callback_data=SetWisdomCallbackFactory(
                    user_id=user.id, value=not user.enable_wisdom
                ).pack(),
            )
        ]
    )

    value = None
    if user.language == "ru":
        value = "en"
    else:
        value = "r"

    key = None
    if user.language == "RU":
        key = "ru"
    else:
        key = "en"

    lst.append(
        [
            InlineKeyboardButton(
                text=f"{lexicon[key]}",
                callback_data=SetlanguageCallbackFactory(
                    user_id=user.id, value=value
                ).pack(),
            )
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*lst])
    return keyboard
