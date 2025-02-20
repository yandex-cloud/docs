---
title: Создать дообучение модели генерации текста в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете создать датасет и дообучить модель генерации текста в {{ foundation-models-name }} с помощью API и {{ ml-sdk-name }}.
---

# Создать дообучение модели генерации текста в {{ foundation-models-name }}

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

Этот пример показывает, как [дообучить модель](../../concepts/tuning/index.md) {{ gpt-lite }} по методу {{ lora }} в {{ foundation-models-name }}. Ссылки на другие примеры доступны в разделе [См. также](#see-also).

## Перед началом работы {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Загрузите датасет {#create-dataset}

Подготовьте [данные для дообучения](../../concepts/tuning/generating.md) модели в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8). Если вы хотите разбить данные на два датасета для обучения и валидации, повторите следующие шаги для каждого датасета. Используйте полученные в результате загрузки идентификаторы при запуске дообучения.

В этом примере дообучение запускается с использованием только обучающего датасета. 

Создайте датасет для дообучения:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `dataset-create.py` и добавьте в него код:

     {% include [sdk-dataset](../../../_includes/foundation-models/examples/dataset-sdk.md) %}

  1. Выполните созданный файл:

     ```bash
     python3 dataset-create.py
     ```

     Результат:

     ```text
     new dataset=AsyncDataset(id='fdsfehj6grsu********', folder_id='b1gt6g8ht345********', name='YandexGPT Lite tuning', description=None, metadata=None, created_by='ajegtlf2q28a********', created_at=datetime.datetime(2025, 1, 20, 11, 38, 19), updated_at=datetime.datetime(2025, 1, 20, 11, 39, 4), labels=None, status=<DatasetStatus.READY: 3>, task_type='TextToTextGeneration', rows=0, size_bytes=3514)
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
         "task_type": "TextToTextGeneration", 
         "upload_format": "jsonlines"
       }
     EOM
     ```

     Где:
     * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создается датасет.

     Результат:

     ```text
     {
       "datasetId": "fdso08c1u1cq********",
       "dataset": {
         "datasetId": "fdso08c1u1cq********",
         "folderId": "b1gt6g8ht345********",
         "name": "My awesome dataset",
         "status": "DRAFT",
         "taskType": "TextToTextGeneration",
         "createdAt": "2025-01-20T10:36:50Z",
         "updatedAt": "2025-01-20T10:36:50Z",
         "createdById": "ajeg2b2et02f********",
         "createdBy": "ajeg2b2et02f********"
       }
     }
     ```

     Сохраните идентификатор созданного датасета (значение поля `datasetId`) — он понадобится при загрузке данных в датасет.

  1. {% include [tuning-dataset-api-step2](../../../_includes/foundation-models/tuning-dataset-api-step2.md) %}

  1. {% include [tuning-dataset-api-step3](../../../_includes/foundation-models/tuning-dataset-api-step3.md) %}

  1. {% include [tuning-dataset-api-step4](../../../_includes/foundation-models/tuning-dataset-api-step4.md) %}

  1. {% include [tuning-dataset-api-step5](../../../_includes/foundation-models/tuning-dataset-api-step5.md) %}

{% endlist %}

## Запустите дообучение {#start-tuning}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `start-tuning.py` и добавьте в него код:

     {% include [sdk-tuning](../../../_includes/foundation-models/examples/tuning-sdk.md) %}

     Где:

     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создан [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
     * `<API-ключ>` — [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта, полученный ранее и необходимый для [аутентификации в API](../../../foundation-models/api-ref/authentication.md).

         {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
     * `<идентификатор_датасета>` — сохраненный на предыдущем шаге идентификатор созданного датасета.

  1. Выполните созданный файл:

     ```bash
     python3 start-tuning.py
     ```

     Результат:

     ```text
     Resulting GPTModelResult(alternatives=(Alternative(role='assistant', text='Меня зовут Женя. Полностью - Евгений Нейроныч.', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=14, completion_tokens=11, total_tokens=25), model_version='23.10.2024') 
     completion_result=GPTModelResult(alternatives=(Alternative(role='assistant', text='Из Перми', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=13, completion_tokens=2, total_tokens=15), model_version='23.10.2024') 
     ```

     Дообучение модели может занять до 1 суток в зависимости от объема датасета и загрузки системы.

  Используйте полученный URI дообученной модели (значение поля `uri`) при [обращении](../../concepts/yandexgpt/models.md#addressing-models) к ней.

  1. Метрики дообучения доступны в формате TensoBoard. Загруженный файл можно открыть, например, в проекте [{{ ml-platform-full-name }}]({{ link-datasphere-main }}):
  
     ```python
     metrics_url = new_model.get_metrics_url()
     download_tensorboard(metrics_url)
     ```


- cURL {#curl}

  1. Запустите дообучение:

     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM-токен>" \
       -d @ \
       {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
       {
         "base_model_uri": "gpt://<идентификатор_каталога>/yandexgpt-lite/latest",
         "train_datasets": [{"dataset_id": "<идентификатор_датасета>", "weight": 1.0}],
         "name": "my first model",
         "text_to_text_completion": {}
       } 
     EOM
     ```

     Где:
     * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором дообучается модель.
     * `<идентификатор_датасета>` — идентификатор датасета, сохраненный ранее.

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
       "id": "ftnlljf53kil********",
       "createdAt": "2025-01-20T11:17:33Z",
       "modifiedAt": "2025-01-20T11:25:40Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftnlljf53kil********"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest@tamr2nc6pev5e********",
         "tuningTaskId": "ftnlljf53kil********"
       }
     }
     ```

  Используйте полученный URI дообученной модели (значение поля `targetModelUri`) при [обращении](../../concepts/yandexgpt/models.md#addressing-models) к ней.

  1. Метрики дообучения доступны в формате TensoBoard. Получите ссылку, чтобы загрузить файл: 
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM-токен>" \
       -d '{"task_id": "<идентификатор_задания>"}' \
       {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/GetMetricsUrl
     ```

     Загруженный файл можно открыть, например, в проекте [{{ ml-platform-full-name }}]({{ link-datasphere-main }}).

{% endlist %}

### Обращение к дообученной модели {#model-call}

После завершения операции дообучения сохраните URI дообученной модели вида `gpt://<URI_базовой_модели>/<версия>@<суффикс_дообучения>`. Используйте его, чтобы отправлять [синхронные](../yandexgpt/create-prompt.md) и [асинхронные](../yandexgpt/async-request.md) запросы или [создать AI-ассистента](../assistant/create.md) на основе дообученной модели. 

#### См. также {#see-also}

* [{#T}](../../concepts/tuning/index.md)
* [{#T}](./tune-classifiers.md)
* Больше примеров SDK доступно в [репозитории на GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).