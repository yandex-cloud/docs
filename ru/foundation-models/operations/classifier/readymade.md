# Использовать классификаторы по промту на базе {{ yagpt-name }}

Сервис {{ foundation-models-full-name }} предоставляет [классификаторы по промту](../../concepts/classifier/index.md) на базе {{ yagpt-name }} двух видов: [Zero-shot](../../concepts/classifier/index.md#zero-shot) и [Few-shot](../../concepts/classifier/index.md#few-shot). Чтобы направить запрос к классификатору по промту, используйте метод [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) Text Classification API.

## Перед началом работы {#before-begin}

{% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Отправьте запрос к классификатору {#request}

Чтобы отправить запрос к классификатору:

1. Создайте файл с телом запроса (например, `body.json`):

    {% list tabs group=classifier-models %}

    - Классификатор Zero-shot {#zero-shot}

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

    - Классификатор Few-shot {#few-shot}

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

    {% endlist %}

1. Отправьте запрос к классификатору, выполнив команду:

   {% list tabs group=programming_language %}

   - Bash {#bash}
   
     {% include [curl](../../../_includes/curl.md) %}
     
     {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

      ```bash
      export IAM_TOKEN=<IAM-токен>
      curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@<путь_к_файлу_с_телом_запроса>" \
        "https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification"
      ```
      {% note info %}
      
      Эндпоинт `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification` работает только с классификаторами по промту. Для [дообученных классификаторов](additionally-trained.md) используйте `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification`.
      
      {% endnote %}

   {% endlist %}

    В ответе сервис вернет результаты классификации с определенными значениями вероятности (`confidence`) отнесения текста запроса к каждому из классов:

    {% list tabs group=classifier-models %}

    - Классификатор Zero-shot {#zero-shot}

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

    - Классификатор Few-shot {#few-shot}

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

    {% endlist %}

    Сумма значений полей вероятности (`confidence`) для всех классов всегда равна `1`.