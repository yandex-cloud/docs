# Изображение интерьера

## Параметры запроса {#params}

* **Промт**: Минималистичный интерьер, много солнечного света, солнечный круг, высокие потолки, диван, круглый журнальный столик , торшер в углу, белый, пастельно-желтый, фисташковый, персиковый, реализм, сюрреализм.

* **Зерно**: `77`

* **Результат**:

![illustrations-interior](../../../_assets/yandexgpt/illustrations-interior.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 77
  },
  "messages": [
    {
      "weight": 1,
      "text": "минималистичный интерьер, много солнечного света, солнечный круг, высокие потолки, диван, круглый журнальный столик , торшер в углу, белый, пастельно-желтый, фисташковый, персиковый, реализм, сюрреализм"
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
