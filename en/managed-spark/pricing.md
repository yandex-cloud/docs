---
title: '{{ msp-full-name }} pricing policy'
description: This article covers the {{ msp-full-name }} pricing policy.
editable: false
---

# {{ msp-full-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        gravityIcon: Calculator
        iconPosition: left
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=14a0c1151c16#calculator
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
        iconPosition: left
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn2pkj6x6txcsqlb72gm
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


This section describes the {{ msp-full-name }} pricing [policy](#rules) and [current prices](#prices) for its resources. For other {{ yandex-cloud }} resources consumed while using the service you pay as per their pricing plans.

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

Pricing applies differently depending on cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

## What goes into the cost of using {{ msp-full-name }} {#rules}

When using {{ msp-full-name }}, you pay for:

* Computing resources of cluster components.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

Cluster operation cost is charged per minute. The minimum billing unit is one minute, e.g., 1.5 minutes of cluster usage is billed as 2 minutes.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Cluster cost calculation example {#example}

Suppose we calculate the 30-day usage cost of a cluster with the following configuration:

* **Cluster system node**: Consumes a fixed quantity: 8 vCPUs, 8 GB RAM.
* **Driver**: Two `standard` configuration instances, `c4-m16` [host class](concepts/instance-types.md), fixed quantity: 4 vCPUs, 16 GB RAM.
* **Executor**: Four `standard` configuration instances, `c4-m16` host class, fixed quantity: 4 vCPUs, 16 GB RAM.




{% include [usd-host](../_pricing_examples/managed-spark/usd-host.md) %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|spark }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

