# Yandex [!KEYREF objstorage-name] pricing

In the [!KEYREF objstorage-name] service, you pay for:

- The amount of storage used by your data.
- The number of operations on your data.
- The amount of outgoing traffic.

Users can access:

- Cold storage: a low rate for data storage and a high rate for operations. It is optimal for storing a large volume of data with a small number of operations on it.
- Standard storage: a high rate for data storage and a low rate for operations. It is optimal for storing a small amount of data with a large number of operations on it.

[!INCLUDE [pricing-intro](../_includes/pricing-intro.md)]

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

## Data storage {#charge-for-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on per-second data. The minimum pricing unit is 1 hour of storing 1 MB of data.

Prices are specified for a 30-day month. For shorter months, the price is higher. For longer months, it is lower.

| Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, with VAT |
| ----- | ----- | ----- |
| Standard storage | 1.05 ₽ | 1.24 ₽ |
| Cold storage | 0.56 ₽ | 0.66 ₽ |

Here is an example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a month that is 30 days long. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 11.5 / 24 / 30
```

## Operations on data {#charge-for-operations}

Operations are charged as follows:

  - The minimum pricing unit for PUT operations is 10.
  - The minimum pricing unit for GET and HEAD operations is 100.
  - You are not charged for deleting data (the DELETE operation).

| Service | Cost, rubles without VAT | Cost, rubles with VAT |
| ----- | ----- | ----- |
| **Standard storage** |  |
| 1,000 PUT operations | 0.25 ₽ | 0.30 ₽ |
| 10,000 GET or HEAD operations | 0.20 ₽ | 0.24 ₽ |
| **Cold storage** |  |
| 1,000 PUT operations | 0.62 ₽ | 0.73 ₽ |
| 10,000 GET or HEAD operations | 0.50 ₽ | 0.60 ₽ |

[!INCLUDE [pricing-egress-traffic](../_includes/pricing-egress-traffic.md)]

