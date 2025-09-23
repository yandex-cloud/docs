```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = "Управление генеративными моделями осуществляется с помощью промтов. Эффективный промт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промт, тем более точными будут результаты работы модели."


def main():
    sdk = YCloudML(
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