---
title: Создать дообучение модели генерации текста в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете создать датасет и дообучить модель генерации текста в {{ foundation-models-name }} с помощью {{ ai-playground }}, API и {{ ml-sdk-name }}.
---

# Дообучить модель генерации текста

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

Этот пример показывает, как [дообучить модель](../../concepts/tuning/index.md) {{ gpt-lite }} по методу {{ lora }} в {{ foundation-models-name }}. Ссылки на другие примеры доступны в разделе [См. также](#see-also).

## Перед началом работы {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Загрузите датасет {#create-dataset}

Подготовьте [данные для дообучения](../../concepts/resources/dataset.md#generating) модели в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8). Если вы хотите разбить данные на два датасета для обучения и валидации, повторите следующие шаги для каждого датасета. Используйте полученные в результате загрузки идентификаторы при запуске дообучения.

В этом примере дообучение запускается с использованием только обучающего датасета. 

Создайте датасет для дообучения:

{% list tabs group=programming_language %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роли](../../security/index.md) `ai.playground.user` и `ai.datasets.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.dataset.datasets }}**.
  1. Нажмите **{{ ui-key.yacloud.dataset.create }}**.
  1. Введите имя и описания датасета. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. В поле **{{ ui-key.yacloud.common.type }}** выберите **{{ ui-key.yacloud.yagpt.foundation-models.playground.text-generation.title }}**.
  1. Добавьте или удалите [метки](../../../resource-manager/concepts/labels.md) датасета. Они позволяют разделить и сгруппировать ресурсы на логические группы.
  1. Нажмите **Выбрать файл** или перетащите созданный ранее JSON-файл в зону загрузки.
  1. Нажмите **{{ ui-key.yacloud.dataset.create }}**.

- SDK {#sdk}

  1. Создайте файл `dataset-create.py` и добавьте в него код:

     {% include [sdk-dataset](../../../_includes/foundation-models/examples/dataset-sdk.md) %}

  1. Выполните созданный файл:

     ```bash
     python3 dataset-create.py
     ```

     Результат:

     ```text
     new tuning_dataset=Dataset(id='fdsv21bmp09v********', folder_id='b1gt6g8ht345********', name=
     'YandexGPT Lite tuning', description=None, metadata=None, created_by='ajegtlf2q28a********', 
     created_at=datetime.datetime(2025, 3, 12, 19, 31, 44), updated_at=datetime.datetime(2025, 3, 
     12, 19, 32, 20), labels=None, allow_data_logging=False, status=<DatasetStatus.READY: 3>, 
     task_type='TextToTextGeneration', rows=3, size_bytes=3514, validation_errors=())
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

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роли](../../security/index.md) `ai.playground.user`, `ai.datasets.user` и `ai.models.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud.tuning.tunings }}**.
  1. Нажмите **{{ ui-key.yacloud.tuning.train-model }}**.
  1. Введите имя и описания датасета. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. В поле **{{ ui-key.yacloud.tuning.task }}** выберите **{{ ui-key.yacloud.tuning.generation }}**.
  1. (Опционально) Добавьте или удалите [метки](../../../resource-manager/concepts/labels.md) дообучения. Они позволяют разделить и сгруппировать ресурсы на логические группы.
  1. В поле **{{ ui-key.yacloud.yagpt.model }}** выберите нужную модель.
  1. В поле **{{ ui-key.yacloud.dataset.dataset }}** нажмите **{{ ui-key.yacloud.common.add }}**.
  1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud.dataset.select-from-created }}** и выберите созданный ранее датасет.
  1. Нажмите **{{ ui-key.yacloud.tuning.addition-params }}**, чтобы провести тонкую настройку дообучения.
  1. Нажмите **{{ ui-key.yacloud.tuning.start-tuning }}**.

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
     Resulting GPTModel(uri=gpt://b1gt6g8ht345********/yandexgpt-lite/latest@tamrmgia22979********, 
     config=GPTModelConfig(temperature=None, max_tokens=None, reasoning_mode=None, response_format=None))
     completion_result=GPTModelResult(alternatives=(Alternative(role='assistant', text='Привет! Как дела?', 
     status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=12, completion_tokens=5, 
     total_tokens=17), model_version='23.10.2024')
     completion_result=GPTModelResult(alternatives=(Alternative(role='assistant', text='Здравствуйте! У меня 
     всё хорошо, спасибо. Как ваши дела?', status=<AlternativeStatus.FINAL: 3>),), usage=Usage
     (input_text_tokens=13, completion_tokens=13, total_tokens=26), model_version='23.10.2024')
     ```

     Дообучение модели может занять до 1 суток в зависимости от объема датасета и загрузки системы.

     Используйте полученный URI дообученной модели (значение поля `uri`) при [обращении](../../concepts/yandexgpt/models.md#addressing-models) к ней.

  1. Метрики дообучения доступны в формате TensorBoard. Загруженный файл можно открыть, например, в проекте [{{ ml-platform-full-name }}]({{ link-datasphere-main }}):
  
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

  1. Метрики дообучения доступны в формате TensorBoard. Получите ссылку, чтобы загрузить файл: 
  
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
* [{#T}](../../tutorials/models-fine-tuning.md)
* Больше примеров SDK доступно в [репозитории на GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).