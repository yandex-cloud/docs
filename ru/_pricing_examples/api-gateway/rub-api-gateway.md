> {{ sku|RUB|api-gateway.requests.v1|pricingRate.0.1|string }} × ((10 000 000 – 100 000) / 1 000 000) = {% calc [currency=RUB] {{ sku|RUB|api-gateway.requests.v1|pricingRate.0.1|number }} × ((10000000 - 100000) / 1000000) %}

Где:

* {{ sku|RUB|api-gateway.requests.v1|pricingRate.0.1|string }} — цена за 1 миллион вызовов API-шлюза.
* 10 000 000 — количество запросов по HTTPS.
* 100 000 — вычитаем, потому что первые сто тысяч вызовов не тарифицируются.
* 1 000 000 — делим, чтобы посчитать количество миллионов запросов по HTTPS.