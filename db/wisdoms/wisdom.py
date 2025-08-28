from dataclasses import dataclass, field
import json
from os.path import exists


import asyncio
import logging
import os
import sys

from db.connection import get_pg_connection
from config.config import Config, load_config
from psycopg import AsyncConnection, Error


config: Config = load_config()

logging.basicConfig(
    level=logging.getLevelName(level=config.log.level),
    format=config.log.format,
)

logger = logging.getLogger(__name__)

if sys.platform.startswith("win") or os.name == "nt":
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())


conn: AsyncConnection | None = None


async def get_connection():
    global conn
    try:
        conn = await get_pg_connection(
            db_name=config.db.name,
            host=config.db.host,
            port=config.db.port,
            user=config.db.user,
            password=config.db.password,
        )
    except Error as db_error:
        logger.exception("Database-specific error: %s", db_error)
    except Exception as e:
        logger.exception("Unhandled error: %s", e)


asyncio.run(get_connection())


FOLDER = "wisdoms/Paulo Coelho Maktub/"


@dataclass
class Page:
    number: int
    photo: str
    text: str


class DB_Wisdom:
    def __init__(self, path: str):
        self.path = path
        self.pages = self.load(path)

    def add(self, page: Page):
        for b in self.pages:
            if b.number == page.number:
                break
        else:
            self.pages.append(page)

    def get_page(self, number: int):
        for b in self.pages:
            if b.number == number:
                return b

    @staticmethod
    def load(path: str) -> list[Page]:
        if not exists(path):
            with open(path, "x", encoding="utf-8") as f:
                f.seek(0)
                f.truncate()
                f.write(json.dumps([], ensure_ascii=False, indent=4))
                return []

        with open(path, "r+", encoding="utf-8") as f:
            content = f.read()
            if content:
                pages = json.loads(content)
                return [
                    Page(page["number"], FOLDER + page["photo"], page["text"])
                    for page in pages
                ]

    @staticmethod
    def get_json_list_pages(pages: list[Page]) -> list[dict]:
        return [
            {
                "id": page.number,
                "name": page.photo,
                "path": page.text,
            }
            for page in pages
        ]

    def save(self):
        pages = self.get_json_list_pages(self.pages)
        with open(self.path, "r+", encoding="utf-8") as f:
            f.seek(0)
            f.truncate()
            f.write(json.dumps(pages, ensure_ascii=False, indent=4))

