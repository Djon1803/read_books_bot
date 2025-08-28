import logging
from typing import Any, Awaitable, Callable

from aiogram import BaseMiddleware
from aiogram.fsm.context import FSMContext
from aiogram.types import TelegramObject, Update, User

from db.db import User as User_bd

from psycopg import AsyncConnection
logger = logging.getLogger(__name__)




class LangSettingsMiddleware(BaseMiddleware):
    async def __call__(
        self,
        handler: Callable[[TelegramObject, dict[str, Any]], Awaitable[Any]],
        event: Update,
        data: dict[str, Any],
    ) -> Any:
        user: User = data.get("event_from_user")
        if user is None:
            return await handler(event, data)
        
        if event.callback_query is None:
            return await handler(event,  data)
        
        locales: list[str] = data.get('locales')

        state: FSMContext = data.get('state')
        user_context_data: dict = await state.get_data()

        if event.callback_query.data == "cancel_lang_button_data":
            user_context_data.update(user_lang=None)
            await state.set_data(user_context_data)

        elif event.callback_query.data in locales and event.callback_query.data != user_context_data.get('user_lang'):
            user_context_data.update(user_lang=event.callback_query.data)
            await state.set_data(user_context_data)

        return await handler(event, data)




class TranslatorMiddleware(BaseMiddleware):
    async def __call__(
        self,
        handler: Callable[[TelegramObject, dict[str, Any]], Awaitable[Any]],
        event: TelegramObject,
        data: dict[str, Any],
    ) -> Any:
        user: User = data.get("event_from_user")

        if user is None:
            return await handler(event, data)
        state: FSMContext = data.get('state')
        user_context_data = await state.get_data()
        if (user_lang := user_context_data.get('user_lang')) is None:
            
            conn: AsyncConnection = data.get("conn")
            if conn is None:
                logger.error("Database connection not found in middleware data.")
                raise RuntimeError("Missing database connection for detecting the user's language.")
            user_db : User_bd = data.get('user')
            user_lang: str | None = user_db.language
            if user_lang is None:
                user_lang = user.language_code
        translations: dict = data.get("translations")
        lexicon: dict = translations.get(user_lang)
        if lexicon is None:
            data["lexicon"] = translations[translations["default"]]
        else:
            data["lexicon"] = lexicon
        return await handler(event, data)