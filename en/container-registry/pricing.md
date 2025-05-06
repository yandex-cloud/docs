---
title: '{{ container-registry-full-name }} pricing policy'
description: This article covers the {{ container-registry-name }} pricing policy.
editable: false
---

# {{ container-registry-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ container-registry-name }} {#rules}

The {{ container-registry-name }} usage cost includes:
* Amount of storage used by your data.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using the storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored for a month is calculated as the average value based on granulated per-second data. The minimum billing unit is 1 hour of storing 1 MB of data.

{% note warning %}

If multiple [Docker images](concepts/docker-image.md) in the same registry use the same layers, you are not charged repeatedly for storing each reused layer. A layer's [digest](concepts/docker-image.md#version) indicates whether the layer is unique.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and does not depend on the number of days in the month. The storage cost per day is higher for shorter months and lower for longer months.




{% include [usd.md](../_pricing/container-registry/usd.md) %}


Here is an example of proportional calculation. Let's assume a user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```text
Storage_cost = Price_per_GB_per_month * 15 * 12 / 24 / 30
```


### Vulnerability scanner {#scanner}

The cost of using the [vulnerability scanner](concepts/vulnerability-scanner.md) for Docker images depends on how many scans you run:

First-time scan of the first six different Docker images per month is free of charge. Further six scans of any Docker images per month are free of charge.



{% include [usd-scanner.md](../_pricing/container-registry/usd-scanner.md) %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}