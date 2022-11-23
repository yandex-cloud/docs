---
editable: false
---

# Pricing for {{ container-registry-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect on December 6, 2022. Until then, {{ container-registry-name }} can be used free of charge.

{% endnote %}

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

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

## Pricing{% if product == "cloud-il" %} starting December 6, 2022{% endif %} {#prices}

### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and doesn't depend on the number of days in the month. The storage cost per day is higher for shorter months and lower for longer months.

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub.md](../_pricing/cr/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/cr/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/cr/usd.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/cr/ils.md) %}

{% endif %}

Example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}