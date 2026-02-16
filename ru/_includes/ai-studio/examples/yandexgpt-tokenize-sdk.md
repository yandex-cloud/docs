```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_ai_studio_sdk import AIStudio

messages = "Управление генеративными моделями осуществляется с помощью промптов. Эффективный промпт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промпт, тем более точными будут результаты работы модели."


def main():
    sdk = AIStudio(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    model = sdk.models.completions("yandexgpt")

    result = model.tokenize(messages)

    for token in result:
        print(token)


if __name__ == "__main__":
    main()
```