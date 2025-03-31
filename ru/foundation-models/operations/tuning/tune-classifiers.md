---
title: Создать дообучение модели классификатора в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете создать датасет и дообучить модель классификатора в {{ foundation-models-name }} с помощью {{ ai-playground }}, API и {{ ml-sdk-name }}.
---

# Дообучить модель классификации текста

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

Если стандартных моделей классификаторов вам недостаточно, вы можете [дообучить модель](../../concepts/tuning/index.md) классификатора на базе {{ gpt-lite }}, чтобы она точнее классифицировала ваши запросы.

## Перед началом работы {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Загрузите датасет {#create-dataset}

В зависимости от [типа классификации](../../concepts/classifier/index.md), для которого будет использоваться дообученная модель, подготовьте [данные для дообучения](../../concepts/resources/dataset.md#classifier) модели в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://{{ lang }}.wikipedia.org/wiki/UTF-8). Если вы хотите разбить данные на два датасета для обучения и валидации, повторите следующие шаги для каждого датасета. Используйте полученные в результате загрузки идентификаторы при запуске дообучения.

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

  1. В поле **{{ ui-key.yacloud.common.type }}** выберите тип классификации: **{{ ui-key.yacloud.dataset.text-classification-multilabel-key-value }}** или **{{ ui-key.yacloud.dataset.text-classification-multiclass-key-value }}**.
  1. Добавьте или удалите [метки](../../../resource-manager/concepts/labels.md) датасета. Они позволяют разделить и сгруппировать ресурсы на логические группы.
  1. Нажмите **Выбрать файл** или перетащите созданный ранее JSON-файл в зону загрузки.
  1. Нажмите **{{ ui-key.yacloud.dataset.create }}**.

- SDK {#sdk}

  1. Создайте файл `dataset-create.py` и добавьте в него код:

     {% include [dataset-sdk-cls](../../../_includes/foundation-models/examples/dataset-sdk-cls.md) %}

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

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роли](../../security/index.md) `ai.playground.user`, `ai.datasets.user` и `ai.models.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud.tuning.tunings }}**.
  1. Нажмите **{{ ui-key.yacloud.tuning.train-model }}**.
  1. Введите имя и описания датасета. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. В поле **{{ ui-key.yacloud.tuning.task }}** выберите **{{ ui-key.yacloud.tuning.classification }}**.
  1. Выберите **{{ ui-key.yacloud.tuning.classification-task }}**: **{{ ui-key.yacloud.dataset.text-classification-multiclass.short-title }}** или **{{ ui-key.yacloud.dataset.text-classification-multilabel.short-title }}**.
  1. (Опционально) Добавьте или удалите [метки](../../../resource-manager/concepts/labels.md) дообучения. Они позволяют разделить и сгруппировать ресурсы на логические группы.
  1. В поле **{{ ui-key.yacloud.yagpt.model }}** выберите нужную модель.
  1. В поле **{{ ui-key.yacloud.dataset.dataset }}** нажмите **{{ ui-key.yacloud.common.add }}**.
  1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud.dataset.select-from-created }}** и выберите созданный ранее датасет.
  1. Нажмите **{{ ui-key.yacloud.tuning.addition-params }}**, чтобы провести тонкую настройку дообучения.
  1. Нажмите **{{ ui-key.yacloud.tuning.start-tuning }}**.

- SDK {#sdk}

  1. Создайте файл `start-tuning.py` и добавьте в него код:

     {% include [tuning-sdk-cls](../../../_includes/foundation-models/examples/tuning-sdk-cls.md) %}

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
     Resulting TextClassifiersModel(uri=cls://b1gt6g8ht345********/yandexgpt-lite/
     latest@tamrqj184r59v********, config=TextClassifiersModelConfig(task_description=None, labels=None, 
     samples=None))
     classification_result=TextClassifiersModelResult(predictions=(TextClassificationLabel(label='гнев', 
     confidence=0.0026986361481249332), TextClassificationLabel(label='грусть', confidence=0.
     0013768149074167013), TextClassificationLabel(label='радость', confidence=0.00017048732843250036), 
     TextClassificationLabel(label='страх', confidence=0.9950377345085144), TextClassificationLabel
     (label='удивление', confidence=0.0007163778645917773)), model_version='')
     classification_result=TextClassifiersModelResult(predictions=(TextClassificationLabel(label='гнев', 
     confidence=0.00042847482836805284), TextClassificationLabel(label='грусть', confidence=1.
     9441255062702112e-05), TextClassificationLabel(label='радость', confidence=2.6669084718378144e-07), 
     TextClassificationLabel(label='страх', confidence=0.999543309211731), TextClassificationLabel
     (label='удивление', confidence=8.627005627204198e-06)), model_version='')
     ```

     Дообучение модели может занять до 1 суток в зависимости от объема датасета и степени загрузки системы.

     Используйте полученный URI дообученной модели (значение поля `uri`) при [обращении](../../concepts/classifier/models#addressing-models) к ней.

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

  1. Метрики дообучения доступны в формате TensorBoard. Получите ссылку, чтобы загрузить файл: 
  
     ```bash
     grpcurl \
       -H "Authorization: Bearer <IAM-токен>" \
       -d '{"task_id": "<идентификатор_задания>"}' \
       {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/GetMetricsUrl
     ```

     Загруженный файл можно открыть, например, в проекте [{{ ml-platform-full-name }}]({{ link-datasphere-main }}).

{% endlist %}

### Обращение к дообученному классификатору {#model-call}

После завершения операции дообучения сохраните URI дообученной модели вида `cls://<URI_базовой_модели>/<версия>@<суффикс_дообучения>`. Используйте его, чтобы отправлять [синхронные](../classifier/additionally-trained.md) запросы к дообученному классификатору. 


#### См. также {#see-also}

* [{#T}](../../tutorials/models-fine-tuning.md)
* Больше примеров доступно в [репозитории на GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).