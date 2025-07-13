from aiogram import Router, F
from aiogram.filters import Command
from aiogram.types import Message, CallbackQuery

import logging

logger = logging.getLogger(__name__)


from keyboards.pagination import get_inline_read_book
from keyboards.bookmarks import get_inline_btns_marks, get_inline_btns_del_marks

from db.db import Book, DB_Books, User, DB_Users

from callback_factory.mark import DelMarkCallbackFactory, ShowMarkCallbackFactory

from config_data.config import Config, load_config

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с номером текущей страницы и добавлять текущую страницу в закладки
@router.callback_query(F.data.in_(["page_add_mark"]))
async def process_page_add_mark(callback: CallbackQuery, user: User, users: DB_Users):
    user.add_mark(user.id_select_book, user.reading[str(user.id_select_book)])
    users.save()
    await callback.answer(text=user.lexicon.lexicon["add_mark"])


# Этот хэндлер будет срабатывать на команду "/bookmarks"
# и отправлять пользователю список сохраненных закладок,
# если они есть или сообщение о том, что закладок нет
@router.message(Command(commands="bookmarks"))
async def process_bookmarks_command(message: Message, user: User, books: DB_Books):
    if user.marks:
        text = user.lexicon.lexicon["/bookmarks"]
        keyboards = get_inline_btns_marks(user, books, user.marks)
        await message.answer(text=text, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["no_bookmarks"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# "редактировать" под списком закладок
@router.callback_query(F.data.in_(["edit_marks"]))
async def process_edit_marks(callback: CallbackQuery, user: User, books: DB_Books):
    if user.marks:
        text = user.lexicon.lexicon["/bookmarks"]
        keyboards = get_inline_btns_del_marks(user, books, user.marks)
        await callback.message.edit_text(text=text, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["no_bookmarks"]
        await callback.message.edit_text(text=text)
        await callback.answer()


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с закладкой из списка закладок к удалению
@router.callback_query(DelMarkCallbackFactory.filter())
async def process_del_mark(
    callback: CallbackQuery,
    user: User,
    books: DB_Books,
    users: DB_Users,
    callback_data: DelMarkCallbackFactory,
):
    book_id = callback_data.book_id
    number_page = callback_data.number_page
    user.del_mark(book_id, number_page)
    users.save()

    if user.marks:
        keyboards = get_inline_btns_del_marks(user, books, user.marks)
        await callback.message.edit_text(
            text=user.lexicon.lexicon["/bookmarks"], reply_markup=keyboards
        )
    else:
        await callback.message.edit_text(text=user.lexicon.lexicon["no_bookmarks"])


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с закладкой из списка закладок для просмотра
@router.callback_query(ShowMarkCallbackFactory.filter())
async def process_show_page(
    callback: CallbackQuery,
    user: User,
    books: DB_Books,
    users: DB_Users,
    callback_data: ShowMarkCallbackFactory,
):
    book_id = callback_data.book_id
    number_page = callback_data.number_page
    book = books.get_book(book_id)
    if book:
        page = book.get_page(number_page)
        user.id_select_book = book_id
        user.reading[str(book_id)] = number_page
        users.save()
        keyboards = get_inline_read_book(user, book, number_page)
        await callback.message.answer(text=page, reply_markup=keyboards)
        await callback.answer()
    else:
        await callback.answer(text=user.lexicon.lexicon["del_book"])
