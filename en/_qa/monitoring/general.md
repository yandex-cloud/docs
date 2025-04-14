# General questions about {{ monitoring-name }}

{% include [logs](../logs.md) %}

#### How can I see the service dashboards? {#dont-see-dashboards}

Service dashboards appear automatically when you create {{ yandex-cloud }} resources. Add a resource and refresh the {{ monitoring-name }} [homepage]({{ link-monitoring }}).

#### The old data in {{ monitoring-name }} charts has disappeared. Why? {#lost-data-graphs}

If a metric has not received new data for 30 days, it is automatically deleted from {{ monitoring-name }}. This period is 60 days for {{ managed-prometheus-name }} and 7 days for {{ compute-full-name }}. For more information, see [{#T}](../../monitoring/concepts/ttl.md).

There is also a non-configurable [decimation mechanism](../../monitoring/concepts/decimation.md) reducing the amount of stored data.

#### My metrics are not reported and I cannot create a {{ prometheus-name }} workspace. Why? {#prometheus-trouble}

This can happen if you do not have monitoring data-providing [resources](../../overview/roles-and-resources.md#resources) in your cloud. Start using any resource and wait for the metrics to show up in {{ monitoring-name }}.