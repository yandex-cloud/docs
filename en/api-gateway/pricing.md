---
title: '{{ api-gw-full-name }} pricing policy'
description: This article provides the {{ api-gw-name }} pricing policy.
editable: false
---

# {{ api-gw-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ api-gw-name }} {#rules}

In {{ api-gw-name }}, you are charged for the number of requests to the created API gateways and outgoing traffic. 

{% note warning %}

{{ api-gw-name }} only handles HTTPS requests. All requests to API gateways over HTTP are redirected automatically to their HTTPS versions. 

{% endnote %}

### Cost calculation formula {#price-formula}



Cost per month = {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|string }} × Request count (in millions)


{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of calculating the cost of an API gateway {#price-example}

{% include [prices-example](../_includes/api-gateway/prices-example.md) %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### API gateway requests {#request}



{% include [usd.md](../_pricing/api-gateway/usd.md) %}

You pay for the actual number of calls.

> For example, 10,000 calls in excess of the free amount will cost {% calc [currency=USD] {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|number }} / 100 %}, if one million calls costs {{ sku|USD|api-gateway.requests.v1|pricingRate.0.1|string }}.


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
