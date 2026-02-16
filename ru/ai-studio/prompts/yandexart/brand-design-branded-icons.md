---
title: Иконки в фирменном стиле
description: В статье вы ознакомитесь с промптом для создания иконок в фирменном стиле.
---

# Иконки в фирменном стиле

## Параметры запроса {#params}

* **Промпт**: Иконка жёлтой лампочки в гладком современном дизайне. Белый и градиенты на светлом размытом фоне. Тонкие отражения и легкое свечение вокруг лампочки. Яркое, энергичное изображение, идея.
* **Зерно**: `12`
* **Результат**:

![brand-design-branded-icons](../../../_assets/yandexgpt/brand-design-branded-icons.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 12
  },
  "messages": [
    {
      "text": "Иконка жёлтой лампочки в гладком современном дизайне. Белый и градиенты на светлом размытом фоне. Тонкие отражения и легкое свечение вокруг лампочки. Яркое, энергичное изображение, идея"
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
