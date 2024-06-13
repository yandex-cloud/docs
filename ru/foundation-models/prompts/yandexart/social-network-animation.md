# Иллюстрация для детей

## Параметры запроса {#params}

* **Промт**: Мультяшная лисичка сидит подоконнике, чашка чая, уют, ламповая атмосфера, мягкие цвета, простые текстуры.

* **Зерно**: `17`

* **Результат**:

![social-network-animation](../../../_assets/yandexgpt/social-network-animation.jpeg)

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
      "text": "мультяшная лисичка сидит подоконнике, чашка чая, уют, ламповая атмосфера, мягкие цвета, простые текстуры"
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
