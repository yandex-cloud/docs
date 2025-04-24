```python
#!/usr/bin/env python3

from __future__ import annotations

import pathlib
from yandex_cloud_ml_sdk import YCloudML
from yandex_cloud_ml_sdk.auth import YandexCloudCLIAuth


def main() -> None:

    sdk = YCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    # Так можно посмотреть список всех загруженных датасетов
    for dataset in sdk.datasets.list():
        print(f"List of existing datasets {dataset=}")

    # Так можно удалить все ранее загруженные датасеты
    # но лучше этого не делать, если не нужно
    # for dataset in sdk.datasets.list():
    #    dataset.delete()

    # Создаем датасет
    dataset_draft = sdk.datasets.draft_from_path(
        task_type="<тип_датасета>",
        path="<путь_к_файлу>",
        upload_format="jsonlines",
        name="<название>",
    )

    # Дождемся окончания загрузки данных и создания датасета
    operation = dataset_draft.upload_deferred()
    tuning_dataset = operation.wait()
    print(f"new {tuning_dataset=}")


if __name__ == "__main__":
    main()
```