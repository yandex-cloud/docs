```python
#!/usr/bin/env python3
# pylint: disable=duplicate-code

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

request_text = 'translate into Russian \"what\'s the weather like in London?\"'


def main():
    sdk = YCloudML(
        folder_id="<folder_ID>",
        auth="<API_key>",
    )

    # Sample 1: Zero-shot classification
    model = sdk.models.text_classifiers("yandexgpt").configure(
        task_description="determine the intent type",
        labels=["translation", "alarm", "weather"],
    )

    result = model.run(request_text)

    print("Zero-shot classification:")

    for prediction in result:
        print(prediction)

    # Sample 2: Few-shot classification
    model = model.configure(
        task_description="determine the intent type",
        labels=["translation", "alarm", "weather"],
        samples=[
            {"text": "set an alarm", "label": "alarm"},
            {"text": "weather for tomorrow", "label": "weather"},
            {"text": "translate the phrase \"set an alarm\"", "label": "translation"},
        ],
    )

    result = model.run(request_text)

    print("Few-shot classification:")

    for prediction in result:
        print(prediction)


if __name__ == "__main__":
    main()
```