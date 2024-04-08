# Идеи дизайна чайника

## Параметры запроса {#params}

### Пример 1 {#example-1}

* **Промт**: Электрический чайник в форме пингвина, стилизация, белый фон, трансформация, будущее, высокое качество, супер детализация.

* **Зерно**: `3`

* **Результат**:

![marketing-food](../../../_assets/yandexgpt/marketing-pot-22.jpeg)

### Пример 2 {#example-2}

* **Промт**: Электрический чайник в форме пингвина, стилизация, белый фон, трансформация, будущее, высокое качество, супер детализация.

* **Зерно**: `22`

* **Результат**:

![marketing-food](../../../_assets/yandexgpt/marketing-pot-3.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 3
  },
  "messages": [
    {
      "weight": 1,
      "text": "электрический чайник в форме пингвина, стилизация, белый фон, трансформация, будущее, высокое качество, супер детализация"
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
