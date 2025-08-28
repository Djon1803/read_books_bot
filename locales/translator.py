from locales.en import EN
from locales.ru import RU


def get_translations() -> dict[str, str | dict[str, str]]:
    return {
        "default": "ru",
        "en": EN,
        "ru": RU,
    }