---
editable: false
---

# {{ sws-full-name }} pricing



To calculate the cost of using {{ sws-name }}, see the prices on this page.

## What goes into the cost of using {{ sws-name }} {#rules}

The {{ sws-name }} cost depends on the following parameters:
* Number of requests to the protected resource
* Number of [security profiles](./concepts/profiles.md)
* Total number of [security rules](./concepts/rules.md) in all profiles

## Prices for the Russia region {#prices}


### Requests {#requests}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}

{% include [sum-cloud-account](../_includes/smartwebsecurity/sum-cloud-account.md) %}

> For example, the total cost of sending 315.04 million requests per month to {{ sws-name }} for analysis will be:
> 0.01 × $0.000000 + 0.99 × $200.000000 + 9 × $28.000000 + 90 × $1.600000 + 215.04 × $1.120000 = $834.844800 excluding VAT.
>
> Where:
> * 0.01 × $0.000000: Non-billable threshold of 0.01 million requests.
> * 0.99 × $200.000000: Cost of the subsequent 0.99 million requests.
> * 9 × $28.000000: Cost of the subsequent nine million requests.
> * 90 × $1.600000: Cost of the subsequent 90 million requests.
> * 215.04 × $1.120000: Cost of the remaining 215.04 million requests.


### Security profiles and rules {#profiles-and-rules}

Minimum billing units are one security profile per month and one security rule per month.



{% include [usd-profiles-and-rules](../_pricing/smartwebsecurity/usd-profiles-and-rules.md) %}

