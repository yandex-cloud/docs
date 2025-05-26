On average, {{ cdn-short-name }} metrics are updated every three minutes. 

{% note info %}

For technical reasons, EdgeCenter CDN provider metrics are [exported](../../monitoring/operations/metric/prometheusExport.md) from {{ monitoring-full-name }} in {{ prometheus-name }} format with a delay, and their timestamps are 10-15 minutes ahead of the actual time. For example, a metric value exported in {{ prometheus-name }} format and timestamped at 01:00 will actually reflect data collected between 00:45 and 00:50.

{% endnote %}

In the [{{ monitoring-short-name }} interface]({{ link-monitoring }}), timestamps match the actual time these metrics were collected.

