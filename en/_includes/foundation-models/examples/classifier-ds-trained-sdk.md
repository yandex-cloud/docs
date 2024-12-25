```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

request_text = "Vieta's formulas"

def main() -> None:
    sdk = YCloudML(folder_id="<folder_ID>", auth="<API_key>")

    model = sdk.models.text_classifiers('cls://<folder_ID>/<classifier_ID>')

    # The result will contain predictions within predefined classes
    # and the most weighty prediction will be "mathematics": 0.92
    result = model.run(request_text)

    for prediction in result:
        print(prediction)


if __name__ == '__main__':
    main()
```