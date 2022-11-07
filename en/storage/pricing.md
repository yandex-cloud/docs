---
editable: false
---

# Pricing for {{ objstorage-name }}


{% include [use-calculator](../_includes/pricing/use-calculator.md) %}


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


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

## Pricing  {#prices}

### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and doesn't depend on the number of days in the month.





{% include [usd.md](../_pricing/storage/usd-used_space.md) %}




The daily cost of data storage service is calculated as `Cost_of_1_GB_per_month / number_of_days_in_the_month`. For shorter months, the storage cost per day is higher. For longer months, it's lower.

Example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```

The first 1 GB of data stored in standard storage per month is free of charge.





> For example, if the monthly cost of storing 1 GB of data in standard storage is $0.016167 and the amount of data stored per month is 23 GB, the storage cost per month will be:
> (23 - 1) × $0.016167 = 22 × $0.016167 = $0.355674.



{% include [ice-minimum-duration](../_includes/storage/ice-minimum-duration.md) %}





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



### Data operations {#prices-operations}





{% include [usd.md](../_pricing/storage/usd-operations.md) %}




{% note info %}

Data operations that result in an error are charged only in the following cases:
* Error code 403 for a GET or HEAD operation.
* Error code 404 for a PUT, POST, GET, or HEAD operation.

Prices for standard storage are applied when calculating costs.

{% endnote %}

Each month, the first 10000 PUT and POST operations and the first 100000 GET and HEAD operations in standard storage are free of charge.





> For example, if the monthly cost of 10,000 GET operations in standard storage is $0.003129 and the amount of GET operations per month is 24,500, the total monthly cost of data operations will be:
> ((24500 - 10,000) / 10000) × $0.003129 = (14500 / 10000) × $0.003129 = $0.00453705.



### Egress traffic {#prices-traffic}

When using the service, you pay for traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free.

The minimum billable unit is 1 MB. The billing period is a calendar month.





{% include [usd.md](../_pricing/storage/usd-egress.md) %}




The first 10 GB of outgoing traffic per month for {{ objstorage-name }} is free of charge.





> For example, if the cost of 1 GB of outgoing traffic over 10 GB and up to 1 TB per month is $0.016167 and you had 283 GB of outgoing traffic for the month, the cost for the month will be:
> (283 - 10) × $0.016167 = 273 × $0.016167 = $4.413591.


