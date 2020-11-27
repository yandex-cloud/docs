---
editable: false
---
# Pricing for {{ monitoring-full-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

Currently, {{ monitoring-short-name }} users are charged for writing custom metrics via the [API](api-ref/index.md) and reading any metrics via the [API](api-ref/index.md).

Pricing specifics:
* After writing or reading the first 50 million values, the cost of writes is reduced. See [Pricing](#prices).
* Writes of {{ yandex-cloud }} resource metrics collected automatically are free of charge.
* Reads using the {{ monitoring-short-name }} interface and the {{ yandex-cloud }} console are free of charge.
* Incoming and outgoing traffic in {{ monitoring-short-name }} is free of charge.

### Pricing {#prices}

The minimum billable unit is one metric value. The cost is rounded to the nearest hundredth.

For example, the cost of writing the first 86,400 values is `₽0.6048` and rounded to `₽0.60`. The cost of writing 87,000 values is `₽0.609` and rounded to `₽0.61`.

{% list tabs %}

- Prices in USD

  Service | Price per 1 million values,<br>without VAT
  ----- | -----
  Reading any metric values via the API<br/>(up to 50 million values) | $0,064103
  Reading any metric values via the API<br/>(over 50 million values) | $0,038462
  Writing custom metric values via the API<br/>(up to 50 million values) | $0,089744
  Writing custom metric values via the API<br/>(over 50 million values) | $0,051282
  Writing {{ yandex-cloud }} resource metric values | $0.00


- Prices in roubles

  Service | Price per 1 million values,<br>with VAT
  ----- | -----
  Reading any metric values via the API<br/>(up to 50 million values) | ₽5.00
  Reading any metric values via the API<br/>(over 50 million values) | ₽3.00
  Writing custom metric values via the API<br/>(up to 50 million values) | ₽7.00
  Writing custom metric values via the API<br/>(over 50 million values) | ₽4.00
  Writing {{ yandex-cloud }} resource metric values | ₽0.00
  

{% endlist %}

### Cost calculation example {#example}

Let's say you're writing 20 metrics to {{ monitoring-short-name }} with a frequency of **1 value per minute**. Then the following number of values will be written within 30 days:

>20 metrics * 1 value/min * 60 minutes * 24 hours * 30 days = 864,000 values = 0.864 million values

So the cost of using the service for 30 days is `0.864 million values * $0.089744 = $0.077538`.

If you write 20 metrics with a frequency of **1 value per second**, the following number of values will be written within 30 days:

>20 metrics * 1 value/sec * 60 seconds * 60 minutes * 24 hours * 30 days = 51,840,000 values = 51.84 million values

In this case, the cost of using the service for 30 days is `50 million values * $0.089744 + (51.84 - 50) million values * $0.051282 = $4.581558`.

For example, you set up the export of 100 metrics from {{ monitoring-short-name }} to your own Prometheus monitoring system installation with a collection period of **15 seconds**. Then the following number of values will be read within 30 days:

> 100 metrics * 60 seconds / 15 seconds * 60 minutes * 24 hours * 30 days = 17,280,000 values = 17.28 million values

In this case, the cost of using the service for 30 days is `17.28 million values * $0.064103 = $1.107699`.
