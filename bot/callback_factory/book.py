from aiogram.filters.callback_data import CallbackData


class DelBookCallbackFactory(CallbackData, prefix='del_book'):
    id: int

class LoadBookCallbackFactory(CallbackData, prefix='load_book'):
    id: int

class SelectBookCallbackFactory(CallbackData, prefix='select_book'):
    id: int