# Изображение интерьера

## Параметры запроса {#params}

* **Промт**: Минималистичный интерьер, много солнечного света, солнечный круг, высокие потолки, диван, журнальный столик, настольная лампа, белый, пастельно-желтый, фисташковый, персиковый, реализм, сюрреализм, октан рендер.

* **Зерно**: `33`

* **Результат**:

![illustrations-interior](../../../_assets/yandexgpt/illustrations-interior.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 1
  },
  "messages": [
    {
      "weight": 33,
      "text": "Минималистичный интерьер, много солнечного света, солнечный круг, высокие потолки, диван, журнальный столик, настольная лампа, белый, пастельно-желтый, фисташковый, персиковый, реализм, сюрреализм, октан рендер"
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
