---
editable: false
---
# Pricing for {{ objstorage-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ objstorage-short-name }} {#rules}

The cost of {{ objstorage-name }} usage is based on:

- The amount of storage used by your data.
- The number of operations on your data.
- The amount of outgoing traffic

Users can access:

- Cold storage: A low rate for data storage and a high rate for operations. It's optimal for storing large amounts of data and performing a small number of operations.
- Standard storage: A high rate for data storage and a low rate for operations. It's optimal for storing small amounts of data and performing a large number of operations.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Storage usage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on granulated per-second data. The minimum billable unit is 1 hour of storing 1 MB of data.

### Data operations {#rules-operations}

Data operations are charged according to the following policy:

  - The minimum billable unit for PUT and POST operations is 10.
  - The minimum billable unit for GET and HEAD operations is 100.
  - You aren't charged for deleting data (the DELETE operation).

## Pricing {#prices}

### Data storage {#prices-storage}

Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

| Service | Cost of 1 GB per month, with VAT |
| ----- | ----- |
| The first 1 GB in standart storage per month | Not charged |
| Standard storage | 1.2610 ₽ |
| Cold storage | 0.6712 ₽ |

Example of a proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a 30-day month. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```

### Data operations {#prices-operations}

| Service | Cost, rubles with VAT |
| ----- | ----- |
| **Standard storage** |
| The first 10 000 PUT or POST operations per month | Not charged |
| The first 100 000 GET or HEAD operations per month | Not charged |
| 1000 PUT or POST operations | 0.3051 ₽ |
| 10,000 GET or HEAD operations | 0.2441 ₽ |
| **Cold storage** |
| 1000 PUT or POST operations | 0.7424 ₽ |
| 10,000 GET or HEAD operations | 0.6102 ₽ |

{% note info %}

Data operations that result in an error are charged only in the following cases:

* Error code 403 for a GET or HEAD operation.
* Error code 404 for a PUT, POST, GET, or HEAD operation.

Prices for standard storage are applied when calculating costs.

{% endnote %}

### Outgoing traffic {#prices-traffic}

When using the service, you pay for traffic from the Cloud to the internet. Traffic between Yandex.Cloud services and incoming internet traffic are free.

The minimum billable unit is 1 MB.

| Resource category | Cost of 1 GB with VAT |
| ----- | ----- |
| Outgoing traffic, up to 10 GB per month | Free |
| Outgoing traffic over 10 GB and up to 1 TB | 0.96 ₽ |
| Outgoing traffic over 1 TB and up to 50 TB | 0.80 ₽ |
| Outgoing traffic over 50 TB and up to 100 TB | 0.75 ₽ |
| Outgoing traffic over 100 TB | 0.72 ₽ |

The first 10 GB of outgoing traffic for {{ objstorage-name }} are accounted for independently of other services.

