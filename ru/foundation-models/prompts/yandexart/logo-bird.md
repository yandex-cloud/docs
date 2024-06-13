# Логотип с птицей

## Параметры запроса {#params}

* **Промт**: Красивая птичка, круглая иконка, в стиле векторной графики, в современном плоском стиле, svg.

* **Зерно**: `17`

* **Результат**:

![logo-bird](../../../_assets/yandexgpt/logo-bird.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 17
  },
  "messages": [
    {
      "weight": 1,
      "text": "красивая птичка, круглая иконка, в стиле векторной графики, в современном плоском стиле, svg"
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
