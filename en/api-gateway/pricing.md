---
editable: false
---

# Pricing for {{  api-gw-full-name }}

## What goes into the cost of using {{ api-gw-name }} {#rules}

In {{ api-gw-name }}, you're charged for the number of requests to created API gateways and outgoing traffic.

{% note warning %}

{{ api-gw-name }} only handles HTTPS requests. The service automatically redirects all requests to API gateways over HTTP to their HTTPS versions. 

{% endnote %}




### Pricing formula {#price-formula}

Cost per month = $0.96 × Number of millions of requests

{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of calculating the cost of an API gateway {#price-example}

For example, let's say you create an API gateway that processed 10000000 requests over HTTPS.

The cost of this API gateway will be:

> 0.96 × ((10000000 – 100000) / 1000000) = $9.504

Where:
* 0.96: Price per 1 million API gateway calls.
* 10000000: Number of requests over HTTPS.
* 100000 is subtracted because the first one hundred thousand calls are free of charge.
* 1000000 is the divisor used to calculate the number of millions of requests over HTTPS.


## Pricing {#prices}

### API gateway requests {#request}




{% include notitle [usd.md](../_pricing/api-gateway/usd.md) %}


### Egress traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}
