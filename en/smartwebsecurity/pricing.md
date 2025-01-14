---
title: '{{ sws-full-name }} pricing policy'
description: This article provides the {{ sws-name }} pricing policy.
editable: false
---

# {{ sws-full-name }} pricing policy



{% note tip %}




To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=24251ebe98ed#calculator) on the {{ yandex-cloud }} website or see the pricing in this section.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ sws-name }} {#rules}

In {{ sws-name }}, you pay for the actual number of [legitimate](concepts/rules.md#rule-action) requests.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [sum-cloud-account](../_includes/smartwebsecurity/sum-cloud-account.md) %}

### Requests processed by security profile rules {#requests-smart}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}


### Requests processed by WAF rules {#requests-waf}

{% note warning %}

The pricing below will apply starting October 1, 2024.

{% endnote %}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests-waf.md) %}


To use additional protection against DDoS attacks at OSI layers 3 and 4, connect [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). You will be billed for the [public IP address](../vpc/pricing.md#prices-public-ip) and [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection) usage.




{% include [usd-smartwebsecurity](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity.md) %}
