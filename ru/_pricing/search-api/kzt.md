| Услуга | Цена за 1000 запросов, вкл. НДС |
|---|---|
| Дневные синхронные запросы | {{ sku|KZT|searchapi.requests.sync.v3|string }} |
| Дневные отложенные запросы | {{ sku|KZT|searchapi.requests.async.v3|string }} |
| Ночные синхронные запросы | {{ sku|KZT|searchapi.requests.night.sync.v3|string }} |
| Ночные отложенные запросы | {{ sku|KZT|searchapi.requests.night.async.v3|string }} |
| Поиск изображений | {{ sku|KZT|searchapi.requests.image.sync.v3|string }} |
| Синхронные запросы с [генеративным ответом](../../search-api/concepts/generative-response.md) | {% calc [currency=KZT] {{ sku|KZT|searchapi.generative.requests.v3|number }} × 1000 %} |