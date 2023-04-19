---
editable: false
---

# Pricing for {{ container-registry-name }}


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## What goes into the cost of using {{ container-registry-name }} {#rules}

The {{ container-registry-name }} usage cost is based on:
* The amount of storage used by your data.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on granulated per-second data. The minimum billable unit is 1 hour of storing 1 MB of data.

{% note warning %}

If multiple [Docker images](concepts/docker-image.md) in the same registry use the same layers, you are not charged repeatedly for storing each reused layer. A layer's [digest](concepts/docker-image.md#version) indicates whether the layer is unique.

{% endnote %}

## Pricing {#prices}

### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and doesn't depend on the number of days in the month. The storage cost per day is higher for shorter months and lower for longer months.





{% include [usd.md](../_pricing/container-registry/usd.md) %}




Example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```


### Vulnerability scanner {#scanner}

{% note alert %}

Using the vulnerability scanner will stop being free of charge starting **April 24, 2023**.

{% endnote %}

The cost of using the [vulnerability scanner](concepts/vulnerability-scanner.md) for Docker images depends on how many scans you run.

First-time scan of the first six different Docker images per month is free of charge. Further six scans of any Docker images per month are free of charge.





{% include [usd-scanner.md](../_pricing/container-registry/usd-scanner.md) %}








{% include [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



