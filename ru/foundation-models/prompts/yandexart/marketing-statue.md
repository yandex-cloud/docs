---
title: Иллюстрация для материалов
description: В статье вы ознакомитесь с промтом для создания иллюстрации для материалов.
---

# Иллюстрация для материалов

## Параметры запроса {#params}

* **Промт**: Белая античная статуя, девушка, портрет, в современных очках авиаторах розового цвета, на чёрном фоне.
* **Зерно**: `2`
* **Результат**:

![marketing-statue](../../../_assets/yandexgpt/marketing-statue.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 2
  },
  "messages": [
    {
      "text": "Белая античная статуя, девушка, портрет, в современных очках авиаторах розового цвета, на чёрном фоне"
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
