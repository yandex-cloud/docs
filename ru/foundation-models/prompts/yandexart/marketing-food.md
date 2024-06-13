# Изображения для рекламы корма для собак

## Параметры запроса {#params}

* **Промт**: Корм для собак, сложные слои и текстуры, детализированный дизайн персонажей, фон с яркими, причудливыми и красочными сценами, пастельная цветокоррекция как в фильме Уэса Андерсона, зернистость пленки, Tokina at-x 11-16 мм f/2.8 Pro DX II.

* **Зерно**: `7`

* **Результат**:

![marketing-food](../../../_assets/yandexgpt/marketing-food.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 7
  },
  "messages": [
    {
      "weight": 1,
      "text": "корм для собак, сложные слои и текстуры, детализированный дизайн персонажей, фон с яркими, причудливыми и красочными сценами, пастельная цветокоррекция как в фильме Уэса Андерсона, зернистость пленки, tokina at-x 11-16 мм f/2.8 pro dx ii"
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
