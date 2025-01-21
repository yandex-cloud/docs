```python
#!/usr/bin/env python3

from __future__ import annotations
import pathlib
import uuid
from yandex_cloud_ml_sdk import YCloudML


def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path


def main():
    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    # Посмотрим список датасетов, прошедших валидацию
    for dataset in sdk.datasets.list(status="READY", name_pattern="multiclass"):
        print(f"List of existing datasets {dataset=}")

    # Зададим датасет для обучения и базовую модель
    train_dataset = sdk.datasets.get("<идентификатор_датасета>")
    base_model = sdk.models.text_classifiers("yandexgpt-lite")

    # Определяем минимальные параметры
    # Используйте base_model.tune_deferred(), чтобы контролировать больше параметров
    tuned_model = base_model.tune(
        train_dataset, name=str(uuid.uuid4()), classification_type="<тип_классификации>"
    )
    print(f"Resulting {tuned_model}")

    # Запускаем дообучение
    classification_result = tuned_model.run("hey!")
    print(f"{classification_result=}")

    # Сохраним URI дообученной модели
    tuned_uri = tuned_model.uri
    model = sdk.models.text_classifiers(tuned_uri)

    classification_result = model.run("hey!")
    print(f"{classification_result=}")


if __name__ == "__main__":
    main()
```