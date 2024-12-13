```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = '[\
              {\
                "role": "system",\
                "text": "Исправь ошибки в тексте."\
              },\
              {\
                "role": "user",\
                "text": "Ашипки саме сибя ни исрпвят"\
              }\
            ]'

def main() -> None:
    sdk = YCloudML(folder_id='<идентификатор_каталога>', auth="<API-ключ>")

    model = sdk.models.completions('yandexgpt')

    for result in model.configure(temperature=0.5).run_stream(messages):
        for alternative in result:
            print(alternative)

if __name__ == '__main__':
    main()
```