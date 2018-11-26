# Pricing policy for Yandex [!KEYREF objstorage-name]

> [!NOTE]

> Starting from December 1, 2018, the pricing policy for operations on your data will change. Charges are being added for POST operations and data operations that resulted in an error.
> 
> For more information, see [the description of the new rates](#new).

## What goes into the cost of [!KEYREF objstorage-short-name] use {#rules}

The cost of [!KEYREF objstorage-name] usage is based on:

- The amount of storage used by your data.
- The number of operations on your data.
- The amount of outgoing traffic.

Users can access:

- Cold storage: a low rate for data storage and a high rate for operations. It is optimal for storing a large volume of data with a small number of operations on it.
- Standard storage: a high rate for data storage and a low rate for operations. It is optimal for storing a small amount of data with a large number of operations on it.

[!INCLUDE [pricing-intro](../_includes/pricing-intro.md)]

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Data storage use {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on per-second data. The minimum pricing unit is 1 hour of storing 1 MB of data.

### Performing operations on data {#rules-operations}

Operations on data are rated according to the rules:

  - The minimum pricing unit for PUT operations is 10.
  - The minimum pricing unit for GET and HEAD operations is 100.
  - You are not charged for deleting data (the DELETE operation).

## Prices until December 1, 2018 {#old}

### Data storage {#prices-storage-old}

Prices are specified for a 30-day month. For shorter months, the price is higher. For longer months, it is lower.

| Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, with VAT |
| ----- | ----- | ----- |
| Standard storage | 1.05 ₽ | 1.24 ₽ |
| Cold storage | 0.56 ₽ | 0.66 ₽ |

Here is an example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a month that is 30 days long. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 11.5 / 24 / 30
```

### Operations on data {#prices-operations-old}

| Service | Cost, rubles without VAT | Cost, rubles with VAT |
| ----- | ----- | ----- |
| **Standard storage** |  |
| 1,000 PUT operations | 0.25 ₽ | 0.30 ₽ |
| 10,000 GET or HEAD operations | 0.20 ₽ | 0.24 ₽ |
| **Cold storage** |  |
| 1,000 PUT operations | 0.62 ₽ | 0.73 ₽ |
| 10,000 GET or HEAD operations | 0.50 ₽ | 0.60 ₽ |

### Outgoing traffic {#prices-traffic-old}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing-egress-traffic.md)]

## Prices as of December 1, 2018 {#new}

### Data storage {#prices-storage-old}

Prices are specified for a 30-day month. For shorter months, the price is higher. For longer months, it is lower.

| Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, with VAT |
| ----- | ----- | ----- |
| Standard storage | 1.05 ₽ | 1.24 ₽ |
| Cold storage | 0.56 ₽ | 0.66 ₽ |

Here is an example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a month that is 30 days long. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 11.5 / 24 / 30
```

### Operations on data {#prices-operations-old}

| Service | Cost, rubles without VAT | Cost, rubles with VAT |
| ----- | ----- | ----- |
| **Standard storage** |  |
| 1,000 PUT or POST operations | 0.25 ₽ | 0.30 ₽ |
| 10,000 GET or HEAD operations | 0.20 ₽ | 0.24 ₽ |
| **Cold storage** |  |
| 1,000 PUT or POST operations | 0.62 ₽ | 0.73 ₽ |
| 10,000 GET or HEAD operations | 0.50 ₽ | 0.60 ₽ |

> [!NOTE]
> 
> Operations with data that resulted in an error are charged only in the following cases:
> 
> * Error code 403 for a GET or HEAD operation.
> * Error code 404 for a PUT, POST, GET, or HEAD operation.
> 
> Prices for standard storage are applied when calculating costs.

[!INCLUDE [pricing-egress-traffic](../_includes/pricing-egress-traffic.md)]

