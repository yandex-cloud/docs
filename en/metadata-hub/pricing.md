---
title: '{{ metadata-hub-full-name }} pricing policy'
description: This article covers the {{ metadata-hub-name }} pricing policy.
editable: false
---

# {{ metadata-hub-full-name }} pricing policy

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
        url: https://yandex.cloud/en/prices?state=ac5d0e6cef3b#calculator
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
        url: https://yandex.cloud/en/price-list?services=dn2rnt6lkfbauucwnfby
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


{{ connection-manager-name }}, {{ schema-registry-name }}, and {{ data-catalog-name }} are free of charge. For other {{ yandex-cloud }} resources consumed while using these services (such as managed database services or [{{ lockbox-name }}](../lockbox/pricing.md)) you pay as per their [pricing plans]({{ link-cloud-calculator }}).

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## {{ metastore-full-name }} cluster billing {#metastore}

{% note info %}

These prices apply starting September 22, 2025.

{% endnote %}

When using {{ metastore-full-name }}, you pay for the computing resources of your cluster. Cluster operation cost is charged per minute. The minimum billing unit is one minute, e.g., 1.5 minutes of cluster usage is billed as 2 minutes.

A `Stopped` cluster is not charged.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Prices for the Russia region {#metastore-prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|metadatahub }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% include [metastore-trademark](../_includes/metadata-hub/metastore-trademark.md) %}
