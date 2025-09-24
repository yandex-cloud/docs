---
title: '{{ metadata-hub-full-name }} pricing policy'
description: This article covers the {{ metadata-hub-name }} pricing policy.
editable: false
---

# {{ metadata-hub-full-name }} pricing policy

{% note info %}

Starting September 22, 2025, {{ metastore-full-name }} cluster usage will be charged according to the [below pricing policy](#metastore).

{% endnote %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ metadata-hub-full-name }} is free of charge.

Other {{ yandex-cloud }} resources you may employ while using {{ metadata-hub-full-name }} (such as managed database services or [{{ lockbox-name }}](../lockbox/pricing.md)) are charged based on their [pricing plans]({{ link-cloud-calculator }}).

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## {{ metastore-full-name }} cluster billing {#metastore}

{% note info %}

This pricing policy will apply starting September 22, 2025.

{% endnote %}

When using {{ metastore-full-name }}, you pay for the computing resources of your cluster. Cluster operation cost is charged per hour. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 1.5 hours.

A `Stopped` cluster is not charged.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Prices for the Russia region {#metastore-prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}




{% include [usd-prices](../_pricing/metastore/usd.md) %}

