The `name` label contains the metric name.

Labels shared by all {{ cloud-registry-name }} metrics:

Label | Value
----|----
service | Service ID: `cloud-registry`
registry_id | [Registry ID](../../../cloud-registry/concepts/registry.md)

## Service metrics {#cloud-registry-metrics}

Metric name<br>Type, units | Description
--- | ---
`registry_artifacts_count`<br>`IGAUGE`, count | Current number of artifacts in the registry
`registry_size_bytes`<br>`IGAUGE`, bytes | Total registry size
