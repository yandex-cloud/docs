# Замена стоковых фотографий

## Параметры запроса {#params}

* **Промт**: Встреча на конференции, бизнес, фотореалистичная репортажная съемка, рукопожатие, размытый фокус на фоне.
* **Зерно**: `10`
* **Пропорции**: `16:9`
* **Результат**:

![illustration-photo-stock](../../../_assets/yandexgpt/illustration-photo-stock.jpg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 10,
    "ratio": "16:9"
  },
  "messages": [
    {
      "weight": 1,
      "text": "Встреча на конференции, бизнес, фотореалистичная репортажная съемка, рукопожатие, размытый фокус на фоне"
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
