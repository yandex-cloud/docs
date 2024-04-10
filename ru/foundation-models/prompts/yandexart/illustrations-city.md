# Город будущего

## Параметры запроса {#params}

* **Промт**: Удивительный мир будущего, гармоничное сочетание технологий и природы, в центре композиции огромное дерево, внутри которого находится целый город.

* **Зерно**: `2`

* **Результат**:

![illustrations-city](../../../_assets/yandexgpt/illustrations-city.jpeg)

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
      "text": "Удивительный мир будущего, гармоничное сочетание технологий и природы, в центре композиции огромное дерево, внутри которого находится целый город."
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
