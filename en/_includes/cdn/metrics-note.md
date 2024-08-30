On average, {{ cdn-short-name }} metrics are updated every 3 minutes.

{% note info %}

For technical reasons, metrics from the EdgeCenter CDN provider are [exported](../../monitoring/operations/metric/prometheusExport.md) from {{ monitoring-full-name }} in {{ prometheus-name }} format with a delay, and their time values are 10-15 minutes ahead of the actual time. For example, for a metric exported in {{ prometheus-name }} format, the actual time for 01:00 would be between 00:45 and 00:50.

{% endnote %}

If you view the metrics in the [{{ monitoring-short-name }} interface]({{ link-monitoring }}), their time values will match the actual time.

