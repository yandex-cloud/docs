> {{ sku|RUB|serverless.containers.compute.memory|pricingRate.10|string }} × (2 × (150 / 3&nbsp;600&nbsp;000) × 3&nbsp;000&nbsp;000 – 10) + {{ sku|RUB|serverless.containers.compute.cpu|pricingRate.5|string }} × (1 × (150 / 3&nbsp;600&nbsp;000) × 3&nbsp;000&nbsp;000 – 5) + {{ sku|RUB|serverless.containers.invocations|pricingRate.1|string }} × ((3&nbsp;000&nbsp;000 – 1&nbsp;000&nbsp;000) / 1&nbsp;000&nbsp;000)
>
> Итого: {% calc [currency=RUB] {{ sku|RUB|serverless.containers.compute.memory|pricingRate.10|number }} × (2 × (150 / 3600000) × 3000000 - 10) + {{ sku|RUB|serverless.containers.compute.cpu|pricingRate.5|number }} × (1 × (150 / 3600000) × 3000000 - 5) + {{ sku|RUB|serverless.containers.invocations|pricingRate.1|number }} × ((3000000 - 1000000) / 1000000) %}

Где:

* {{ sku|RUB|serverless.containers.compute.memory|pricingRate.10|string }} — цена за 1 ГБ×час, свыше 10 ГБ×час в месяц.
* 2 — объем RAM.
* 150 / 3 600 000 — перевод мс в часы, так как время использования RAM считается в ГБ×час.
* 3 000 000 — количество вызовов контейнера.
* 10 — время использования RAM, которое не тарифицируется.
* {{ sku|RUB|serverless.containers.compute.cpu|pricingRate.5|string }} — цена за час использования CPU, свыше 5 vCPU × час в месяц.
* 1 — количество ядер vCPU.
* 150 / 3 600 000 — перевод мс в часы, так как время использования CPU считается в ГБ×час.
* 3 000 000 — количество вызовов контейнера.
* 5 — время использования CPU, которое не тарифицируется.
* {{ sku|RUB|serverless.containers.invocations|pricingRate.1|string }} — цена за 1 млн вызовов контейнера, свыше 1 млн в месяц.
* 3 000 000 — количество вызовов контейнера.
* 1 000 000 — вычитаем, потому что первые миллион вызовов не тарифицируются.
* 1 000 000 — делим, чтобы посчитать количество миллионов вызовов контейнера.