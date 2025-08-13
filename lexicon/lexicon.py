LEXICON_RU: dict[str, str] = {
    "/start": "Привет читатель!\n\nЭто бот для чтения книг\n\nЧтобы посмотреть список команд - набери /help",
    "/help": """Это бот-читалка: 
    
    Доступные команды: 
    /start - Старт
    /help - Справка по работе бота
    /continue - Продолжить чтение
    /beginning - Перейти в начало книги
    /bookmarks - Посмотреть список закладок
    /books - Посмотреть список книг
    /addbook - Добавление книги
    /language - Выбор языка""",
    "/bookmarks": "Это список ваших закладок:",
    "page_next": ">>",
    "page_back": "<<",
    "edit_bookmarks": "Редактировать закладки",
    "edit_button": "❌ РЕДАКТИРОВАТЬ",
    "download_button": "📥 Скачать",
    "del": "❌",
    "download": "📥",
    "cancel": "ОТМЕНИТЬ",
    "no_bookmarks": "У вас пока нет ни одной закладки.\n\nЧтобы "
    "добавить страницу в закладки - во время чтения "
    "книги нажмите на кнопку с номером этой "
    "страницы\n\n/continue - продолжить чтение",
    "cancel_text": "Чтобы продолжить читать нажмите - /continue",
    "save_data": "Данные сохранены",
    "unknown_command": "Моя твоя не понимай!",
    "not_select_book": "У тебя не выбрана книга для чтения, выбери из каталога по команде /books",
    "error_not_select_book": "Упс, Книга не выбрана",
    "add_mark": "Страница добавлена в закладки",
    "first_page": "Ты и так на первой странице",
    "last_page": "Ты и так на последней странице",
    "books": "Книги:",
    "no_books": "К сожалению на данный момент нет опубликованных книг, если хочешь поделится книгой или рассказом командой /addbook",
    "no_del_books": "Нет книг которые вы могли бы удалить",
    "no_save_books": "Нет книг которые вы могли бы скачать",
    "no_book": "В базе не нашли данную книгу",
    "add_book": "Добавление книги",
    "input_name_book": "Введите название книги:",
    "input_author_book": "Введите автора книги:",
    "input_access_book": "Выберите доступность книги:",
    "access_general_button": "Доступно всем",
    "access_personal_button": "Доступно только мне",
    "access_general": "Общий",
    "access_personal": "Личный",
    "input_file_book": "Скиньте текстовый файл с книгой:",
    "select_access": "Выберите доступность нажав на кнопки",
    "added_book": "Книга добавлена в базу, можете его выбрать по команде /books",
    "only_txt_file": "Подходит только текстовые файлы с расширением .txt",
    "other_file": "Если хотели добавить книгу, сначала нужно написать команду /add_book",
    "del_book": "Книга не найдена, возможно была удалена",
    "cancel": "Отменить",
    "cancel_add_book_button": "Закрыть добавление книги",
    "info_book_name": "Книга:",
    "info_book_date_load": "Дата загрузки:",
    "info_book_author": "Автор:",
    "info_book_access": "Доступ:",
    "info_book_pages": "Кол-во страниц:",
    "select": "✅",
    "not_selected": "⠀ ",
    "edit": "✏️",
    "/language": "Языки: ",
    "ru": " Русский 🇷🇺",
    "en": " English 🇬🇧",
    "wisdom": "✨ Мудрость дня\nАктивные подписки:",
    "maktub": 'Пауло Коэльо "МАКТУБ"',

    "admin_users": "Пользователи", 
    "admin_books": "Книги", 
    "admin_wisdoms": "Постраничные истории",
}

LEXICON_COMMANDS_RU: dict[str, str] = {
    "/start": "Старт",
    "/help": "Справка по работе бота",
    "/continue": "Продолжить чтение",
    "/beginning": "Перейти в начало книги",
    "/bookmarks": "Посмотреть список закладок",
    "/books": "Посмотреть список книг",
    "/addbook": "Добавление книги",
    "/wisdom": "Ежедневные вдохновляющие истории",
    "/language": "Выбор языка",
}

