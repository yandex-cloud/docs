| Услуга | Цена за 1 ГБ, вкл. НДС |
| ---- | ---- |
| Запись данных, первые 5 ГБ в месяц | {{ sku|KZT|logging.ingested.traffic|string }} |
| Запись данных, свыше 5 ГБ в месяц | {{ sku|KZT|logging.ingested.traffic|pricingRate.5|string }} |