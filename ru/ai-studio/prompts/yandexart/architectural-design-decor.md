---
title: Предметы декора
description: В статье вы ознакомитесь с промптом для создания предметов декора.
---

# Предметы декора

## Параметры запроса {#params}

* **Промпт**: Минималистичная керамическая ваза на фоне светлого скандинавского интерьера, на столе.
* **Зерно**: `12`
* **Результат**:

![architectural-design-decor](../../../_assets/yandexgpt/architectural-design-decor.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 12
  },
  "messages": [
    {
      "text": "Минималистичная керамическая ваза на фоне светлого скандинавского интерьера, на столе"
    }
  ]
}
```

{% include [prompt-structure](../../../_includes/ai-studio/yandexart/api-parameters.md) %}

{% list tabs group=programming_language %}

- cURL {#curl}

  {% include [prompt-structure](../../../_includes/ai-studio/yandexart/prompt-request.md) %}

{% endlist %}

## Получение результата {#result}

{% include [prompt-result](../../../_includes/ai-studio/yandexart/prompt-result.md) %}
