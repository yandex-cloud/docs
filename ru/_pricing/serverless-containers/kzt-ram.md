| Услуга | Цена за 1 ГБ×час, <br>вкл. НДС |
| ---- | ---- |
| Время использования RAM, первые 10 ГБ×час в месяц | {{ sku|KZT|serverless.containers.compute.memory|string }} |
| Время использования RAM, свыше 10 ГБ×час в месяц | {{ sku|KZT|serverless.containers.compute.memory|pricingRate.10|string }} |