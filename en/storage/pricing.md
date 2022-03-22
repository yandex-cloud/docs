---
editable: false
---

# Pricing for {{ objstorage-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ objstorage-short-name }} {#rules}

The cost of {{ objstorage-name }} usage is based on:
* The amount of storage used by your data.
* The number of operations on your data.
* The amount of outgoing traffic

Users can access:
* Cold storage: A low rate for data storage and a high rate for operations. It's optimal for storing large amounts of data and performing a small number of operations.
* Standard storage: A high rate for data storage and a low rate for operations. It's optimal for storing small amounts of data and performing a large number of operations.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Storage usage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on granulated per-second data. The minimum billable unit is 1 hour of storing 1 MB of data.

### Data operations {#rules-operations}

Data operations are charged according to the following policy:
* The minimum billable unit for PUT and POST operations is 10.
* The minimum billable unit for GET and HEAD operations is 100.
* You aren't charged for deleting data (the DELETE operation).

## Pricing {#prices}


### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and doesn't depend on the number of days in the month.




{% include [usd.md](../_pricing/storage/usd-used_space.md) %}

The daily cost of data storage service is calculated as `Cost_of_1_GB_per_month / number_of_days_in_the_month`. For shorter months, the storage cost per day is higher. For longer months, it's lower.

Example of a proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```

### Data operations {#prices-operations}




{% include [usd.md](../_pricing/storage/usd-operations.md) %}

{% note info %}

Data operations that result in an error are charged only in the following cases:
* Error code 403 for a GET or HEAD operation.
* Error code 404 for a PUT, POST, GET, or HEAD operation.

Prices for standard storage are applied when calculating costs.

{% endnote %}

### Outgoing traffic {#prices-traffic}

When using the service, you pay for traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free.

The minimum billable unit is 1 MB. The billing period is a calendar month.




{% include [usd.md](../_pricing/storage/usd-egress.md) %}

The first 10 GB of outgoing traffic for {{ objstorage-name }} is accounted for independently of other services each month.