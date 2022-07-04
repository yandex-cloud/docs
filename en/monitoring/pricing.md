---
editable: false
---

# Pricing for {{ monitoring-full-name }}

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ monitoring-name }} can be used free of charge.

{% endif %}

{% if product == "yandex-cloud" %}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

The cost of using {{ monitoring-short-name }} includes writing custom metrics via the [API](api-ref/index.md) as well as reading metrics via the [API](api-ref/index.md).

Pricing features:
* After writing or reading the first 50 million values, the writing cost is reduced. See [Pricing](#prices).
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* Reading metrics via the {{ monitoring-short-name }} interface and {{ yandex-cloud }} console is not charged.
* Incoming and outgoing traffic in {{ monitoring-short-name }} is not charged.

### Pricing {#prices}

The minimum billable unit is 1 metric value. The price is rounded up to the nearest hundredth of a ruble.

{% if region == "ru"%}

For example, the cost of writing the first 86,400 values is `(86 400 values / 1 million) * ₽9.8 = ₽0.8467`, which is rounded to `₽0.85`. The cost of writing the first 87,000 values is `(87 000 values / 1 million) * ₽9.8 = ₽0.8526`, which is rounded to `₽0.85`. Where `₽9.8` is the cost per 1 million values (when writing up to 50 million values).

{% endif %}

{% if region == "ru"%}

{% include [rub.md](../_pricing/monitoring/rub.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/monitoring/kzt.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/monitoring/usd.md) %}

{% endif %}

{% if region == "ru"%}

### Example of cost calculation {#example}

Let's say you write to {{ monitoring-short-name }} 20 metrics at a rate of **1 value per minute**. In 30 days, your amount written will be:

> 20 metrics * 1 value/min * 60 minutes * 24 hours * 30 days = 864,000 values = 0.864 million values

The service cost for 30 days will be `0.864 million values * ₽9.8 = ₽8.4672`. After rounding: `₽8.47`.

If you write 20 metrics at a rate of **1 value per second**, in 30 days your total written will be:

> 20 metrics * 1 value/second * 60 seconds * 60 minutes * 24 hours * 30 days = 51,840,000 values = 51.84 million values

In this case, the service cost for 30 days will be `50 million values * ₽9.8 + (51.84 - 50) million values * ₽5,6 = ₽500.304`. After rounding: `₽500.3`.

For another example, perhaps you set up export for 100 metrics from {{ monitoring-short-name }} to your on-premise installation of the {{ prometheus-name }} monitoring system with a polling interval of **15 seconds**. In 30 days, your total read will be:

> 100 metrics * 60 seconds / 15 seconds * 60 minutes * 24 hours * 30 days = 17,280,000 values = 17.28 million values

In this case, the service cost for 30 days will be `17.28 million values * ₽7 = ₽120.96`.

{% endif %}

{% endif %}
