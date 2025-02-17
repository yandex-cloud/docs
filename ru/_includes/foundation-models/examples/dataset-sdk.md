```python
#!/usr/bin/env python3

from __future__ import annotations
import asyncio
import pathlib
from yandex_cloud_ml_sdk import AsyncYCloudML
from yandex_cloud_ml_sdk.auth import YandexCloudCLIAuth


def local_path(path: str) -> pathlib.Path:
    return pathlib.Path(__file__).parent / path


async def main():

    sdk = AsyncYCloudML(
        folder_id="<идентификатор_каталога>",
        auth="<API-ключ>",
    )

    # Создаем датасет для дообучения базовой модели {{ gpt-lite }}
    dataset_draft = sdk.datasets.draft_from_path(
        task_type="TextToTextGeneration",
        path="<путь_к_файлу>",
        upload_format="jsonlines",
        name="YandexGPT Lite tuning",
    )

    # Дождемся окончания загрузки данных и создания датасета
    operation = await dataset_draft.upload_deferred()
    tuning_dataset = await operation
    print(f"new {tuning_dataset=}")

    # Так можно посмотреть список всех загруженных датасетов
    for dataset in sdk.datasets.list():
        print(f"List of existing datasets {dataset=}")


if __name__ == "__main__":
    asyncio.run(main())
```

Где:

* `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создан [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
* `<API-ключ>` — [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта, полученный ранее и необходимый для [аутентификации в API](../../../foundation-models/api-ref/authentication.md).

    {% include [sdk-auth-details-paragraph](../sdk-auth-details-paragraph.md) %}
* `<путь_к_файлу>` — путь к файлу, содержащему заранее подготовленные примеры для дообучения модели.