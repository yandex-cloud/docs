| Услуга  | Цена за 1000 запросов,<br/>вкл. НДС |
|---------|-------------------------------------|
| Ночные запросы, первые 1000 запросов в месяц | {{ sku|KZT|searchapi.requests.night.v1|string }} |
| Ночные запросы, свыше 1000 запросов в месяц | {{ sku|KZT|searchapi.requests.night.v1|pricingRate.1|string }} |
| Дневные запросы | {{ sku|KZT|searchapi.requests.day.v1|string }} |
