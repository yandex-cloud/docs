---
title: Иллюстрация для книги
description: В статье вы ознакомитесь с промтом для создания иллюстрации для книги.
---

# Иллюстрация для книги

## Параметры запроса {#params}

* **Промт**: Девушка с черными волосами, бледная кожа, красные губы, лисьи уши, в традиционном красном кимоно, клены на заднем плане, белое небо, визионерский концепт-арт в стиле Альфонса Мухи и Rossdraws.
* **Зерно**: `10`
* **Результат**:

![illustrations-book](../../../_assets/yandexgpt/illustrations-book.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 10
  },
  "messages": [
    {
      "text": "Девушка с черными волосами, бледная кожа, красные губы, лисьи уши, в традиционном красном кимоно, клены на заднем плане, белое небо, визионерский концепт-арт в стиле Альфонса Мухи и Rossdraws"
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
