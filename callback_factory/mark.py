from aiogram.filters.callback_data import CallbackData


class DelMarkCallbackFactory(CallbackData, prefix='del_mark'):
    book_id: int
    number_page: int

class ShowMarkCallbackFactory(CallbackData, prefix='show_mark'):
    book_id: int
    number_page: int