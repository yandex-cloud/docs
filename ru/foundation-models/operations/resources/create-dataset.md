---
title: Как создать датасет в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете создать любой датасет в {{ foundation-models-name }} в консоли управления, с помощью API и {{ ml-sdk-name }}.
---

# Создать датасет

## Перед началом работы {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}


Подготовьте файл [датасета](../../concepts/resources/dataset.md) в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8). Структура содержимого датасета зависит от его типа.

## Получите JSON-схему датасета {#get-schema}

Если вам необходима JSON-схема, чтобы подготовить данные, вы можете получить структуру любого типа датасета с помощью запроса API:

{% list tabs group=programming_language %}

- cURL {#curl}

  ```json
  grpcurl \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{"task_type": "<тип_датасета>"}' \
    llm.api.cloud.yandex.net:443 yandex.cloud.ai.dataset.v1.DatasetService.ListUploadSchemas
  ```
  
  Где:
  * `<IAM-токе>`
  * `<тип_датасета>` — тип датасета, для которого вы запрашиваете JSON-схему. Доступные значения:
  
    {% include [dataset-types](../../../_includes/foundation-models/dataset-types.md) %}

{% endlist %}

## Загрузите датасет {#create-dataset}

{% list tabs group=programming_language %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роли](../../security/index.md) `ai.playground.user` и `ai.datasets.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. Нажмите **{{ ui-key.yacloud.dataset.create }}**.
  1. Введите имя и описания датасета. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. В поле **{{ ui-key.yacloud.common.type }}** выберите тип датасета.
  1. (Опционально) Добавьте или удалите [метки](../../../resource-manager/concepts/labels.md) датасета. Они позволяют сгруппировать ресурсы в логические группы.
  1. Нажмите **Выбрать файл** или перетащите созданный ранее JSON-файл в зону загрузки.
  1. Нажмите **{{ ui-key.yacloud.dataset.create }}**.

- SDK {#sdk}

  1. Создайте файл `dataset-create.py` и добавьте в него код:

     {% include [dataset-sdk](../../../_includes/foundation-models/examples/dataset-sdk-create.md) %}

     Где:
     * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создается датасет.
     * `<путь_к_файлу>` — путь к заранее подготовленному файлу.
     * `<тип_датасета>` — [тип](#get-schema) создаваемого датасета. 

  1. Выполните созданный файл:

     ```bash
     python3 dataset-create.py
     ```

     Результат:

     ```text
     new tuning_dataset=Dataset(id='fds6vl5ttl0n********', folder_id='b1gt6g8ht345********', name='YandexGPT 
     Lite tuning', description=None, metadata=None, created_by='ajegtlf2q28a********', created_at=datetime.
     datetime(2025, 3, 13, 8, 12, 43), updated_at=datetime.datetime(2025, 3, 13, 8, 13, 17), labels=None, 
     allow_data_logging=False, status=<DatasetStatus.READY: 3>, task_type='TextClassificationMulticlass', 
     rows=4, size_bytes=5679, validation_errors=())
     ```

     Сохраните идентификатор созданного датасета (значение поля `id`) — он понадобится для запуска модели.

- cURL {#curl}

  1. Создайте датасет:
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM-токен>" \
       -d @ \
       {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/Create <<EOM
       {
         "folder_id": "<идентификатор_каталога>", 
         "name": "My awesome dataset", 
         "task_type": "<тип_датасета>", 
         "upload_format": "jsonlines"
       }
     EOM
     ```

     Где:
     * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создается датасет.
     * `<тип_датасета>` — [тип](#get-schema) создаваемого датасета. 

     Результат:

     ```text
     {
       "datasetId": "fds8hd01tset********",
       "dataset": {
         "datasetId": "fds8hd01tset********",
         "folderId": "b1gt6g8ht345********",
         "name": "My awesome dataset",
         "status": "DRAFT",
         "taskType": "<указанный_в_запросе_тип_задачи>",
         "createdAt": "2025-01-20T14:51:34Z",
         "updatedAt": "2025-01-20T14:51:34Z",
         "createdById": "ajeg2b2et02f********",
         "createdBy": "ajeg2b2et02f********"
       }
     }
     ```

     Сохраните идентификатор созданного датасета (значение поля `datasetId`) он понадобится при загрузке данных в датасет.

  1. {% include [tuning-dataset-api-step2](../../../_includes/foundation-models/tuning-dataset-api-step2.md) %}

  1. {% include [tuning-dataset-api-step3](../../../_includes/foundation-models/tuning-dataset-api-step3.md) %}

  1. {% include [tuning-dataset-api-step4](../../../_includes/foundation-models/tuning-dataset-api-step4.md) %}

  1. {% include [tuning-dataset-api-step5](../../../_includes/foundation-models/tuning-dataset-api-step5.md) %}

{% endlist %}