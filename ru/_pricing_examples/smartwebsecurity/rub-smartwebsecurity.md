> Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности:
> 0,01 × {{ sku|RUB|sws.requests.v1|number }} ₽ + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|string }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|string }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|string }} = {% calc [currency=RUB] 0,01 × {{ sku|RUB|sws.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|number }} %}, вкл. НДС.

Где:

* 0,01 × {{ sku|RUB|sws.requests.v1|number }} ₽ — нетарифицируемый порог, первые 0,01 млн запросов.
* 0,99 × {{ sku|RUB|sws.requests.v1|pricingRate.0.01|string }} — стоимость последующих 0,99 млн запросов.
* 9 × {{ sku|RUB|sws.requests.v1|pricingRate.1|string }} — стоимость последующих 9 млн запросов.
* 90 × {{ sku|RUB|sws.requests.v1|pricingRate.10|string }} — стоимость последующих 90 млн запросов.
* 215,04 × {{ sku|RUB|sws.requests.v1|pricingRate.100|string }} — стоимость оставшихся 215,04 млн запросов.