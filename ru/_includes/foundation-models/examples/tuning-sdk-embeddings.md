```python
#!/usr/bin/env python3

from __future__ import annotations
import uuid
from yandex_cloud_ml_sdk import YCloudML

# Конфигурация
folder = "<идентификатор_каталога>"
token = "<API-ключ>"
type = "<тип_датасета>"
dataset_id = "<идентификатор_датасета>"


def main():
    sdk = YCloudML(
        folder_id=folder,
        auth=token,
    )

    # Зададим датасет для обучения и базовую модель
    train_dataset = sdk.datasets.get(dataset_id)
    base_model = sdk.models.text_embeddings("text-embeddings")

    # Запускаем дообучение
    # Дообучение может длиться до нескольких часов
    tuning_task = base_model.tune_deferred(
        train_dataset, name=str(uuid.uuid4()), embeddings_tune_type=type
    )
    tuned_model = tuning_task.wait()
    print(f"Resulting {tuned_model}")


if __name__ == "__main__":
    main()
```