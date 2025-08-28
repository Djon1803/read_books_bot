from aiogram.types import (
    KeyboardButton,
    ReplyKeyboardMarkup,
    ReplyKeyboardRemove,
    InlineKeyboardButton,
    InlineKeyboardMarkup,
)


def get_lang_settings_kb(
    lexicon: dict, locales: list[str], checked: str
) -> InlineKeyboardMarkup:
    buttons = []
    for locale in sorted(locales):
        if locale == "default":
            continue
        if locale == checked:
            buttons.append(
                [
                    InlineKeyboardButton(
                        text=f"🔘 {lexicon.get(locale)}", callback_data=locale
                    )
                ]
            )
        else:
            buttons.append(
                [
                    InlineKeyboardButton(
                        text=f"⚪️ {lexicon.get(locale)}", callback_data=locale
                    )
                ]
            )
    buttons.append(
        [
            InlineKeyboardButton(
                text=lexicon.get("cancel_lang_button_text"),
                callback_data="cancel_lang_button_data",
            ),
            InlineKeyboardButton(
                text=lexicon.get("save_lang_button_text"),
                callback_data="save_lang_button_data",
            ),
        ]
    )
    return InlineKeyboardMarkup(inline_keyboard=buttons)
