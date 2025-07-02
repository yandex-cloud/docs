---
title: '{{ sws-full-name }} pricing policy'
description: This article covers the {{ sws-name }} pricing policy.
editable: false
---

# {{ sws-full-name }} pricing policy



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ sws-name }} {#rules}

The cost depends on the billing mode:

* [By subscription](#subscription): Best for large amounts of incoming traffic.

* [By request count](#requests): Best for small amounts of incoming traffic.

Both methods are based on the number of requests across all [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud) linked to a single [billing account](../billing/concepts/billing-account.md).

Only [legitimate requests](concepts/rules.md#rule-action) are counted for billing purposes. These are requests that were allowed by all rules and let through to the protected resource.

At the same time, there are things to consider about billing in the dry run mode.

* If a rule has blocked a request, in the dry run mode, requests are not blocked and reach their destination. Such requests will be counted for billing. 

* If dry run was enabled only for one rule type, e.g., security profile rules, and the request was blocked by a WAF or ARL rule without dry run on, such a request will not be counted for billing.

Requests processed by ARL profile rules will not be counted for billing. Blocked requests will not be counted either, no matter when and which rule blocked them.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Subscription billing {#subscription}

#| || [**Request a subscription or trial**](https://yandex.cloud/en-ru/services/smartwebsecurity#contact-form) || |#

You pay for packages of legitimate requests. Each package includes a certain number of requests. You can purchase the WAF package only together with the AntiDDoS package.

Our subscription plans are priced per month.



{% include [usd-subscription](../_pricing/smartwebsecurity/usd-subscription.md) %}


The shown prices are for a yearly subscription; no monthly subscription is available.

If the plan you select is not enough, you can switch to another with pro-rata recalculation of the resources consumed to date.

### Billing by request count {#requests}

{% note tip %}




To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=2e8dfeb93503#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

You pay for the actual number of legitimate requests. For each request, you pay for:

* Processing by security profile rules: [basic](concepts/rules.md#base-rules) and [Smart Protection](concepts/rules.md#smart-protection-rules).

* Processing by [WAF rules](concepts/rules.md#waf-rules). If your request is processed by security profile rules and then WAF rules, you pay for both.

* Processing by rules in the dry run mode if the request has reached the protected resource.

#### Requests processed by security profile rules {#requests-smart}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}


#### Requests processed by WAF rules {#requests-waf}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests-waf.md) %}


To use additional protection against DDoS attacks at OSI layers 3 and 4, connect [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). You will be billed for the [public IP address](../vpc/pricing.md#prices-public-ip) and [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection) usage.

#### Example of {{ sws-name }} billing by requests {#price-example}

{% cut "Pre-calculated request costs" %}

To better understand how the cost of requests is calculated, see the table below with prices calculated for a certain number of requests per month. This number does not include the non-billable limit of 10,000 requests.
The prices below are for reference only. {{ sws-name }} usage by your services will be calculated based on the actual request count.



{% include [usd-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity-pack.md) %}


{% endcut %}



{% include [usd-smartwebsecurity](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity.md) %}

