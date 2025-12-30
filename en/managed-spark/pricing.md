---
title: '{{ msp-full-name }} pricing policy'
description: This article covers the {{ msp-full-name }} pricing policy.
editable: false
---

# {{ msp-full-name }} pricing policy

In this section, you can find the {{ msp-full-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources. For other {{ yandex-cloud }} resources consumed while using the service you pay as per their pricing plans.

{% note tip %}



To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=301760ee7702#calculator) on the {{ yandex-cloud }} website or check out the pricing below.



{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

The prices apply differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

## What goes into the cost of using {{ msp-full-name }} {#rules}

When using {{ msp-full-name }}, you pay for:

* Computing resources of cluster components.
* Outgoing traffic from {{ yandex-cloud }}.

Cluster operation cost is charged per hour. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 90 minutes (1.5 hours).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Cluster cost calculation example {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **Driver**: Two `standard` configuration instances, `c4-m16` [host class](concepts/instance-types.md), fixed quantity: 4 vCPUs, 16 GB RAM.
* **Executor**: Four `standard` configuration instances, `c4-m16` host class, fixed quantity: 4 vCPUs, 16 GB RAM.




{% include [usd-host](../_pricing_examples/managed-spark/usd-host.md) %}



## Prices for the Russia region {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|spark }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

