```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
import uuid
from yandex_cloud_ml_sdk import YCloudML


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    # Посмотрим список датасетов, прошедших валидацию
    for dataset in sdk.datasets.list(status="READY", name_pattern="completions"):
        print(f"List of existing datasets {dataset=}")

    # Зададим датасет для обучения и базовую модель
    train_dataset = sdk.datasets.get("<идентификатор_датасета>")
    base_model = sdk.models.completions("yandexgpt-lite")

    # Запускаем дообучение
    # Дообучение может длиться до нескольких часов
    tuned_model = base_model.tune(
        train_dataset, name=str(uuid.uuid4()), n_samples=10000
    )
    print(f"Resulting {tuned_model}")

    # Можно обратиться к дообученной модели с помощью метода run()
    completion_result = tuned_model.run("Привет!")
    print(f"{completion_result=}")

    # А можно сохранить URI дообученной модели
    # И вызывать дообученную модель по URI
    tuned_uri = tuned_model.uri
    model = sdk.models.completions(tuned_uri)
    completion_result = model.run("Как дела?")
    print(f"{completion_result=}")


if __name__ == "__main__":
    main()
```