---
editable: false
---
# Pricing policy for {{ objstorage-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ objstorage-short-name }} {#rules}

The cost of {{ objstorage-name }} usage is based on:

- The amount of storage used by your data.
- The number of operations on your data.
- The amount of outgoing traffic.

Users can access:

- Cold storage: a low rate for data storage and a high rate for operations. It is optimal for storing a large volume of data with a small number of operations on it.
- Standard storage: a high rate for data storage and a low rate for operations. It is optimal for storing a small amount of data with a large number of operations on it.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

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

{% list tabs %}

- Prices in USD

  | Service | Rate for 1 GB per month, without VAT
  | ----- | -----
  | Standard storage | $0.016166 |
  | Cold storage |  $0.008605 |

- Prices in roubles

  | Service | Rate for 1 GB per month, with VAT |
  | ----- | -----
  | Standard storage | ₽1.2610 |
  | Cold storage |  ₽0.6712 |

{% endlist %}

Here is an example of proportional calculation: let's say the user stores 15 GB of data for 11.5 hours during a month that is 30 days long. The total cost of storage can be calculated using the formula:

```
Storage_cost = Cost_per_GB_per_month * 15 * 12 / 24 / 30
```

### Operations with data {#prices-operations}


{% list tabs %}

- Prices in USD

  | Service | Cost, without VAT
  | ----- | ----- |
  | **Standard storage** |
  | 1,000 PUT or POST operations | $0.003911 |
  | 10,000 GET or HEAD operations | $0.003129 |
  | **Cold storage** |
  | 1,000 PUT or POST operations | $0.009517 |
  | 10,000 GET or HEAD operations | $0.007823 |

- Prices in roubles

  | Service | Cost, with VAT |
  | ----- | -----
  | **Standard storage** |
  | 1,000 PUT or POST operations | ₽0.3051 |
  | 10,000 GET or HEAD operations | ₽0.2441 |
  | **Cold storage** |
  | 1,000 PUT or POST operations | ₽0.7424 |
  | 10,000 GET or HEAD operations | ₽0.6102 |

{% endlist %}

{% note info %}

Operations with data that resulted in an error are charged only in the following cases:

* Error code 403 for a GET or HEAD operation.
* Error code 404 for a PUT, POST, GET, or HEAD operation.

{% endnote %}

Prices for standard storage are applied when calculating costs.

### Outgoing traffic {#prices-traffic}

When using the service, you pay for the traffic from the Cloud to the internet. The traffic between Cloud services and the incoming traffic from the internet are free of charge.

The minimum charging unit is 1 MB.

{% list tabs %}

- Prices in USD
  | Resource category | Cost of 1 GB, without VAT |
  | ----- | -----
  | Outgoing traffic, under 10 GB | $0 |
  | Outgoing traffic, from 10 GB to 1 TB | $0.012307 |
  | Outgoing traffic, from 1 TB to 50 TB | $0.010256 |
  | Outgoing traffic, from 50 TB to 100 TB | $0.009615 |
  | Outgoing traffic, over 100 TB | $0.009230 |
  
- Prices in roubles
  | Resource category | Cost of 1 GB, with VAT |
  | ----- | -----
  | Outgoing traffic, under 10 GB | ₽0 |
  | Outgoing traffic, from 10 GB to 1 TB | ₽0.96 |
  | Outgoing traffic, from 1 TB to 50 TB | ₽0.80 |
  | Outgoing traffic, from 50 TB to 100 TB | ₽0.75 |
  | Outgoing traffic, over 100 TB | ₽0.72 |

  
{% endlist %}

The first 10 GB of outgoing traffic for {{ objstorage-name }} is counted independently of other services.
