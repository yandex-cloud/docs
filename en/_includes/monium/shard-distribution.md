{{ monium-name }} stores data in shards with the `project`, `cluster`, and `service` keys. The shard key is selected based on a priority table, with priority decreasing from left to right.

#|
|| header | resource’s own attribute | resource’s standard attribute | default value ||
|| `x-monium-project` | — | — | — ||
|| `x-monium-cluster` | `cluster` | `deployment.name` | `default` ||
|| `x-monium-service` | `service` | `service.name`, `k8s.deployment.name`, `k8s.namespace.name` | `default` ||
|#
