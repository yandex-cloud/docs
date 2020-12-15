---
editable: false
---
# Pricing policy for {{ container-registry-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ container-registry-short-name }} {#rules}

The cost of {{ container-registry-name }} usage is based on:

- The amount of storage used by your data.
- The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on per-second data. The minimum pricing unit is 1 hour of storing 1 MB of data.

{% note warning %}

If multiple Docker images in the same registry use the same layers, reused layers aren't subject to repeat billing for storage. The uniqueness of a layer is determined by its [digest](concepts/docker-image.md#version).

{% endnote %}

## Prices {#prices}

### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and doesn't depend on the number of days in the month. The storage cost per day is higher for shorter months and lower for longer months.

{% list tabs %}

- Prices in USD
  
  | Service | Rate for 1 GB per month, without VAT
  | ----- | ----- 
  | Storage | $0.024256 |  
  
- Prices in roubles
  
  | Service | Rate for 1 GB per month, with VAT |
  | ----- | ----- 
  | Storage | ₽1.8920 |
  
{% endlist %}

Here is an example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a month that is 30 days long. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```

{% include [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}