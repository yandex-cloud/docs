# Deleting expired metrics (TTL)

Metrics that don't received new values for 30 days are considered expired and are automatically deleted from {{monitoring-full-name}}. Automatic deletion of expired metrics is run once a day.

## System metrics {#system}

System metrics are automatically collected from all active {{ yandex-cloud }} resources. Metrics are no longer collected from a specific resource after it's deleted. Metric data of deleted resources is available for 30 days. After this period, metrics are automatically deleted.

> For example, let's assume there is a VM in your folder. If you delete this VM on `August 1, 2020`, its metrics will be available in {{monitoring-full-name}} until `August 31, 2020`.

## Custom metrics {#custom}

Automatic deletion of expired metrics doesn't apply to [custom metrics](../operations/metric/add.md).
