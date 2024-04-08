# Иллюстрация для детей

## Параметры запроса {#params}

* **Промт**: мультяшная лисичка сидит подоконнике, смотрит в окно, рядом чашка чая, теплый вечер за окном, закат, уют, ламповая атмосфера, мягкие яркие цвета, простые текстуры, плоская иллюстрация из детской книжки, рисование водными маркерами

* **Зерно**: `12`

* **Результат**:

![social-network-animation](../../../_assets/yandexgpt/social-network-animation.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 12
  },
  "messages": [
    {
      "weight": 1,
      "text": "мультяшная лисичка сидит подоконнике, смотрит в окно, рядом чашка чая, теплый вечер за окном, закат, уют, ламповая атмосфера, мягкие яркие цвета, простые текстуры, плоская иллюстрация из детской книжки, рисование водными маркерами"
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
