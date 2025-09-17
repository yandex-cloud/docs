| Услуга  | Цена за 1000 запросов,<br/>вкл. НДС |
|---------|-------------------------------------|
| **Запросы через [API v1](../../search-api/concepts/index.md#api-v1)** | |
| Ночные синхронные запросы, первые 1000 запросов в месяц | {{ sku|RUB|searchapi.requests.night.v1|string }} |
| Ночные синхронные запросы, свыше 1000 запросов в месяц  | {{ sku|RUB|searchapi.requests.night.v1|pricingRate.1|string }} |
| Дневные синхронные запросы | {{ sku|RUB|searchapi.requests.day.v1|string }} |
| **Запросы через [API v2](../../search-api/concepts/index.md#api-v2)** | |
| Синхронные запросы | {{ sku|RUB|searchapi.requests.sync.v3|string }} |
| Отложенные запросы | {{ sku|RUB|searchapi.requests.async.v3|string }} | 
| Синхронные запросы с [генеративным ответом](../../search-api/concepts/generative-response.md) | {% calc [currency=RUB] {{ sku|RUB|searchapi.generative.requests.v3|number }} × 1000 %} |

{% note warning %}

Цены ниже будут действовать с 1 октября 2025 года.

{% endnote %}

| Услуга  | Цена за 1000 запросов,<br/>вкл. НДС |
|---------|-------------------------------------|
| **Запросы через [API v2](../../search-api/concepts/index.md#api-v2)** | |
| Дневные синхронные запросы | 480,00 ₽ |
| Дневные отложенные запросы | 30,00 ₽ |
| Ночные синхронные запросы | 360,00 ₽ |
| Ночные отложенные запросы | 25,00 ₽ |
| Поиск изображений | 900,00 ₽ |
| Синхронные запросы с [генеративным ответом](../../search-api/concepts/generative-response.md) | {% calc [currency=RUB] {{ sku|RUB|searchapi.generative.requests.v3|number }} × 1000 %} |