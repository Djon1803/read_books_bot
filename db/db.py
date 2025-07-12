from dataclasses import dataclass, field
import json
from lexicon.lexicon import Lexicon
from services.book import prepare_book
from os.path import exists


@dataclass
class Book:
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
        self.pages = prepare_book(self.path, 650)
        self.count_pages = len(self.pages)

    def get_page(self, index_page: int) -> str:
        return self.pages.get(index_page, None)


class DB_Books:
    def __init__(self, path: str):
        self.path = path
        self.books = self.load(path)

    def add(self, book: Book):
        for b in self.books:
            if b.name == book.name:
                break
        else:
            self.books.append(book)

    def get_book(self, id: int):
        for b in self.books:
            if b.id == id:
                return b

    def del_book(self, id: int):
        for i in range(len(self.books)):
            if self.books[i].id == id:
                del self.books[i]
                return

    @staticmethod
    def load(path: str) -> list[Book]:
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
                    Book(
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

    @staticmethod
    def get_json_list_books(books: list[Book]) -> list[dict]:
        return [
            {
                "id": book.id,
                "name": book.name,
                "path": book.path,
                "author": book.author,
                "owner": book.owner,
                "access": book.access,
                "date_load": book.date_load,
            }
            for book in books
        ]

    def save(self):
        books = self.get_json_list_books(self.books)
        with open(self.path, "r+", encoding="utf-8") as f:
            f.seek(0)
            f.truncate()
            f.write(json.dumps(books, ensure_ascii=False, indent=4))


@dataclass
class User:
    id: int
    username: str
    id_select_book: int
    _language: str = "RU"
    admin: bool = False
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
        for key in self.reading:
            if key == book_id:
                del self.reading[key]

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

    def add(self, user: User):
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

    @staticmethod
    def load(path: str) -> list[User]:
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
                    User(
                        book["id"],
                        book["username"],
                        book["id_select_book"],
                        book["language"],
                        book["admin"],
                        book["books_read"],
                        book["marks"],
                        book["reading"],
                    )
                    for book in books
                ]

    @staticmethod
    def get_json_list_users(users: list[User]) -> list[dict]:
        return [
            {
                "id": user.id,
                "username": user.username,
                "id_select_book": user.id_select_book,
                "language": user.language,
                "books_read": user.books_read,
                "marks": user.marks,
                "admin": user.admin,
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

