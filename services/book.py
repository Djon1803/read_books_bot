# Получение из текста страницу
def get_part_text(text: str, start: int, page_size: int):
    text = text[start : start + page_size]

    if len(text) < page_size:
        return text, len(text)

    len_text = len(text)
    last_char = 0
    old_char = None
    for i in range(len_text - 1, -1, -1):
        char = text[i]
        if char in ",.!:;?" and old_char in {None, " ", "\n", "\t"}:
            last_char = i
            break
        old_char = char
    else:
        last_char = -1
    page = text[: last_char + 1]
    return page, len(page)


# Разбиение книги на страницы
def prepare_text(text: str, page_size: int = 1000) -> dict[int, str]:
    pages: dict[int, str] = {}
    number_page = 1
    start = 0
    while start < len(text):
        page, size = get_part_text(text, start, page_size)
        
        pages[number_page] = page.lstrip()
        number_page += 1
        start += size
    return pages


# Разбиение книги на страницы
def prepare_book(path: str, page_size: int = 1000) -> dict[int, str]:
    pages: dict[int, str] = {}
    text: str = ""

    with open(path, "r", encoding="utf-8") as f:
        text = f.read()
    pages = prepare_text(text, page_size)
    return pages


if __name__ == "__main__":
    path = "page.txt"
    pages = prepare_book(path, 1024)
    for i in range(1, len(pages) + 1):
        print(f"\n\n\nстр. {i}: {pages[i]}")
