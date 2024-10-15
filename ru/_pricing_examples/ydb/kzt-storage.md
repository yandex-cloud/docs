> 128 RU × 1 024 × 10 = 1 310 720 RU

Где:

* 128 — стоимость запроса за 1 МБ данных.
* 1 024 × 10 — объем скопированных данных в МБ.

Потраченное количество RU 1 310 720 [свыше 1 000 000](#prices), следовательно, цена создания резервной копии составит {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} за 1 000 000 RU.

> (1 310 720 RU - 1 000 000 RU) / 1 000 000 × {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} = {% calc [currency=KZT] (1310720 - 1000000) / 1000000 × {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|number }} %}
>
> Итого: {% calc [currency=KZT] (1310720 - 1000000) / 1000000 × {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|number }} %} — стоимость создания резервной копии 10 ГБ данных.

Где:

* 1 310 720 RU — фактическое потребление RU в месяц.
* {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} — цена 1 миллиона RU.