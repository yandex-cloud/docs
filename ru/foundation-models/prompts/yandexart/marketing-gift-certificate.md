---
title: Изображение для подарочных сертификатов
description: В статье вы ознакомитесь с промтом для создания изображения для подарочных сертификатов.
---

# Изображение для подарочных сертификатов

## Параметры запроса {#params}

* **Промт**: Подарочная открытка с изображением корги в стиле Pixar на лаймовом фоне, держит в лапках букет цветов.
* **Зерно**: `10`
* **Пропорции**: `4:3`
* **Результат**:

![marketing-gift-certificate](../../../_assets/yandexgpt/marketing-gift-certificate.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 10,
    "aspectRatio": {
      "widthRatio": "4",
      "heightRatio": "3"
    }
  },
  "messages": [
    {
      "text": "Подарочная открытка с изображением корги в стиле Pixar на лаймовом фоне, держит в лапках букет цветов"
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
