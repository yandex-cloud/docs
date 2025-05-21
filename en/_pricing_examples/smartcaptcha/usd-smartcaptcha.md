For example, if the month's total is 50,000 correct requests, your cost for the month will be:

> (50,000 - 10,000) / 1,000 × {{ sku|USD|smart_captcha.check.requests.v1|pricingRate.10|string }} = {% calc [currency=USD] (50000 - 10000) / 1000 × {{ sku|USD|smart_captcha.check.requests.v1|pricingRate.10|number }} %}

If the month's total is 100,001 correct requests, your cost for the month will be:

> (100,001 - 10,000) / 1,000 × {{ sku|USD|smart_captcha.check.requests.v1|pricingRate.100|string }} = {% calc [currency=USD] (100001 - 10000) / 1000 × {{ sku|USD|smart_captcha.check.requests.v1|pricingRate.100|number }} %}