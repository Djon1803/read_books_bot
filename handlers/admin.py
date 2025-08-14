from aiogram import Router, F
from aiogram.filters import Command, CommandStart
from aiogram.types import Message, CallbackQuery

import logging

logger = logging.getLogger(__name__)

from keyboards.admin import (
    get_inline_btns_admin_tools,
    get_inline_btns_users,
    get_inline_btns_admin_edit_user,
)
from callback_factory.admin import (
    AdminEditUserCallbackFactory,
    SetWisdomCallbackFactory,
    SetlanguageCallbackFactory,
)
from db.db import Book, DB_Books, User, DB_Users

from config_data.config import Config, load_config

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


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


# Этот хэндлер будет срабатывать на команду "/save"
# и сохранять базы данных в json файлы
@router.message(Command(commands="users"))
async def process_save_command(
    message: Message, user: User, books: DB_Books, users: DB_Users
):
    if user.admin:
        text_users = []
        for u in users.users:
            book_name = None
            book_page = None
            if u.id_select_book:
                book = books.get_book(u.id_select_book)
                if book:
                    book_name = book.name
                    book_page = user.reading.get(str(user.id_select_book), None)
            temp = f"имя: {u.username}\nid: {u.id}\nчитает книгу: {book_name}\nномер стр.: {book_page}\nМудрость дня: {u.book_wisdom} \nязык: {u.language}"
            text_users.append(temp)
        await message.answer(text=f"Пользователи:\n\n{'\n\n'.join(text_users)}")
    else:
        await message.answer(text="Нет доступа")


# Этот хэндлер будет срабатывать на команду "/save"
# и сохранять базы данных в json файлы
@router.message(Command(commands="admin"))
async def process_save_command(
    message: Message, user: User, books: DB_Books, users: DB_Users
):
    if user.admin:
        await message.answer(
            text=f"Привет {user.username}",
            reply_markup=get_inline_btns_admin_tools(user),
        )
    else:
        await message.answer(text="Нет доступа")


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для выбора
@router.callback_query(lambda callback: callback.data.startswith("admin_users"))
async def process_select_book(
    callback: CallbackQuery,
    user: User,
    users: DB_Users,
):
    keyboards = get_inline_btns_users(users=users)
    await callback.answer()
    await callback.message.edit_text(text="Пользователи: ", reply_markup=keyboards)


@router.callback_query(AdminEditUserCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    user: User,
    users: DB_Users,
    callback_data: AdminEditUserCallbackFactory,
):
    show_user = users.get_user(callback_data.user_id)
    await callback.answer()
    await callback.message.answer(
        text=show_user.username,
        reply_markup=get_inline_btns_admin_edit_user(admin=user, user=show_user),
    )


@router.callback_query(SetWisdomCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    user: User,
    users: DB_Users,
    callback_data: SetWisdomCallbackFactory,
):
    show_user = users.get_user(callback_data.user_id)
    show_user.book_wisdom = callback_data.value
    await callback.answer()
    await callback.message.edit_text(
        text=show_user.username,
        reply_markup=get_inline_btns_admin_edit_user(admin=user, user=show_user),
    )


@router.callback_query(SetlanguageCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    user: User,
    users: DB_Users,
    callback_data: SetlanguageCallbackFactory,
):
    show_user = users.get_user(callback_data.user_id)
    show_user.language = callback_data.value
    await callback.answer()
    await callback.message.edit_text(
        text=show_user.username,
        reply_markup=get_inline_btns_admin_edit_user(admin=user, user=show_user),
    )
