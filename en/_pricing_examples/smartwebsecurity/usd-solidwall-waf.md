All examples use the "{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}" plan with a capacity of 300 RPS. The profile has one application, which is included in the plan. Amounts exclude VAT.

##### No traffic {#solidwall-usd-example-no-traffic}

The profile exists throughout December 2026, but no requests passed through it. No SolidWall WAF fee is charged for the month: **$0**.

A proxy server with 6 resource units ran all December without scaling. Its cost is calculated separately:

> 6 × 744 × {{ sku|USD|sws.proxy-server.v1|string }} = {% calc [currency=USD] 6 × 744 × {{ sku|USD|sws.proxy-server.v1|number }} %}, without VAT.

Where:

* 744: Number of hours in December (31 days).
* {{ sku|USD|sws.proxy-server.v1|string }}: Price per proxy server resource unit per hour.

##### First partial month with traffic {#solidwall-usd-example-partial-month}

The first traffic through the profile appeared on December 20, 2026, at 00:00. There are 12 days left out of 31 until January 1, 2027.

> 300 × 3.5 × 12 / 31 = {% calc [currency=USD] 300 × 3.5 × 12 / 31 %}, without VAT.

Where:

* 300: Selected RPS capacity.
* $3.5: Price per 1 RPS per month for the 300 RPS capacity.
* 12 / 31: Fraction of December from the first day with traffic through December 31, inclusive.

If there is no traffic in January, the SolidWall WAF fee for January is $0. There is no mandatory charge for the next full month.

##### First partial month and profile deletion {#solidwall-usd-example-delete}

The first traffic appeared on December 20, 2026, at 00:00. The cost depends on when the profile is deleted and whether there was traffic in January:

#|
|| **When the profile is deleted** | **December** | **January** | **Total for two months** ||
|| December 25 | {% calc [currency=USD] round((300 × 3.5 × 12 / 31) × 100) / 100 %} | $0 | {% calc [currency=USD] round((300 × 3.5 × 12 / 31) × 100) / 100 %} ||
|| January 15, no traffic in January | {% calc [currency=USD] round((300 × 3.5 × 12 / 31) × 100) / 100 %} | $0 | {% calc [currency=USD] round((300 × 3.5 × 12 / 31) × 100) / 100 %} ||
|| January 15, traffic in January | {% calc [currency=USD] round((300 × 3.5 × 12 / 31) × 100) / 100 %} | {% calc [currency=USD] 300 × 3.5 %} | {% calc [currency=USD] round((300 × 3.5 × 12 / 31 + 300 × 3.5) × 100) / 100 %} ||
|#

In the first month, the fee is kept for the period from the first traffic to the end of the month, even if the profile is deleted earlier. If there was traffic in the following month, the full monthly fee is charged.

##### New SolidWall WAF profile {#solidwall-usd-example-new-profile}

The billing start date is determined separately for each profile. The first profile receives traffic from December 1, 2026, at 00:00. The second profile was created on December 10, and its first traffic appeared on December 25 at 00:00. There are 7 days left until the end of the month.

* First profile: 300 × 3.5 = {% calc [currency=USD] 300 × 3.5 %}, without VAT.
* New profile: 300 × 3.5 × 7 / 31 = {% calc [currency=USD] round((300 × 3.5 × 7 / 31) × 100) / 100 %}, without VAT.

**Total cost for December:** {% calc [currency=USD] round((300 × 3.5 + 300 × 3.5 × 7 / 31) × 100) / 100 %}, without VAT.

If the new profile had been created earlier, but its traffic started on December 25, the calculation would be the same. If a profile was created and deleted without a single request, its cost is $0.

##### Full month with traffic {#solidwall-usd-example-full-month}

Traffic through the profile runs from December 1, 2026, at 00:00, until the end of the month. The selected capacity is 300 RPS, and the p95 legitimate RPS for December is 200 RPS. The selected capacity is used for billing:

> 300 × 3.5 = {% calc [currency=USD] 300 × 3.5 %}, without VAT.

The first application is included in this amount.

##### Exceeding the selected capacity {#solidwall-usd-example-exceed}

The profile runs all December. The selected capacity is 300 RPS, but the p95 legitimate RPS for the month is 450 RPS:

* Selected capacity: 300 × 3.5 = {% calc [currency=USD] 300 × 3.5 %}, without VAT.
* Excess: (450 - 300) × 3.5 = {% calc [currency=USD] (450 - 300) × 3.5 %}, without VAT.
* Total: 450 × 3.5 = **{% calc [currency=USD] 450 × 3.5 %}**, without VAT.

The rate of the selected capacity is kept for the excess. There is no automatic move to the 500 RPS capacity rate. The cost depends on the p95 for the billing period, so a brief peak above 300 RPS does not by itself create an additional charge.
