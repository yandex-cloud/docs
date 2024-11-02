---
editable: false
---

# {{ sws-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ sws-name }} {#rules}

In {{ sws-name }}, you pay for the actual number of [legitimate](concepts/rules.md#rule-action) requests.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [sum-cloud-account](../_includes/smartwebsecurity/sum-cloud-account.md) %}

### Requests processed by security profile rules {#requests-smart}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}

{% cut "Example of calculating the cost of requests processed by WAF rules" %}

{% include [usd-smartwebsecurity](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity.md) %}

{% endcut %}


### Requests processed by WAF rules {#requests-waf}

{% note warning %}

The pricing below will apply starting October 1, 2024.

{% endnote %}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests-waf.md) %}

{% cut "Example of calculating the cost of requests processed by WAF rules" %}

{% include [usd-smartwebsecurity](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity-waf.md) %}

{% endcut %}


### Request cost calculations

To use DDoS protection at levels 3 and 4 of the OSI model, enable [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). The service is charged for the [public IP address](../vpc/pricing.md#prices-public-ip) and [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection).

