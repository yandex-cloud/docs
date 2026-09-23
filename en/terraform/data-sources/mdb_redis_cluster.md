---
subcategory: Managed Service for ValKey
---

# yandex_mdb_redis_cluster (DataSource)

Get information about a Yandex Managed Redis cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-redis/concepts).

{% note warning %}

Either `cluster_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing MDB Redis Cluster.
//
data "yandex_mdb_redis_cluster" "foo" {
  name = "test"
}

output "network_id" {
  value = data.yandex_mdb_redis_cluster.foo.network_id
}
```

## Arguments & Attributes Reference

- `announce_hostnames` (*Read-Only*) (Bool). Announce fqdn instead of ip address.
- `auth_sentinel` (*Read-Only*) (Bool). Allows to use ACL users to auth in sentinel
- `cluster_id` (String). The ID of the Redis cluster.
- `config` (*Read-Only*) (List Of Object). Configuration of the Redis cluster.
  - `allow_data_loss` . 
  - `backup_window_start` . 
    - `hours` . 
    - `minutes` . 
  - `client_output_buffer_limit_normal` . 
  - `client_output_buffer_limit_pubsub` . 
  - `cluster_allow_pubsubshard_when_down` . 
  - `cluster_allow_reads_when_down` . 
  - `cluster_require_full_coverage` . 
  - `databases` . 
  - `io_threads_allowed` . 
  - `lfu_decay_time` . 
  - `lfu_log_factor` . 
  - `lua_time_limit` . 
  - `maxmemory_percent` . 
  - `maxmemory_policy` . 
  - `notify_keyspace_events` . 
  - `repl_backlog_size_percent` . 
  - `slowlog_log_slower_than` . 
  - `slowlog_max_len` . 
  - `timeout` . 
  - `turn_before_switchover` . 
  - `use_luajit` . 
  - `version` . 
  - `zset_max_listpack_entries` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption.
- `disk_size_autoscaling` (*Read-Only*) (List Of Object). Disk size autoscaling settings.
  - `disk_size_limit` . 
  - `emergency_usage_threshold` . 
  - `planned_usage_threshold` . 
- `environment` (*Read-Only*) (String). Deployment environment of the Redis cluster. Can be either `PRESTABLE` or `PRODUCTION`.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster. Can be either `ALIVE`, `DEGRADED`, `DEAD` or `HEALTH_UNKNOWN`. For more information see `health` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-redis/api-ref/Cluster/).
- `host` (*Read-Only*) (List Of Object). A host of the Redis cluster.
  - `assign_public_ip` . 
  - `fqdn` . 
  - `replica_priority` . 
  - `shard_name` . 
  - `subnet_id` . 
  - `zone` . 
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` (*Read-Only*) (List Of Object). Maintenance window settings.
  - `day` . 
  - `hour` . 
  - `type` . 
- `name` (String). The name of the Redis cluster.
- `network_id` (*Read-Only*) (String). The `VPC Network ID` of subnets which resource attached to.
- `persistence_mode` (*Read-Only*) (String). Persistence mode. Possible values: `ON`, `OFF`.
- `resources` (*Read-Only*) (List Of Object). Resources allocated to hosts of the Redis cluster.
  - `disk_size` . 
  - `disk_type_id` . 
  - `resource_preset_id` . 
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `sharded` (*Read-Only*) (Bool). Redis Cluster mode enabled/disabled. Enables sharding when cluster non-sharded. If cluster is sharded - disabling is not allowed.
- `status` (*Read-Only*) (String). Status of the cluster. Can be either `CREATING`, `STARTING`, `RUNNING`, `UPDATING`, `STOPPING`, `STOPPED`, `ERROR` or `STATUS_UNKNOWN`. For more information see `status` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-redis/api-ref/Cluster/).
- `tls_enabled` (*Read-Only*) (Bool). TLS support mode enabled/disabled.


