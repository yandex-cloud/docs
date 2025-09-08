---
title: Создать дообучение модели эмбеддингов в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете создать датасет и дообучить модель эмбеддингов в {{ foundation-models-name }} с помощью {{ ai-playground }}, API и {{ ml-sdk-name }}.
---

# Дообучить модель эмбеддингов

{% include [lora-tuning-preview](../../../_includes/foundation-models/lora-tuning-preview.md) %}

Этот пример показывает, как [дообучить модель](../../concepts/tuning/index.md) эмбеддингов по методу {{ lora }} в {{ foundation-models-name }}. Ссылки на другие примеры доступны в разделе [См. также](#see-also).

## Перед началом работы {#before-begin}

{% include [tuning-before-beginning](../../../_includes/foundation-models/tuning-before-beginning.md) %}

## Подготовьте данные {#create-dataset}

1. Подготовьте данные в необходимом [формате](../../concepts/resources/dataset.md#embeddings). Для дообучения модели эмбеддингов используйте датасеты пар `TextEmbeddingPairParams` или триплетов `TextEmbeddingTripletParams`.
1. [Создайте датасет](../resources/create-dataset.md) любым удобным способом. В консоли управления вы также сможете создать датасет позднее на этапе создания дообучения.

## Запустите дообучение {#start-tuning}

{% list tabs group=programming_language %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роли](../../security/index.md) `ai.playground.user`, `ai.datasets.user` и `ai.models.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud.tuning.tunings }}**.
  1. Нажмите **{{ ui-key.yacloud.tuning.train-model }}**.
  1. Введите имя и описание дообученной модели. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. (Опционально) Добавьте или удалите [метки](../../../resource-manager/concepts/labels.md) дообучения. Они позволяют разделить и сгруппировать ресурсы на логические группы.
  1. В поле **{{ ui-key.yacloud.tuning.task }}** выберите `{{ ui-key.yacloud.tuning.embedding }}`.
  1. Выберите **{{ ui-key.yacloud.tuning.embedding-type}}**, соответствующий подготовленному датасету. 
  1. В поле **{{ ui-key.yacloud.yagpt.model }}** выберите нужную модель.
  1. В поле **{{ ui-key.yacloud.dataset.dataset }}** нажмите ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.common.add }}**.
  1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud.dataset.select-from-created }}** и выберите созданный ранее датасет.
  1. Нажмите **{{ ui-key.yacloud.tuning.addition-params }}**, чтобы провести тонкую настройку дообучения.
  1. Нажмите **{{ ui-key.yacloud.tuning.start-tuning }}**.

- SDK {#sdk}

  1. Создайте файл `start-tuning.py` и добавьте в него код:

     {% include [sdk-tuning-embeddings](../../../_includes/foundation-models/examples/tuning-sdk-embeddings.md) %}

     Где:

     * `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создан [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md).
     * `<API-ключ>` — [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта, полученный ранее и необходимый для [аутентификации в API](../../../foundation-models/api-ref/authentication.md).

         {% include [sdk-auth-details-paragraph](../../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
     * `<тип_датасета>` — тип созданного ранее [датасета](../../concepts/resources/dataset.md#embeddings). Возможные значения: `pair` (пара) и `triplet` (триплет).
     * `<идентификатор_датасета>` — идентификатор созданного ранее датасета для обучения.

  1. Выполните созданный файл:

     ```bash
     python3 start-tuning.py
     ```

     Дообучение модели может занять до 1 суток в зависимости от объема датасета и загрузки системы.

     Используйте полученный URI дообученной модели (значение поля `uri`) при обращении к ней.

  1. Метрики дообучения доступны в формате TensorBoard. Загруженный файл можно открыть, например, в проекте [{{ ml-platform-full-name }}]({{ link-datasphere-main }}):
  
     ```python
     metrics_url = new_model.get_metrics_url()
     download_tensorboard(metrics_url)
     ```

- cURL {#curl}

  1. Запустите дообучение.
     
     * С датасетом пар:

       ```bash
       grpcurl \
         -H "Authorization: Bearer <IAM-токен>" \
         -d @ \
         {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
         {
           "base_model_uri": "emb://<идентификатор_каталога>/text-embeddings/latest",
           "train_datasets": [{"dataset_id": "<идентификатор_датасета>", "weight": 1.0}],
           "name": "train-embeddings",
           "text_embedding_pair_params": {}
         } 
       EOM
       ```

     * С датасетом триплетов:
     
       ```bash
       grpcurl \
         -H "Authorization: Bearer <IAM-токен>" \
         -d @ \
         {{ api-host-llm }}:443 yandex.cloud.ai.tuning.v1.TuningService/Tune <<EOM
         {
           "base_model_uri": "emb://<идентификатор_каталога>/text-embeddings/latest",
           "train_datasets": [{"dataset_id": "<идентификатор_датасета>", "weight": 1.0}],
           "name": "train-embeddings",
           "text_embedding_triplet_params": {}
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
       "id": "ftna7bps63gh********",
       "createdAt": "2025-07-16T10:44:57Z",
       "modifiedAt": "2025-07-16T10:44:57Z",
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "CREATED",
         "tuningTaskId": "ftna7bps63gh********"
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
       "id": "ftna7bps63gh********",
       "createdAt": "2025-07-16T10:44:57Z",
       "modifiedAt": "2025-07-16T10:48:07Z",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningMetadata",
         "status": "COMPLETED",
         "tuningTaskId": "ftna7bps63gh********"
       },
       "response": {
         "@type": "type.googleapis.com/yandex.cloud.ai.tuning.v1.TuningResponse",
         "status": "COMPLETED",
         "targetModelUri": "emb://b1gt6g8ht345********/text-embeddings/latest@tamr0j6m2crpi********",
         "tuningTaskId": "ftna7bps63gh********"
       }
     }
     ```

     Используйте полученный URI дообученной модели (значение поля `targetModelUri`) при [обращении](../../concepts/generation/models.md#addressing-models) к ней.

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

После завершения операции дообучения сохраните URI дообученной модели вида `emb://<идентификатор_каталога>/text-embeddings/latest@<суффикс_дообучения>`. Используйте его в качестве пользовательской модели эмбеддингов, если это необходимо. Например, можно указать `model_uri` при [построении поискового индекса](../../concepts/assistant/search-index.md).

#### См. также {#see-also}

* [{#T}](../../concepts/tuning/index.md)
* [{#T}](./create.md)
* [{#T}](./tune-classifiers.md)
* [{#T}](../../tutorials/models-fine-tuning.md)
* Больше примеров SDK доступно в [репозитории на GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/classifiers_tuning/examples/sync/tuning).