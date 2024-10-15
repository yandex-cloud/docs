> (50&nbsp;000 / 1&nbsp;000&nbsp;000) × {{ sku|KZT|dns.requests.public.authoritative.v1|string }} = 0,05 × {{ sku|KZT|dns.requests.public.authoritative.v1|string }} = {% calc [currency=KZT] (50000 / 1000000) × {{ sku|KZT|dns.requests.public.authoritative.v1|number }} %}
> 
> Итого: {% calc [currency=KZT] (50000 / 1000000) × {{ sku|KZT|dns.requests.public.authoritative.v1|number }} %}

Где:

* (50&nbsp;000 / 1&nbsp;000&nbsp;000) — количество миллионов выполненных запросов.
* {{ sku|KZT|dns.requests.public.authoritative.v1|string }} — цена за 1 млн запросов в месяц.

Например, стоимость 1,2 млн рекурсивных запросов внешних имен, выполненных с 6 по 31 декабря с ваших ВМ, за месяц составит:

> (1,2 − 1,0) × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|string }} = 0,2 × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|string }} = {% calc [currency=KZT] (1,2 - 1,0) × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|number }} %}
> 
> Итого: {% calc [currency=KZT] (1,2 - 1,0) × {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|number }} %}

Где:

* (1,2 − 1,0) — количество миллионов выполненных запросов. Первый миллион рекурсивных запросов не тарифицируется начиная с 6 декабря 2021.
* {{ sku|KZT|dns.requests.public.recursive.v1|pricingRate.1|string }} — цена за 1 млн рекурсивных запросов в месяц.