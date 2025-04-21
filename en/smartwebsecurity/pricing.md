---
title: '{{ sws-full-name }} pricing policy'
description: This article provides the {{ sws-name }} pricing policy.
editable: false
---

# {{ sws-full-name }} pricing policy

## What goes into the cost of using {{ sws-name }} {#rules}


Billing is based on the number of requests across all [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud) linked to a single [billing account](../billing/concepts/billing-account.md).

In {{ sws-name }}, you pay for the actual number of [legitimate](concepts/rules.md#rule-action) requests.

There are billing specifics in dry run mode:

* Even though a rule blocks a request, those are not blocked in the dry run mode, which means they reach their destination.

* If you only enabled dry run for one rule type, e.g., for security profile rules, while the request was blocked with WAF or ARL without dry run, you are not charged for such a request.

You are not charged for processing requests with ARL profile rules. You are not charged for blocked requests, regardless of when and which rule blocked them.

## Prices for the Russia region {#prices}



{% note warning %}

Starting May 1, 2025, the prices for {{ sws-full-name }} resources in the Russia region will increase. For new USD prices, see our [price list](https://yandex.cloud/en/price-list?currency=USD&installationCode=ru&services=dn2hj22hpe85kloqo6ag).

{% endnote %}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Pay as you go {#requests}



{% note tip %}




To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=2e8dfeb93503#calculator) on the {{ yandex-cloud }} website or see the pricing data in this section.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

You pay for the actual number of legitimate requests. For each request, you are charged for:

* Processing with security profile rules, both [basic](concepts/rules.md#base-rules) and [Smart Protection](concepts/rules.md#smart-protection-rules) ones.
  
* Processing with [WAF rules](concepts/rules.md#waf-rules). If a request is processed with security profile rules and then with WAF rules, you are charged for both.

* Processing with any rules in dry run mode if the request is directed to a protected resource.

#### Requests processed by security profile rules {#requests-smart}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}


#### Requests processed by WAF rules {#requests-waf}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests-waf.md) %}


To use additional protection against DDoS attacks at OSI layers 3 and 4, connect [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). You will be billed for the [public IP address](../vpc/pricing.md#prices-public-ip) and [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection) usage.




{% include [usd-smartwebsecurity](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity.md) %}
