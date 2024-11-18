> {{ sku|RUB|serverless.functions.compute.v1|pricingRate.10|string }} × ((512 / 1024) × (800 / 3 600 000) × 10 000 000 – 10) + {{ sku|RUB|serverless.functions.invocations.v1|pricingRate.1|string }} × ((10 000 000 – 1 000 000) / 1 000 000)
>
> Итого: {% calc [currency=RUB] round(({{ sku|RUB|serverless.functions.compute.v1|pricingRate.10|number }} × ((512 / 1024) × (800 / 3600000) × 10000000 - 10) + {{ sku|RUB|serverless.functions.invocations.v1|pricingRate.1|number }} × ((10000000 - 1000000) / 1000000)) × 100) / 100 %}

Где:
* {{ sku|RUB|serverless.functions.compute.v1|pricingRate.10|string }} — цена за 1 ГБ×час.
* 512 / 1024  — перевод МБ в ГБ, так как время выполнения считается в ГБ×час.
* 800 / 3 600 000 — перевод мс в часы, так как время выполнения считается в ГБ×час.
* 10 000 000 — количество вызовов функции.
* 10 — вычитаем, потому что первые 10 ГБ×час не тарифицируются.
* {{ sku|RUB|serverless.functions.invocations.v1|pricingRate.1|string }} — цена за 1 миллион вызовов функции.
* 10 000 000 — количество вызовов функции.
* 1 000 000 — вычитаем, потому что первые миллион вызовов не тарифицируются.
* 1 000 000 — делим, чтобы посчитать количество миллионов вызовов функции.
