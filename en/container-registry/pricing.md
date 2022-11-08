---
editable: false
---

# Pricing for {{ container-registry-name }}



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## What goes into the cost of using {{ container-registry-name }} {#rules}

The cost of {{ container-registry-name }} usage is based on:
* The amount of storage used by your data.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on granulated per-second data. The minimum billable unit is 1 hour of storing 1 MB of data.

{% note warning %}

If multiple Docker images in the same registry use the same layers, you aren't charged repeatedly for storing each reused layer. A layer's [digest](concepts/docker-image.md#version) indicates whether the layer is unique.

{% endnote %}

## Pricing {#prices}

### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and doesn't depend on the number of days in the month. The storage cost per day is higher for shorter months and lower for longer months.





{% include [usd.md](../_pricing/cr/usd.md) %}




Example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```





{% include [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



