# Изображение природы

## Параметры запроса {#params}

* **Промт**: гиперреалистичная фотография, солнце сквозь деревья, лиственный лес, лето, широкий кадр, 32к, фото Nikon d800, объектив 30 мм, hd full wallpaper

* **Зерно**: `9`

* **Результат**:

![illustrations-nature](../../../_assets/yandexgpt/illustrations-nature.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 9
  },
  "messages": [
    {
      "weight": 1,
      "text": "гиперреалистичная фотография, солнце сквозь деревья, лиственный лес, лето, широкий кадр, 32к, фото Nikon d800, объектив 30 мм, hd full wallpaper"
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
