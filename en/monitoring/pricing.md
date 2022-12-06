---
editable: false
---

# Pricing for {{ monitoring-full-name }}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

The cost of using {{ monitoring-short-name }} includes writing custom metrics via the [API](api-ref/index.md) as well as reading metrics via the [API](api-ref/index.md).

Pricing features:
* After writing or reading the first 50 million values, the writing cost is reduced. See [Pricing](#prices).
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* Reading metrics via the {{ monitoring-short-name }} interface and {{ yandex-cloud }} console is not charged.
* Incoming and outgoing traffic in {{ monitoring-short-name }} is not charged.

### Example of cost calculation {#example}

The cost of using {{ monitoring-short-name }} for 30 days while writing 20 metrics at a rate of **1 value per minute**:


> 20 × 1 × (60 × 24 × 30) = 864000 values = 0.864 million values
> 
> 
> 0.864 × $0.0784 = $0.0677376 = $0.07
>
> Total: $0.07



Where:

* 20 is the number of metrics.
* 1 is the number of values written per minute.
* (60 × 24 × 30) is the number of minutes in 30 days.
* $0.0784 is the cost of writing 1 million values (up to 50 million values).

The cost of using {{ monitoring-short-name }} for 30 days while writing 20 metrics at a rate of **1 value per second**:


> 20 × 1 × (60 × 60 × 24 × 30) = 51840000 values = 51.84 million values
> 
> 
> 50 × $0.0784 + (51.84 - 50) × $0.0448 = $4.00
>
> Total: $4.00



Where:

* 20 is the number of metrics.
* 1 is the number of values written per second.
* (60 × 60 × 24 × 30) is the number of seconds in 30 days.
* $0.0784 is the cost of writing 1 million values (up to 50 million values).
* $0.0448 is the cost of writing 1 million values (over 50 million values).

The cost of exporting 100 metrics from {{ monitoring-short-name }} to your own installation of the {{ prometheus-name }} monitoring system with a polling interval of **15 seconds** for 30 days:


> 100 × (60 / 15) × (60 × 24 × 30) = 17280000 values = 17.28 million values
> 
> 
> 17.28 × $0.0560 = $0.97
>
> Total: $0.97



Where:

* 100 is the number of metrics.
* (60 / 15) is the number of values read per minute.
* (60 × 24 × 30) is the number of minutes in 30 days.
* $0.0560 is the cost of reading 1 million values (up to 50 million values).

## Pricing {#prices}





The minimum billable unit is 1 metric value. The cost is rounded to the nearest cent.

For example, the cost of writing the first 100000 values is `(100000 values / 1 million) × $0.0784 = $0.00784`, which is rounded to `$0.01`. The cost of writing 150000 values is `(150000 values / 1 million) × $0.0784 = $0.01176`, which is rounded to `$0.01`. Where `$0.0784` is the cost per 1 million values (when writing up to 50 million values).

{% include [usd.md](../_pricing/monitoring/usd.md) %}



