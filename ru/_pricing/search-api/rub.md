| Услуга  | Цена за 1000 запросов,<br/>вкл. НДС |
|---------|-------------------------------------|
| Дневные синхронные запросы | {{ sku|RUB|searchapi.requests.sync.v3|string }} |
| Дневные отложенные запросы | {{ sku|RUB|searchapi.requests.async.v3|string }} |
| Ночные синхронные запросы | {{ sku|RUB|searchapi.requests.night.sync.v3|string }} |
| Ночные отложенные запросы | {{ sku|RUB|searchapi.requests.night.async.v3|string }} |
| Поиск изображений | {{ sku|RUB|searchapi.requests.image.sync.v3|string }} |
| Синхронные запросы с [генеративным ответом](../../search-api/concepts/generative-response.md) | {% calc [currency=RUB] {{ sku|RUB|searchapi.generative.requests.v3|number }} × 1000 %} |