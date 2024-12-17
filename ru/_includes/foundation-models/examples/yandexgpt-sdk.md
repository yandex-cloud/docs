```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = [
    {
        "role": "system",
        "text": "Найди ошибки в тексте и исправь их",
    },
    {
        "role": "user",
        "text": """Ламинат подойдет для укладке на кухне или в детской 
комнате – он не боиться влаги и механических повреждений благодаря 
защитному слою из облицованных меламиновых пленок толщиной 0,2 мм и 
обработанным воском замкам.""",
    },
]


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    result = (
        sdk.models.completions("yandexgpt").configure(temperature=0.5).run(messages)
    )

    for alternative in result:
        print(alternative)


if __name__ == "__main__":
    main()
```