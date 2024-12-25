---
title: Иллюстрация для статьи
description: В статье вы ознакомитесь с промтом для создания иллюстраций для статьи.
---

# Иллюстрация для статьи

## Параметры запроса {#params}

* **Промт**: Кленовый лист, насыщенные оранжевый и багровый цвета, крупный план, глубина, гиперреализм, внимание к деталям, Octane рендер, f/2.8, ISO 200.
* **Зерно**: `12`
* **Пропорции**: `16:9`
* **Результат**:

![illustrations-article](../../../_assets/yandexgpt/illustrations-article.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 12,
    "ratio": "16:9"
  },
  "messages": [
    {
      "weight": 1,
      "text": "Кленовый лист, насыщенные оранжевый и багровый цвета, крупный план, глубина, гиперреализм, внимание к деталям, Octane рендер, f/2.8, ISO 200"
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
