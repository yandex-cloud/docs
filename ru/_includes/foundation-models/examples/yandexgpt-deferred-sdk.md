```python
#!/usr/bin/env python3

from __future__ import annotations
import time
from yandex_cloud_ml_sdk import YCloudML

messages_1 = [
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

messages_2 = [
    {"role": "system", "text": "Найди ошибки в тексте и исправь их"},
    {"role": "user", "text": "Ашипки саме сибя ни исрпвят."},
]


def main():

    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    model = sdk.models.completions("yandexgpt")

    # Variant 1: wait for the operation to complete using 5-second sleep periods

    print("Variant 1:")

    operation = model.configure(temperature=0.5).run_deferred(messages_1)

    status = operation.get_status()
    while status.is_running:
        time.sleep(5)
        status = operation.get_status()

    result = operation.get_result()
    print(result)

    # Variant 2: wait for the operation to complete using the wait method

    print("Variant 2:")

    operation = model.run_deferred(messages_2)

    result = operation.wait()
    print(result)


if __name__ == "__main__":
    main()
```