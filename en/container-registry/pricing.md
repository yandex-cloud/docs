---
editable: false
---
# Pricing policy for {{ container-registry-name }}

{% note alert %}

During the Preview stage, the service can be used free of charge. The following pricing policy will be starting July 9, 2019, when the service becomes [general availability](../overview/concepts/launch-stages.md).

{% endnote %}


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ container-registry-short-name }} {#rules}

The cost of {{ container-registry-name }} usage is based on:

- The amount of storage used by your data.
- The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on per-second data. The minimum pricing unit is 1 hour of storing 1 MB of data.

## Prices {#prices}

### Data storage {#prices-storage}

Prices are specified for a 30-day month. For shorter months, the price is higher. For longer months, it is lower.

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

