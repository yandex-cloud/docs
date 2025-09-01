---
title: Маскот компании
description: В статье вы ознакомитесь с промтом для создания маскота компании.
---

# Маскот компании

## Параметры запроса {#params}

* **Промт**: Котёнок с гарнитурой оператора контактного центра, в стиле 3D анимации, на однотонном розовом фоне.
* **Зерно**: `10`
* **Результат**:

![brand-design-mascot](../../../_assets/yandexgpt/brand-design-mascot.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 10
  },
  "messages": [
    {
      "text": "Котёнок с гарнитурой оператора контактного центра, в стиле 3D анимации, на однотонном розовом фоне"
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
