---
title: Визуальный образ компании
description: В статье вы ознакомитесь с промптом для создания визуального образа компании.
---

# Визуальный образ компании

## Параметры запроса {#params}

* **Промпт**: Банка освежающей газировки в руке, предметная съемка, контрастный жёлтый фон, рекламная съемка, брызги, свежесть.
* **Зерно**: `12`
* **Результат**:

![marketing-visual-key](../../../_assets/yandexgpt/marketing-visual-key.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 12
  },
  "messages": [
    {
      "text": "Банка освежающей газировки в руке, предметная съемка, контрастный жёлтый фон, рекламная съемка, брызги, свежесть"
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
