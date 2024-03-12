# Deleting expired metrics (TTL)

In {{ monitoring-full-name }}, there are two types of metrics:

* Custom metrics.
* System metrics automatically collected from all active {{ yandex-cloud }} resources.

Metrics that do not receive new values for 30 days are considered expired and are automatically deleted from {{ monitoring-full-name }}. Automatic deletion of expired metrics is run once a day.

Metrics are no longer collected from a specific resource after its deletion. Metric data of deleted resources is available for 30 days. After this period, metrics are automatically deleted. If your folder hosts a VM and you delete it on `August 1, 2020`, its metrics will be available in {{ monitoring-full-name }} until `August 31, 2020`.

To set a shorter storage period, contact [technical support]({{ link-console-support }}).