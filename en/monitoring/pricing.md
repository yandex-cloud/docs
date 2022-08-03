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

The cost of using the {{ monitoring-short-name }} service for 30 days while writing 20 metrics at a rate of **1 value per minute**:

> 20 * 1 * (60 * 24 * 30) = 864,000 values = 0.864 million values
> 0.864 * 9.8 = ₽8.4672 = ₽8.47
> 
> Total: ₽8.47

Where:

* 20 — number of metrics.
* 1 — number of values recorded per minute.
* (60 * 24 * 30) — number of minutes in 30 days.
* ₽9.8 — cost of writing 1 million values (up to 50 million values).

The cost of using the {{ monitoring-short-name }} service for 30 days while writing 20 metrics at a rate of **1 value per second**:

> 20 * 1 * (60 * 60 * 24 * 30) = 51,840,000 values = 51.84 million values
> 50 * 9.8 + (51.84 - 50) * 5.6 = ₽500.3
> 
> Total: ₽500.3

Where:

* 20 — number of metrics.
* 1 — number of values recorded per second.
* (60 * 60 * 24 * 30) — number of seconds in 30 days.
* ₽9.8 — cost of writing 1 million values (up to 50 million values).
* ₽5.6 — cost of writing 1 million values (over 50 million values).

The cost of exporting 100 metrics from {{ monitoring-short-name }} to your on-premise installation of the {{ prometheus-name }} monitoring system with a polling interval of **15 seconds** for 30 days:

> 100 * (60 / 15) * (60 * 24 * 30) = 17,280,000 values = 17.28 million values
> 17.28 * 7 = ₽120.96
> 
> Total: ₽120.96

Where:

* 100 — number of metrics.
* (60 / 15) — number of readings per minute.
* (60 * 24 * 30) — number of minutes in 30 days.
* ₽7 — cost of reading 1 million values (up to 50 million values).

## Pricing {#prices}

The minimum billable unit is 1 metric value. The price is rounded up to the nearest hundredth of a ruble.





{% include [usd.md](../_pricing/monitoring/usd.md) %}



