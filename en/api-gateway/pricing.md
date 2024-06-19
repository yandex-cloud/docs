---
title: "{{ api-gw-full-name }} pricing policy"
description: "This article describes the {{ api-gw-name }} pricing policy."
editable: false
---

# {{ api-gw-full-name }} pricing



## What goes into the cost of using {{ api-gw-name }} {#rules}

In {{ api-gw-name }}, you are charged for the number of requests to the created API gateways and outgoing traffic.

{% note warning %}

{{ api-gw-name }} only handles HTTPS requests. The service automatically redirects all requests to API gateways over HTTP to their HTTPS versions. 

{% endnote %}

### Pricing formula {#price-formula}



Cost per month = $0.96 × Number of millions of requests


{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of calculating the cost of an API gateway {#price-example}

{% include [prices-example](../_includes/api-gateway/prices-example.md) %}

## Prices for Russia {#prices}


### API gateway requests {#request}



{% include [usd.md](../_pricing/api-gateway/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
