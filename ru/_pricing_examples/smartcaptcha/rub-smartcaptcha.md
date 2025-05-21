Например, если в месяц было 50 000 корректных запросов, стоимость за месяц составит:

> (50 000 - 10 000) / 1 000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.10|string }} = {% calc [currency=RUB] (50000 - 10000) / 1000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.10|number }} %}

Если в месяц был 100 001 корректный запрос, стоимость за месяц составит:

> (100 001 - 10 000) / 1 000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.100|string }} = {% calc [currency=RUB] (100001 - 10000) / 1000 × {{ sku|RUB|smart_captcha.check.requests.v1|pricingRate.100|number }} %}