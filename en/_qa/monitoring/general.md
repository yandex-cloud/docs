# General questions about {{ monitoring-name }}

{% include [logs](../logs.md) %}

#### How do I view service dashboards? {#dont-see-dashboards}

Service dashboards are created automatically after resources are created in {{ yandex-cloud }}. Add a resource and update the {{ monitoring-name }} [homepage]({{ link-monitoring }}).

#### The old data in {{ monitoring-name }} charts has disappeared. Why? {#lost-data-graphs}

Metrics for which no new values have been received for 30 days are automatically deleted from {{ monitoring-name }}. For {{ managed-prometheus-name }}, this period is 60 days; for {{ compute-full-name }}, 7 days. For more information, see [{#T}](../../monitoring/concepts/ttl.md).

There is also a non-configurable [decimation mechanism](../../monitoring/concepts/decimation.md) that decreases the amount of stored data.

#### In {{ prometheus-name }}, metrics are not delivered, and I cannot create a workspace. Why? {#prometheus-trouble}

This may happen if none of your cloud [resources](../../overview/roles-and-resources.md#resources) are sending monitoring data. Start using a resource and wait for the metrics to show up in {{ monitoring-name }}.