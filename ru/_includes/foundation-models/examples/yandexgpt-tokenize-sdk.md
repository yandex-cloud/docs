```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = '[\
              {\
                "role": "system",\
                "text": "Найди ошибки в тексте и исправь их"\
              },\
              {\
                "role": "user",\
                "text": "Ашипки саме сибя ни исрпвят."\
              }\
            ]'

def main() -> None:
    sdk = YCloudML(folder_id="<идентификатор_каталога>", auth="<API-ключ>")

    model = sdk.models.completions('yandexgpt')

    result = model.tokenize(messages)

    for token in result:
        print(token)

if __name__ == '__main__':
    main()
```