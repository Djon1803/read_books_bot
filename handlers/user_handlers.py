from aiogram import Router, F
from aiogram.filters import Command, CommandStart
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
from keyboards.bookmarks import get_inline_btns_marks, get_inline_btns_del_marks
from keyboards.languages import get_inline_btns_languages

from db.db import Book, DB_Books, User, DB_Users

from os import remove
from os.path import exists, abspath
import datetime

from services.services import get_user

from filters.filters import (
    IsAddBookInputName,
    IsAddBookInputAuthor,
    IsAddBookInputAccess,
    IsCancelAddBook,
)

from config_data.config import Config, load_config

config: Config = load_config()

# Инициализируем роутер уровня модуля
router = Router()


# Этот хэндлер будет срабатывать на команду "/start" -
# добавлять пользователя в базу данных
# и отправлять ему приветственное сообщение
@router.message(CommandStart())
async def process_start_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
    await message.answer(text=user.lexicon.lexicon["/start"])


# Этот хэндлер будет срабатывать на команду "/help"
# и отправлять пользователю сообщение со списком доступных команд в боте
@router.message(Command(commands="help"))
async def process_help_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
    await message.answer(text=user.lexicon.lexicon["/help"])


# Этот хэндлер будет срабатывать на команду "/save"
# и сохранять базы данных в json файлы
@router.message(Command(commands="save"))
async def process_save_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
    users.save()
    books.save()
    await message.answer(user.lexicon.lexicon["save_data"])


# Этот хэндлер будет срабатывать на команду "/beginning"
# и отправлять пользователю первую страницу книги с кнопками пагинации
@router.message(Command(commands="beginning"))
async def process_beginning_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
    book = books.get_book(user.id_select_book)
    if book:
        index_page = 1
        user.reading[str(book.id)] = index_page
        page = book.get_page(index_page)
        keyboards = get_inline_read_book(user, book, index_page)
        await message.answer(text=page, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["not_select_book"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с номером текущей страницы и добавлять текущую страницу в закладки
@router.callback_query(F.data.in_(["page_add_mark"]))
async def process_page_add_mark(
    callback: CallbackQuery, books: DB_Books, users: DB_Users
):
    user = get_user(callback, books, users)
    user.add_mark(user.id_select_book, user.reading[str(user.id_select_book)])
    await callback.answer(text=user.lexicon.lexicon["add_mark"])


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки "назад"
# во время взаимодействия пользователя с сообщением-книгой
@router.callback_query(F.data.in_(["page_back"]))
async def process_page_back_press(
    callback: CallbackQuery, books: DB_Books, users: DB_Users
):
    user = get_user(callback, books, users)
    book = books.get_book(user.id_select_book)
    this_index = user.reading.get(str(user.id_select_book), 1)
    if book:
        index_page = this_index
        if this_index > 1:
            index_page -= 1
            user.reading[str(user.id_select_book)] = index_page
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
    callback: CallbackQuery, books: DB_Books, users: DB_Users
):
    user = get_user(callback, books, users)
    book = books.get_book(user.id_select_book)
    this_index = user.reading.get(str(user.id_select_book), 1)
    if book:
        index_page = this_index
        if this_index < book.count_pages:
            index_page += 1
            user.reading[str(user.id_select_book)] = index_page
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
async def process_continue_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
    book = books.get_book(user.id_select_book)
    index_page = user.reading[str(user.id_select_book)]

    if book:
        page = book.get_page(index_page)
        keyboards = get_inline_read_book(user, book, index_page)
        await message.answer(text=page, reply_markup=keyboards)
    else:
        text = user.lexicon.lexicon["not_select_book"]
        await message.answer(text=text)


# Этот хэндлер будет срабатывать на команду "/books"
# Отобразит пользователю доступные книги для чтения
@router.message(Command(commands="books"))
async def process_books_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
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
async def process_edit_books(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)

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
async def process_load_books(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)

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
@router.callback_query(F.data.startswith("del_book="))
async def process_del_book(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)
    book_id = int(callback.data.split("=")[1])
    book = books.get_book(book_id)
    logger.info("Del book: %s", book)
    users.clear_book(book_id)
    remove(books.get_book(book_id).path)
    books.del_book(book_id)

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
@router.callback_query(F.data.startswith("load_book="))
async def process_load_book(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)
    book_id = int(callback.data.split("=")[1])
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
@router.callback_query(F.data.startswith("select_book="))
async def process_select_book(
    callback: CallbackQuery, books: DB_Books, users: DB_Users
):
    user = get_user(callback, books, users)
    book_id = int(callback.data.split("=")[1])
    book = books.get_book(book_id)
    if book:
        user.id_select_book = book_id

        if user.reading.get(str(book_id)):
            index_page = user.reading.get(str(book_id), 1)
        else:
            index_page = 1
            user.reading[str(book_id)] = index_page

        page = book.get_page(index_page)
        keyboards = get_inline_read_book(user, book, index_page)
        await callback.message.answer(text=page, reply_markup=keyboards)
        await callback.answer()
    else:
        await callback.answer(text=user.lexicon.lexicon["no_book"])


# Этот хэндлер будет срабатывать на команду "/addbook"
# начнется диалог с пользователем для добавления книги
@router.message(Command(commands="addbook"))
async def process_addbook_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)
    user.add_book = {}
    text = f"{user.lexicon.lexicon['add_book']}\n\n{user.lexicon.lexicon['input_name_book']}"
    await message.answer(text=text, reply_markup=get_keyboard_close_addbook(user))


