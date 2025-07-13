from aiogram import Router, F
from aiogram.types import Message, CallbackQuery

from db.db import User

import logging

logger = logging.getLogger(__name__)

# Инициализируем роутер уровня модуля
router = Router()


@router.message()
async def handle_other_message(message: Message, user: User):
    text = user.lexicon.lexicon["unknown_command"]
    await message.answer(text=text)


# Вывод списка книг
@router.callback_query(F.data.in_(["cancel"]))
async def process_cancel(callback: CallbackQuery, user: User):
    await callback.answer()
    await callback.message.edit_text(text=user.lexicon.lexicon["cancel_text"])


# Ловит все остальные callback
@router.callback_query()
async def handle_other_callback(callback: CallbackQuery):
    logger.info("Unknown command message: %s", callback.data)
