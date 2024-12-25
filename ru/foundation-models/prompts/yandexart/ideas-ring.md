---
title: Дизайн кольца
description: В статье вы ознакомитесь с промтом для создания дизайна кольца.
---

# Дизайн кольца

## Параметры запроса {#params}

* **Промт**: Изысканное кольцо из белого золота в форме дракона, много мелких деталей, фэнтези.
* **Зерно**: `5`
* **Результат**:

![ideas-ring](../../../_assets/yandexgpt/ideas-ring.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 5
  },
  "messages": [
    {
      "weight": 1,
      "text": "Изысканное кольцо из белого золота в форме дракона, много мелких деталей, фэнтези"
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
