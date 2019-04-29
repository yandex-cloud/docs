---
editable: false
---
# Pricing policy for [!KEYREF objstorage-name]

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

## What goes into the cost of using [!KEYREF objstorage-short-name] {#rules}

The cost of [!KEYREF objstorage-name] usage is based on:

- The amount of storage used by your data.
- The number of operations on your data.
- The amount of outgoing traffic.

Users can access:

- Cold storage: a low rate for data storage and a high rate for operations. It is optimal for storing a large volume of data with a small number of operations on it.
- Standard storage: a high rate for data storage and a low rate for operations. It is optimal for storing a small amount of data with a large number of operations on it.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]

### Using storage {#rules-storage}

Storage usage is measured in GB per month. The volume of data stored during a month is the average value over the month based on per-second data. The minimum pricing unit is 1 hour of storing 1 MB of data.

### Performing operations on data {#rules-operations}

Operations on data are rated according to the rules:

  - The minimum pricing unit for PUT operations is 10.
  - The minimum pricing unit for GET and HEAD operations is 100.
  - You are not charged for deleting data (the DELETE operation).

## Prices {#prices}

### Data storage {#prices-storage}

Prices are specified for a 30-day month. For shorter months, the price is higher. For longer months, it is lower.

---

**[!TAB Prices in USD]**

| Service | Rate for 1 GB per month, without VAT
| ----- | ----- 
| Standard storage | $0.016166 |
| Cold storage |  $0.008605 |

**[!TAB Prices in roubles]**

| Service | Rate for 1 GB per month, with VAT |
| ----- | ----- 
| Standard storage | ₽1.2610 |
| Cold storage |  ₽0.6712 |

---

Here is an example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a month that is 30 days long. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 11.5 / 24 / 30
```

### Operations with data {#prices-operations}


---

**[!TAB Prices in USD]**

| Service | Cost, without VAT
| ----- | ----- | 
| **Standard storage** | 
| 1,000 PUT or POST operations | $0.003911 |
| 10,000 GET or HEAD operations | $0.003129 |
| **Cold storage** | 
| 1,000 PUT or POST operations | $0.009517 |
| 10,000 GET or HEAD operations | $0.007823 |

**[!TAB Prices in roubles]**

| Service | Cost, with VAT |
| ----- | ----- 
| **Standard storage** | 
| 1,000 PUT or POST operations | ₽0.3051 |
| 10,000 GET or HEAD operations | ₽0.2441 |
| **Cold storage** | 
| 1,000 PUT or POST operations | ₽0.7424 |
| 10,000 GET or HEAD operations | ₽0.6102 |

---

> [!NOTE]
>
> Operations with data that resulted in an error are charged only in the following cases:
>
> * Error code 403 for a GET or HEAD operation.
> * Error code 404 for a PUT, POST, GET, or HEAD operation.

Prices for standard storage are applied when calculating costs.

[!INCLUDE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]

