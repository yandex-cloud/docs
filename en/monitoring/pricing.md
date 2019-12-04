---
editable: false
---
# Pricing for {{ monitoring-full-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

Currently, the cost of {{ monitoring-short-name }} usage is calculated based on the number custom metrics written via the [API](api-ref/index.md).

Please note the following details:

* After writing the first 50 million values, the write cost is reduced. For details, see [Pricing](#prices).
* Yandex.Cloud resource metrics, as well as incoming and outgoing traffic, are free.

### Pricing {#prices}

The minimum billable unit is 1 metric value. The price is rounded up to the nearest hundredth of a ruble.

For example, the cost to write the first 86400 values is `₽0.6048`, which gets rounded to `₽0.60`.
The cost to write the first 87000 values is `₽0.609`, which is also rounded to `₽0.61 `.

{% list tabs %}

- Prices in USD

  | Service | Price per 1 million values,<br>without VAT |
  | ----- | ----- |
  | Writing custom metric values via the API<br/>(≤50 million values) | $0,089746 |
  | Writing custom metric values via the API<br/>(>50 million values) | $0,051282 |
  | Reading custom metric values via the API | $0 |

- Prices in roubles

  | Service | Price per 1 million values,<br>with VAT |
  | ----- | ----- |
  | Writing custom metric values via the API<br/>(≤50 million values) | ₽7.00 |
  | Writing custom metric values via the API<br/>(>50 million values) | ₽4.00 |
  | Reading custom metric values via the API | ₽0 |

{% endlist %}

### Example of cost calculation {#example}

For example, you write 20 metrics to the {{ monitoring-short-name }} service at the rate of **1 value per minute**.
After 30 days there will be the following number of values:

>20 metrics * 1 value/minute * 60 minutes * 24 hours * 30 days = 864,000 values ​​= 0.864 million values

Thus, the cost of using the service for 30 days will be `0.864 million values ​​* ₽7 = ₽6.05`.

If you record 20 metrics with at the rate of **1 value per second**, then in 30 days will be recorded:

> 20 metrics * 1 value/second * 60 seconds * 60 minutes * 24 hours * 30 days = 51,840,000 values ​​= 51.84 million values

In this case, the cost of using the service for 30 days will be `50 million values ​​* ₽7 + (51.84 - 50) million values ​​* ₽4 = ₽357.36`.
