from aiogram import Router, F
from aiogram.filters import Command
from aiogram.types import (
    Message,
    CallbackQuery,
    ContentType,
    FSInputFile,
    ReplyKeyboardRemove,
)

import logging

logger = logging.getLogger(__name__)

from keyboards.books import (
    get_inline_btns_books,
    get_inline_btns_load_books,
    get_inline_btns_del_books,
    get_keyboard_close_addbook,
    get_keyboard_input_access,
)

from keyboards.pagination import get_inline_read_book

from db.db import Book, DB_Books, User, DB_Users

from os import remove
from os.path import exists, abspath
import datetime

from filters.filters import (
    IsAddBookInputName,
    IsAddBookInputAuthor,
    IsAddBookInputAccess,
    IsCancelAddBook,
)

from callback_factory.book import (
    DelBookCallbackFactory,
    LoadBookCallbackFactory,
    SelectBookCallbackFactory,
)

from config_data.config import Config, load_config

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на команду "/beginning"
# и отправлять пользователю первую страницу книги с кнопками пагинации
@router.message(Command(commands="beginning"))
async def process_beginning_command(
    message: Message, user: User, books: DB_Books, users: DB_Users
):
    book = books.get_book(user.id_select_book)
    if book:
        index_page = 1
        user.reading[str(book.id)] = index_page
        users.save()
        page = book.get_page(index_page)
        keyboards = get_inline_read_book(user, book, index_page)
        await message.answer(text=page, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["not_select_book"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки "назад"
# во время взаимодействия пользователя с сообщением-книгой
@router.callback_query(F.data.in_(["page_back"]))
async def process_page_back_press(
    callback: CallbackQuery, user: User, books: DB_Books, users: DB_Users
):
    book = books.get_book(user.id_select_book)
    this_index = user.reading.get(str(user.id_select_book), 1)
    if book:
        index_page = this_index
        if this_index > 1:
            index_page -= 1
            user.reading[str(user.id_select_book)] = index_page
            users.save()
            page = book.get_page(index_page)
            keyboards = get_inline_read_book(user, book, index_page)
            await callback.message.edit_text(text=page, reply_markup=keyboards)
        else:
            await callback.answer(text=user.lexicon.lexicon["first_page"])
    else:
        await callback.answer(text=user.lexicon.lexicon["error_not_select_book"])


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки "вперёд"
# во время взаимодействия пользователя с сообщением-книгой
@router.callback_query(F.data.in_(["page_next"]))
async def process_page_next_press(
    callback: CallbackQuery, user: User, books: DB_Books, users: DB_Users
):
    book = books.get_book(user.id_select_book)
    this_index = user.reading.get(str(user.id_select_book), 1)
    if book:
        index_page = this_index
        if this_index < book.count_pages:
            index_page += 1
            user.reading[str(user.id_select_book)] = index_page
            users.save()
            page = book.get_page(index_page)
            keyboards = get_inline_read_book(user, book, index_page)
            await callback.message.edit_text(text=page, reply_markup=keyboards)
        else:
            await callback.answer(text=user.lexicon.lexicon["last_page"])
    else:
        await callback.answer(text=user.lexicon.lexicon["error_not_select_book"])


# Этот хэндлер будет срабатывать на команду "/continue"
# и отправлять пользователю страницу книги, на которой пользователь
# остановился в процессе взаимодействия с ботом
@router.message(Command(commands="continue"))
async def process_continue_command(message: Message, user: User, books: DB_Books):
    book = books.get_book(user.id_select_book)

    if book:
        index_page = user.reading[str(user.id_select_book)]
        page = book.get_page(index_page)
        keyboards = get_inline_read_book(user, book, index_page)
        await message.answer(text=page, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["not_select_book"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на команду "/books"
# Отобразит пользователю доступные книги для чтения
@router.message(Command(commands="books"))
async def process_books_command(message: Message, user: User, books: DB_Books):
    lst_books = [
        book
        for book in books.books
        if user.admin or book.owner == user.id or book.access == "general"
    ]
    if lst_books:
        text = user.lexicon.lexicon["books"]
        keyboards = get_inline_btns_books(user, lst_books)
        await message.answer(text=text, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["no_books"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# при нажатие на кнопу для редактирования книг из списка книг
@router.callback_query(F.data.in_(["edit_books"]))
async def process_edit_books(callback: CallbackQuery, user: User, books: DB_Books):
    lst_books = [book for book in books.books if user.admin or book.owner == user.id]

    if lst_books:
        text = user.lexicon.lexicon["books"]
        keyboards = get_inline_btns_del_books(user, lst_books)
        await callback.message.edit_text(text=text, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["no_del_books"]
        await callback.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# при нажатие на кнопу для скачивания книг из списка книг
@router.callback_query(F.data.in_(["load_books"]))
async def process_load_books(callback: CallbackQuery, user: User, books: DB_Books):
    lst_books = [
        book
        for book in books.books
        if user.admin or book.owner == user.id or book.access == "general"
    ]

    if lst_books:
        text = user.lexicon.lexicon["books"]
        keyboards = get_inline_btns_load_books(user, lst_books)
        await callback.message.edit_text(text=text, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["no_save_books"]
        await callback.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для удаления
@router.callback_query(DelBookCallbackFactory.filter())
async def process_del_book(
    callback: CallbackQuery,
    user: User,
    books: DB_Books,
    users: DB_Users,
    callback_data: DelBookCallbackFactory,
):
    book_id = callback_data.id
    book = books.get_book(book_id)
    logger.info("Del book: %s", book)
    users.clear_book(book_id)
    remove(books.get_book(book_id).path)
    books.del_book(book_id)
    books.save()
    users.save()

    lst_books = [
        book
        for book in books.books
        if user.admin or (book.owner and book.owner == user.id)
    ]
    if lst_books:
        text = user.lexicon.lexicon["books"]
        keyboards = get_inline_btns_del_books(user, lst_books)
        await callback.message.edit_text(text=text, reply_markup=keyboards)
    else:
        await callback.message.edit_text(text=user.lexicon.lexicon["no_del_books"])


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для скачивания
@router.callback_query(LoadBookCallbackFactory.filter())
async def process_load_book(
    callback: CallbackQuery,
    user: User,
    books: DB_Books,
    callback_data: LoadBookCallbackFactory,
):
    book_id = callback_data.id
    book = books.get_book(book_id)
    book_path = abspath(book.path)
    if book and exists(book.path):

        access = None
        if book.access == "general":
            access = user.lexicon.lexicon["access_general"]
        else:
            access = user.lexicon.lexicon["access_personal"]

        text = (
            f"{user.lexicon.lexicon['info_book_name']} {book.name}, "
            + f"\n{user.lexicon.lexicon['info_book_pages']} {book.count_pages}"
            + f"\n{user.lexicon.lexicon['info_book_author']} {book.author}"
            + f"\n{user.lexicon.lexicon['info_book_date_load']} {book.date_load}"
            + f"\n{user.lexicon.lexicon['info_book_access']} {access}"
        )
        await callback.message.answer(text=text)
        book_file = FSInputFile(path=book_path)
        await callback.message.answer_document(document=book_file)
    else:
        await callback.message.answer(text=user.lexicon.lexicon["no_book"])
    await callback.answer()


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с книгой из списка книг для выбора
@router.callback_query(SelectBookCallbackFactory.filter())
async def process_select_book(
    callback: CallbackQuery,
    user: User,
    books: DB_Books,
    users: DB_Users,
    callback_data: SelectBookCallbackFactory,
):
    book_id = callback_data.id
    book = books.get_book(book_id)
    if book:
        user.id_select_book = book_id

        if user.reading.get(str(book_id)):
            index_page = user.reading.get(str(book_id), 1)
        else:
            index_page = 1
            user.reading[str(book_id)] = index_page

        users.save()

        page = book.get_page(index_page)
        keyboards = get_inline_read_book(user, book, index_page)
        await callback.message.answer(text=page, reply_markup=keyboards)
        await callback.answer()
    else:
        await callback.answer(text=user.lexicon.lexicon["no_book"])


# Этот хэндлер будет срабатывать на команду "/addbook"
# начнется диалог с пользователем для добавления книги
@router.message(Command(commands="addbook"))
async def process_addbook_command(message: Message, user: User):
    user.add_book = {}
    text = f"{user.lexicon.lexicon['add_book']}\n\n{user.lexicon.lexicon['input_name_book']}"
    await message.answer(text=text, reply_markup=get_keyboard_close_addbook(user))


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# "отменить" во время добавления новой книги
@router.message(IsCancelAddBook())
async def process_add_book_cancel(message: Message, user: User):
    if hasattr(user, "add_book"):
        del user.add_book
    await message.answer(
        text="Вы вышли из режима добавления книги", reply_markup=ReplyKeyboardRemove()
    )


# Хэндлер ввода названия книги и запрос Автора книги
@router.message(IsAddBookInputAccess())
async def process_add_book_input_access(message: Message, user: User):
    access = message.text
    if access in [
        user.lexicon.lexicon["access_general_button"],
        user.lexicon.lexicon["access_personal_button"],
    ]:
        if access == user.lexicon.lexicon["access_general_button"]:
            user.add_book["access"] = "general"
        else:
            user.add_book["access"] = "personal"
        await message.answer(
            text=user.lexicon.lexicon["input_file_book"],
            reply_markup=get_keyboard_close_addbook(user),
        )
    else:
        await message.answer(text=user.lexicon.lexicon["select_access"])


# Хэндлер ввода названия книги и запрос Автора книги
@router.message(IsAddBookInputName())
async def process_add_book_input_name(message: Message, user: User):
    name = message.text
    user.add_book["name"] = name
    await message.answer(text=user.lexicon.lexicon["input_author_book"])


# Хэндлер ввода названия книги и запрос Автора книги
@router.message(IsAddBookInputAuthor())
async def process_add_book_input_author(message: Message, user: User):
    author = message.text
    user.add_book["author"] = author
    await message.answer(
        text=user.lexicon.lexicon["input_access_book"],
        reply_markup=get_keyboard_input_access(user),
    )


# Этот хэндлер будет срабатывать отправку файлов
# Если это при добавление книги то переданный файл сохранится в папке
# а иначе сообщит пользователю об неизвестной команде
@router.message(F.content_type == ContentType.DOCUMENT)
async def process_add_book_input_document(
    message: Message, user: User, books: DB_Books
):
    path_books = config.path_books
    file_name = message.document.file_name
    if hasattr(user, "add_book") and user.add_book != {}:
        ext = file_name.split(".")[-1].lower()
        if ext == "txt":
            d = datetime.datetime.now()
            date_load = d.strftime("%d.%m.%Y")
            file_path = path_books + file_name
            await message.bot.download(message.document.file_id, file_path)
            book_id = books.books[-1].id + 1 if books.books else 1
            book = Book(
                id=book_id,
                name=user.add_book["name"],
                path=file_path,
                author=user.add_book["author"],
                owner=user.id,
                access=user.add_book["access"],
                date_load=date_load,
            )
            books.add(book)
            logger.info("Add book: %s", book)
            text = user.lexicon.lexicon["added_book"]
            del user.add_book
            books.save()
            await message.answer(text=text, reply_markup=ReplyKeyboardRemove())
        else:
            text = user.lexicon.lexicon["only_txt_file"]
            await message.answer(text=text)
    else:
        text = user.lexicon.lexicon["other_file"]
        await message.answer(text=text)
