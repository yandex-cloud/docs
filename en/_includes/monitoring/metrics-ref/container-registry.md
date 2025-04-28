The `name` label contains the metric name.

Labels shared by all {{ container-registry-name }} metrics:

Label | Value
----|----
service | Service ID: `container-registry`
registry | [Registry](../../../container-registry/concepts/registry.md) ID

## Service metrics {#container-registry-metrics}

Metric name<br>Type, units | Description
--- | ---
`registry.images_count`<br>`IGAUGE`, count | Current number of Docker images in the registry
`registry.size_bytes`<br>`IGAUGE`, bytes | Total size of Docker images in the registry