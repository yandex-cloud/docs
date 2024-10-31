You can only connect a WAF profile when a security profile is used. Therefore, you pay for processing requests both by WAF and security profile rules.

> Let’s calculate the cost of 315.04 million legitimate requests per month processed by security and WAF profile rules:
> (0.01 × $0.000000 + 0.99 × $200.000000 + 9 × $28.000000 + 90 × $1.600000 + 215.04 × $1.120000) × 2 = $1669.689600, excluding VAT.

Where:

* 0.01 × $0.000000: Non-billable threshold of 0.01 million requests.
* 0.99 × $200.000000: Cost of the subsequent 0.99 million requests.
* 9 × $28.000000: Cost of the subsequent 9 million requests.
* 90 × $1.600000: Cost of the subsequent 90 million requests.
* 215.04 × $1.120000: Cost of the remaining 215.04 million requests.
* × 2: The total cost is multiplied by `2` as each request was first processed by security profile rules and then by WAF profile rules.