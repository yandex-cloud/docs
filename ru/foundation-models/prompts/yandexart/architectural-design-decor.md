# Предметы декора

## Параметры запроса {#params}

* **Промт**: Минималистичная керамическая ваза на фоне светлого скандинавского интерьера, на столе.
* **Зерно**: `12`
* **Результат**:

![architectural-design-decor](../../../_assets/yandexgpt/architectural-design-decor.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 12
  },
  "messages": [
    {
      "weight": 1,
      "text": "Минималистичная керамическая ваза на фоне светлого скандинавского интерьера, на столе"
    }
  ]
}
```

{% include [prompt-structure](../../../_includes/foundation-models/yandexart/api-parameters.md) %}

{% list tabs group=programming_language %}

- cURL {#curl}

  {% include [prompt-structure](../../../_includes/foundation-models/yandexart/prompt-request.md) %}

{% endlist %}

## Получение результата {#result}

{% include [prompt-result](../../../_includes/foundation-models/yandexart/prompt-result.md) %}
