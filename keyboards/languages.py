from aiogram.types import (
    KeyboardButton,
    ReplyKeyboardMarkup,
    ReplyKeyboardRemove,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)

from db.db import Book, User, DB_Books, DB_Users


# Формирование инлайн клавиатуры для выбора книг
def get_inline_btns_languages(user: User) -> InlineKeyboardMarkup:
    # Создаем объекты инлайн-кнопок
    lst = []
    text = f"{user.lexicon.lexicon['select'] if user.language == 'RU' else ''} {user.lexicon.lexicon['ru']}"
    lst.append([InlineKeyboardButton(text=text, callback_data="select_language=RU")])

    text  = f"{user.lexicon.lexicon['select'] if user.language == 'EN' else ''} {user.lexicon.lexicon['en']}"
    lst.append([InlineKeyboardButton(text=text, callback_data="select_language=EN")])

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
