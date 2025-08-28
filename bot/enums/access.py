from enum import Enum


class AccessBook(str, Enum):
    PUBLIC = "public"
    PRIVATE = "private"