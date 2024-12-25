```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = '[\
              {\
                "role": "system",\
                "text": "Correct errors in the text."\
              },\
              {\
                "role": "user",\
                "text": "Mistaiks wuil not correkt themselfs"\
              }\
            ]'

def main() -> None:
    sdk = YCloudML(folder_id='<folder_ID>', auth="<API_key>")

    model = sdk.models.completions('yandexgpt')

    for result in model.configure(temperature=0.5).run_stream(messages):
        for alternative in result:
            print(alternative)

if __name__ == '__main__':
    main()
```