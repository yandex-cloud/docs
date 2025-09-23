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
    for dataset in sdk.datasets.list(status="READY", name_pattern="multiclass"):
        print(f"List of existing datasets {dataset=}")

    # Зададим датасет для обучения и базовую модель
    train_dataset = sdk.datasets.get("<идентификатор_датасета>")
    base_model = sdk.models.text_classifiers("yandexgpt-lite")

    # Определяем минимальные параметры
    # Используйте base_model.tune_deferred(), чтобы контролировать больше параметров
    # Запускаем дообучение
    tuned_model = base_model.tune(
        train_dataset, name=str(uuid.uuid4()), classification_type="<тип_классификации>"
    )
    print(f"Resulting {tuned_model}")

    # Можно обратиться к дообученной модели с помощью метода run()
    classification_result = tuned_model.run("Ничего себе!")
    print(f"{classification_result=}")

    # А можно сохранить URI дообученной модели
    # И вызывать дообученную модель по URI
    tuned_uri = tuned_model.uri
    model = sdk.models.text_classifiers(tuned_uri)
    classification_result = model.run("Круто!")
    print(f"{classification_result=}")


if __name__ == "__main__":
    main()
```