# Реклама сумки

## Параметры запроса {#params}

* **Промт**: Минималистичная фотография продукта, Луиджи Гирри, маленькая сумка крупным планом, в стиле lomo LC-A, светло-янтарный и красный, Габриэль Метсу, размытый фон, смелые линии, яркий цвет, вневременная элегантность, скульптура, Французская Ривьера.

* **Зерно**: `99`

* **Результат**:

![marketing-accessory](../../../_assets/yandexgpt/marketing-accessory.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 99
  },
  "messages": [
    {
      "weight": 1,
      "text": "минималистичная фотография продукта, Луиджи Гирри, маленькая сумка крупным планом, в стиле lomo LC-A, светло-янтарный и красный, Габриэль Метсу, размытый фон, смелые линии, яркий цвет, вневременная элегантность, скульптура, Французская Ривьера"
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
