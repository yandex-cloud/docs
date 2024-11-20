> Let’s calculate the cost of 315.04 million legitimate requests per month processed by security profile rules: 
> 0.01 × ${{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|string }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|string }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|string }} = {% calc [currency=USD] 0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }} %}, excluding VAT.

Where:

* 0.01 × ${{ sku|USD|sws.requests.v1|number }}: Non-billable threshold of 0.01 million requests.
* 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|string }}: Cost of the subsequent 0.99 million requests.
* 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|string }}: Cost of the subsequent 9 million requests.
* 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|string }}: Cost of the subsequent 90 million requests.
* 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|string }}: Cost of the remaining 215.04 million requests.

You can only connect a WAF profile when using a security profile. The cost will consist of processing the requests by both the security profile and WAF profile rules. Since the prices for the security profile and WAF profile are the same, the total cost will be twice as large as opposed to only using a security profile.

> Let’s calculate the cost of 315.04 million legitimate requests per month processed by security and WAF profile rules:
> {% calc [currency=USD] 0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }} %} × 2 = {% calc [currency=USD] (0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }}) × 2 %}, excluding VAT.

Where:

* {% calc [currency=USD] 0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }} %}: Cost of 315.04 million legitimate requests per month processed by security profile rules.
* × 2: The cost is multiplied by `2` since the prices for the security profile and WAF profile are equal.