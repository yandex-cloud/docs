---
title: '{{ metadata-hub-full-name }} pricing policy'
description: This article covers the {{ metadata-hub-name }} pricing policy.
editable: false
---

# {{ metadata-hub-full-name }} pricing policy

{{ connection-manager-name }}, {{ schema-registry-name }}, and {{ data-catalog-name }} are free of charge. For other {{ yandex-cloud }} resources consumed while using these services (such as managed database services or [{{ lockbox-name }}](../lockbox/pricing.md)) you pay as per their [pricing plans]({{ link-cloud-calculator }}).

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## {{ metastore-full-name }} cluster billing {#metastore}

{% note info %}

These prices apply starting September 22, 2025.

{% endnote %}

When using {{ metastore-full-name }}, you pay for the computing resources of your cluster. Cluster operation cost is charged per hour. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 90 minutes (1.5 hours).

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
