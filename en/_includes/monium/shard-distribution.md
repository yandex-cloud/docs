All metrics, logs, and traces in {{ monium-name }} have mandatory labels: `project`, `cluster`, and `service`. These labels form the shard key.

When delivering telemetry in OpenTelemetry format, the values of these key attributes are assigned in the following order of priority:

* Values assigned via HTTP or gRPC headers have the highest priority.
* Then follow the values set in the resource attributes of the request body with the `cluster` and `service` keys.
* Next are the values set in the resource attributes recommended by the OpenTelemetry semantic convention.
* If the above-listed values are not set, the default value is used.

The project name is only taken from the header. The algorithm for determining the shard key is presented in the table below.

#|
|| header | resource’s own attribute | resource’s standard attribute | default value ||
|| `x-monium-project` | — | — | — ||
|| `x-monium-cluster` | `cluster` | `deployment.name` | `default` ||
|| `x-monium-service` | `service` | `service.name`, `k8s.deployment.name`, `k8s.namespace.name` | `default` ||
|#
