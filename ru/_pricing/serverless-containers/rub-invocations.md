| Услуга | Цена за 1 млн вызовов, <br>вкл. НДС |
| ---- | ---- |
| Вызов контейнера, первые 1 млн в месяц | {{ sku|RUB|serverless.containers.invocations|string }} |
| Вызов контейнера, свыше 1 млн в месяц | {{ sku|RUB|serverless.containers.invocations|pricingRate.1|string }} |