**Example 1**

Cost of using {{ monitoring-short-name }} for 30 days if writing 20 metrics at **1 value per minute** via the {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 24 × 30) = 864,000 values = 0.864M values
> 0.864 × 0.0026 = {% calc [currency=USD] 0.864 × 0.0026 %} = {% calc [currency=USD] round((0.864 × 0.0026) × 100) / 100 %}
>
> Total: {% calc [currency=USD] round((0.864 × 0.0026) × 100) / 100 %}

Where:

* 20: Number of metrics.
* 1: Number of values written per minute.
* (60 × 24 × 30): Number of minutes in 30 days.
* 0.0026: Cost of writing 1,000,000 values.

**Example 2**

Cost of exporting 100 metrics from {{ monitoring-short-name }} to your own {{ prometheus-name }} monitoring system installation with a polling interval of **15 seconds** for 30 days via the {{ monitoring-short-name }} API:

> 100 × (60 / 15) × (60 × 24 × 30) = 17,280,000 values = 17.28M values
> 17.28 × {{ sku|USD|monitoring.point.prometheus.export|string }} = {% calc [currency=USD] round((17.28 × {{ sku|USD|monitoring.point.prometheus.export|number }}) × 100) / 100 %}
>
> Total: {% calc [currency=USD] round((17.28 × {{ sku|USD|monitoring.point.prometheus.export|number }}) × 100) / 100 %}

Where:

* 100: Number of metrics.
* (60 / 15): Number of values read per minute.
* (60 × 24 × 30): Number of minutes in 30 days.
* {{ sku|USD|monitoring.point.prometheus.export|string }}: Cost of reading 1,000,000 values (up to 50,000,000).