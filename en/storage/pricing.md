---
editable: false
---

# Pricing for {{ objstorage-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect on December 6, 2022. Until then, {{ objstorage-name }} can be used free of charge.

{% endnote %}

{% endif %}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

## What goes into the cost of using {{ objstorage-short-name }} {#rules}

The cost of {{ objstorage-name }} usage is based on:

* [Storage class](concepts/storage-class.md).
* The amount of storage used by your data.
* The number of operations on your data.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

{% include [not-charged-storage.md](../_includes/pricing/price-formula/not-charged-storage.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Using storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on granulated per-second data. The minimum billable unit is 1 hour of storing 1 MB of data.

{% include [ice-minimum-duration](../_includes/storage/ice-minimum-duration.md) %}

### Performing operations with data {#rules-operations}


Data operations are charged according to the following policy:
* The minimum pricing unit for PUT and POST operations is 10.
* The minimum billable unit for GET and HEAD operations is 100.
* You aren't charged for deleting data (the DELETE operation).

## Pricing {% if product == "cloud-il" %}starting December 6, 2022{% endif %} {#prices}

### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and doesn't depend on the number of days in the month.

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub.md](../_pricing/storage/rub-used_space.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/storage/kzt-used_space.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/storage/usd-used_space.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/storage/ils-used_space.md) %}

{% endif %}

The daily cost of data storage service is calculated as `Cost_of_1_GB_per_month / number_of_days_in_the_month`. For shorter months, the storage cost per day is higher. For longer months, it's lower.

