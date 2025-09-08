---
title: '{{ cloud-registry-full-name }} pricing policy'
description: This article covers the {{ cloud-registry-name }} pricing policy.
editable: false
---

# {{ cloud-registry-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ cloud-registry-name }} {#rules}

The {{ cloud-registry-name }} usage cost includes:
* Amount of storage used by your data.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хранилища {#rules-storage}

Storage usage is measured in GB per hour. The volume of data stored for a month is calculated as the average value based on granulated per-second data. The minimum billing unit is 1 hour of storing 1 MB of data.

{% note warning %}

If multiple [Docker images](concepts/docker-image.md) in the same registry use the same layers, you are not charged repeatedly for storing each reused layer. A layer's [digest](concepts/docker-image.md#version) indicates whether the layer is unique.

{% endnote %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% note warning %}

These prices apply starting September 15, 2025.

{% endnote %}

### Data storage {#prices-storage}



{% include [usd.md](../_pricing/cloud-registry/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

