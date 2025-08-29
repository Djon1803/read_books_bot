"""
Перенос всех страниц книг
"""

import asyncio
import os
import sys

from db.connection import get_pg_connection
from config.config import Config, load_config
from psycopg import AsyncConnection, Error


config: Config = load_config()

if sys.platform.startswith("win") or os.name == "nt":
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

from dataclasses import dataclass, field
from bot.services.book import prepare_book
from os.path import exists
import json


from datetime import datetime
from dataclasses import dataclass
from typing import Optional

from psycopg import AsyncConnection, Error
from psycopg.rows import class_row

from bot.enums.access import AccessBook
from bot.enums.roles import UserRole
from typing import Any
import logging

logger = logging.getLogger(__name__)


class BaseDAO:
    def __init__(self, conn: AsyncConnection):
        self.conn = conn


@dataclass
class User:
    id: int
    created_at: str
    user_id: int
    username: Optional[str]
    language: str = "ru"
    role: str = UserRole.USER
    is_alive: bool = False
    banned: bool = False
    selected_book: Optional[int] = None
    page_selected_book: Optional[int] = None
    enable_wisdom: bool = False
    selected_wisdom: Optional[int] = None
    page_selected_wisdom: Optional[int] = None
    time_send_wisdom: str = "09:00:00"


class UserDAO(BaseDAO):
    async def get_by_id(self, user_id_: int) -> User | None:
        async with self.conn.cursor(row_factory=class_row(User)) as cur:
            await cur.execute(
                """
                SELECT id, created_at, user_id, username, language, role, 
                is_alive, banned, selected_book, page_selected_book, enable_wisdom, 
                selected_wisdom, page_selected_wisdom, time_send_wisdom 
                FROM users WHERE user_id = %s
                """,
                (user_id_,),
            )
            return await cur.fetchone()

    async def get_by_username(self, username_: int) -> User | None:
        async with self.conn.cursor(row_factory=class_row(User)) as cur:
            await cur.execute(
                """
                SELECT id, created_at, user_id, username, language, role, 
                is_alive, banned, selected_book, page_selected_book, enable_wisdom, 
                selected_wisdom, page_selected_wisdom, time_send_wisdom 
                FROM users WHERE username = %s
                """,
                (username_,),
            )
            return await cur.fetchone()

    async def create(self, user: User) -> User:
        async with self.conn.cursor(row_factory=class_row(User)) as cur:
            await cur.execute(
                """
                INSERT INTO users (user_id, username, language, role, is_alive, banned, 
                selected_book, page_selected_book, 
                enable_wisdom, selected_wisdom, page_selected_wisdom, time_send_wisdom) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) 
                RETURNING *
                """,
                (
                    user.user_id,
                    user.username,
                    user.language,
                    user.role,
                    user.is_alive,
                    user.banned,
                    user.selected_book,
                    user.page_selected_book,
                    user.enable_wisdom,
                    user.selected_wisdom,
                    user.page_selected_wisdom,
                    user.time_send_wisdom,
                ),
            )
            return await cur.fetchone()

    async def update(self, user: User) -> User:
        async with self.conn.cursor(row_factory=class_row(User)) as cur:
            await cur.execute(
                """
                UPDATE users
                SET user_id = %s,
                    username = %s,
                    language = %s,
                    role = %s,
                    is_alive = %s,
                    banned = %s,
                    selected_book = %s,
                    page_selected_book = %s,
                    enable_wisdom = %s,
                    selected_wisdom = %s,
                    page_selected_wisdom = %s,
                    time_send_wisdom = %s
                WHERE id = %s
                RETURNING *
                """,
                (
                    user.user_id,
                    user.username,
                    user.language,
                    user.role,
                    user.is_alive,
                    user.banned,
                    user.selected_book,
                    user.page_selected_book,
                    user.enable_wisdom,
                    user.selected_wisdom,
                    user.page_selected_wisdom,
                    user.time_send_wisdom,
                    user.id,
                ),
            )
            return await cur.fetchone()

    async def activity(self, user: User) -> None:
        async with self.conn.cursor(row_factory=class_row(User)) as cur:
            await cur.execute(
                """
                    INSERT INTO activity (user_id, activity_date)
                    VALUES (%s, CURRENT_DATE)
                    ON CONFLICT (user_id, activity_date)
                    DO UPDATE
                    SET actions = activity.actions + 1;
                """,
                (user.user_id,),
            )
        logger.info("User activity updated. table=`activity`, user_id=%d", user.user_id)

    async def get_all(self) -> list[User] | None:
        async with self.conn.cursor(row_factory=class_row(User)) as cur:
            await cur.execute("SELECT * FROM users")
            return await cur.fetchall()


