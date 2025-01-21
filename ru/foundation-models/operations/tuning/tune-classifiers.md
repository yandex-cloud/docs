---
title: Создать дообучение модели классификатора в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете создать датасет и дообучить модель классификатора в {{ foundation-models-name }} с помощью API и {{ ml-sdk-name }}.
---

# Создать дообучение модели классификатора в {{ foundation-models-name }}

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

Если стандартных моделей классификаторов вам недостаточно, вы можете дообучить модель классификатора на базе {{ gpt-lite }}, чтобы она точнее классифицировала ваши запросы.

## Перед началом работы {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Загрузите датасет {#create-dataset}

В зависимости от [типа классификации](../../concepts/classifier/index.md), для которого будет использоваться дообученная модель, подготовьте [данные для дообучения](../../concepts/tuning/classifier#data) модели в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8). Если вы хотите разбить данные на два датасета для обучения и валидации, повторите следующие шаги для каждого датасета. Используйте полученные в результате загрузки идентификаторы при запуске дообучения.

В этом примере дообучение запускается с использованием только обучающего датасета. 

Создайте датасет для дообучения:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `dataset-create.py` и добавьте в него код:

     {% include [dataset-sdk-cls](../../../_includes/foundation-models/examples/dataset-sdk-cls.md) %}

  1. Выполните созданный файл:

     ```bash
     python3 dataset-create.py
     ```

     Результат:

     ```text
     new dataset=AsyncDataset(id='fds7a7ieb0dh********', folder_id='b1gt6g8ht345********', name='YandexGPT tuning', description=None, metadata=None, created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 1, 20, 16, 19, 33), updated_at=datetime.datetime(2025, 1, 20, 16, 20, 19), labels=None, status=<DatasetStatus.READY: 3>, task_type='<тип_классификации>', rows=0, size_bytes=5679)
     ```

     Сохраните идентификатор созданного датасета (значение поля `id`) — он понадобится при дообучении модели.

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
         "task_type": "<тип_классификации>", 
         "upload_format": "jsonlines"
       }
     EOM
     ```

     Где:
     * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создается датасет.
     * `<тип_классификации>` — [тип классификации](../../concepts/classifier/index.md), для которой с помощью создаваемого датасета будет дообучаться модель. Возможные значения:

         * `TextClassificationMultilabel` — бинарная классификация или классификация с несколькими метками.
         * `TextClassificationMulticlass` — многоклассовая классификация.

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

## Запустите дообучение {#start-tuning}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `start-tuning.py` и добавьте в него код:

     {% include [sdk-tuning](../../../_includes/foundation-models/examples/tuning-sdk-cls.md) %}

     Где:

     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создан [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
     * `<API-ключ>` — [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта, полученный ранее и необходимый для [аутентификации в API](../../../foundation-models/api-ref/authentication.md).

         {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
     * `<идентификатор_датасета>` — сохраненный на предыдущем шаге идентификатор созданного датасета.
     * `<тип_классификации>` — [тип классификации](../../concepts/classifier/index.md), для которой будет дообучаться модель. Возможные значения:

         * `binary` — бинарная классификация.
         * `multilabel` — классификация с несколькими метками.
         * `multiclass` — многоклассовая классификация.

  1. Выполните созданный файл:

     ```bash
     python3 start-tuning.py
     ```

     Результат:

     ```text
     Resulting TextClassifiersModel(uri=cls://b1gt6g8ht345********/yandexgpt-lite/latest@tamrjs1t1368c********, config=TextClassifiersModelConfig(task_description=None, labels=None, samples=None))
     classification_result=TextClassifiersModelResult(predictions=(TextClassificationLabel(label='гнев', confidence=0.5534219145774841), TextClassificationLabel(label='грусть', confidence=0.00046947275404818356), TextClassificationLabel(label='радость', confidence=0.12941128015518188), TextClassificationLabel(label='страх', confidence=0.3008902668952942), TextClassificationLabel(label='удивление', confidence=0.015807058662176132)), model_version='')
     classification_result=TextClassifiersModelResult(predictions=(TextClassificationLabel(label='гнев', confidence=0.5534219145774841), TextClassificationLabel(label='грусть', confidence=0.00046947275404818356), TextClassificationLabel(label='радость', confidence=0.12941128015518188), TextClassificationLabel(label='страх', confidence=0.3008902668952942), TextClassificationLabel(label='удивление', confidence=0.015807058662176132)), model_version='')
     ```

     Дообучение модели может занять до 1 суток в зависимости от объема датасета и степени загрузки системы.

  Используйте полученный URI дообученной модели (значение поля `uri`) при [обращении](../../concepts/classifier/models#addressing-models) к ней.

- cURL {#curl}

  1. Запустите дообучение:

     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM-токен>" \
       -d @ \
       {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
       {
         "base_model_uri": "cls://<идентификатор_каталога>/yandexgpt-lite/latest",
         "train_datasets": [{"dataset_id": "<идентификатор_датасета>", "weight": 1.0}],
         "name": "my first model",
         "<тип_классификации>": {}
       } 
     EOM
     ```

     Где:
     * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором дообучается модель.
     * `<идентификатор_датасета>` — идентификатор датасета, сохраненный ранее.
     * `<тип_классификации>` — [тип классификации](../../concepts/classifier/index.md), для которой будет дообучаться модель. Возможные значения:

         * `text_classification_multilabel` — бинарная классификация или классификация с несколькими метками.
         * `text_classification_multiclass` — многоклассовая классификация.

     Результат:

     ```text
     {
       "id": "ftnlljf53kil********",
       "createdAt": "2025-01-20T11:17:33Z",
       "modifiedAt": "2025-01-20T11:17:33Z",
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata"
       }
     }
     ```

     В ответе сервис вернет объект [Operation](../../../api-design-guide/concepts/operation.md). Сохраните идентификатор (`id`) операции, полученный в ответе.

  1. Дообучение модели может занять до 1 суток в зависимости от объема датасета и степени загрузки системы. Чтобы проверить готовность дообучения, запросите статус операции:

     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM-токен>" \
       -d '{"operation_id": "<идентификатор_операции>"}' \
       {{ api-host-llm }}:443 yandex.cloud.operation.OperationService/Get
     ```

     Где:
     * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
     * `<идентификатор_операции>` — идентификатор операции дообучения модели, полученный на предыдущем шаге.

     Если дообучение завершилось, объект Operation будет содержать URI дообученной модели в поле `targetModelUri`:

     ```json
     {
       "id": "ftnc7at9r66t********",
       "createdAt": "2025-01-20T15:41:06Z",
       "modifiedAt": "2025-01-20T15:46:10Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftnc7at9r66t********"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "cls://b1gt6g8ht345********/yandexgpt-lite/latest@tamr8gqhetveg********",
         "tuningTaskId": "ftnc7at9r66t********"
       }
     }
     ```

  Используйте полученный URI дообученной модели (значение поля `targetModelUri`) при [обращении](../../concepts/classifier/models#addressing-models) к ней.

{% endlist %}

#### См. также {#see-also}

Больше примеров доступно в [репозитории на GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).