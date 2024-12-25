---
title: Продвижение в социальных сетях
description: В статье вы ознакомитесь с промтом для продвижения в социальных сетях.
---

# Продвижение в социальных сетях

## Параметры запроса {#params}

* **Промт**: Надпись Fresh. Динамичная композиция из свежих овощей и фруктов, сочно, капли воды, на голубом однотонном фоне. Профессиональная рекламная съемка.
* **Зерно**: `10`
* **Результат**:

![marketing-social](../../../_assets/yandexgpt/marketing-social.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 10
  },
  "messages": [
    {
      "weight": 1,
      "text": "Надпись Fresh. Динамичная композиция из свежих овощей и фруктов, сочно, капли воды, на голубом однотонном фоне. Профессиональная рекламная съемка"
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
