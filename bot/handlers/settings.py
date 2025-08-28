import logging
from contextlib import suppress

from aiogram import Bot, F, Router
from aiogram.enums import BotCommandScopeType
from aiogram.exceptions import TelegramBadRequest
from aiogram.filters import Command, CommandStart, StateFilter
from aiogram.fsm.context import FSMContext
from aiogram.types import BotCommandScopeChat, CallbackQuery, Message
from bot.filters.filters import LocaleFilter
from bot.keyboards.languages import get_lang_settings_kb
from bot.keyboards.menu_button import get_main_menu_commands
from bot.states.states import LangSG
from db.db import User, UserDAO
from psycopg import AsyncConnection

logger = logging.getLogger(__name__)

router = Router()


# Этот хэндлер будет срабатывать на любые сообщения, кроме команды /start, в состоянии `LangSG.lang`
@router.message(StateFilter(LangSG.lang), ~CommandStart())
async def process_any_message_when_lang(
    message: Message,
    bot: Bot,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
    user: User,
):
    user_id = message.from_user.id
    data = await state.get_data()
    user_lang = data.get("user_lang")

    with suppress(TelegramBadRequest):
        msg_id = data.get("lang_settings_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)

    msg = await message.answer(
        text=lexicon.get("/lang"),
        reply_markup=get_lang_settings_kb(
            lexicon=lexicon, locales=locales, checked=user_lang
        ),
    )

    await state.update_data(lang_settings_msg_id=msg.message_id)


# Этот хэндлер будет срабатывать на команду /lang
@router.message(Command(commands="language"))
async def process_lang_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
    user: User,
):
    await state.set_state(LangSG.lang)
    user_lang = user.language

    msg = await message.answer(
        text=lexicon.get("/language"),
        reply_markup=get_lang_settings_kb(
            lexicon=lexicon, locales=locales, checked=user_lang
        ),
    )

    await state.update_data(lang_settings_msg_id=msg.message_id, user_lang=user_lang)


# Этот хэндлер будет срабатывать на нажатие кнопки "Сохранить" в режиме настроек языка
@router.callback_query(F.data == "save_lang_button_data")
async def process_save_click(
    callback: CallbackQuery,
    bot: Bot,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    data = await state.get_data()
    user.language = data.get("user_lang")
    await UserDAO(conn=conn).update(user)
    await callback.message.edit_text(text=lexicon.get("lang_saved"))

    user_role = user.role
    await bot.set_my_commands(
        commands=get_main_menu_commands(lexicon=lexicon, role=user_role),
        scope=BotCommandScopeChat(
            type=BotCommandScopeType.CHAT, chat_id=callback.from_user.id
        ),
    )
    await state.update_data(lang_settings_msg_id=None, user_lang=None)
    await state.set_state()


# Этот хэнлер будет срабатывать на нажатие кнопки "Отмена" в режиме настроек языка
@router.callback_query(F.data == "cancel_lang_button_data")
async def process_cancel_click(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    user_lang = user.language
    await callback.message.edit_text(
        text=lexicon.get("lang_cancelled").format(lexicon.get(user_lang))
    )
    await state.update_data(lang_settings_msg_id=None, user_lang=None)
    await state.set_state()


# Этот хэндлер будет срабатывать на нажатие любой радио-кнопки с локалью
# в режиме настроек языка интерфейса
@router.callback_query(LocaleFilter())
async def process_lang_click(
    callback: CallbackQuery, lexicon: dict[str, str], locales: list[str], user: User
):
    try:
        await callback.message.edit_text(
            text=lexicon.get("/lang"),
            reply_markup=get_lang_settings_kb(
                lexicon=lexicon, locales=locales, checked=callback.data
            ),
        )
    except TelegramBadRequest:
        await callback.answer()
