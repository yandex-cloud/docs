Например, если в месяц было 50 000 корректных запросов, стоимость за месяц составит:

> (50 000 - 10 000) / 1 000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.10|string }} = {% calc [currency=RUB] (50000 - 10000) / 1000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.10|number }} %}

Если в месяц была 101 000 корректных запросов, стоимость за месяц составит:

> (100 000 - 10 000) / 1 000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.10|string }} + (101 000 - 100 000) / 1 000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.100|string }} = {% calc [currency=RUB] (100000 - 10000) / 1000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.10|number }} + (101 000 - 100 000) / 1 000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.100|number }} %}