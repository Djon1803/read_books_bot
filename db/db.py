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
