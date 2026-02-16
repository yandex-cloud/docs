---
title: Как удалить датасет из {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете удалить датасет из {{ foundation-models-name }} в консоли управления, с помощью API и {{ ml-sdk-name }}.
---

# Удалить датасет

## Перед началом работы {#before-begin}

{% include [tuning-before-beginning](../../../_includes/ai-studio/tuning-before-beginning.md) %}

## Удалите датасет {#delete-dataset}

Чтобы удалить датасет:

{% list tabs group=programming_language %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), на который у вашего аккаунта есть [роли](../../security/index.md) `ai.playground.user` и `ai.datasets.editor` или выше.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}** выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. В открывшемся списке в строке с нужным датасетом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- SDK {#sdk}

  1. Создайте файл `dataset-delete.py` и добавьте в него следующий код:

      ```python
      from __future__ import annotations

      from yandex_ai_studio_sdk import AIStudio

      YANDEX_API_KEY = "<API-ключ>"
      YANDEX_FOLDER_ID = "<идентификатор_каталога>"
      DATASET_ID = "<идентификатор_датасета>"


      def main() -> None:

          sdk = AIStudio(
              folder_id=YANDEX_FOLDER_ID,
              auth=YANDEX_API_KEY,
          )

          # Сохраняем объект с удаляемым датасетом в переменную
          dataset_to_delete = sdk.datasets.get(dataset_id=DATASET_ID)

          # Удаляем датасет
          dataset_to_delete.delete()


      if __name__ == "__main__":
          main()
      ```

      Где:

      * `YANDEX_API_KEY` — полученный перед началом работы [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта.
      * `YANDEX_FOLDER_ID` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором находится удаляемый датасет.
      * `DATASET_ID` — идентификатор датасета, который необходимо удалить. Посмотреть список всех датасетов в каталоге можно в [консоли управления]({{ link-console-main }}) или с помощью [API](../../dataset/api-ref/grpc/Dataset/list.md).
      
          Через {{ ml-sdk-name }} посмотреть список датасетов в каталоге можно с помощью метода `list()`:

          ```python
          for dataset in sdk.datasets.list():
              print(f"List of existing datasets {dataset=}")
          ```
  1. Выполните созданный файл:

      ```bash
      python3 dataset-delete.py
      ```

      В результате указанный датасет будет удален.

- cURL {#curl}

  1. Получите идентификатор датасета, который вы хотите удалить:
  
      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d @ \
        {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/List <<EOM
        {
          "folder_id": "<идентификатор_каталога>"
        }
      EOM
      ```

      Где:
      * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
      * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создается датасет.

     Результат:

     ```json
      {
        "datasets": [
          {
            "datasetId": "fdsl9hf65509********",
            "folderId": "b1gt6g8ht345********",
            "name": "sample-dataset",
            "status": "READY",
            "taskType": "TextToTextGeneration",
            "createdAt": "2025-11-28T08:53:59Z",
            "updatedAt": "2025-11-28T08:54:38Z",
            "rows": "354",
            "sizeBytes": "32314",
            "createdById": "ajeol2afu1js********",
            "createdBy": "ajeol2afu1js********"
          }
        ]
      }
     ```

     Сохраните идентификатор удаляемого датасета (значение поля `datasetId`) — он понадобится при удалении датасета.

  1. Удалите датасет:

      ```bash
      grpcurl \
        -H "Authorization: Bearer <IAM-токен>" \
        -d @ \
        {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/Delete <<EOM
        {
          "dataset_id": "<идентификатор_датасета>"
        }
      EOM
      ```

      Где:
      * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
      * `<идентификатор_датасета>` — идентификатор датасета, сохраненный на предыдущем шаге.

     В результате gRPC-вызова указанный датасет будет удален.


{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-dataset.md)