from aiogram import Bot, Router, F
from aiogram.filters import Command, StateFilter
from aiogram.types import (
    Message,
    CallbackQuery,
    ContentType,
    FSInputFile,
    ReplyKeyboardRemove,
)

import os
from contextlib import suppress
import logging
from aiogram.exceptions import TelegramBadRequest

logger = logging.getLogger(__name__)

from bot.keyboards.book import (
    get_inline_btns_books,
    get_inline_btns_load_books,
    get_inline_btns_del_books,
    get_keyboard_close_addbook,
    get_keyboard_input_access,
)

from bot.keyboards.pagination import get_inline_read_book

from db.db import Book, BookDAO, User, UserDAO, Page, PageDAO

from os import remove
from os.path import exists, abspath
import datetime

from bot.callback_factory.book import (
    DelBookCallbackFactory,
    LoadBookCallbackFactory,
    SelectBookCallbackFactory,
)

from psycopg import AsyncConnection
from aiogram.fsm.context import FSMContext

from bot.enums.access import AccessBook
from bot.states.states import AddBook

from config.config import Config, load_config

from bot.states.states import AddBook

from bot.services.book import prepare_book

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на команду "/beginning"
# и отправлять пользователю первую страницу книги с кнопками пагинации
@router.message(Command(commands="beginning"))
async def process_beginning_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book: Book = await BookDAO(conn=conn).get_by_id(user.selected_book)
    if book:
        index_page = 1
        user.page_selected_book = index_page
        await UserDAO(conn=conn).update(user)
        page: Page = await PageDAO(conn=conn).get_by_id(
            book_id_=book.id, number_=index_page
        )
        if page:
            keyboards = get_inline_read_book(user, book, index_page, lexicon)
            await message.answer(text=page.text, reply_markup=keyboards)
        else:
            text = lexicon["not_select_book"]
            await message.answer(text=text)
    else:
        text = lexicon["not_select_book"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки "назад"
# во время взаимодействия пользователя с сообщением-книгой
@router.callback_query(F.data.in_(["page_back"]))
async def process_page_back_press(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book: Book = await BookDAO(conn=conn).get_by_id(user.selected_book)
    this_index = user.page_selected_book
    if book:
        index_page = this_index
        if this_index > 1:
            index_page -= 1
            user.page_selected_book = index_page
            await UserDAO(conn=conn).update(user)
            page = await PageDAO(conn=conn).get_by_id(
                book_id_=book.id, number_=index_page
            )
            if page:
                keyboards = get_inline_read_book(user, book, index_page, lexicon)
                await callback.message.edit_text(text=page.text, reply_markup=keyboards)
            else:
                await callback.answer(text=lexicon["error_not_select_book"])
        else:
            await callback.answer(text=lexicon["first_page"])
    else:
        await callback.answer(text=lexicon["error_not_select_book"])


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки "вперёд"
# во время взаимодействия пользователя с сообщением-книгой
@router.callback_query(F.data.in_(["page_next"]))
async def process_page_next_press(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book: Book = await BookDAO(conn=conn).get_by_id(user.selected_book)
    this_index = user.page_selected_book
    if book:
        index_page = this_index
        if this_index < book.count_pages:
            index_page += 1
            user.page_selected_book = index_page
            await UserDAO(conn=conn).update(user)
            page = await PageDAO(conn=conn).get_by_id(
                book_id_=book.id, number_=index_page
            )
            if page:
                keyboards = get_inline_read_book(user, book, index_page, lexicon)
                await callback.message.edit_text(text=page.text, reply_markup=keyboards)
            else:
                await callback.answer(text=lexicon["error_not_select_book"])
        else:
            await callback.answer(text=lexicon["last_page"])
    else:
        await callback.answer(text=lexicon["error_not_select_book"])


# Этот хэндлер будет срабатывать на команду "/continue"
# и отправлять пользователю страницу книги, на которой пользователь
# остановился в процессе взаимодействия с ботом
@router.message(Command(commands="continue"))
async def process_continue_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book: Book = await BookDAO(conn=conn).get_by_id(user.selected_book)
    if book:
        index_page = user.page_selected_book
        page = await PageDAO(conn=conn).get_by_id(book_id_=book.id, number_=index_page)
        if page:
            keyboards = get_inline_read_book(user, book, index_page, lexicon)
            await message.answer(text=page.text, reply_markup=keyboards)
        else:
            text = lexicon["not_select_book"]
    else:
        text = lexicon["not_select_book"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на команду "/books"
# Отобразит пользователю доступные книги для чтения
@router.message(Command(commands="books"))
async def process_books_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    lst_books: list[Book] = await BookDAO(conn).get_all()
    lst_books = filter(
        lambda x: x.access == AccessBook.PUBLIC and not x.wisdom, lst_books
    )
    if lst_books:
        text = lexicon["books"]
        keyboards = get_inline_btns_books(user, lst_books, lexicon)
        await message.answer(text=text, reply_markup=keyboards)
    else:
        text = lexicon["no_books"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# при нажатие на кнопу для редактирования книг из списка книг
@router.callback_query(F.data.in_(["edit_books"]))
async def process_edit_books(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    lst_books: list[Book] = await BookDAO(conn).get_all()
    lst_books = filter(lambda x: x.user_id == user.user_id and not x.wisdom, lst_books)
    if lst_books:
        text = lexicon["books"]
        keyboards = get_inline_btns_del_books(user, lst_books, lexicon)
        await callback.message.edit_text(text=text, reply_markup=keyboards)
    else:
        text = lexicon["no_del_books"]
        await callback.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# при нажатие на кнопу для скачивания книг из списка книг
@router.callback_query(F.data.in_(["load_books"]))
async def process_load_books(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    books: list[Book] = await BookDAO(conn).get_all()
    lst_books = [
        book
        for book in books
        if book.user_id == user.user_id or book.access == AccessBook.PUBLIC
    ]

    if lst_books:
        text = lexicon["books"]
        keyboards = get_inline_btns_load_books(user, lst_books, lexicon)
        await callback.message.edit_text(text=text, reply_markup=keyboards)
    else:
        text = lexicon["no_save_books"]
        await callback.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для скачивания
@router.callback_query(LoadBookCallbackFactory.filter())
async def process_load_book(
    callback: CallbackQuery,
    callback_data: LoadBookCallbackFactory,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book_id = callback_data.id
    book: Book = await BookDAO(conn).get_by_id(book_id)
    book_path = abspath(book.path)
    if book and exists(book.path):
        access = None
        if book.access == "public":
            access = lexicon["access_public"]
        else:
            access = lexicon["access_private"]

        text = (
            f"{lexicon['info_book_name']} {book.name}, "
            + f"\n{lexicon['info_book_pages']} {book.count_pages}"
            + f"\n{lexicon['info_book_author']} {book.author}"
            + f"\n{lexicon['info_book_date_load']} {book.created_at}"
            + f"\n{lexicon['info_book_access']} {access}"
        )
        await callback.message.answer(text=text)
        book_file = FSInputFile(path=book_path)
        await callback.message.answer_document(document=book_file)
    else:
        await callback.message.answer(text=lexicon["no_book"])
    await callback.answer()


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для удаления
@router.callback_query(DelBookCallbackFactory.filter())
async def process_del_book(
    callback: CallbackQuery,
    user: User,
    conn: AsyncConnection,
    callback_data: DelBookCallbackFactory,
    lexicon: dict[str, str],
):
    book_id = callback_data.id
    book: Book = await BookDAO(conn).get_by_id(book_id)

    if not book:
        await callback.message.edit_text(text=lexicon["no_del_books"])
        return

    logger.info("Del book: %s", book)

    await BookDAO(conn).delete(book_id)

    books: list[Book] = await BookDAO(conn).get_all()
    lst_books = filter(lambda x: x.user_id == user.user_id and not x.wisdom, books)
    keyboards = get_inline_btns_del_books(user, lst_books, lexicon)
    await callback.message.edit_text(text=lexicon["books"], reply_markup=keyboards)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для выбора
@router.callback_query(SelectBookCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    callback_data: SelectBookCallbackFactory,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    book_id = callback_data.id
    book: Book = await BookDAO(conn).get_by_id(book_id)
    if book:
        index_page = 1
        user.selected_book = book_id
        user.page_selected_book = index_page
        await UserDAO(conn=conn).update(user)

        page: Page = await PageDAO(conn=conn).get_by_id(
            book_id_=book.id, number_=index_page
        )
        if page:
            keyboards = get_inline_read_book(user, book, index_page, lexicon)
            await callback.message.answer(text=page.text, reply_markup=keyboards)
            await callback.answer()
        else:
            await callback.answer(text=lexicon["no_book"])
    else:
        await callback.answer(text=lexicon["no_book"])


# Этот хэндлер будет срабатывать на команду "/addbook"
# начнется диалог с пользователем для добавления книги
@router.message(Command(commands="addbook"))
async def process_addbook_command(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    await state.set_state(AddBook.name)
    text = f"{lexicon['add_book']}\n\n{lexicon['input_name_book']}"
    msg = await message.answer(
        text=text, reply_markup=get_keyboard_close_addbook(lexicon)
    )
    await state.update_data(addbok_msg_id=msg.message_id)


# Этот хэнлер будет срабатывать на нажатие кнопки "Отмена" в режиме настроек языка
@router.callback_query(F.data == "cancel_addbook_button_data")
async def process_cancel_click(
    callback: CallbackQuery,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
):
    await callback.answer()
    await state.update_data(
        addbook_msg_id=None,
        name=None,
        author=None,
        wisdom=None,
        access=None,
        upload=None,
    )
    await state.set_state()


@router.message(StateFilter(AddBook.name), F.content_type == ContentType.TEXT)
async def process_any_message_when_lang(
    message: Message,
    bot: Bot,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
):
    name = message.text
    await state.update_data(name=name)
    await state.set_state(AddBook.author)

    user_id = message.from_user.id
    data = await state.get_data()
    with suppress(TelegramBadRequest):
        msg_id = data.get("addbok_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)
    msg = await message.answer(
        text=lexicon["input_author_book"],
        reply_markup=get_keyboard_close_addbook(lexicon),
    )
    await state.update_data(addbok_msg_id=msg.message_id)


@router.message(StateFilter(AddBook.name))
async def process_any_message_when_lang(
    message: Message,
    bot: Bot,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
):
    user_id = message.from_user.id
    data = await state.get_data()
    with suppress(TelegramBadRequest):
        msg_id = data.get("addbok_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)

    text = f"{lexicon['add_book']}\n\n{lexicon['input_name_book']}"
    msg = await message.answer(
        text=text, reply_markup=get_keyboard_close_addbook(lexicon)
    )
    await state.update_data(addbok_msg_id=msg.message_id)


@router.message(StateFilter(AddBook.author), F.content_type == ContentType.TEXT)
async def process_any_message_when_lang(
    message: Message,
    bot: Bot,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
    user: User,
):
    author = message.text
    await state.update_data(author=author)
    await state.set_state(AddBook.access)

    user_id = message.from_user.id
    data = await state.get_data()
    with suppress(TelegramBadRequest):
        msg_id = data.get("addbok_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)

    msg = await message.answer(
        text=lexicon["input_access_book"],
        reply_markup=get_keyboard_input_access(lexicon),
    )

    await state.update_data(addbok_msg_id=msg.message_id)


@router.message(StateFilter(AddBook.author))
async def process_any_message_when_lang(
    message: Message,
    bot: Bot,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
):
    user_id = message.from_user.id
    data = await state.get_data()
    with suppress(TelegramBadRequest):
        msg_id = data.get("addbok_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)

    msg = await message.answer(
        text=lexicon["input_author_book"],
        reply_markup=get_keyboard_close_addbook(lexicon),
    )
    await state.update_data(addbok_msg_id=msg.message_id)


# Хэндлер ввода названия книги и запрос Автора книги
# Этот хэнлер будет срабатывать на нажатие кнопки "Отмена" в режиме настроек языка
@router.callback_query(
    StateFilter(AddBook.access), F.data.in_(["addbook_public", "addbook_private"])
)
async def process_add_book_input_access(
    callback: CallbackQuery,
    bot: Bot,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    access = None
    if callback.data == "addbook_public":
        access = "public"
    else:
        access = "private"

    await state.update_data(access=access)
    await state.set_state(AddBook.upload)

    user_id = callback.from_user.id
    data = await state.get_data()
    with suppress(TelegramBadRequest):
        msg_id = data.get("addbok_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)

    msg = await callback.message.answer(
        text=lexicon["input_file_book"],
        reply_markup=get_keyboard_close_addbook(lexicon),
    )
    await state.update_data(addbok_msg_id=msg.message_id)


@router.message(StateFilter(AddBook.access))
async def process_any_message_when_lang(
    message: Message,
    bot: Bot,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
):
    user_id = message.from_user.id
    data = await state.get_data()
    with suppress(TelegramBadRequest):
        msg_id = data.get("addbok_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)

    msg = await message.answer(
        text=lexicon["input_access_book"],
        reply_markup=get_keyboard_input_access(lexicon),
    )

    await state.update_data(addbok_msg_id=msg.message_id)


def get_unique_filename(path_books: str, file_name: str) -> str:
    base, ext = os.path.splitext(file_name)  # отделяем имя и расширение
    candidate = os.path.join(path_books, file_name)
    counter = 1

    while os.path.exists(candidate):
        candidate = os.path.join(path_books, f"{base}_{counter}{ext}")
        counter += 1
    return candidate


# Этот хэндлер будет срабатывать отправку файлов
# Если это при добавление книги то переданный файл сохранится в папке
# а иначе сообщит пользователю об неизвестной команде
@router.message(StateFilter(AddBook.upload), F.content_type == ContentType.DOCUMENT)
async def process_add_book_input_document(
    message: Message,
    conn: AsyncConnection,
    lexicon: dict[str, str],
    state: FSMContext,
    user: User,
):
    path_books = config.path_books
    file_name = message.document.file_name
    await state.update_data(file_name=file_name)

    ext = file_name.split(".")[-1].lower()
    if ext == "txt":
        file_path = get_unique_filename(path_books, file_name)
        await message.bot.download(message.document.file_id, file_path)
        await state.update_data(file_path=file_path)

        page_size = 700
        data = await state.get_data()

        pages: dict[int, str] = prepare_book(
            path=data.get("file_path"), page_size=page_size
        )

        book: Book = Book(
            id=0,
            created_at="",
            name=data.get("name"),
            path=data.get("file_path"),
            author=data.get("author"),
            wisdom=False,
            page_size=page_size,
            access=data.get("access"),
            user_id=user.user_id,
            count_pages=len(pages),
        )
        book = await BookDAO(conn).create(book)
        page_dao = PageDAO(conn)

        for key, text in pages.items():
            page: Page = Page(0, "", book.id, key, None, text)
            await page_dao.create(page)

        logger.info("Add book: %s", book)
        await message.answer(text="Книга успешна добавлена в базу")

        await state.update_data(
            addbook_msg_id=None,
            name=None,
            author=None,
            wisdom=None,
            access=None,
            upload=None,
        )
        await state.set_state()

    else:
        text = lexicon["only_txt_file"]
        await message.answer(text=text)


@router.message(StateFilter(AddBook.upload))
async def process_any_message_when_lang(
    message: Message,
    bot: Bot,
    lexicon: dict[str, str],
    state: FSMContext,
    locales: list[str],
):
    user_id = message.from_user.id
    data = await state.get_data()
    with suppress(TelegramBadRequest):
        msg_id = data.get("addbok_msg_id")
        if msg_id:
            await bot.edit_message_reply_markup(chat_id=user_id, message_id=msg_id)

    msg = await message.answer(
        text=lexicon["input_file_book"],
        reply_markup=get_keyboard_close_addbook(lexicon),
    )
    await state.update_data(addbok_msg_id=msg.message_id)
