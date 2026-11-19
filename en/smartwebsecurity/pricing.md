---
title: '{{ sws-full-name }} pricing policy'
description: This article covers the {{ sws-name }} pricing policy.
editable: false
---

# {{ sws-full-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        gravityIcon: Calculator
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=0fd59c4ae9e5#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        gravityIcon: CircleRuble
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn2hj22hpe85kloqo6ag
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

#| || [**Request a subscription or trial**](https://yandex.cloud/en-ru/services/smartwebsecurity#contact-form) || |#

## What goes into the cost of using {{ sws-name }} {#rules}

{{ sws-name }} offers two billing options:

* [Subscription billing](#subscription) is suitable for large volumes of traffic processed by security profile rules, with optional Cloud WAF checks.
* [Billing by request count](#requests) is required for [external domain protection](#domain-protection-charges) and [SolidWall WAF](#requests-solidwall-waf), regardless of traffic volume. It is also suitable for small volumes of traffic processed by security profile rules, with or without Cloud WAF. Separate rates apply to SolidWall WAF, [proxy server resources](#proxy-resources), and [Network Protection](#network-protection).

Under both options, only [legitimate requests](concepts/rules.md#rule-action) count toward security profile and Cloud WAF usage. These are requests the service allows through to the protected resource. The service counts them per calendar month across all [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud) linked to the same [billing account](../billing/concepts/billing-account.md).

{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}

You can enable [Logging only](concepts/rules.md#dry-run) (dry run) for individual rules. A rule in this mode logs matches without blocking requests. Billing depends on the outcome of the other checks.

* **The request reaches the resource.** It counts toward your monthly subscription allowance. With billing by request count, it counts toward security profile usage and separately toward Cloud WAF usage if Cloud WAF checked it. You pay only for requests above each [free allowance](#security-profile-cloud-waf).
* **Another rule blocks the request.** For example, an [Advanced Rate Limiter](concepts/arl.md) (ARL) rule blocks it when the request rate exceeds the configured limit. The request does not count under either billing option.

ARL checks carry no separate charge.

If you use [Network Protection](#network-protection-traffic), traffic that passes through its scrubbing nodes counts toward Network Protection charges even if a rule later blocks the request at L7.

## Subscription billing {#subscription}

Subscriptions run for one year. [Choose a plan](#subscription-prices) based on the number of legitimate requests you expect per calendar month. For the security profile, you pay a monthly fee for the AntiDDoS package. If you also use Cloud WAF, you pay for both the AntiDDoS and WAF packages.

If your request volume exceeds the amount included in your plan, you can move to the next plan. Charges for resources already used are recalculated on a pro rata basis.

## Billing by request count {#requests}

### Security profile and Cloud WAF {#security-profile-cloud-waf}

Requests processed by [basic rules](concepts/rules.md#base-rules) or [Smart Protection rules](concepts/rules.md#smart-protection-rules) count toward security profile usage. If [Cloud WAF rules](concepts/rules.md#waf-rules) also check a request, it counts toward Cloud WAF usage as well.

For each type of processing, the first 10,000 requests per calendar month are free. Above the free allowance, the requests in each pricing tier are billed at that tier's rate per million.

For example, suppose the security profile processes 12,000 legitimate requests across your billing account in one month, and Cloud WAF checks 8,000 of them. You pay only for the 2,000 security profile requests above the free allowance. For larger volumes, see the [request pricing examples](#price-example).

### Additional protection for an L7 load balancer {#load-balancer-ddos-protection}

If your security profile is connected to an [{{ alb-name }} L7 load balancer](../application-load-balancer/), you can enable [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md) for protection against L3–L4 DDoS attacks. Separate charges apply for the [public IP address](../vpc/pricing.md#prices-public-ip) and [DDoS protection](../vpc/pricing.md#prices-ddos-protection).

### Domain protection {#domain-protection-charges}

With [domain protection](concepts/domain-protect.md), you pay for [proxy server resources](#proxy-resources) and [Network Protection](#network-protection) in addition to request processing. If you enable [SolidWall WAF](#requests-solidwall-waf), it is billed separately.

#### Proxy server resources {#proxy-resources}

When you activate domain protection, the service reserves at least six [resource units](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) for the proxy server, two per availability zone. You can request a higher minimum.

Billing starts at activation, even if the proxy server receives no traffic. For each hour the proxy server runs, you pay for the minimum number of resource units running during that hour.

A resource unit is an internal VM that runs the proxy server in an availability zone. The service automatically scales the group to keep each unit within the following limits.

* 1,000 requests per second (RPS).
* 4,000 concurrent active connections.
* 300 new connections per second.
* 22 MB (176 Mbit) per second of incoming and outgoing traffic combined.

#### Network Protection {#network-protection}

[Network Protection](https://yandex.cloud/ru/docs/smartwebsecurity/concepts/network-protection) (in Russian) protects the proxy server against L3–L4 DDoS attacks. Each proxy server is billed at the [same rate per Mbps](#network-protection-prices) regardless of bandwidth. There is no minimum fee, minimum billable bandwidth, or minimum usage period.

##### Billable incoming traffic {#network-protection-traffic}

Billing includes incoming traffic that the scrubbing nodes pass through to any port on the proxy server, even if a request is later blocked at L7. Traffic dropped by the scrubbing nodes and outgoing responses to clients are excluded. If the nodes pass no incoming traffic during the billing period, the Network Protection charge is zero.

##### Protection period {#network-protection-period}

Protection for the proxy server's address starts automatically when you create the server and lasts until you delete it. The protection period continues while the proxy server is stopped. Five-minute intervals without traffic count as zero when calculating p95 and average speed, so stopping the server may leave the charge unchanged.

If you restart the same proxy server, its traffic statistics for the month carry over. If you create a new server and keep the old one, the protection charge is calculated for each. The [Network Protection pricing examples](#network-protection-price-example) show how this affects the total.

##### Monthly cost calculation {#network-protection-formula}

For each proxy server, the billable bandwidth is the higher of two incoming traffic speeds, both measured in Mbps over the protection period.

* **p95** is the 95th percentile of the average speeds over five-minute intervals. This limits the effect of short traffic spikes.
* **Average speed** is the total volume of billable traffic divided by the duration of the protection period. A short spike can increase the average speed and the cost even if p95 stays the same.



**Monthly cost = rate × max(p95, average speed) × T / M**.


`T` is the total time the proxy server was connected to protection during the billing month, including intervals without traffic. `M` is the length of the calendar month in the same time units. The month starts at 00:00 UTC+3 on the first day. If protection was active for only part of the month, the charge is prorated. If the server was never connected to protection that month, the charge is zero.

##### Checking charges {#network-protection-billing}

[Usage details](../billing/operations/check-charges.md) in {{ billing-name }} shows charges since the beginning of the month. Charges may rise unevenly as the load changes. The service calculates the final cost using the [monthly formula](#network-protection-formula) after the month ends. To verify the charge, check how much incoming traffic Network Protection passed through to the same proxy server that month. The [monitoring instructions](https://yandex.cloud/ru/docs/smartwebsecurity/operations/monitoring#network-protection) (in Russian) show how to find this data in {{ monium-full-name }}.

#### SolidWall WAF {#requests-solidwall-waf}

SolidWall WAF requires a [security profile with a Smart Protection rule](operations/solidwall-waf-profile-create.md#setup). In addition to domain protection and [request processing](#security-profile-cloud-waf), you pay for legitimate traffic and additional applications in each SolidWall WAF profile.

Billing starts when the profile first receives traffic, including in monitoring mode, but no earlier than 00:00 UTC+3 on December 1, 2026. There is no charge for the profile in a calendar month without traffic.

##### Plans and RPS capacity {#solidwall-waf-bandwidth}

The [plan](concepts/solidwall-waf.md#tariffs) determines which checks SolidWall WAF performs.

* **{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}** checks requests against attack signatures and supports loads of up to 1,000 RPS.
* **{{ ui-key.yacloud.smart-web-security.solidWallAdvancedTariff_6mLtW }}** also analyzes responses and user sessions based on application logic.

Choose the RPS capacity based on the expected combined peak load across all applications in the profile. For example, a capacity of 700 RPS covers a peak of 600 requests per second. In the [price table](#solidwall-waf-prices), each capacity is listed under its plan. The **Price** column gives the monthly rate per RPS for that capacity. Once the profile receives its first traffic, changes to the plan or capacity take effect on the first day of the following month.

##### Cost of legitimate traffic {#solidwall-waf-traffic}

In a month with traffic, the selected capacity is the minimum billable load. If the actual load exceeds that capacity, the same rate applies to the excess. Actual load is the 95th percentile (p95) of average legitimate RPS over five-minute intervals. The calculation excludes the highest 5% of values.

**Monthly cost of legitimate traffic = max(selected RPS capacity, p95 legitimate RPS) × rate for the selected capacity × share of month**

In the first month, the p95 calculation starts when the profile first receives traffic. To calculate the share of the month, count the days from the first day with traffic through the last day of the month, inclusive, and divide by the number of calendar days in that month. In subsequent months with traffic, the share is one. Deleting the profile does not shorten the billable period. See the [SolidWall WAF pricing examples](#solidwall-waf-price-example).

##### Cost of additional applications {#solidwall-waf-applications}

Billing uses the maximum number of applications active at the same time during the calendar month. An application is active if it has a connected domain and receives traffic. The plan includes the first application. Each additional application is billed at the plan's rate per application. Deleting an application does not reduce the recorded maximum.

The [proxy server and SolidWall WAF pricing example](#proxy-solidwall-waf-price-example) shows the total including proxy server resources and security profile request processing.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Subscription prices {#subscription-prices}



{% include [usd-subscription](../_pricing/smartwebsecurity/usd-subscription.md) %}


### Request-based pricing {#request-prices}

#### Network Protection {#network-protection-prices}

{% note warning %}

Network Protection rates apply from December 1, 2026.

{% endnote %}



{% include [usd-network-protection-pricing](../_pricing/smartwebsecurity/usd-network-protection-pricing.md) %}


#### SolidWall WAF {#solidwall-waf-prices}

{% note warning %}

SolidWall WAF rates apply from December 1, 2026.

{% endnote %}



{% include [usd-solidwall-waf-pricing](../_pricing/smartwebsecurity/usd-solidwall-waf-pricing.md) %}


#### Calculator and price list {#calculator-price-list}

<MDX>
  <Calculator
    services={['smartwebsecurity']} collapsible
  />
</MDX>



<MDX>
  <PriceList
    serviceIds={['{{ pcs|sws }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


## Cost calculation examples {#price-examples}

### Example of {{ sws-name }} billing by request count {#price-example}

{% cut "Pre-calculated request costs" %}

The table shows the cost of processing legitimate requests per calendar month, including the first 10,000 requests at no charge. The request count is the total across all clouds linked to the billing account. The last column assumes that both the security profile and Cloud WAF process every request.



{% include [usd-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity-pack.md) %}


{% endcut %}

The examples below assume that there are no other requests under the billing account that month.



{% include [usd-requests-pricing-examples](../_includes/smartwebsecurity/usd-requests-pricing-examples.md) %}


### Examples of Network Protection cost calculation {#network-protection-price-example}



{% include [usd-network-protection](../_pricing_examples/smartwebsecurity/usd-network-protection.md) %}


### Examples of SolidWall WAF cost calculation {#solidwall-waf-price-example}



{% include [usd-solidwall-waf](../_pricing_examples/smartwebsecurity/usd-solidwall-waf.md) %}


### Example of calculating proxy server and SolidWall WAF costs {#proxy-solidwall-waf-price-example}

Let's calculate the cost of proxy server resources, request processing by security profile rules, and SolidWall WAF for a calendar month (30 days, 720 hours), assuming:

* One proxy server uses six resource units throughout the month without scaling.
* The **{{ ui-key.yacloud.smart-web-security.solidWallBasicTariff_hB5xS }}** SolidWall WAF plan is selected with a capacity of 300 RPS. The actual load does not exceed 300 RPS.
* Two applications are active in the SolidWall WAF profile throughout the month. The first is included in the plan; the second is billed separately.
* A security profile with a Smart Protection rule is connected to the domains. It processes 10 million legitimate requests during the month. There are no other requests under the billing account that month.

The first 10,000 requests processed by security profile rules are free. The remaining 9.99 million requests are charged at the per-million rates for the applicable pricing tiers.

If you use Cloud WAF, you also pay for requests processed by its rules.

The [Network Protection](#network-protection) fee is calculated separately based on the rate of incoming traffic that passed through and the time protection was active. See the [Network Protection examples](#network-protection-price-example) for the calculation.



{% include [usd-proxy-solidwall-waf](../_pricing_examples/smartwebsecurity/usd-proxy-solidwall-waf.md) %}


