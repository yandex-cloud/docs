Согласно правилам тарификации:
* 100 000 сообщений — не тарифицируются;
* 900 000 сообщений тарифицируются по цене {% calc [currency=RUB] {{ sku|RUB|iot.mqtt|pricingRate.100000|number }} × 1000000 %} за 1 млн. сообщений;
* 3 000 000 сообщений тарифицируются по цене {% calc [currency=RUB] {{ sku|RUB|iot.mqtt|pricingRate.1000000|number }} × 1000000 %} за 1 млн. сообщений.

Расчет стоимости:
> 900 000 / 1 000 000 × {% calc [currency=RUB] {{ sku|RUB|iot.mqtt|pricingRate.100000|number }} × 1000000 %} + 3 000 000 / 1 000 000 × {% calc [currency=RUB] {{ sku|RUB|iot.mqtt|pricingRate.1000000|number }} × 1000000 %}
>
> Итого: {% calc [currency=RUB] (900000 / 1000000 × ({{ sku|RUB|iot.mqtt|pricingRate.100000|number }} × 1000000)) + (3000000 / 1000000 × ({{ sku|RUB|iot.mqtt|pricingRate.1000000|number }} × 1000000)) %}