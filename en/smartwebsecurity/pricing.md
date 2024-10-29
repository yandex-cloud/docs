---
editable: false
---

# {{ sws-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ sws-name }} {#rules}

The {{ sws-name }} cost depends on the number of [legitimate](concepts/rules.md#rule-action) requests.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [sum-cloud-account](../_includes/smartwebsecurity/sum-cloud-account.md) %}

### Requests processed by security profile rules {#requests-smart}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}

{% cut "Example of cost calculation for requests processed by security profile rules" %}

{% include [usd-smartwebsecurity](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity.md) %}

{% endcut %}


### Requests processed by WAF rules {#requests-waf}

{% note warning %}

The following price will be effective as of October 1, 2024.

{% endnote %}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests-waf.md) %}


### Ready-made cost calculations for requests

To estimate the approximate cost of requests, the table below shows the price calculations for a certain number of requests per month. This number does not include the free limit of 10,000 requests. The cost provided is for reference. The actual usage of {{ sws-name }} by your services will be calculated based on the actual number of requests.



{% include [usd-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity-pack.md) %}


To use DDoS protection at levels 3 and 4 of the OSI model, enable [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). The service is charged for the [public IP address](../vpc/pricing.md#prices-public-ip) and [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection).
