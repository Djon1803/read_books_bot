from aiogram.types import BotCommand
from bot.enums.roles import UserRole


def get_main_menu_commands(lexicon: dict[str, str], role: UserRole):
    if role == UserRole.USER:
        return [
            BotCommand(command="/start", description=lexicon.get("/start")),
            BotCommand(command="/continue", description=lexicon.get("/continue")),
            BotCommand(command="/beginning", description=lexicon.get("/beginning")),
            BotCommand(command="/bookmarks", description=lexicon.get("/bookmarks")),
            BotCommand(command="/books", description=lexicon.get("/books")),
            BotCommand(command="/addbook", description=lexicon.get("/addbook")),
            BotCommand(command="/wisdom", description=lexicon.get("/wisdom")),
            BotCommand(command="/lang", description=lexicon.get("/lang_description")),
            BotCommand(command="/help", description=lexicon.get("/help_description")),
        ]
    elif role == UserRole.ADMIN:
        return [
            BotCommand(command="/start", description=lexicon.get("/start")),
            BotCommand(command="/continue", description=lexicon.get("/continue")),
            BotCommand(command="/beginning", description=lexicon.get("/beginning")),
            BotCommand(command="/bookmarks", description=lexicon.get("/bookmarks")),
            BotCommand(command="/books", description=lexicon.get("/books")),
            BotCommand(command="/addbook", description=lexicon.get("/addbook")),
            BotCommand(command="/wisdom", description=lexicon.get("/wisdom")),
            BotCommand(command="/lang", description=lexicon.get("/lang_description")),
            BotCommand(command="/help", description=lexicon.get("/help_description")),
            BotCommand(command="/ban", description=lexicon.get("/ban_description")),
            BotCommand(command="/unban", description=lexicon.get("/unban_description")),
            BotCommand(command="/users", description=lexicon.get("/users")),
            BotCommand(
                command="/statistics",
                description=lexicon.get("/statistics_description"),
            ),
        ]
