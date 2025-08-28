from aiogram.types import (
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import User


# Формирование инлайн клавиатуры для просмотра закладок
def get_inline_btns_wisdom(user: User, lexicon: dict[str:str]) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    btns = []
    if user.enable_wisdom:
        btns.append(
            [
                InlineKeyboardButton(
                    text=f"{lexicon['select']} {lexicon['maktub']}",
                    callback_data="wisdom_false",
                )
            ]
        )
    else:
        btns.append(
            [
                InlineKeyboardButton(
                    text=f"{lexicon['not_selected']} {lexicon['maktub']}",
                    callback_data="wisdom_true",
                )
            ]
        )

    btns.append(
        [
            InlineKeyboardButton(
                text=lexicon["cancel"],
                callback_data="cancel",
            )
        ]
    )

    # Создаем объект инлайн-клавиатуры
    keyboard = InlineKeyboardMarkup(inline_keyboard=[*btns])
    return keyboard
