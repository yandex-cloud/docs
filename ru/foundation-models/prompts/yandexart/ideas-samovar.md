# Вымышленные предметы

## Параметры запроса {#params}

* **Промт**: Дизайн самовара в футуристичном стиле, стимпанк, неоновая подсветка, на однотонном светлом фоне, предметная съемка, пар от кипения.
* **Зерно**: `7`
* **Результат**:

![ideas-samovar](../../../_assets/yandexgpt/ideas-samovar.jpg)

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
      "text": "Дизайн самовара в футуристичном стиле, стимпанк, неоновая подсветка, на однотонном светлом фоне, предметная съемка, пар от кипения"
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
