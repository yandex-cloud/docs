# General questions about {{ monitoring-name }}

{% include [logs](../logs.md) %}

#### How do I view service dashboards? {#dont-see-dashboards}

Service dashboards are created automatically after resources are created in {{ yandex-cloud }}. Add a resource and update the {{ monitoring-name }} [homepage]({{ link-monitoring }}).

#### The old data in {{ monitoring-name }} charts has disappeared. Why? {#lost-data-graphs}

Metrics that haven't received new values within 30 days are automatically deleted from {{ monitoring-name }}. For more information, see [{#T}](../../monitoring/concepts/ttl.md).

There is also a non-configurable [decimation mechanism](../../monitoring/concepts/decimation.md) that decreases the amount of stored data.
