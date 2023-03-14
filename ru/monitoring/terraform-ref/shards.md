# ycp_monitoring_shard (Resource)

Monitoring shard

## Schema

### Required

- `cluster_id` (String) Cluster identifier
- `project_id` (String) Project identifier
- `service_id` (String) Shard identifier
- `shard_id` (String) Shard identifier, will be copied to id

### Optional

- `id` (String) The ID of this resource.
- `labels` (Map of String) Shard labels
- `metrics_name_label` (String) Required metric name label for shard metrics.
  It's neccessary to convert sensor=<metric_name>, label1="value1", label2="value2" to <metric_name>{label1="value1", label2="value2"} format.
  This label must be required in pull/push data and existing metrics
- `metrics_ttl_days` (Number) If this field is filled, Solomon will drop all metrics where last point was metrics TTL days ago
- `state` (String) Shard state. INACTIVE/READ_ONLY/WRITE_ONLY/RW/ACTIVE. Default is RW
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)

## Example
```
resource "ycp_monitoring_shard" "solomon_alerting_prod_alerting" {
  shard_id         = format("%s%s", ycp_monitoring_project.aletrushkin_test_tf_1.project_id, "_alerting_prod_alerting")
  project_id       = "project_id_here"
  cluster_id       = ycp_monitoring_cluster.solomon_alerting_prod.id
  service_id       = ycp_monitoring_service_pull.solomon_alerting.id
  metrics_ttl_days = 1
}

resource "ycp_monitoring_shard" "solomon_alerting_prod_alerting_statuses" {
  shard_id         = format("%s%s", ycp_monitoring_project.aletrushkin_test_tf_1.project_id, "_alerting_prod_alerting_statuses")
  project_id       = "project_id_here"
  cluster_id       = ycp_monitoring_cluster.solomon_alerting_prod.id
  service_id       = ycp_monitoring_service_pull.solomon_alerting_statuses.id
  metrics_ttl_days = 1
}
```