@dataclass
class Book:
    id: int
    created_at: str
    name: str
    path: str
    author: str
    wisdom: bool
    page_size: int
    access: str = AccessBook.PUBLIC
    user_id: Optional[int] = None
    count_pages: Optional[int] = 0


class BookDAO(BaseDAO):
    async def get_by_id(self, id_: int) -> Book | None:
        async with self.conn.cursor(row_factory=class_row(Book)) as cur:
            await cur.execute("SELECT * FROM books WHERE id = %s", (id_,))
            return await cur.fetchone()

    async def create(self, book: Book) -> Book:
        async with self.conn.cursor(row_factory=class_row(Book)) as cur:
            await cur.execute(
                """
                INSERT INTO books (name, author, user_id, access, wisdom, path, page_size, count_pages)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING *
                """,
                (
                    book.name,
                    book.author,
                    book.user_id,
                    book.access,
                    book.wisdom,
                    book.path,
                    book.page_size,
                    book.count_pages,
                ),
            )
            return await cur.fetchone()

    async def update(self, book: Book) -> Book:
        async with self.conn.cursor(row_factory=class_row(Book)) as cur:
            await cur.execute(
                """
                UPDATE books
                SET name = %s,
                    author = %s,
                    user_id = %s,
                    access = %s,
                    wisdom = %s,
                    path = %s,
                    page_size = %s,
                    count_pages = %s
                WHERE id = %s
                RETURNING *
                """,
                (
                    book.name,
                    book.author,
                    book.user_id,
                    book.access,
                    book.wisdom,
                    book.path,
                    book.page_size,
                    book.count_pages,
                    book.id,
                ),
            )
            return await cur.fetchone()

    async def delete(self, book_id: int) -> None:
        async with self.conn.cursor() as cur:
            await cur.execute("DELETE FROM books WHERE id = %s", (book_id,))

    async def get_by_name(self, name_: str) -> Book | None:
        async with self.conn.cursor(row_factory=class_row(Book)) as cur:
            await cur.execute("SELECT * FROM books WHERE name = %s", (name_,))
            return await cur.fetchone()

    async def get_all(self) -> list[Book] | None:
        async with self.conn.cursor(row_factory=class_row(Book)) as cur:
            await cur.execute("SELECT * FROM books")
            return await cur.fetchall()


@dataclass
class Page:
    id: int
    created_at: str
    book_id: int
    number: int
    photo: Optional[str] = None
    text: Optional[str] = None


class PageDAO(BaseDAO):
    async def get_by_id(self, book_id_: int, number_: int) -> Page | None:
        async with self.conn.cursor(row_factory=class_row(Page)) as cur:
            await cur.execute(
                "SELECT * FROM pages_books WHERE book_id = %s AND number = %s",
                (book_id_, number_),
            )
            return await cur.fetchone()

    async def create(self, page: Page) -> Page:
        async with self.conn.cursor(row_factory=class_row(Page)) as cur:
            await cur.execute(
                """
                INSERT INTO pages_books (book_id, number, photo, text)
                VALUES (%s, %s, %s, %s)
                RETURNING *
                """,
                (page.book_id, page.number, page.photo, page.text),
            )
            return await cur.fetchone()

    async def update(self, page: Page) -> Page:
        async with self.conn.cursor(row_factory=class_row(Page)) as cur:
            await cur.execute(
                """
                UPDATE pages_books
                SET book_id = %s,
                    number = %s,
                    photo = %s,
                    text = %s
                WHERE id = %s
                RETURNING *
                """,
                (page.book_id, page.number, page.photo, page.text, page.id),
            )
            return await cur.fetchone()


class ActivityDAO(BaseDAO):
    async def get_statistics(self) -> list[(int, int)] | None:
        async with self.conn.cursor() as cur:
            await cur.execute(
                query="""
                SELECT user_id, SUM(actions) AS total_actions
                FROM activity
                WHERE activity_date = CURRENT_DATE
                GROUP BY user_id
                ORDER BY total_actions DESC
                LIMIT 5;
            """,
            )
            rows = await cur.fetchall()

            logger.info("Users activity got from table=`activity`")
            return [*rows] if rows else None


