---
title: '{{ mtr-full-name }} pricing policy'
description: This article covers the {{ mtr-name }} pricing policy.
editable: false
---

# {{ mtr-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    children: []
:::




This section describes the {{ mtr-name }} pricing [policy](#rules) and [current prices](#prices) for its resources. For other {{ yandex-cloud }} resources consumed while using the service you pay as per their pricing plans.


{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

Pricing applies differently depending on cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

## What goes into the cost of using {{ mtr-name }} {#rules}

When using {{ mtr-name }}, you pay for:

* Computing resources of cluster components.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

Cluster operation cost is charged per minute. The minimum billing unit is one minute, e.g., 1.5 minutes of cluster usage is billed as 2 minutes.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Cluster cost calculation example {#example}

Suppose we calculate the 30-day usage cost of a cluster with the following configuration:

* **Coordinator**: One `standard` configuration instance: 4 × 100% vCPU, 16 GB RAM.
* **Workers**: One `standard` configuration instance, fixed number: 4 × 100% vCPU, 16 GB RAM.



{% include [usd-trino](../_pricing_examples/managed-trino/usd.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|trino }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

