# Использовать дообученные классификаторы на базе {{ yagpt-name }}

Чтобы выполнить запрос к классификатору [дообученной](../../../datasphere/concepts/models/foundation-models.md#classifier-training) в {{ ml-platform-name }} модели, используйте метод [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API.

## Перед началом работы {#before-begin}

{% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Отправьте запрос к классификатору {#request}

Чтобы отправить запрос к классификатору:

{% list tabs group=programming_language %}

- Bash {#bash}

  {% include [curl](../../../_includes/curl.md) %}
  
  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}
  
  1. Создайте файл с телом запроса (например, `body.json`):
  
      ```json
      {
        "modelUri": "cls://<идентификатор_каталога>/<идентификатор_классификатора>",
        "text": "<текст_запроса>"
      }
      ```
  
      Где:
      * `modelUri` — [идентификатор модели](../../../foundation-models/concepts/classifier/models.md), которая будет использоваться для классификации сообщения. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} и идентификатор [дообученной](../../../datasphere/concepts/models/foundation-models.md#classifier-training) в {{ ml-platform-name }} модели.
      * `text` — текстовое содержимое сообщения. Суммарное количество токенов на один запрос не должно превышать 8000.
  
      Имена классов, по которым модель будет распределять запросы, должны быть заданы в процессе дообучения модели, поэтому не передаются в запросе.
      
  1. Отправьте запрос к классификатору, выполнив команду:
  
      ```bash
      export IAM_TOKEN=<IAM-токен>
      curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@<путь_к_файлу_с_телом_запроса>" \
        "https://{{ api-host-llm }}:443/foundationModels/v1/textClassification"
      ```

      {% note info %}
      
      Эндпоинт `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification` работает только с дообученными классификаторами. Для [классификаторов по промту](readymade.md) используйте `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification`.
      
      {% endnote %}      
  
      В ответе сервис вернет результаты классификации с определенными значениями вероятности (`confidence`) принадлежности текста запроса к каждому из классов:
  
      ```json
      {
        "predictions": [
          {
            "label": "<название_класса_1>",
            "confidence": 0.00010150671005249023
          },
          {
            "label": "<название_класса_2>",
            "confidence": 0.000008225440979003906
          },
          ...
          {
            "label": "<название_класса_n>",
            "confidence": 0.93212890625
          }
        ],
        "modelVersion": "<версия_модели>"
      }
      ```
  
      При многоклассовой классификации сумма значений полей вероятности (`confidence`) для всех классов всегда равна `1`.
  
      При классификации с несколькими метками значение поля вероятности (`confidence`) для каждого класса рассчитывается независимо (сумма значений не равна `1`).

{% endlist %}