@dataclass
class Mark:
    id: int
    created_at: str
    user_id: int
    book_id: int
    number_page: int


class MarkDAO(BaseDAO):
    async def get(self, user_id: int, book_id: int, number_page: int) -> Mark | None:
        async with self.conn.cursor(row_factory=class_row(Mark)) as cur:
            await cur.execute(
                """
                SELECT id, created_at, user_id, book_id, number_page
                FROM marks WHERE user_id = %s AND book_id = %s AND number_page = %s
                """,
                (user_id, book_id, number_page),
            )
            return await cur.fetchone()

    async def create(self, mark: Mark) -> Mark:
        async with self.conn.cursor(row_factory=class_row(Mark)) as cur:
            await cur.execute(
                """
                INSERT INTO marks (user_id, book_id, number_page) 
                VALUES (%s, %s, %s) 
                RETURNING *
                """,
                (mark.user_id, mark.book_id, mark.number_page),
            )
            return await cur.fetchone()

    async def update(self, mark: Mark) -> Mark:
        async with self.conn.cursor(row_factory=class_row(Mark)) as cur:
            await cur.execute(
                """
                UPDATE marks
                SET user_id = %s,
                    book_id = %s,
                    number_page = %s
                WHERE id = %s
                RETURNING *
                """,
                (mark.user_id, mark.book_id, mark.number_page, mark.id),
            )
            return await cur.fetchone()

    async def delete(self, user_id: int, book_id: int, number_page: int) -> None:
        async with self.conn.cursor() as cur:
            await cur.execute(
                """
                DELETE FROM marks WHERE user_id = %s AND book_id = %s AND number_page = %s
                """,
                (user_id, book_id, number_page),
            )

    async def get_all(
        self, user_id: int, book_id: int = None, number_page: int = None
    ) -> list[Mark] | None:
        async with self.conn.cursor(row_factory=class_row(Mark)) as cur:
            if book_id and number_page:
                await cur.execute(
                    """
                    SELECT id, created_at, user_id, book_id, number_page
                    FROM marks 
                    WHERE user_id = %s AND book_id = %s AND number_page = %s
                    """,
                    (user_id, book_id, number_page),
                ),
            else:
                await cur.execute(
                    "SELECT id, created_at, user_id, book_id, number_page "
                    "FROM marks "
                    "WHERE user_id = %s",
                    (user_id,),
                ),
            return await cur.fetchall()


@dataclass
class Book3:
    LEN_PAGE = 100
    id: int
    name: str
    path: str
    author: str = None
    owner: str = None
    access: str = "general"
    date_load: str = None
    count_pages: int = None
    pages: dict[int, str] = None

    def __post_init__(self):
        self.pages = prepare_book(self.path, 700)
        self.count_pages = len(self.pages)


class DB_Books:
    def __init__(self, path: str):
        self.path = path
        self.books = self.load(path)

    @staticmethod
    def load(path: str) -> list[Book3]:
        if not exists(path):
            with open(path, "x", encoding="utf-8") as f:
                f.seek(0)
                f.truncate()
                f.write(json.dumps([], ensure_ascii=False, indent=4))
                return []

        with open(path, "r+", encoding="utf-8") as f:
            content = f.read()
            if content:
                books = json.loads(content)
                return [
                    Book3(
                        book["id"],
                        book["name"],
                        book["path"],
                        book["author"],
                        book["owner"],
                        book["access"],
                        book["date_load"],
                    )
                    for book in books
                ]


from locales.lexicon import Lexicon


@dataclass
class User3:
    id: int
    username: str
    id_select_book: int
    _language: str = "RU"
    admin: bool = False
    book_wisdom: bool = False
    page_number_book_wisdom: int = 1
    books_read: list[int] = field(default_factory=list)
    marks: list[dict] = field(default_factory=list)
    reading: dict[str:int] = field(default_factory=dict)
    lexicon: Lexicon = field(init=False)

    def __post_init__(self):
        self.lexicon = Lexicon(self.language)

    def add_mark(self, book_id: int, number_page: int):
        for mark in self.marks:
            if mark["book_id"] == book_id and mark["number_page"] == number_page:
                return
        else:
            self.marks.append({"book_id": book_id, "number_page": number_page})

    def del_mark(self, book_id: int, number_page: int):
        for i in range(len(self.marks)):
            if (
                self.marks[i]["book_id"] == book_id
                and self.marks[i]["number_page"] == number_page
            ):
                self.marks.pop(i)
                return

    def update_reading_book(self, book_id: int, number_page: int):
        self.reading[book_id] = number_page

    def del_reading_book(self, book_id: int):
        d = {}
        for key, value in self.reading.items():
            if key != str(book_id):
                d[key] = value
        self.reading = d

    @property
    def language(self):
        return self._language

    @language.setter
    def language(self, value):
        self._language = value

        self.lexicon = Lexicon(self.language)


