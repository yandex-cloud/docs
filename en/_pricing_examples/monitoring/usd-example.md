**Example 1**

The cost of using {{ monitoring-short-name }} for 30 days if writing 20 metrics at **1 value per minute** via the {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 24 × 30) = 864,000 values = 0.864M values
> 0.864 × $0.0784 = $0.0677376 = $0.07
>
> Total: $0.07

Where:

* 20: Number of metrics.
* 1: Number of values written per minute.
* (60 × 24 × 30): Number of minutes in 30 days.
* $0.0784: Cost of writing 1M values (up to 50M).

**Example 2**

The cost of using {{ monitoring-short-name }} for 30 days if writing 20 metrics at **1 value per second** via the {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 60 × 24 × 30) = 51,840,000 values = 51.84M values
> 50 × $0.0784 + (51.84 - 50) × $0.0448 = $4.00
>
> Total: $4.00

Where:

* 20: Number of metrics.
* 1: Number of values written per second.
* (60 × 60 × 24 × 30): Number of seconds in 30 days.
* $0.0784: Cost of writing 1M values (up to 50M).
* $0.0448: Cost of writing 1M values (over 50M).

**Example 3**

The cost of exporting 100 metrics from {{ monitoring-short-name }} to your own {{ prometheus-name }} monitoring system installation with a polling interval of **15 seconds** for 30 days via the {{ monitoring-short-name }} API:

> 100 × (60 / 15) × (60 × 24 × 30) = 17,280,000 values = 17.28M values
> 17.28 × $0.0560 = $0.97
>
> Total: $0.97

Where:

* 100: Number of metrics.
* (60 / 15): Number of values read per minute.
* (60 × 24 × 30): Number of minutes in 30 days.
* $0.0560: Cost of reading 1M values (up to 50M).