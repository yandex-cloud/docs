{{ monium-name }} stores data in shards with the `project`, `cluster`, and `service` keys. The shard key is selected based on a priority table, with priority decreasing from left to right.

#|
|| header | resource attribute | resource attribute | constant ||
|| `x-monium-project` | — | — | — ||
|| `x-monium-cluster` | `cluster` | `deployment.name` | `default` ||
|| `x-monium-service` | `service` | `service.name` | `default` ||
|#