Example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month × 15 × 12 / 24 / 30
```

The first 1 GB of data stored in standard storage per month is free of charge.

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

> For example, if the monthly cost of storing 1 GB of data in standard storage is ₽2.01 and the amount of data stored per month is 23 GB, the storage cost per month will be:
> (23 - 1) × ₽2.01 = 22 × ₽2.01 = ₽44.22

{% endif %}

{% if region == "kz" %}

> For example, if the monthly cost of storing 1 GB of data in standard storage is ₸10.05 and the amount of data stored per month is 23 GB, the storage cost per month will be:
> (23 - 1) × ₸10.05 = 22 × ₸10.05 = ₸221.1

{% endif %}

{% if region == "int" %}

> For example, if the monthly cost of storing 1 GB of data in standard storage is $0.016167 and the amount of data stored per month is 23 GB, the storage cost per month will be:
> (23 - 1) × $0.016167 = 22 × $0.016167 = $0.355674

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

> For example, if the monthly cost of storing 1 GB of data in standard storage is ₪0.0661 and the amount of data stored per month is 23 GB, the storage cost per month will be:
> (23 - 1) × ₪0.0661 = 22 × ₪0.0661 = ₪1.4542

{% endif %}

{% include [ice-minimum-duration](../_includes/storage/ice-minimum-duration.md) %}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

> For example, if the monthly cost of storing 1 GB of data in ice storage is ₽0.54 and a 3 GB object was stored from January 1 to September 20 (8 months and 20 days), its storage is charged as follows:
>
> Total from January 1 to September 20
>
> : _A_ = 3 × (8 + (20 / 30)) × ₽0.54 = (3 × 260 / 30) × ₽0.54 = ₽14.04
>
> September 20 after deleting the object
>
> : _B_ = (3 × 12 × ₽0.54) - _A_ = ₽19.44 - ₽14.04 = ₽5.40
>
> Total
>
> : _A_ + _B_ = ₽19.44

{% endif %}

{% if region == "kz" %}

> For example, if the monthly cost of storing 1 GB of data in ice storage is ₸2.68 and a 3 GB object was stored from January 1 to September 20 (8 months and 20 days), its storage is charged as follows:
>
> Total from January 1 to September 20
>
> : _A_ = 3 × (8 + (20 / 30)) × ₸2.68 = (3 × 260 / 30) × ₸2.68 = ₸69.68
>
> September 20 after deleting the object
>
> : _B_ = (3 × 12 × ₸2.68) - _A_ = ₸96.48 - ₸69.68 = ₸26.80
>
> Total
>
> : _A_ + _B_ = ₸96.48

{% endif %}

{% if region == "int" %}

> For example, if the monthly cost of storing 1 GB of data in ice storage is $0.004280 and a 3 GB object was stored from January 1 to September 20 (8 months and 20 days), its storage is charged as follows:
>
> Total from January 1 to September 20
>
> : _A_ = 3 × (8 + (20 / 30)) × $0.004280 = (3 × 260 / 30) × $0.004280 = $0.111280
>
> September 20 after deleting the object
>
> : _B_ = (3 × 12 × $0.004280) - _A_ = $0.154080 - $0.111280 = $0.042800
>
> Total
>
> : _A_ + _B_ = $0.154080

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

> For example, if the monthly cost of storing 1 GB of data in ice storage is ₪0.0173 and a 3 GB object was stored from January 1 to September 20 (8 months and 20 days), its storage is charged as follows:
>
> Total from January 1 to September 20
>
> : _A_ = 3 × (8 + (20 / 30)) × ₪0.0173 = (3 × 260 / 30) × ₪0.0173 = ₪0.4498
>
> September 20 after deleting the object
>
> : _B_ = (3 × 12 × ₪0.0173) - _A_ = ₪0.6228 - ₪0.4498 = ₪0.1730
>
> Total
>
> : _A_ + _B_ = ₪0.6228

{% endif %}

### Data operations {#prices-operations}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub.md](../_pricing/storage/rub-operations.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/storage/kzt-operations.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/storage/usd-operations.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/storage/ils-operations.md) %}

{% endif %}

{% note info %}

Data operations that result in an error are charged only in the following cases:
* Error code 403 for a GET or HEAD operation.
* Error code 404 for a PUT, POST, GET, or HEAD operation.

Prices for standard storage are applied when calculating costs.

{% endnote %}

Each month, the first 10000 PUT and POST operations and the first 100000 GET and HEAD operations in standard storage are free of charge.

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

> For example, if the monthly cost of 10000 GET operations in standard storage is ₽0.39 and the amount of GET operations per month is 24500, the total monthly cost of data operations will be:
> ((24500 - 10000) / 10000) × ₽0.39 = (14500 / 10000) × ₽0.39 = ₽0.5655

{% endif %}

{% if region == "kz" %}

> For example, if the monthly cost of 10000 GET operations in standard storage is ₸1.95 and the amount of GET operations per month is 24500, the total monthly cost of data operations will be:
> ((24500 - 10000) / 10000) × ₸1.95 = (14500 / 10000) × ₸1.95 = ₸2.8275

{% endif %}

{% if region == "int" %}

> For example, if the monthly cost of 10000 GET operations in standard storage is $0.003129 and the amount of GET operations per month is 24500, the total monthly cost of data operations will be:
> ((24500 - 10000) / 10000) × $0.003129 = (14500 / 10000) × $0.003129 = $0.00453705

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

> For example, if the monthly cost of 10000 GET operations in standard storage is ₪0.0198 and the amount of GET operations per month is 24500, the total monthly cost of data operations will be:
> ((24500 - 10000) / 10000) × ₪0.0198 = (14500 / 10000) × ₪0.0198 = ₪0.02871

{% endif %}

### Egress traffic {#prices-traffic}

When using the service, you pay for traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free.

The minimum billable unit is 1 MB. The billing period is a calendar month.

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub.md](../_pricing/storage/rub-egress.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/storage/kzt-egress.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/storage/usd-egress.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/storage/ils-egress.md) %}

{% endif %}

The first 10 GB of outgoing traffic per month for {{ objstorage-name }} is free of charge.

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

> For example, if the cost of 1 GB of outgoing traffic over 10 GB and up to 1 TB per month is ₽1.53 and you had 283 GB of outgoing traffic for the month, the cost for the month will be:
> (283 - 10) × ₽1.53 = 273 × ₽1.53 = ₽417.69

{% endif %}

{% if region == "kz" %}

> For example, if the cost of 1 GB of outgoing traffic over 10 GB and up to 1 TB per month is ₸7.65 and you had 283 GB of outgoing traffic for the month, the cost for the month will be:
> (283 - 10) × ₸7.65 = 273 × ₸7.65 = ₸2088.45

{% endif %}

{% if region == "int" %}

> For example, if the cost of 1 GB of outgoing traffic over 10 GB and up to 1 TB per month is $0.016167 and you had 283 GB of outgoing traffic for the month, the cost for the month will be:
> (283 - 10) × $0.016167 = 273 × $0.016167 = $4.413591

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

> For example, if the cost of 1 GB of outgoing traffic over 10 GB and up to 1 TB per month is ₪0.1843 and you had 283 GB of outgoing traffic for the month, the cost for the month will be:
> (283 - 10) × ₪0.1843 = 273 × ₪0.1843 = ₪50.3139

{% endif %}
