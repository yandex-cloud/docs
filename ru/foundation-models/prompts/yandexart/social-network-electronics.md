# Изображение электроники

## Параметры запроса {#params}

* **Промт**: прицельная сетка, электронные схемы, текст, значки, киберпанк, макрофото, фотореализм, гипердетализация, Pixar

* **Зерно**: `2`

* **Результат**:

![social-network-electronics](../../../_assets/yandexgpt/social-network-electronics.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 2
  },
  "messages": [
    {
      "weight": 1,
      "text": "прицельная сетка, электронные схемы, текст, значки, киберпанк, макрофото, фотореализм, гипердетализация, Pixar"
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
