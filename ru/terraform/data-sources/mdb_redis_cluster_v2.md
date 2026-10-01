---
subcategory: Managed Service for ValKey
---

# yandex_mdb_redis_cluster_v2 (DataSource)

Manages a Redis cluster within the Yandex Cloud. For more information, see [the official documentation](https://cloud.yandex.com/docs/managed-redis/). [How to connect to the DB](https://yandex.cloud/docs/managed-redis/quickstart#connect). To connect, use port 6379. The port number is not configurable.

## Example usage

```terraform
data "yandex_mdb_redis_cluster_v2" "foo" {
  name = "test"
}

output "network_id" {
  value = data.yandex_mdb_redis_cluster_v2.foo.network_id
}
```

## Arguments & Attributes Reference

- `access` [Block]. Access policy to the Redis cluster.
  - `data_lens` (*Read-Only*) (Bool). Allow access for Yandex DataLens. Can be either true or false.
  - `web_sql` (*Read-Only*) (Bool). Allow access for SQL queries in the management console. Can be either true or false.
- `announce_hostnames` (*Read-Only*) (Bool). Announce fqdn instead of ip address. Can be either true or false.
- `auth_sentinel` (*Read-Only*) (Bool). Allows to use ACL users to auth in sentinel
- `cluster_id` (String). ID of the Redis cluster. This ID is assigned by MDB at creation time.
- `config` [Block]. Configuration of the Redis cluster.
  - `allow_data_loss` (*Read-Only*) (Bool). Allows some data to be lost in favor of faster switchover/restart. Can be either true or false.
  - `backup_retain_period_days` (*Read-Only*) (Number). Retain period of automatically created backup in days.
  - `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
    - `hours` (*Read-Only*) (Number). The hour at which backup will be started.
    - `minutes` (*Read-Only*) (Number). The minute at which backup will be started.
  - `client_output_buffer_limit_normal` (*Read-Only*) (String). Redis connection output buffers limits for clients.
  - `client_output_buffer_limit_pubsub` (*Read-Only*) (String). Redis connection output buffers limits for pubsub operations.
  - `cluster_allow_pubsubshard_when_down` (*Read-Only*) (Bool). Permits Pub/Sub shard operations when cluster is down. Can be either true or false.
  - `cluster_allow_reads_when_down` (*Read-Only*) (Bool). Allows read operations when cluster is down. Can be either true or false.
  - `cluster_require_full_coverage` (*Read-Only*) (Bool). Controls whether all hash slots must be covered by nodes. Can be either true or false.
  - `databases` (*Read-Only*) (Number). Number of database buckets on a single redis-server process.
  - `io_threads_allowed` (*Read-Only*) (Bool). Allow redis to use io-threads. Can be either true or false.
  - `lfu_decay_time` (*Read-Only*) (Number). The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10).
  - `lfu_log_factor` (*Read-Only*) (Number). Determines how the frequency counter represents key hits.
  - `lua_time_limit` (*Read-Only*) (Number). Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism.
  - `maxmemory_percent` (*Read-Only*) (Number). Redis maxmemory percent
  - `maxmemory_policy` (*Read-Only*) (String). Redis key eviction policy for a dataset that reaches maximum memory, available to the host.
  - `notify_keyspace_events` (*Read-Only*) (String). String setting for pub\sub functionality.
  - `password` (*Read-Only*) (String). Authentication password.
  - `repl_backlog_size_percent` (*Read-Only*) (Number). Replication backlog size as a percentage of flavor maxmemory.
  - `slowlog_log_slower_than` (*Read-Only*) (Number). Threshold for logging slow requests to server in microseconds (log only slower than it).
  - `slowlog_max_len` (*Read-Only*) (Number). Max slow requests number to log.
  - `timeout` (*Read-Only*) (Number). Time that Redis keeps the connection open while the client is idle.
  - `turn_before_switchover` (*Read-Only*) (Bool). Allows to turn before switchover in RDSync. Can be either true or false.
  - `use_luajit` (*Read-Only*) (Bool). Use JIT for lua scripts and functions. Can be either true or false.
  - `version` (*Read-Only*) (String). Redis version.
  - `zset_max_listpack_entries` (*Read-Only*) (Number). Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `disk_encryption_key_id` (*Read-Only*) (String). ID of the symmetric encryption key used to encrypt the disk of the cluster.
- `disk_size_autoscaling` [Block]. Disk size autoscaling settings.
  - `disk_size_limit` (*Read-Only*) (Number). Limit of disk size after autoscaling in bytes.
  - `emergency_usage_threshold` (*Read-Only*) (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (*Read-Only*) (Number). Maintenance window autoscaling disk usage (percent).
- `environment` (*Read-Only*) (String). Deployment environment of the Redis cluster.
- `folder_id` (*Read-Only*) (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hosts` [Block]. A hosts of the Redis cluster as label:host_info pairs.
  - `assign_public_ip` (*Read-Only*) (Bool). Assign a public IP address to the host. Can be either true or false.
  - `fqdn` (*Read-Only*) (String). Fully Qualified Domain Name. In other words, hostname.
  - `replica_priority` (*Read-Only*) (Number). A replica with a low priority number is considered better for promotion.
  - `shard_name` (*Read-Only*) (String). Shard Name of the host in the cluster.
  - `subnet_id` (*Read-Only*) (String). ID of the subnet where the host is located.
  - `zone` (*Read-Only*) (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [Block]. Maintenance window settings of the Redis cluster.
  - `day` (*Read-Only*) (String). Day of week for maintenance window if window type is weekly.
  - `hour` (*Read-Only*) (Number). Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.
  - `type` (*Read-Only*) (String). Type of maintenance window.
- `modules` [Block]. Valkey modules.
  - `valkey_bloom` [Block]. Valkey bloom module settings.
    - `enabled` (*Read-Only*) (Bool). Enable Valkey bloom module.
  - `valkey_json` [Block]. Valkey json module settings.
    - `enabled` (*Read-Only*) (Bool). Enable Valkey json module.
  - `valkey_search` [Block]. Valkey search module settings.
    - `enabled` (*Read-Only*) (Bool). Enable Valkey search module.
    - `reader_threads` (*Read-Only*) (Number). Number of reader threads.
    - `writer_threads` (*Read-Only*) (Number). Number of writer threads.
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). The `VPC Network ID` of subnets which resource attached to.
- `persistence_mode` (*Read-Only*) (String). Persistence mode.
- `resources` [Block]. Resources allocated to hosts of the Redis cluster.
  - `disk_size` (*Read-Only*) (Number). Size of the disk in bytes.
  - `disk_type_id` (*Read-Only*) (String). ID of the disk type that determines the disk performance characteristics.
  - `resource_preset_id` (*Read-Only*) (String). ID of the resource preset that determines the number of CPU cores and memory size for the host.
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `sharded` (*Read-Only*) (Bool). Redis sharded mode. Can be either true or false.
- `timeouts` [Block]. 
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
- `tls_enabled` (*Read-Only*) (Bool). TLS port and functionality. Can be either true or false.


