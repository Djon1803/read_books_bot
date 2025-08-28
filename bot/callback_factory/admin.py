from aiogram.filters.callback_data import CallbackData


class AdminEditUserCallbackFactory(CallbackData, prefix='admin_edit_user'):
    user_id: int


class SetWisdomCallbackFactory(CallbackData, prefix='set_wisdom'):
    user_id: int
    value: bool

class SetlanguageCallbackFactory(CallbackData, prefix='set_language'):
    user_id: int
    value: str