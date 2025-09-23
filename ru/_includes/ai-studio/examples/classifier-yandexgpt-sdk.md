```python
#!/usr/bin/env python3
# pylint: disable=duplicate-code

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

request_text = 'переведи на английский "какая погода в лондоне?"'


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    # Sample 1: Zero-shot classification
    model = sdk.models.text_classifiers("yandexgpt").configure(
        task_description="определи тип интента",
        labels=["перевод", "будильник", "погода"],
    )

    result = model.run(request_text)

    print("Zero-shot classification:")

    for prediction in result:
        print(prediction)

    # Sample 2: Few-shot classification
    model = model.configure(
        task_description="определи тип интента",
        labels=["перевод", "будильник", "погода"],
        samples=[
            {"text": "поставь будильник", "label": "будильник"},
            {"text": "погода на завтра", "label": "погода"},
            {"text": 'переведи фразу "поставь будильник"', "label": "перевод"},
        ],
    )

    result = model.run(request_text)

    print("Few-shot classification:")

    for prediction in result:
        print(prediction)


if __name__ == "__main__":
    main()
```