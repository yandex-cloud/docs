> {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|string }} × ((10,000,000 – 100,000) / 1,000,000) = {% calc [currency=USD] {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|number }} × ((10000000 - 100000) / 1000000) %}

Where:

* {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|string }}: Price per 1 million API gateway calls.
* 10,000,000: Number of requests over HTTPS.
* 100,000: Subtracted since the first one hundred thousand calls are free of charge.
* 1,000,000: Divisor used to calculate the number of millions of requests over HTTPS.