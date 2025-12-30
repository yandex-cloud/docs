---
title: '{{ container-registry-full-name }} pricing policy'
description: This article covers the {{ container-registry-name }} pricing policy.
editable: false
---

# {{ container-registry-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ container-registry-name }} {#rules}

The {{ container-registry-name }} usage cost includes:
* Amount of storage used by your data.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using the storage {#rules-storage}

Storage usage is measured in GB per month. The amount of data stored for a month is calculated as the average value based on granular per-second data. The minimum billing unit is 1 hour of storing 1 MB of data.

{% note warning %}

If multiple [Docker images](concepts/docker-image.md) in the same registry use the same layers, you are not charged repeatedly for storing each re-used layer. Whether the layer is unique is determined by its [hash](concepts/docker-image.md#version).

{% endnote %}


## Prices for the Russia region {#prices}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|cr }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


Here is an example of proportional calculation. Let's assume a user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using this formula:

```text
Storage_cost = Price_per_GB_per_month * 15 * 12 / 24 / 30
```


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
