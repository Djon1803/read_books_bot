from dataclasses import dataclass
from environs import Env


@dataclass
class TgBot:
    token: str  # Токен для доступа к телеграм-боту


@dataclass
class LogSettings:
    level: str
    format: str


@dataclass
class Config:
    tg_bot: TgBot
    users_db: str
    books_db: str
    log: LogSettings
    path_books: str


def load_config(path: str | None = None) -> Config:
    env = Env()
    env.read_env(path)
    return Config(
        tg_bot=TgBot(token=env("BOT_TOKEN")),
        users_db=env("DB_USERS"),
        books_db=env("DB_BOOKS"),
        log=LogSettings(level=env("LOG_LEVEL"), format=env("LOG_FORMAT")),
        path_books=env("PATH_BOOKS"),
    )
