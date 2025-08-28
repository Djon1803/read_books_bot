from aiogram.fsm.state import State, StatesGroup


class LangSG(StatesGroup):
    lang = State()


class AddBook(StatesGroup):
    name = State()
    author = State()
    # wisdom = State()
    access = State()
    upload = State()
