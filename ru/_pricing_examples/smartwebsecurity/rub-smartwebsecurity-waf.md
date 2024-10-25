Профиль WAF можно подключить только при использовании профиля безопасности. Поэтому запросы, обработанные правилами WAF, оплачиваются и за обработку правилами профиля безопасности.

> Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности и WAF: 
> (0,01 × {{ sku|RUB|sws.waf.requests.v1|number }} ₽ + 0,99 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.1|string }} + 90 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.10|string }} + 215,04 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.100|string }}) × 2 = {% calc [currency=RUB] (0,01 × {{ sku|RUB|sws.waf.requests.v1|number }} + 0,99 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.1|number }} + 90 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.100|number }}) × 2 %}, вкл. НДС.

Где:

* 0,01 × {{ sku|RUB|sws.waf.requests.v1|number }} ₽ — нетарифицируемый порог, первые 0,01 млн запросов.
* 0,99 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.0.01|string }} — стоимость последующих 0,99 млн запросов.
* 9 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.1|string }} — стоимость последующих 9 млн запросов.
* 90 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.10|string }} — стоимость последующих 90 млн запросов.
* 215,04 × {{ sku|RUB|sws.waf.requests.v1|pricingRate.100|string }} — стоимость оставшихся 215,04 млн запросов.
* × 2 — итоговая стоимость умножается на `2`, поскольку каждый запрос последовательно обрабатывался правилами из профиля безопасности, а затем правилами из профиля WAF.