LEXICON_EN: dict[str, str] = {
    "/start": "Hello, reader!\n\nThis is a book reading bot.\n\nTo see the list of commands, type /help",
    "/help": """This is a reading bot:

    Available commands:
    /start - Старт
    /help - Help on how to use the bot
    /continue - Continue reading
    /beginning - Go to the beginning of the book
    /bookmarks - View list of bookmarks
    /books - View list of books
    /addbook - Add a book
    /language - Select languages""",
    "/bookmarks": "Here is your list of bookmarks:",
    "page_next": ">>",
    "page_back": "<<",
    "edit_bookmarks": "Edit bookmarks",
    "edit_button": "❌ EDIT",
    "download_button": "📥 Download",
    "del": "❌",
    "download": "📥",
    "cancel": "CANCEL",
    "no_bookmarks": "You don't have any bookmarks yet.\n\nTo add a page to bookmarks - while reading the book, press the button with the page number\n\n/continue - continue reading",
    "cancel_text": "To continue reading, press /continue",
    "save_data": "Data saved",
    "unknown_command": "Unknown command",
    "not_select_book": "You haven't selected a book to read, choose one from the catalog using /books",
    "error_not_select_book": "Oops, no book selected",
    "add_mark": "Page added to bookmarks",
    "first_page": "You're already on the first page",
    "last_page": "You're already on the last page",
    "books": "Books:",
    "no_books": "Unfortunately, there are no books published yet. If you want to share a book or a story, use /addbook",
    "no_del_books": "There are no books you can delete",
    "no_save_books": "There are no books you can download",
    "no_book": "The book was not found in the database",
    "add_book": "Adding a book",
    "input_name_book": "Enter the book title:",
    "input_author_book": "Enter the author's name:",
    "input_access_book": "Select book access:",
    "access_general_button": "Available to everyone",
    "access_personal_button": "Available only to me",
    "access_general": "Public",
    "access_personal": "Private",
    "input_file_book": "Send a text file with the book:",
    "select_access": "Select access by clicking the buttons",
    "added_book": "Book added to the database, you can choose it using /books",
    "only_txt_file": "Only .txt text files are supported",
    "other_file": "If you wanted to add a book, first use the command /add_book",
    "del_book": "Book not found, it may have been deleted",
    "cancel_add_book_button": "Close book addition",
    "info_book_name": "Book:",
    "info_book_date_load": "Date uploaded:",
    "info_book_author": "Author:",
    "info_book_access": "Access:",
    "info_book_pages": "Number of pages:",
    "select": "✅",
    "not_selected": "⠀ ",
    "edit": "✏️",
    "/language": "Languages:",
    "ru": " Русский 🇷🇺",
    "en": " English 🇬🇧",
    "wisdom": "✨ Wisdom of the day\nActive subscriptions:",
    "maktub": 'Paulo Coelho "MAKTUB"',

    "admin_users": "Users",
    "admin_books": "Books",
    "admin_wisdoms": "Paged Stories",
}

LEXICON_COMMANDS_EN: dict[str, str] = {
    "/start": "Start",
    "/help": "Справка по работе бота",
    "/continue": "Продолжить чтение",
    "/beginning": "Перейти в начало книги",
    "/bookmarks": "Посмотреть список закладок",
    "/books": "Посмотреть список книг",
    "/addbook": "Добавление книги",
    "/wisdom": "Daily Inspirational Stories",
    "/language": "Выбор языка",
}


class Lexicon:
    def __init__(self, language: str = "RU"):
        self.lexicon: dict[str, str]
        self.lexicon_commands: dict[str, str]
        if language == "RU":
            self.lexicon = LEXICON_RU
            self.lexicon_commands = LEXICON_COMMANDS_RU
        else:
            self.lexicon = LEXICON_EN
            self.lexicon_commands = LEXICON_COMMANDS_EN
