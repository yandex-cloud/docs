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

For example, the cost of writing the first 86,400 values is `$0.007754` and rounded to `$0.01`. The cost of writing 870,000 values is `$0.078077` and rounded to `$0.08`. Where `$0.089744` is the price per 50 million metrics. 

{% if region == "ru"%}
         
{% include [rub.md](../_pricing/monitoring/rub.md) %}
         
{% endif %}
         
{% if region == "pre-kz"%}
         
{% include [kzt.md](../_pricing/monitoring/kzt.md) %}
         
{% endif %}
         
{% if region == "int"%}
         
{% include [usd.md](../_pricing/monitoring/usd.md) %}
         
{% endif %}

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
