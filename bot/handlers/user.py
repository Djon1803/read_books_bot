from aiogram import Router, F
from aiogram.filters import Command, CommandStart
from aiogram.types import Message, CallbackQuery

import logging

logger = logging.getLogger(__name__)

from db.db import User

from config.config import Config, load_config

from psycopg import AsyncConnection
from aiogram.fsm.context import FSMContext

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на команду "/start" -
# добавлять пользователя в базу данных
# и отправлять ему приветственное сообщение
@router.message(CommandStart())
async def process_start_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    await message.answer(text=lexicon["/start"])


# Этот хэндлер будет срабатывать на команду "/help"
# и отправлять пользователю сообщение со списком доступных команд в боте
@router.message(Command(commands="help"))
async def process_help_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    await message.answer(text=lexicon["/help"])