class DB_Users:
    def __init__(self, path: str):
        self.path = path
        self.users = self.load(path)

    def add(self, user: User3):
        for u in self.users:
            if u.id == user.id:
                break
        else:
            self.users.append(user)

    def get_user(self, user_id: int):
        for u in self.users:
            if u.id == user_id:
                return u

    def clear_book(self, book_id: int):
        for user in self.users:
            for i in range(len(user.marks)):
                if user.marks[i]["book_id"] == book_id:
                    del user.marks[i]

            user.del_reading_book(book_id)

            if user.id_select_book == book_id:
                keys = list(user.reading.keys())
                if keys:
                    user.id_select_book = int(keys[-1])
                else:
                    user.id_select_book = None

    @staticmethod
    def load(path: str) -> list[User3]:
        if not exists(path):
            with open(path, "x", encoding="utf-8") as f:
                f.seek(0)
                f.truncate()
                f.write(json.dumps([], ensure_ascii=False, indent=4))
                return []

        with open(path, "r+", encoding="utf-8") as f:
            content = f.read()
            if content:
                books = json.loads(content)
                return [
                    User3(
                        book["id"],
                        book["username"],
                        book["id_select_book"],
                        book["language"],
                        book["admin"],
                        book["book_wisdom"],
                        book["page_number_book_wisdom"],
                        book["books_read"],
                        book["marks"],
                        book["reading"],
                    )
                    for book in books
                ]

    @staticmethod
    def get_json_list_users(users: list[User3]) -> list[dict]:
        return [
            {
                "id": user.id,
                "username": user.username,
                "id_select_book": user.id_select_book,
                "language": user.language,
                "books_read": user.books_read,
                "marks": user.marks,
                "admin": user.admin,
                "book_wisdom": user.book_wisdom,
                "page_number_book_wisdom": user.page_number_book_wisdom,
                "reading": user.reading,
            }
            for user in users
        ]

    def save(self):
        users = self.get_json_list_users(self.users)
        with open(self.path, "r+", encoding="utf-8") as f:
            f.seek(0)
            f.truncate()
            f.write(json.dumps(users, ensure_ascii=False, indent=4))


async def add_books():
    conn: AsyncConnection | None = None

    try:
        conn = await get_pg_connection(
            db_name=config.db.name,
            host=config.db.host,
            port=config.db.port,
            user=config.db.user,
            password=config.db.password,
        )
        book_dao = BookDAO(conn=conn)
        page_dao = PageDAO(conn=conn)
        db = DB_Books("C:/MyProjects/read_books_bot/db/books.json")

        for b in db.books:
            book = await book_dao.get_by_id(b.id)
            if not book:
                book: Book = Book(0, "", b.name, b.path, b.author, False, 700)
                book = await book_dao.create(book)
                if book:
                    for key, value in b.pages.items():
                        await page_dao.create(Page(0, "", book.id, key, None, value))
    finally:
        if conn:
            await conn.commit()
            await conn.close()


# asyncio.run(add_books())


async def add_users():
    conn: AsyncConnection | None = None

    try:
        conn = await get_pg_connection(
            db_name=config.db.name,
            host=config.db.host,
            port=config.db.port,
            user=config.db.user,
            password=config.db.password,
        )
        user_dao = UserDAO(conn=conn)
        db = DB_Users("C:/MyProjects/read_books_bot/db/users.json")

        for u in db.users:
            user = await user_dao.get_by_id(u.id)
            if not user:
                user: User = User(
                    0,
                    "",
                    u.id,
                    u.username,
                    "ru",
                    UserRole.USER,
                    False,
                    False,
                    u.id_select_book,
                    u.reading.get(str(u.id_select_book)),
                    u.book_wisdom,
                    9,
                    u.page_number_book_wisdom,
                )
                user = await user_dao.create(user)
    finally:
        if conn:
            await conn.commit()
            await conn.close()


asyncio.run(add_users())
