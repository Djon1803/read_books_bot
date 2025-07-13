from aiogram import Router, F
from aiogram.filters import Command, CommandStart
from aiogram.types import Message, CallbackQuery

import logging

logger = logging.getLogger(__name__)

from keyboards.languages import get_inline_btns_languages

from db.db import Book, DB_Books, User, DB_Users

from config_data.config import Config, load_config

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на команду "/start" -
# добавлять пользователя в базу данных
# и отправлять ему приветственное сообщение
@router.message(CommandStart())
async def process_start_command(message: Message, user: User):
    await message.answer(text=user.lexicon.lexicon["/start"])


# Этот хэндлер будет срабатывать на команду "/help"
# и отправлять пользователю сообщение со списком доступных команд в боте
@router.message(Command(commands="help"))
async def process_help_command(message: Message, user: User):
    await message.answer(text=user.lexicon.lexicon["/help"])


# Этот хэндлер будет срабатывать на команду "/save"
# и сохранять базы данных в json файлы
@router.message(Command(commands="save"))
async def process_save_command(
    message: Message, user: User, books: DB_Books, users: DB_Users
):
    if user.admin:
        users.save()
        books.save()
        await message.answer(text=user.lexicon.lexicon["save_data"])
    else:
        await message.answer(text="Нет доступа")


# Этот хэндлер будет срабатывать на команду "/language"
# и показывать пользователю список локализаций
@router.message(Command(commands="language"))
async def process_language_command(message: Message, user: User):
    text = user.lexicon.lexicon["/language"]
    keyboards = get_inline_btns_languages(user)
    await message.answer(text=text, reply_markup=keyboards)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с языком из списка языков для выбора
@router.callback_query(lambda callback: callback.data.startswith("select_language="))
async def process_select_language(callback: CallbackQuery, user: User, users: DB_Users):
    language = callback.data.split("=")[1]

    if language == "EN":
        user.language = language
    else:
        user.language = "RU"

    users.save()

    text = user.lexicon.lexicon["/language"]
    keyboards = get_inline_btns_languages(user)
    await callback.answer()
    await callback.message.edit_text(text=text, reply_markup=keyboards)
