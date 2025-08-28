from aiogram import Router, F
from aiogram.filters import Command, CommandStart, CommandObject
from aiogram.types import Message, CallbackQuery

import logging

logger = logging.getLogger(__name__)

from bot.keyboards.admin import (
    get_inline_btns_admin_tools,
    get_inline_btns_users,
    get_inline_btns_admin_edit_user,
)
from bot.callback_factory.admin import (
    AdminEditUserCallbackFactory,
    SetWisdomCallbackFactory,
    SetlanguageCallbackFactory,
)

from psycopg import AsyncConnection
from aiogram.fsm.context import FSMContext

from db.db import User, UserDAO, Book, BookDAO, ActivityDAO

from config.config import Config, load_config

from bot.filters.filters import UserRoleFilter
from bot.enums.roles import UserRole

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()

router.message.filter(UserRoleFilter(UserRole.ADMIN))


# Этот хэндлер будет срабатывать на команду /help для пользователя с ролью `UserRole.ADMIN`
@router.message(Command("help"))
async def process_admin_help_command(message: Message, lexicon: dict):
    await message.answer(text=lexicon.get("/help"))


@router.message(Command(commands="users"))
async def process_save_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    users: list[User] = await UserDAO(conn=conn).get_all()
    text_users = []
    for u in users:
        book_name = None
        book_page = None
        if user.selected_book:
            book: Book = await BookDAO(conn=conn).get_by_id(user.selected_book)
            if book:
                book_name = book.name
                book_page = user.page_selected_book

        book_wisdom_name = None
        book_wisdom_page = None
        if user.selected_wisdom:
            book: Book = await BookDAO(conn=conn).get_by_id(user.selected_wisdom)
            if book:
                book_name = book.name
                book_page = user.page_selected_wisdom

        temp = f"""имя: {'@' + u.username if u.username else u.username }
id: {u.user_id}
забанен: {u.banned}
читает книгу: {book_name}
номер стр.: {book_page}
Мудрость дня: {u.enable_wisdom}
Книга мудрости дня: {book_wisdom_name}
номер стр.: {book_wisdom_page}
время отправки: MSK {u.time_send_wisdom}
язык: {u.language}"""
        text_users.append(temp)

    BATCH_SIZE = 15
    for i in range(0, len(text_users), BATCH_SIZE):
        batch = text_users[i : i + BATCH_SIZE]
        await message.answer(text="\n\n".join(batch))


# Этот хэндлер будет срабатывать на команду "/save"
# и сохранять базы данных в json файлы
@router.message(Command(commands="admin"))
async def process_save_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    await message.answer(
        text=f"Привет {user.username}",
        reply_markup=get_inline_btns_admin_tools(user),
    )


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для выбора
@router.callback_query(lambda callback: callback.data.startswith("admin_users"))
async def process_select_book(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    users: list[User] = await UserDAO(conn=conn).get_all()
    keyboards = get_inline_btns_users(users=users)
    await callback.answer()
    await callback.message.edit_text(text="Пользователи: ", reply_markup=keyboards)


@router.callback_query(AdminEditUserCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
    callback_data: AdminEditUserCallbackFactory,
):
    show_user: User = await UserDAO(conn=conn).get_by_id(callback_data.user_id)
    await callback.answer()
    await callback.message.answer(
        text=show_user.username,
        reply_markup=get_inline_btns_admin_edit_user(admin=user, user=show_user),
    )


@router.callback_query(SetWisdomCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
    callback_data: SetWisdomCallbackFactory,
):
    show_user: User = await UserDAO(conn=conn).get_by_id(callback_data.user_id)
    show_user.enable_wisdom = callback_data.value
    await callback.answer()
    await callback.message.edit_text(
        text=show_user.username,
        reply_markup=get_inline_btns_admin_edit_user(admin=user, user=show_user),
    )


@router.callback_query(SetlanguageCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
    callback_data: SetlanguageCallbackFactory,
):
    show_user: User = await UserDAO(conn=conn).get_by_id(callback_data.user_id)
    show_user.language = callback_data.value
    await callback.answer()
    await callback.message.edit_text(
        text=show_user.username,
        reply_markup=get_inline_btns_admin_edit_user(admin=user, user=show_user),
    )


# Этот хэндлер будет срабатывать на команду /statistics для пользователя с ролью `UserRole.ADMIN`
@router.message(Command("statistics"))
async def process_admin_statistics_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
):
    statistics = await ActivityDAO(conn=conn).get_statistics()
    await message.answer(
        text=lexicon.get("statistics").format(
            "\n".join(
                f"{i}. <b>{stat[0]}</b>: {stat[1]}"
                for i, stat in enumerate(statistics, 1)
            )
        )
    )


# Этот хэндлер будет срабатывать на команду /ban для пользователя с ролью `UserRole.ADMIN`
@router.message(Command("ban"))
async def process_ban_command(
    message: Message,
    command: CommandObject,
    conn: AsyncConnection,
    lexicon: dict[str, str],
) -> None:
    args = command.args

    if not args:
        await message.reply(lexicon.get("empty_ban_answer"))
        return

    arg_user = args.split()[0].strip()

    user: User = None
    if arg_user.isdigit():
        user: User = await UserDAO(conn).get_by_id(int(arg_user))
    elif arg_user.startswith("@"):
        user: User = await UserDAO(conn).get_by_username(int(arg_user[1:]))
    else:
        await message.reply(text=lexicon.get("incorrect_ban_arg"))
        return

    banned_status = user.banned

    if banned_status is None:
        await message.reply(lexicon.get("no_user"))
    elif banned_status:
        await message.reply(lexicon.get("already_banned"))
    else:
        user.banned = True
        await UserDAO(conn).update(user)
        await message.reply(text=lexicon.get("successfully_banned"))


# Этот хэндлер будет срабатывать на команду /unban для пользователя с ролью `UserRole.ADMIN`
@router.message(Command("unban"))
async def process_unban_command(
    message: Message,
    command: CommandObject,
    conn: AsyncConnection,
    lexicon: dict[str, str],
) -> None:
    args = command.args

    if not args:
        await message.reply(lexicon.get("empty_unban_answer"))
        return

    arg_user = args.split()[0].strip()

    user: User = None
    if arg_user.isdigit():
        user: User = await UserDAO(conn).get_by_id(int(arg_user))
    elif arg_user.startswith("@"):
        user: User = await UserDAO(conn).get_by_username(int(arg_user[1:]))
    else:
        await message.reply(text=lexicon.get("incorrect_unban_arg"))
        return

    banned_status = user.banned

    if banned_status is None:
        await message.reply(lexicon.get("no_user"))
    elif banned_status:
        user.banned = False
        await UserDAO(conn).update(user)
        await message.reply(text=lexicon.get("successfully_unbanned"))
    else:
        await message.reply(lexicon.get("not_banned"))
