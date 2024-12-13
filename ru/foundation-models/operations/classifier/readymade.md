# Использовать классификаторы по промту на базе {{ yagpt-name }}

Сервис {{ foundation-models-full-name }} предоставляет [классификаторы по промту](../../concepts/classifier/index.md) на базе {{ yagpt-name }} двух видов: [Zero-shot](../../concepts/classifier/index.md#zero-shot) и [Few-shot](../../concepts/classifier/index.md#few-shot). Чтобы направить запрос к классификатору по промту, используйте метод [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) Text Classification API или [{{ ml-sdk-full-name }}](../../sdk/index.md).

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}
  1. {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Отправьте запрос к классификатору {#request}

{% list tabs group=programming_language %}

- SDK {#sdk}

  В данный код входят два независимые друг от друга примера, иллюстрирующие различные варианты использования интерфейса SDK:
  * Пример 1: запрос к классификатору [Zero-shot](../../concepts/classifier/index.md#zero-shot).
  * Пример 2: запрос к классификатору [Few-shot](../../concepts/classifier/index.md#few-shot).

  1. Создайте файл `classify.py` и добавьте в него следующий код:

      {% include [classifier-yandexgpt-sdk](../../../_includes/foundation-models/examples/classifier-yandexgpt-sdk.md) %}

      Где:

      * `request_text` — текстовое содержимое сообщения.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Выполните созданный файл:

      ```bash
      python3 classify.py
      ```

      В ответе сервис вернет результаты классификации для обоих примеров с определенными значениями вероятности (`confidence`) отнесения текста запроса к каждому из классов:

      ```text
      Zero-shot classification:
      TextClassificationLabel(label='перевод', confidence=1.1142491374016572e-08)
      TextClassificationLabel(label='будильник', confidence=3.088581834731485e-08)
      TextClassificationLabel(label='погода', confidence=1.0)
      Few-shot classification:
      TextClassificationLabel(label='перевод', confidence=0.9954985976219177)
      TextClassificationLabel(label='будильник', confidence=3.306578582851216e-05)
      TextClassificationLabel(label='погода', confidence=0.004468236118555069)
      ```

- cURL {#curl}

  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  1. Создайте файл с телом запроса (например, `body.json`):

      {% cut "Классификатор Zero-shot" %}

      ```json
      {
        "modelUri": "cls://<идентификатор_каталога>/yandexgpt/latest",
        "text": "5:0",
        "task_description": "Определи категорию статьи по ее заголовку",
        "labels": [
          "культура",
          "технологии",
          "спорт"
        ]
      }
      ```

      Где:
      * `modelUri` — [идентификатор модели](../../../foundation-models/concepts/classifier/models.md), которая будет использоваться для классификации сообщения. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}.
      * `text` — текстовое содержимое сообщения.
      * `taskDescription` — текстовое описание задания для классификатора.
      * `labels` — массив классов.

          {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

      {% endcut %}

      {% cut "Классификатор Few-shot" %}

      ```json
      {
        "modelUri": "cls://<идентификатор_каталога>/yandexgpt/latest",
        "text": "переведи на английский \"какая погода в лондоне?\"",
        "task_description": "определи тип интента",
        "labels": [
          "перевод",
          "будильник",
          "погода"
        ],
        "samples": [
          {
            "text": "поставь будильник",
            "label": "будильник"
          },
          {
            "text": "погода на завтра",
            "label": "погода"
          },
          {
            "text": "переведи фразу \"поставь будильник\"",
            "label": "перевод"
          }
        ]
      }
      ```

      Где:
      * `modelUri` — [идентификатор модели](../../../foundation-models/concepts/classifier/models.md), которая будет использоваться для классификации сообщения. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}.
      * `text` — текстовое содержимое сообщения.
      * `taskDescription` — текстовое описание задания для классификатора.
      * `labels` — массив классов.

          {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

      * `samples` — массив с примерами запросов для классов, заданных в поле `labels`. Примеры запросов передаются в виде объектов, каждый из которых содержит один образец текстового запроса и класс, к которому такой запрос следует относить.

      {% endcut %}

  1. Отправьте запрос к классификатору, выполнив команду:

      ```bash
      export IAM_TOKEN=<IAM-токен>
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "@<путь_к_файлу_с_телом_запроса>" \
        "https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification"
      ```

      {% note info %}

      Эндпоинт `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification` работает только с классификаторами по промту. Для [дообученных классификаторов](additionally-trained.md) используйте `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification`.
      
      {% endnote %}

      В ответе сервис вернет результаты классификации с определенными значениями вероятности (`confidence`) отнесения текста запроса к каждому из классов:

      {% cut "Классификатор Zero-shot" %}

      ```json
      {
        "predictions": [
          {
            "label": "культура",
            "confidence": 2.2111835562554916e-7
          },
          {
            "label": "технологии",
            "confidence": 0.0003487042267806828
          },
          {
            "label": "спорт",
            "confidence": 0.9996510744094849
          }
        ],
        "modelVersion": "07.03.2024"
      }
      ```

      {% endcut %}

      {% cut "Классификатор Few-shot" %}

      ```json
      {
        "predictions": [
          {
            "label": "перевод",
            "confidence": 0.9357050657272339
          },
          {
            "label": "будильник",
            "confidence": 0.00061939493753016
          },
          {
            "label": "погода",
            "confidence": 0.06367553025484085
          }
        ],
        "modelVersion": "07.03.2024"
      }
      ```

      {% endcut %}

{% endlist %}

Сумма значений полей вероятности (`confidence`) для всех классов всегда равна `1`.

#### См. также {#see-also}

* [{#T}](../../concepts/classifier/index.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/text_classifiers)