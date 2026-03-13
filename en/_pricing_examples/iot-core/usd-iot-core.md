As per the pricing policy:
* 100,000 messages are free of charge.
* 900,000 messages come at {% calc [currency=USD] {{ sku|USD|iot.mqtt|pricingRate.100000|number }} × 1000000 %} per 1,000,000 messages.
* 3,000,000 messages come at {% calc [currency=USD] {{ sku|USD|iot.mqtt|pricingRate.1000000|number }} × 1000000 %} per 1,000,000 messages.

The cost is calculated as follows:
> 900,000 / 1,000,000 × {% calc [currency=USD] {{ sku|USD|iot.mqtt|pricingRate.100000|number }} × 1000000 %} + 3,000,000 / 1,000,000 × {% calc [currency=USD] {{ sku|USD|iot.mqtt|pricingRate.1000000|number }} × 1000000 %}
>
> Total: {% calc [currency=USD] (900000 / 1000000 × ({{ sku|USD|iot.mqtt|pricingRate.100000|number }} × 1000000)) + (3000000 / 1000000 × ({{ sku|USD|iot.mqtt|pricingRate.1000000|number }} × 1000000)) %}