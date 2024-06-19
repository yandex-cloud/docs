| Услуга  | Цена за 1000 запросов,<br/>вкл. НДС |
|---------|-------------------------------------|
| Ночные запросы, первые 1000 запросов в месяц | {{ sku|KZT|searchapi.requests.night.v1|int|string }} |
| Ночные запросы, свыше 1000 запросов в месяц | {{ sku|KZT|searchapi.requests.night.v1|pricingRate.1|int|string }} |
| Дневные запросы | {{ sku|KZT|searchapi.requests.day.v1|int|string }} |
