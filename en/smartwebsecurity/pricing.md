---
title: '{{ sws-full-name }} pricing policy'
description: This article covers the {{ sws-name }} pricing policy.
editable: false
---

# {{ sws-full-name }} pricing policy



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ sws-name }} {#rules}

The cost depends on the billing mode:

* [Subscription](#subscription): Best for large amounts of incoming traffic.
  
* [Request count](#requests): Best for small amounts of incoming traffic.

Both methods are based on the number of requests across all [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud) linked to a single [billing account](../billing/concepts/billing-account.md).

Only [legitimate requests](concepts/rules.md#rule-action) are counted for billing purposes. These are requests that were allowed by all rules and let through to the protected resource.

At the same time, there are things to consider about billing in the dry run mode:

* If a rule has blocked a request, in the dry run mode, requests are not blocked and reach their destination. Such requests will be counted towards consumption. 

* If dry run was enabled only for one rule type, e.g., security profile rules, and the request was blocked by a WAF or ARL rule without dry run on, such a request will not be counted towards consumption.

Requests processed by ARL profile rules will not be counted towards consumption. Blocked requests will not be counted either, no matter when and which rule blocked them.

When using [domains](concepts/domain-protect.md), in addition to the cost of processed requests, [a fee is charged](#proxy-resources) for traffic passing through the proxy server and protection against DDoS attacks at the L3-L4 levels of the [OSI model](https://wikipedia.org/wiki/OSI_model).

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Subscription billing {#subscription}

#| || [**Request a subscription or trial**](https://yandex.cloud/en-ru/services/smartwebsecurity#contact-form) || |#

You pay for packages of legitimate requests. Each package includes a certain number of requests. You can purchase the WAF package only together with the AntiDDoS package.

Our subscription plans are priced per calendar month.

{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}



{% include [usd-subscription](../_pricing/smartwebsecurity/usd-subscription.md) %}


The prices below are for 12-month subscription; no monthly subscription is available.

If the plan you select is not enough, you can switch to another with pro-rata recalculation of the resources consumed to date.

### Billing by request count {#requests}

{% note tip %}




To calculate the cost of using {{ sws-name }}, use [our calculator](https://yandex.cloud/en/prices?state=2e8dfeb93503#calculator) on the {{ yandex-cloud }} website or check the pricing data below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

The billing period is a calendar month. 
  
{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}

You pay for the actual number of legitimate requests. For each request, you pay for:

* Processing by security profile rules: [basic](concepts/rules.md#base-rules) and [Smart Protection](concepts/rules.md#smart-protection-rules).
  
* Processing by [WAF rules](concepts/rules.md#waf-rules). If your request is processed by security profile rules and then WAF rules, you pay for both.
  
* Processing by rules in the dry run mode if the request has reached the protected resource.

#### Requests processed by security profile rules {#requests-smart}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests.md) %}


#### Requests processed by WAF rules {#requests-waf}



{% include [usd-requests](../_pricing/smartwebsecurity/usd-requests-waf.md) %}


To use additional protection against DDoS attacks at OSI layers 3 and 4, enable [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). In this case, you will be billed for using the [public IP address](../vpc/pricing.md#prices-public-ip) and [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection).

#### Proxy server resources {#proxy-resources}

When using the domain, you pay for the actual compute resources consumed by active proxy servers and for protecting your traffic from DDoS attacks at the L3-L4 levels.

Resource usage is determined by the number of [resource units](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling), i.e., internal VMs provisioned per availability zone for the proxy server.

One resource unit supports these peak performance thresholds (thresholds for automatic scaling):

* 1000 requests per second (RPS).
* 4000 concurrently active connections.
* 300 new connections per second.
* 22 MB (176 Mbit) of traffic per second (covers both incoming and outgoing traffic).

The default minimum number of proxy server resource units is 6 (2 in each availability zone).

The system automatically scales the resource unit group based on the proxy server node’s external workload. The system calculates the group size to ensure resource unit utilization remains below specified thresholds.

Proxy server usage is billed hourly. You are charged based on the highest number of resource units running during each hour.

Traffic protection from DDoS attacks at the L3-L4 levels is charged according to the volume of [legitimate](concepts/rules.md#rule-action) traffic in GB.

{% note warning %}

Prices for proxy server resources apply starting November 10, 2025.

{% endnote %}



{% include [usd-domain](../_pricing/smartwebsecurity/usd-domain.md) %}


#### Example of {{ sws-name }} billing by request count {#price-example}

{% cut "Pre-calculated request costs" %}

To better understand how the cost of requests is calculated, see the table below with prices calculated for a certain number of requests per month. This number does not include the non-billable limit of 10,000 requests.
The prices below are for reference only. {{ sws-name }} usage by your services will be calculated based on the actual request count.



{% include [usd-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity-pack.md) %}


{% endcut %}



{% include [usd-smartwebsecurity](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity.md) %}

