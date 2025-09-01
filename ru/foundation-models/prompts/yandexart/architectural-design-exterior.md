---
title: Концепция экстерьера здания
description: В статье вы ознакомитесь с промтом для создания экстерьера здания.
---

# Концепция экстерьера здания

## Параметры запроса {#params}

* **Промт**: Архитектура, дом в стиле Захи Хадид, игра света, высокая детализация, 3D рендер, houdini 3D, Octane 3D, водная гладь.
* **Зерно**: `5`
* **Результат**:

![architectural-design-exterior](../../../_assets/yandexgpt/architectural-design-exterior.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 5
  },
  "messages": [
    {
      "text": "Архитектура, дом в стиле Захи Хадид, игра света, высокая детализация, 3D рендер, houdini 3D, Octane 3D, водная гладь"
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
