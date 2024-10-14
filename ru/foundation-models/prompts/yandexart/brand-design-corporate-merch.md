# Корпоративный мерч

## Параметры запроса {#params}

* **Промт**: Худи свободного кроя, жёлтого цвета, в центре иллюстрация с логотипом в виде рисунка кометы чёрного цвета. Минималистичная съемка товара, на светлом однотонном фоне, на модели со светлыми волосами.
* **Зерно**: `11`
* **Результат**:

![brand-design-corporate-merch](../../../_assets/yandexgpt/brand-design-corporate-merch.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 11
  },
  "messages": [
    {
      "weight": 1,
      "text": "Худи свободного кроя, жёлтого цвета, в центре иллюстрация с логотипом в виде рисунка кометы чёрного цвета. Минималистичная съемка товара, на светлом однотонном фоне, на модели со светлыми волосами"
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
