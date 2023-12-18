| Услуга  | Цена за 1000 запросов,<br/>вкл. НДС |
|---------|-------------------------------------|
| Ночные запросы, первые 1000 запросов в месяц | {{ sku|RUB|searchapi.requests.night.v1|int|string }} |
| Ночные запросы, свыше 1000 запросов в месяц  | {{ sku|RUB|searchapi.requests.night.v1|pricingRate.1|int|string }} |
| Дневные запросы | {{ sku|RUB|searchapi.requests.day.v1|int|string }} |

