---
editable: false
---

# {{ sws-full-name }} pricing

To calculate the cost of using {{ sws-name }}, see the prices on this page.

## What goes into the cost of using {{ sws-name }} {#rules}

The cost of {{ sws-name }} depends on the following characteristics:
* the number of requests to the protected resource;
* the number of [security profiles](./concepts/profiles.md);
* the total number of [security rules](./concepts/rules.md) across all profiles.

## Pricing {#prices}

### Requests {#requests}




{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}

Payment is made for the actual number of requests.

> For example, the final cost of sending 315.04 million requests per month for analysis in {{ sws-name }} will be:
> 0.01 × $0.000000 + 0.99 × $200.000000 + 9 × $28.000000 + 90 × $1.600000 + 215.04 × $1.120000 = $834.844800, without VAT.
>
> Where:
> * 0.01 × $0.000000: non-chargeable threshold is the first 0.01 million requests;
> * 0.99 × $200.000000: the cost of the subsequent 0.99 million requests;
> * 9 × $28.000000: the cost of the subsequent 9 million requests;
> * 90 × $1.600000: the cost of the subsequent 90 million requests;
> * 215.04 × $1.120000: the cost of the rest 215.04 million requests.


### Security profiles and rules {#profiles-and-rules}

The minimum billing units are 1 security profile per month, 1 security rule per month.




{% include [usd-profiles-and-rules](../_pricing/smartwebsecurity/usd-profiles-and-rules.md) %}