# Хэндлер ввода названия книги и запрос Автора книги
@router.message(IsAddBookInputAccess())
async def process_add_book_input_access(
    message: Message, books: DB_Books, users: DB_Users
):
    user = get_user(message, books, users)
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
async def process_add_book_input_name(
    message: Message, books: DB_Books, users: DB_Users
):
    user = get_user(message, books, users)
    name = message.text
    user.add_book["name"] = name
    await message.answer(text=user.lexicon.lexicon["input_author_book"])


# Хэндлер ввода названия книги и запрос Автора книги
@router.message(IsAddBookInputAuthor())
async def process_add_book_input_author(
    message: Message, books: DB_Books, users: DB_Users
):
    user = get_user(message, books, users)
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
    message: Message, books: DB_Books, users: DB_Users
):
    user = get_user(message, books, users)
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


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# "отменить" во время добавления новой книги
@router.message(IsCancelAddBook())
async def process_add_book_cancel(message: Message):
    user = get_user(message)
    if hasattr(user, "add_book"):
        del user.add_book
    await message.answer(
        text="Вы вышли из режима добавления книги", reply_markup=ReplyKeyboardRemove()
    )


# Этот хэндлер будет срабатывать на команду "/bookmarks"
# и отправлять пользователю список сохраненных закладок,
# если они есть или сообщение о том, что закладок нет
@router.message(Command(commands="bookmarks"))
async def process_bookmarks_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)

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
async def process_edit_marks(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)

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
@router.callback_query(F.data.startswith("del_mark"))
async def process_del_mark(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)
    data = [text.split("=") for text in callback.data.split(":")[1].split("&")]
    book_id = int(data[0][1])
    number_page = int(data[1][1])
    user.del_mark(book_id, number_page)

    if user.marks:
        keyboards = get_inline_btns_del_marks(user, books, user.marks)
        await callback.message.edit_text(
            text=user.lexicon.lexicon["/bookmarks"], reply_markup=keyboards
        )
    else:
        await callback.message.edit_text(text=user.lexicon.lexicon["no_bookmarks"])


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с закладкой из списка закладок для просмотра
@router.callback_query(F.data.startswith("show_page"))
async def process_show_page(callback: CallbackQuery, books: DB_Books, users: DB_Users):
    user = get_user(callback, books, users)
    data = [text.split("=") for text in callback.data.split(":")[1].split("&")]
    book_id = int(data[0][1])
    number_page = int(data[1][1])
    book = books.get_book(book_id)
    if book:
        page = book.get_page(number_page)
        user.id_select_book = book_id
        user.reading[str(book_id)] = number_page
        keyboards = get_inline_read_book(user, book, number_page)
        await callback.message.answer(text=page, reply_markup=keyboards)
        await callback.answer()
    else:
        await callback.answer(text=user.lexicon.lexicon["del_book"])


# Этот хэндлер будет срабатывать на команду "/language"
# и показывать пользователю список локализаций
@router.message(Command(commands="language"))
async def process_language_command(message: Message, books: DB_Books, users: DB_Users):
    user = get_user(message, books, users)

    text = user.lexicon.lexicon["/language"]
    keyboards = get_inline_btns_languages(user)
    await message.answer(text=text, reply_markup=keyboards)


# Этот хэндлер будет срабатывать на нажатие инлайн-кнопки
# с языком из списка языков для выбора
@router.callback_query(lambda callback: callback.data.startswith("select_language="))
async def process_select_language(
    callback: CallbackQuery, books: DB_Books, users: DB_Users
):
    user = get_user(callback, books, users)
    language = callback.data.split("=")[1]

    if language == "EN":
        user.language = language
    else:
        user.language = "RU"

    users.save()
    books.save()

    text = user.lexicon.lexicon["/language"]
    keyboards = get_inline_btns_languages(user)
    await callback.answer()
    await callback.message.edit_text(text=text, reply_markup=keyboards)
