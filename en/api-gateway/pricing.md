---
title: "{{ api-gw-full-name }} pricing policy"
description: "This article describes the {{ api-gw-name }} pricing policy."
editable: false
---

# {{  api-gw-full-name }} pricing

## What is included in {{ api-gw-name }} cost {#rules}

In {{ api-gw-name }}, you are charged for the number of requests to the created API gateways and outgoing traffic.

{% note warning %}

{{ api-gw-name }} only handles HTTPS requests. The service automatically redirects all requests to API gateways over HTTP to their HTTPS versions. 

{% endnote %}




### Pricing formula {#price-formula}

Cost per month = $0.96 × Number of millions of requests

{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of calculating the cost of an API gateway {#price-example}

Let's assume, you created an API gateway that processed 10,000,000 requests over HTTPS.

The cost of this API gateway will be:

> 0.96 × ((10,000,000 – 100,000) / 1,000,000) = $9.504

Where:
* 0.96: Price per 1 million API gateway calls.
* 10,000,000: Number of requests over HTTPS.
* 100,000 is subtracted because the first one hundred thousand calls are free of charge.
* 1,000,000 is the divisor used to calculate the number of millions of requests over HTTPS.


## Pricing {#prices}

### API gateway requests {#request}




{% include notitle [usd.md](../_pricing/api-gateway/usd.md) %}


### Egress traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}
