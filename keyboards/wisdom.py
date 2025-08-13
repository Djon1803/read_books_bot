from aiogram.types import (
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import DB_Books, User


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_wisdom(user: User) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btns = []
    if user.book_wisdom:
        btns.append(
            [
                InlineKeyboardButton(
                    text=f"{user.lexicon.lexicon['select']} {user.lexicon.lexicon['maktub']}",
                    callback_data="wisdom_false",
                )
            ]
        )
    else:
        btns.append(
            [
                InlineKeyboardButton(
                    text=f"{user.lexicon.lexicon['not_selected']} {user.lexicon.lexicon['maktub']}",
                    callback_data="wisdom_true",
                )
            ]
        )

    btns.append(
        [
            InlineKeyboardButton(
                text=user.lexicon.lexicon["cancel"],
                callback_data="cancel",
            )
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*btns])
    return keyboard
