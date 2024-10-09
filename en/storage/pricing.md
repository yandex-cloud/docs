---
editable: false
---

# {{ objstorage-name }} pricing policy

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ objstorage-short-name }} {#rules}

The {{ objstorage-name }} usage cost is based on:

* [Storage class](concepts/storage-class.md).
* Amount of storage used by your data.
* Number of operations with your data.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

{% include [not-charged-storage.md](../_includes/pricing/price-formula/not-charged-storage.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Using storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is taken as the month's average based on granulated per-second data. The minimum billing unit is **1 hour of storing 1 MB of data**.

### Performing operations with data {#rules-operations}

Data operations are billed according to the following policy:
* The minimum billing unit for PUT, POST, PATCH, LIST, and TRANSITION operations is 10.
* The minimum billing unit for GET, HEAD, and OPTIONS operations is 100.
* You are not charged for deleting data (DELETE operation).


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Data storage {#prices-storage}

The cost of 1 GB per month is fixed and does not depend on the number of days in the month.




{% include [usd.md](../_pricing/storage/usd-used_space.md) %}


^1^ The daily cost of data storage service is calculated as `Cost_of_1_GB_per_month / number_of_days_in_the_month`. For shorter months, the storage cost per day is higher. For longer months, it is lower.

Here is an example of proportional calculation. Let's assume a user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```text
Storage_price = Price_per_GB_per_month × 15 × 12 / 24 / 30
```

^2^ The first 1 GB of data stored in regular storage per month is free of charge.






{% include [usd-used-space-standard](../_pricing_examples/storage/usd-used-space-standard.md) %}


^3^ The minimum billable storage time of an object in ice storage is 12 months. If you delete an object that was stored for less than 12 months, you will be charged the remaining cost after deletion.






{% include [usd-used-space-ice](../_pricing_examples/storage/usd-used-space-ice.md) %}


### Data operations {#prices-operations}




{% include [usd.md](../_pricing/storage/usd-operations.md) %}


{% note info %}

You are going to be charged for the GET, HEAD, OPTIONS, PATCH, POST, and PUT operations ending with Error 403 or 404. The cost is calculated based on standard storage rates.

{% endnote %}

The first 10,000 PUT, POST, PATCH, and LIST operations and the first 100,000 GET, HEAD, and OPTIONS operations in standard storage per month are free of charge.






{% include [usd-operations](../_pricing_examples/storage/usd-operations.md) %}


### Egress traffic {#prices-traffic}

When using the service, you pay for traffic from {{ yandex-cloud }} to the internet. Traffic between {{ yandex-cloud }} services and incoming internet traffic are free.

The minimum billing unit is 1 MB. The billing period is a calendar month.




{% include [usd.md](../_pricing/storage/usd-egress.md) %}


The first 100 GB of outgoing traffic per month for {{ objstorage-name }} are free of charge.






  {% include [usd-egress](../_pricing_examples/storage/usd-egress.md) %}
