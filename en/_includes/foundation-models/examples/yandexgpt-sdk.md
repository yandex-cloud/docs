```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

messages = '[\
              {\
                "role": "system",\
                "text": "Find errors in the text and correct them"\
              },\
              {\
                "role": "user",\
                "text": "Laminate flooring is sutiable for instalation in the kitchen or in a child's \
                room. It withsatnds moisturre and mechanical dammage thanks to \
                a 0.2 mm thick proctive layer of melamine films and \
                a wax-treated interlocking system."\
              }\
            ]'

def main() -> None:
    sdk = YCloudML(folder_id='<folder_ID>', auth="<API_key>")

    result = sdk.models.completions('yandexgpt').configure(temperature=0.5).run(messages)

    for alternative in result:
        print(alternative)

if __name__ == '__main__':
    main()
```