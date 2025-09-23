```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = [
    {"role": "system", "text": "Найди ошибки в тексте и исправь их"},
    {"role": "user", "text": "Ашипки саме сибя ни исрпвят."},
]


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    model = sdk.models.completions("yandexgpt")

    for result in model.configure(temperature=0.5).run_stream(messages):
        for alternative in result:
            print(alternative)


if __name__ == "__main__":
    main()
```