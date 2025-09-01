---
title: Дизайн-проект офиса
description: В статье вы ознакомитесь с промтом для создания дизайн-проекта офиса.
---

# Дизайн-проект офиса

## Параметры запроса {#params}

* **Промт**: Интерьер офисного кабинета, дизайн проект. Стена покрыта плющом, авангардные предметы интерьера, бетон, детали из латуни. Мягкий свет, полумрак, эстетика, вид из окна на панораму города.
* **Зерно**: `12`
* **Результат**:

![architectural-design-office](../../../_assets/yandexgpt/architectural-design-office.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 12
  },
  "messages": [
    {
      "text": "Интерьер офисного кабинета, дизайн проект. Стена покрыта плющом, авангардные предметы интерьера, бетон, детали из латуни. Мягкий свет, полумрак, эстетика, вид из окна на панораму города"
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
