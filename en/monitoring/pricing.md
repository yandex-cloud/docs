---
editable: false
---

# Pricing for {{ monitoring-full-name }}

{% if product == "cloud-il" %}

{% note info %}

The prices listed below will take effect when {{ monitoring-short-name }} [becomes public](../overview/concepts/launch-stages.md) (the date will be announced later). Until then, the service can be used free of charge.

{% endnote %}

{% endif %}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

The cost of using {{ monitoring-short-name }} includes writing custom metrics via the [API](api-ref/index.md) as well as reading metrics via the [API](api-ref/index.md).

Pricing features:
* After writing or reading the first 50 million values, the writing cost is reduced. See [Pricing](#prices).
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* Reading metrics via the {{ monitoring-short-name }} interface and {{ yandex-cloud }} console is not charged.
* Incoming and outgoing traffic in {{ monitoring-short-name }} is not charged.

{% if product == "yandex-cloud" %}

### Example of cost calculation {#example}

The cost of using {{ monitoring-short-name }} for 30 days while writing 20 metrics at a rate of **1 value per minute**:

> 20 * 1 * (60 * 24 * 30) = 864000 values = 0.864 million values
{% if region == "ru" %}> 0.864 * ₽9.80 = ₽8.4672 = ₽8.47{% endif %}
{% if region == "kz" %}> 0.864 * ₸49.00 = ₸42.336 = ₸42.34{% endif %}
{% if region == "int" %}> 0.864 * $0.0784 = $0.0677376 = $0.07{% endif %}
>
> Total: {% if region == "ru" %}₽8.47{% endif %}{% if region == "kz" %}₸42.34{% endif %}{% if region == "int" %}$0.07{% endif %}

Where:

* 20 is the number of metrics.
* 1 is the number of values written per minute.
* (60 * 24 * 30) is the number of minutes in 30 days.
* {% if region == "ru" %}₽9.80{% endif %}{% if region == "kz" %}₸49.00{% endif %}{% if region == "int" %}$0.0784{% endif %} is the cost of writing 1 million values (up to 50 million values).

The cost of using {{ monitoring-short-name }} for 30 days while writing 20 metrics at a rate of **1 value per second**:

> 20 * 1 * (60 * 60 * 24 * 30) = 51840000 values = 51.84 million values
{% if region == "ru" %}> 50 * ₽9.80 + (51.84 - 50) * ₽5.60 = ₽500.30{% endif %}
{% if region == "kz" %}> 50 * ₸49.00 + (51.84 - 50) * ₸28.00 = ₸2501.52{% endif %}
{% if region == "int" %}> 50 * $0.0784 + (51.84 - 50) * $0.0448 = $4.00{% endif %}
>
> Total: {% if region == "ru" %}₽500.30{% endif %}{% if region == "kz" %}₸2501.52{% endif %}{% if region == "int" %}$4.00{% endif %}

Where:

* 20 is the number of metrics.
* 1 is the number of values written per second.
* (60 * 60 * 24 * 30) is the number of seconds in 30 days.
* {% if region == "ru" %}₽9.80{% endif %}{% if region == "kz" %}₸49.00{% endif %}{% if region == "int" %}$0.0784{% endif %} is the cost of writing 1 million values (up to 50 million values).
* {% if region == "ru" %}₽5.60{% endif %}{% if region == "kz" %}₸28.00{% endif %}{% if region == "int" %}$0.0448{% endif %} is the cost of writing 1 million values (over 50 million values).

The cost of exporting 100 metrics from {{ monitoring-short-name }} to your own installation of the {{ prometheus-name }} monitoring system with a polling interval of **15 seconds** for 30 days:

> 100 * (60 / 15) * (60 * 24 * 30) = 17280000 values = 17.28 million values
{% if region == "ru" %}> 17.28 * ₽7.00 = ₽120.96{% endif %}
{% if region == "kz" %}> 17.28 * ₸35.00 = ₸604.80{% endif %}
{% if region == "int" %}> 17.28 * $0.0560 = $0.97{% endif %}
>
> Total: {% if region == "ru" %}₽120.96{% endif %}{% if region == "kz" %}₸604.80{% endif %}{% if region == "int" %}$0.97{% endif %}

Where:

* 100 is the number of metrics.
* (60 / 15) is the number of values read per minute.
* (60 * 24 * 30) is the number of minutes in 30 days.
* {% if region == "ru" %}₽7.00{% endif %}{% if region == "kz" %}₸35.00{% endif %}{% if region == "int" %}$0.0560{% endif %} is the cost of reading 1 million values (up to 50 million values).

{% endif %}

## Pricing {% if product == "cloud-il" %}(after the service becomes public){% endif %} {#prices}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

The minimum billable unit is 1 metric value. The price is rounded up to the nearest hundredth of a ruble.

For example, the cost of writing the first 86400 values is `(86400 values / 1 million) * ₽9.8 = ₽0.8467`, which is rounded to `₽0.85`. The cost of writing 87000 values is `(87000 values / 1 million) * ₽9.8 = ₽0.8526`, which is rounded to `₽0.85`. Where `₽9.80` is the cost per 1 million values (when writing up to 50 million values).

{% include [rub.md](../_pricing/monitoring/rub.md) %}

{% endif %}

{% if region == "kz" %}

The minimum billable unit is 1 metric value. The cost is rounded to the nearest tiyn.

For example, the cost of writing the first 86500 values is `(86500 values / 1 million) * ₸49.00 = ₸4.2385`, which is rounded to `₸4.24`. The cost of writing 86600 values is `(86600 values / 1 million) * ₸49.00 = ₸4.2434`, which is rounded to `₸4.24`. Where `₸49.00` is the cost per 1 million values (when writing up to 50 million values).

{% include [kzt.md](../_pricing/monitoring/kzt.md) %}

{% endif %}

{% if region == "int" %}

The minimum billable unit is 1 metric value. The cost is rounded to the nearest cent.

For example, the cost of writing the first 100000 values is `(100000 values / 1 million) * $0.0784 = $0.00784`, which is rounded to `$0.01`. The cost of writing 150000 values is `(150000 values / 1 million) * $0.0784 = $0.01176`, which is rounded to `$0.01`. Where `$0.0784` is the cost per 1 million values (when writing up to 50 million values).

{% include [usd.md](../_pricing/monitoring/usd.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

The minimum billable unit is 1 metric value. The cost is rounded to the nearest agora.

{% include [ils.md](../_pricing/monitoring/ils.md) %}

{% endif %}
