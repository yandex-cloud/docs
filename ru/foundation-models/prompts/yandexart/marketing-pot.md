# Идеи дизайна чайника

## Параметры запроса {#params}

* **Промт**: Электрический чайник, в форме пингвина, в профиль, стилизация, белый фон, будущее, высокое качество, супер детализация.

* **Зерно**: `31`

* **Результат**:

![marketing-food](../../../_assets/yandexgpt/marketing-pot-31.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 31
  },
  "messages": [
    {
      "weight": 1,
      "text": "электрический чайник, в форме пингвина, в профиль, стилизация, белый фон, будущее, высокое качество, супер детализация"
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
