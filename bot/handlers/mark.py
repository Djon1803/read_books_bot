from aiogram import Router, F
from aiogram.filters import Command
from aiogram.types import Message, CallbackQuery

import logging

logger = logging.getLogger(__name__)


from bot.keyboards.pagination import get_inline_read_book
from bot.keyboards.bookmarks import get_inline_btns_marks, get_inline_btns_del_marks

from db.db import Book, User

from bot.callback_factory.mark import DelMarkCallbackFactory, ShowMarkCallbackFactory

from config.config import Config, load_config

from psycopg import AsyncConnection
from aiogram.fsm.context import FSMContext

from db.db import Page, PageDAO, Mark, MarkDAO, Book, BookDAO, User, UserDAO

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с номером текущей страницы и добавлять текущую страницу в закладки
@router.callback_query(F.data.in_(["page_add_mark"]))
async def process_page_add_mark(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    if user.selected_book and user.page_selected_book:
        mark: Mark = await MarkDAO(conn=conn).get(
            user.user_id, user.selected_book, user.page_selected_book
        )
        if mark:
            await callback.answer(text="Страница уже есть в закладках")
        else:
            mark = Mark(
                0, "", user.user_id, user.selected_book, user.page_selected_book
            )
            await MarkDAO(conn=conn).create(mark)
            await callback.answer(text=lexicon["add_mark"])


# Этот хэндлер будет срабатывать на команду "/bookmarks"
# и отправлять пользователю список сохраненных закладок,
# если они есть или сообщение о том, что закладок нет
@router.message(Command(commands="bookmarks"))
async def process_bookmarks_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    marks = await MarkDAO(conn).get_all(user.user_id)
    print(f"{marks=}")
    if marks:
        books: list[Book] = await BookDAO(conn).get_all()
        text = lexicon["/bookmarks"]
        keyboards = get_inline_btns_marks(user, books, marks, lexicon)
        await message.answer(text=text, reply_markup=keyboards)
    else:
        text = lexicon["no_bookmarks"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# "редактировать" под списком закладок
@router.callback_query(F.data.in_(["edit_marks"]))
async def process_edit_marks(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    marks = await MarkDAO(conn).get_all(user.user_id)
    if marks:
        books: list[Book] = await BookDAO(conn).get_all()
        text = lexicon["/bookmarks"]
        keyboards = get_inline_btns_del_marks(user, books, marks, lexicon)
        await callback.message.edit_text(text=text, reply_markup=keyboards)
    else:
        text = lexicon["no_bookmarks"]
        await callback.message.edit_text(text=text)
        await callback.answer()


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с закладкой из списка закладок к удалению
@router.callback_query(DelMarkCallbackFactory.filter())
async def process_del_mark(
    callback: CallbackQuery,
    callback_data: DelMarkCallbackFactory,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book_id = callback_data.book_id
    number_page = callback_data.number_page
    page: Page = await PageDAO(conn=conn).get_by_id(
        book_id_=book_id, number_=number_page
    )
    mark: Mark = await MarkDAO(conn).get(user.user_id, book_id, number_page)
    await MarkDAO(conn).delete(user.user_id, book_id, number_page)
    marks: list[Mark] = await MarkDAO(conn).get_all(user.user_id)
    if marks:
        books: list[Book] = await BookDAO(conn).get_all()
        keyboards = get_inline_btns_del_marks(user, books, marks, lexicon)
        await callback.message.edit_text(
            text=lexicon["/bookmarks"], reply_markup=keyboards
        )
    else:
        await callback.message.edit_text(text=lexicon["no_bookmarks"])


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с закладкой из списка закладок для просмотра
@router.callback_query(ShowMarkCallbackFactory.filter())
async def process_show_page(
    callback: CallbackQuery,
    callback_data: ShowMarkCallbackFactory,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book_id = callback_data.book_id
    number_page = callback_data.number_page
    book: Book = await BookDAO(conn).get_by_id(book_id)
    if book:
        page: Page = await PageDAO(conn).get_by_id(book_id, number_page)
        if page:
            user.selected_book = book_id
            user.page_selected_book = number_page
            await UserDAO(conn=conn).update(user)

            keyboards = get_inline_read_book(user, book, number_page, lexicon)
            await callback.message.answer(text=page.text, reply_markup=keyboards)
            await callback.answer()
        else:
            await callback.answer(text=lexicon["del_book"])
    else:
        await callback.answer(text=lexicon["del_book"])
