---
title: "{{ monitoring-full-name }} pricing policy"
description: "This article describes the {{ monitoring-name }} pricing policy."
editable: false
---

# {{ monitoring-full-name }} pricing

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

Currently, {{ monitoring-short-name }} charges for writing custom metrics via the [{{ monitoring-short-name }} API](api-ref/index.md) and writing any metrics via the [{{ prometheus-name }} Remote API](operations/prometheus/index.md), as well as reading any metrics via the [{{ monitoring-short-name }} API](api-ref/index.md).

Reading metrics via the {{ prometheus-name }} Remote API is not yet billable.

Pricing features:
* After writing or reading the first 50 million values via the {{ monitoring-short-name }} API, the writing charge is reduced. For more information, refer to [{#T}](#prices).
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* Reading metrics via the {{ monitoring-short-name }} interface and {{ yandex-cloud }} console is not charged.
* Incoming and outgoing traffic in {{ monitoring-short-name }} is not charged.


### Cost calculation example {#example}

The cost of using {{ monitoring-short-name }} for 30 days if writing 20 metrics at **1 value per minute** via the {{ monitoring-short-name }} API:



{% include [usd-example](../_pricing/monitoring/usd-example.md) %}




## Prices for Russia {#prices}




### {{ monitoring-short-name }} API {#monitoring-api}




The minimum billing unit is 1 metric value. The cost is rounded to the nearest cent.

For example, the cost of writing the first 100,000 values is `(100,000 values / 1 million) × $0.0784 = $0.00784`, which is rounded to `$0.01`. The cost of writing 150,000 values is `(150,000 values / 1 million) × $0.0784 = $0.01176`, which is rounded to `$0.01`. Where `$0.0784` is the cost per 1 million values (when writing up to 50 million values).

{% include [usd.md](../_pricing/monitoring/usd.md) %}


### {{ prometheus-name }} Remote API {#prometheus-remote-api}




{% include [usd-prometheus.md](../_pricing/monitoring/usd-prometheus.md) %}


{% include [trademark](../_includes/monitoring/trademark.md) %}
