---
title: '{{ maf-full-name }} pricing policy'
description: This article covers the {{ maf-name }} pricing policy.
editable: false
---

# {{ maf-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 6
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=2e61e2b05731#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        icon: ../_assets/console-icons/circle-ruble.svg
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn2o8879r181fgps5lb3
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




This section describes the {{ maf-name }} pricing [policy](#rules) and [current prices](#prices) for its resources. For other {{ yandex-cloud }} resources consumed while using the service you pay as per their pricing plans.

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ maf-name }} {#rules}

When using {{ maf-name }}, you pay for:

* Computing resources of cluster components.
* Outgoing traffic volume.

Cluster operation cost is charged per minute. The minimum billing unit is one minute, e.g., 1.5 minutes of cluster usage is billed as 2 minutes.

Using {{ objstorage-full-name }} for [storing DAG files](operations/upload-dags.md) is charged according to the [{{ objstorage-name }} pricing policy](../storage/pricing.md).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Example of cluster cost calculation {#example}

Let's calculate the cost of using a cluster with the following properties for 30 days:

* **Web server**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.
* **Scheduler**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.
* **Workers**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.



{% include [usd-airflow](../_pricing_examples/managed-airflow/usd.md) %}


## Prices for the Russia region {#prices}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.apache_airflow }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

