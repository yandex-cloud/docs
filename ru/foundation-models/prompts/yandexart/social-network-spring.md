# Обложка для поста

## Параметры запроса {#params}

* **Промт**: Весеннее утро, нежные цветы яблони, нежное, абстрактное, размытое, эмоциональное, глазурь, градиент, несколько четких акцентных деталей, минимализм.

* **Зерно**: `21`

* **Результат**:

![social-network-spring](../../../_assets/yandexgpt/social-network-spring.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 21
  },
  "messages": [
    {
      "weight": 1,
      "text": "Весеннее утро, нежные цветы яблони, нежное, абстрактное, размытое, эмоциональное, глазурь, градиент, несколько четких акцентных деталей, минимализм"
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
