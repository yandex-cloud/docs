---
title: Персонаж для игры
description: В статье вы ознакомитесь с промтом для создания персонажа для игры.
---

# Персонаж для игры

## Параметры запроса {#params}

* **Промт**: Гном, могучий воин, рыжая борода, ps5 graphics, портрет.
* **Зерно**: `10`
* **Пропорции**: `9:16`
* **Результат**:

![ideas-character](../../../_assets/yandexgpt/ideas-character.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 10,
    "aspectRatio": {
      "widthRatio": "9",
      "heightRatio": "16"
    }
  },
  "messages": [
    {
      "text": "Гном, могучий воин, рыжая борода, ps5 graphics, портрет"
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
