---
editable: false
---
# Pricing for {{ monitoring-full-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

The cost of using {{ monitoring-short-name }} includes writing custom metrics via the [API](api-ref/index.md) as well as reading metrics via the [API](api-ref/index.md).

Pricing features:

* After writing or reading the first 50 million values, the writing cost is reduced. For details, see [Pricing](#prices).
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* Reading metrics via the {{ monitoring-short-name }} interface and {{ yandex-cloud }}  console is not charged.
* Incoming and outgoing traffic in {{ monitoring-short-name }} is not charged.

### Pricing {#prices}

{% if region == "ru"%}

The minimum billable unit is 1 metric value. The price is rounded up to the nearest hundredth of a ruble.

For example, the cost of writing the first 86,400 values is `0.6048 ₽`, which is rounded to `0.60 ₽`. The cost of writing the first 87,000 values is `0.609 ₽`, which is rounded to `0.60 ₽`. Where `7,00 ₽` — the price per 1 million values (writing up to 50 million values).

{% include [rub.md](../_pricing/monitoring/rub.md) %}
         
{% endif %}
         
{% if region == "kz"%}
         
{% include [kzt.md](../_pricing/monitoring/kzt.md) %}
         
{% endif %}
         
{% if region == "int"%}

The minimum billable unit is one metric value. The cost is rounded to the nearest hundredth.

For example, the cost of writing the first 86,400 values is `$0.007754` and rounded to `$0.01`. The cost of writing 870,000 values is `$0.078077` and rounded to `$0.08`. Where `$0.089744` is the price per 50 million metrics. 
         
{% include [usd.md](../_pricing/monitoring/usd.md) %}
         
{% endif %}

{% if region == "ru"%}

### Example of cost calculation {#example}

Let's say you write to {{ monitoring-short-name }} 20 metrics at a rate of **1 value per minute**. In 30 days, your total written will be:

> 20 metrics * 1 value/min * 60 minutes * 24 hours * 30 days = 864,000 values = 0.864 million values

The service cost for 30 days will be `0.864 million values * 7 ₽ = 6.05 ₽`.

If you write 20 metrics at a rate of **1 value per second**, in 30 days your total written will be:

> 20 metrics * 1 value/second * 60 seconds * 60 minutes * 24 hours * 30 days = 51,840,000 values = 51.84 million values

In this case, the service cost for 30 days will be `50 million values * 7 ₽ + (51.84 - 50) million values * 4 ₽ = 357.36 ₽`.

For another example, perhaps you set up export for 100 metrics from {{ monitoring-short-name }} to your on-premise installation of the {{ prometheus-name }} monitoring system with a polling interval of **15 seconds**. In 30 days, your total read will be:

> 100 metrics * 60 seconds / 15 seconds * 60 minutes * 24 hours * 30 days = 17,280,000 values = 17.28 million values

In this case, the service cost for 30 days will be `17.28 million values * 5 ₽ = 86.4 ₽`.

{% endif %}

{% if region == "int"%}

### Example of cost calculation {#example}

Let's say you're writing 20 metrics to {{ monitoring-short-name }} with a frequency of **1 value per minute**. Then the following number of values will be written within 30 days:

>20 metrics * 1 value/min * 60 minutes * 24 hours * 30 days = 864,000 values = 0.864 million values

So the cost of using the service for 30 days is `0.864 million values * $0.089744 = $0.077538`.

If you write 20 metrics with a frequency of **1 value per second**, the following number of values will be written within 30 days:

>20 metrics * 1 value/sec * 60 seconds * 60 minutes * 24 hours * 30 days = 51,840,000 values = 51.84 million values

In this case, the cost of using the service for 30 days is `50 million values * $0.089744 + (51.84 - 50) million values * $0.051282 = $4.581558`.

For example, you set up the export of 100 metrics from {{ monitoring-short-name }} to your own Prometheus monitoring system installation with a collection period of **15 seconds**. Then the following number of values will be read within 30 days:

> 100 metrics * 60 seconds / 15 seconds * 60 minutes * 24 hours * 30 days = 17,280,000 values = 17.28 million values

In this case, the cost of using the service for 30 days is `17.28 million values * $0.064103 = $1.107699`.

{% endif %}
