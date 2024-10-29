**Example 1**

The cost of using {{ monitoring-short-name }} for 30 days if writing 20 metrics at **1 value per minute** via the {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 24 × 30) = 864,000 values = 0.864M values
> 0.864 × {{ sku|USD|monitoring.point.write|string }} = {% calc [currency=USD] 0.864 × {{ sku|USD|monitoring.point.write|number }} %} = {% calc [currency=USD] round((0.864 × {{ sku|USD|monitoring.point.write|number }}) × 100) / 100 %}
>
> Total: {% calc [currency=USD] round((0.864 × {{ sku|USD|monitoring.point.write|number }}) × 100) / 100 %}

Where:

* 20: Number of metrics.
* 1: Number of values written per minute.
* (60 × 24 × 30): Number of minutes in 30 days.
* {{ sku|USD|monitoring.point.write|string }}: Cost of writing 1M values (up to 50M).

**Example 2**

The cost of using {{ monitoring-short-name }} for 30 days if writing 20 metrics at **1 value per second** via the {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 60 × 24 × 30) = 51,840,000 values = 51.84M values
> 50 × {{ sku|USD|monitoring.point.write|string }} + (51.84 - 50) × {{ sku|USD|monitoring.point.write|pricingRate.50|string }} = {% calc [currency=USD] round((50 × {{ sku|USD|monitoring.point.write|number }} + (51.84 - 50) × {{ sku|USD|monitoring.point.write|pricingRate.50|number }}) × 100) / 100 %}
>
> Total: {% calc [currency=USD] round((50 × {{ sku|USD|monitoring.point.write|number }} + (51.84 - 50) × {{ sku|USD|monitoring.point.write|pricingRate.50|number }}) × 100) / 100 %}

Where:

* 20: Number of metrics.
* 1: Number of values written per second.
* (60 × 60 × 24 × 30): Number of seconds in 30 days.
* {{ sku|USD|monitoring.point.write|string }}: Cost of writing 1M values (up to 50M).
* {{ sku|USD|monitoring.point.write|pricingRate.50|string }}: Cost of writing 1M values (over 50M).

**Example 3**

The cost of exporting 100 metrics from {{ monitoring-short-name }} to your own {{ prometheus-name }} monitoring system installation with a polling interval of **15 seconds** for 30 days via the {{ monitoring-short-name }} API:

> 100 × (60 / 15) × (60 × 24 × 30) = 17,280,000 values = 17.28M values
> 17.28 × {{ sku|USD|monitoring.point.prometheus.export|string }} = {% calc [currency=USD] round((17.28 × {{ sku|USD|monitoring.point.prometheus.export|number }}) × 100) / 100 %}
>
> Total: {% calc [currency=USD] round((17.28 × {{ sku|USD|monitoring.point.prometheus.export|number }}) × 100) / 100 %}

Where:

* 100: Number of metrics.
* (60 / 15): Number of values read per minute.
* (60 × 24 × 30): Number of minutes in 30 days.
* {{ sku|USD|monitoring.point.prometheus.export|string }}: Cost of reading 1M values (up to 50M).