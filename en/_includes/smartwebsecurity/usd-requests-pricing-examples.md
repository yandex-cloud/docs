##### Security profile {#security-profile-usd}

> Let’s calculate the cost of 315,040,000 legitimate requests per month processed by security profile rules:
>
> 0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|string }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|string }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|string }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|string }} = {% calc [currency=USD] 0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }} %}, without VAT.

Where:

* 0.01 × {{ sku|USD|sws.requests.v1|number }}: Non-billable threshold of the first 0.01 million requests.
* 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|string }}: Cost of the subsequent 0.99 million requests.
* 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|string }}: Cost of the subsequent 9 million requests.
* 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|string }}: Cost of the subsequent 90 million requests.
* 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|string }}: Cost of the remaining 215.04 million requests.

You can only connect a Cloud WAF profile if using a security profile. Both profiles, security and Cloud WAF, will contribute to the cost of request processing. Since the security and Cloud WAF profiles are priced equally, the total cost will be double that of a security profile alone if all legitimate requests are processed by both profiles.

##### Security profile and Cloud WAF {#security-profile-waf-usd}

> Let’s calculate the cost of 315,040,000 legitimate requests per month processed by security and Cloud WAF profile rules:
>
> {% calc [currency=USD] 0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }} %} × 2 = {% calc [currency=USD] (0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }}) × 2 %}, without VAT.

Where:

* {% calc [currency=USD] 0.01 × {{ sku|USD|sws.requests.v1|number }} + 0.99 × {{ sku|USD|sws.requests.v1|pricingRate.0.01|number }} + 9 × {{ sku|USD|sws.requests.v1|pricingRate.1|number }} + 90 × {{ sku|USD|sws.requests.v1|pricingRate.10|number }} + 215.04 × {{ sku|USD|sws.requests.v1|pricingRate.100|number }} %}: Cost of 315,040,000 legitimate requests per month processed by security profile rules.
* × 2: The cost is multiplied by `2` since the security and Cloud WAF profiles are priced equally.
