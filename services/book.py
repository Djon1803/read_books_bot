# Получение из текста страницу
def _get_part_text(text: str, start: int, page_size: int):
    text = text[start:]
    len_text = len(text)
    last_char = 0
    for i in range(len_text):
        char = text[i]
        next_char = text[i + 1] if i + 1 < len_text else None
        if char in ",.!:;?" and next_char in {None, " ", "\n", "\t"}:
            if i < page_size:
                last_char = i
            else:
                break
    page = text[: last_char + 1]
    return page, len(page)


# Разбиение книги на страницы
def prepare_book(path: str, page_size: int = 1000) -> dict[int, str]:
    pages: dict[int, str] = {}
    text: str = ""

    with open(path, "r", encoding="utf-8") as f:
        text = f.read()

    number_page = 1
    start = 0
    while start < len(text):
        page, size = _get_part_text(text, start, page_size)
        pages[number_page] = page.lstrip()
        number_page += 1
        start += size
    return pages
