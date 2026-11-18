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

## What goes into the cost of using {{ sws-name }} {#rules}

The cost depends on the billing mode:

* [Subscription](#subscription): Best for large amounts of incoming traffic.
  
* [Request count](#requests): Best for small amounts of incoming traffic.

Both methods are based on the number of requests across all [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud) linked to a single [billing account](../billing/concepts/billing-account.md).

Only [legitimate requests](concepts/rules.md#rule-action) are counted when calculating the cost of request processing. These are requests that were allowed by all rules and let through to the protected resource.

At the same time, there are things to consider about billing in the dry run mode:

* If a rule has blocked a request, in the dry run mode, requests are not blocked and reach their destination. Such requests will be counted for billing. 

* If dry run was enabled only for one rule type, e.g., security profile rules, and the request was blocked by a WAF or ARL rule without dry run on, such a request will not be counted for billing.

Requests processed by ARL profile rules are not billed separately. Blocked requests are not counted when calculating the cost of request processing, no matter when and which rule blocked them.

When using a proxy server, Network Protection is billed separately. Its cost includes incoming traffic passed by Network Protection, including traffic of requests that were later blocked at L7. The calculation rules are described in the [Network Protection](#network-protection) section.

When using [domains](concepts/domain-protect.md), in addition to the cost of processed requests, [you pay](#proxy-resources) for the computing resources of the proxy server. Since domain protection is not included in the subscription, you can only enable it with request-count-based billing.

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




For cost estimation, use [this calculator](https://yandex.cloud/en/prices?state=2e8dfeb93503#calculator) on our website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

The billing period is a calendar month. 
  
{% include [calendar-month](../_includes/smartcaptcha/calendar-month.md) %}

You pay for the actual number of legitimate requests. For each request, you pay for:

* Processing by security profile rules: [basic](concepts/rules.md#base-rules) and [Smart Protection](concepts/rules.md#smart-protection-rules).
  
* Processing by [WAF rules](concepts/rules.md#waf-rules). If your request is processed by security profile rules and then WAF rules, you pay for both.
  
* Processing by rules in the dry run mode if the request has reached the protected resource.

To use additional protection against DDoS attacks at OSI layers 3 and 4, enable [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md). In this case, you will be billed for using the [public IP address](../vpc/pricing.md#prices-public-ip) and [{{ ddos-protection-full-name }}](../vpc/pricing.md#prices-ddos-protection).

#### Proxy server resources {#proxy-resources}

When using domains, you pay for the actual usage of the computing resources of each active proxy server.

When domain protection is activated, a minimum amount of proxy server resources is automatically reserved: 6 [resource units](../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling), 2 per availability zone. Their billing starts immediately, whether or not the domain is receiving traffic.

A resource unit is an internal VM created for the purpose of operating a proxy server in the availability zone.

One resource unit delivers the following maximum performance (autoscaling thresholds):

* 1,000 requests per second (RPS).
* 4,000 concurrently active connections.
* 300 new connections per second.
* 22 MB (176 Mbit) of traffic per second (covers both incoming and outgoing traffic).

The system autoscales the resource unit group based on external load on the proxy server nodes. It calculates the group size to keep load per resource unit below the specified thresholds.

The default minimum number of resource units is 6; you can increase this number upon request.

The proxy server fee is per hour. You are charged for the minimum number of resource units that were running for an hour.

Applications connected to a proxy server also get L3–L4 DDoS protection from Network Protection, which is [billed separately](#network-protection).

#### Network Protection {#network-protection}

{% note warning %}

Network Protection rates apply from December 1, 2026.

{% endnote %}

Network Protection protects applications connected to {{ sws-full-name }} proxy servers against DDoS attacks at L3–L4.



{% include [usd-network-protection-pricing](../_pricing/smartwebsecurity/usd-network-protection-pricing.md) %}


The cost is calculated separately for each proxy server. The price per 1 Mbps is the same at any bandwidth volume. There is no minimum fee, minimum billable bandwidth, or minimum usage period.

Proxy server computing resources, request processing by security profile rules, and Cloud WAF are billed separately. A zero Network Protection cost does not cancel the fees for these components.

##### Which traffic is billed {#network-protection-traffic}

Billing covers cleaned incoming traffic: data that Network Protection scrubbing nodes passed to the proxy server on all ports of its address. If this traffic is later blocked at L7, it is still counted in the Network Protection cost.

Traffic dropped by Network Protection and outgoing responses from the resource to clients are not counted. If no billable incoming traffic was recorded during the entire billing period, the Network Protection cost is zero.

##### How the monthly cost is calculated {#network-protection-formula}

For each proxy server, two metrics are determined for the period of connection to protection:

- **p95**: The 95th percentile of average incoming traffic speeds over five-minute intervals, in Mbps. This metric reduces the impact of short load spikes.
- **Average speed**: The total volume of billable incoming traffic divided by the connection duration to protection, converted to Mbps. The volume includes short spikes.

The billable bandwidth equals the larger of these two values. Therefore, short spikes can increase the cost through the average speed, even if p95 does not change.



**Monthly cost = rate × max(p95, average speed) × T / M**.


Here, `T` is the total duration of all proxy server connection intervals to protection in the billing month, including intervals without traffic. `M` is the duration of the full calendar month. Use the same time units for the `T / M` ratio.

The billing month starts at 00:00 on the first day of the month, Moscow time. If protection is enabled for part of the month, the cost is calculated in proportion to the connection duration. If there is no connection, the cost is zero.

##### Protection period and proxy server stop {#network-protection-period}

Network Protection is enabled automatically when a proxy server is created. Deleting the proxy server ends the protection period.

Stopping a proxy server keeps its address protected and does not end the billing period. Five-minute intervals without traffic are counted at zero speed. After the same proxy server is restarted, the statistics accumulated for the month are preserved.

Intervals with zero speed are included in the calculation of the average speed and p95, and in the connection duration to protection. Therefore, stopping a resource does not guarantee a proportional cost reduction: the result depends on the traffic over the entire connection period in the month.

A new proxy server is billed separately. If an old proxy server is stopped but not deleted, its calculation continues according to the general formula. The total cost is the sum of charges for both resources.

##### Charges and traffic review {#network-protection-billing}

During the month, the billing shows the accumulated charge for the billable consumption. When the load changes, the amount may increase unevenly. It is not a forecast of the full-month cost. The final cost is calculated after the month ends using the formula above.

You can view the charges in the **Details** section of {{ billing-name }}. For instructions, see [Viewing service usage details](../billing/operations/check-charges.md).

To verify the final calculation independently, use the data on incoming traffic passed by Network Protection in {{ monium-full-name }} for the same proxy server and the completed billing month. For instructions, see [Monitoring in {{ sws-name }}](operations/monitoring.md).

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




#### Example of {{ sws-name }} billing by request count {#price-example}

{% cut "Pre-calculated request costs" %}

To better understand how the cost of requests is calculated, see the table below with prices calculated for a certain number of requests per month. This number does not include the non-billable limit of 10,000 requests.
The prices below are for reference only. {{ sws-name }} usage by your services will be calculated based on the actual request count.



{% include [usd-smartwebsecurity-pack](../_pricing_examples/smartwebsecurity/usd-smartwebsecurity-pack.md) %}


{% endcut %}



{% include [usd-requests-pricing-examples](../_includes/smartwebsecurity/usd-requests-pricing-examples.md) %}


#### Examples of Network Protection cost calculation {#network-protection-price-example}



{% include [usd-network-protection](../_pricing_examples/smartwebsecurity/usd-network-protection.md) %}


