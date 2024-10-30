> 0,5 RU × 1 024 × 1 024 × 10 = 5 242 880 RU

Где:

* 0,5 — стоимость запроса за 1 КБ данных.
* 1 024 × 1 024 × 10 — объем восстанавливаемых данных в КБ.

Потраченное количество RU 5 242 880 [свыше 1 000 000](#prices), следовательно, цена восстановления из резервной копии составит {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} за 1 000 000 RU.

> (5 242 880 RU - 1 000 000 RU) / 1 000 000 × {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} = {% calc [currency=KZT] (5242880 - 1000000) / 1000000 × {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|number }} %}
>
> Итого: {% calc [currency=KZT] (5242880 - 1000000) / 1000000 × {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|number }} %} — стоимость восстановления из резервной копии 10 ГБ данных.

Где:

* 5 242 880 RU — фактическое потребление RU в месяц.
* {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} — цена 1 миллиона RU.