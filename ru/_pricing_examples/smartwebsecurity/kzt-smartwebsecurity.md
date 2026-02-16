> Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности:
> 0,01 × {{ sku|KZT|sws.requests.v1|number }} ₸ + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|string }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|string }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|string }} = {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %}, вкл. НДС.

Где:

* 0,01 × {{ sku|KZT|sws.requests.v1|number }} ₸ — нетарифицируемый порог, первые 0,01 млн запросов.
* 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|string }} — стоимость последующих 0,99 млн запросов.
* 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|string }} — стоимость последующих 9 млн запросов.
* 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|string }} — стоимость последующих 90 млн запросов.
* 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|string }} — стоимость оставшихся 215,04 млн запросов.

Профиль WAF можно подключить только при использовании профиля безопасности. Стоимость будет складываться из обработки запросов правилами обоих профилей — безопасности и WAF. Так как цены для профиля безопасности и WAF равны, общая стоимость будет в два раза выше, чем при использовании только профиля безопасности.

> Рассчитаем стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности и WAF: 
> {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} × 2 = {% calc [currency=KZT] (0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }}) × 2 %}, вкл. НДС.

Где:

* {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} — стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности.
* × 2 — стоимость умножается на `2`, поскольку цены для профиля безопасности и WAF равны.

> Рассчитаем стоимость 315,04 млн легитимных запросов в месяц при использовании прокси-сервера и правил профиля безопасности:
> {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} + 6 × 720 × {{ sku|KZT|sws.proxy-server.v1|string }} + 7 × {{ sku|KZT|sws.antiddos.traffic|string }} = {% calc [currency=KZT] (0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }}) + 6 × 720 × {{ sku|KZT|sws.proxy-server.v1|number }} + 7 × {{ sku|KZT|sws.antiddos.traffic|number }} %}, вкл. НДС.

Где: 

* {% calc [currency=KZT] 0,01 × {{ sku|KZT|sws.requests.v1|number }} + 0,99 × {{ sku|KZT|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|KZT|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|KZT|sws.requests.v1|pricingRate.10|number }} + 215,04 × {{ sku|KZT|sws.requests.v1|pricingRate.100|number }} %} — стоимость 315,04 млн легитимных запросов в месяц, обработанных правилами профиля безопасности.
* 6 — минимальное количество ресурсных единиц прокси-сервера. 
* 720 — количество часов в 30 днях.
* {{ sku|KZT|sws.proxy-server.v1|string }} — стоимость 1 ресурсной единицы прокси-сервера за 1 час.
* 7 — объем входящего трафика (в гигабайтах).
* {{ sku|KZT|sws.antiddos.traffic|string }} — стоимость защиты 1 ГБ входящего трафика от DDoS-атак.