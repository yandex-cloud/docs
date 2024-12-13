```python
#!/usr/bin/env python3

from __future__ import annotations
from yandex_cloud_ml_sdk import YCloudML

request_text = "Vieta's formulas"

def main() -> None:
    sdk = YCloudML(folder_id="<идентификатор_каталога>", auth="<API-ключ>")

    model = sdk.models.text_classifiers('cls://<идентификатор_каталога>/<идентификатор_классификатора>')

    # The result will contain predictions within predefined classes
    # and the most weighty prediction will be "mathematics": 0.92
    result = model.run(request_text)

    for prediction in result:
        print(prediction)


if __name__ == '__main__':
    main()
```