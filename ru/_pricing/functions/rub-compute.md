Услуга | Цена за 1 ГБ×час, <br>вкл. НДС
----- | -----
Выполнение функций, первые 10 ГБ×час в месяц | {{ sku|RUB|serverless.functions.compute.v1|string }}
Выполнение функций, свыше  10 ГБ×час в месяц | {{ sku|RUB|serverless.functions.compute.v1|pricingRate.10|string }}
