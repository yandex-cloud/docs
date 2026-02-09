---
subcategory: Managed Service for ValKey
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_redis_cluster_v2.md
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

- `access` [FW-Block]. Access policy to the Redis cluster.
  - `data_lens` (Bool). Allow access for Yandex DataLens. Can be either true or false.
  - `web_sql` (Bool). Allow access for SQL queries in the management console. Can be either true or false.
- `announce_hostnames` (Bool). Announce fqdn instead of ip address. Can be either true or false.
- `auth_sentinel` (Bool). Allows to use ACL users to auth in sentinel
- `cluster_id` (*Read-Only*) (String). ID of the Redis cluster. This ID is assigned by MDB at creation time.
- `config` [FW-Block]. Configuration of the Redis cluster.
  - `allow_data_loss` (Bool). Allows some data to be lost in favor of faster switchover/restart. Can be either true or false.
  - `backup_retain_period_days` (Number). Retain period of automatically created backup in days.
  - `backup_window_start` [FW-Block]. Time to start the daily backup, in the UTC timezone.
    - `hours` (**Required**)(Number). The hour at which backup will be started.
    - `minutes` (**Required**)(Number). The minute at which backup will be started.
  - `client_output_buffer_limit_normal` (String). Redis connection output buffers limits for clients.
  - `client_output_buffer_limit_pubsub` (String). Redis connection output buffers limits for pubsub operations.
  - `cluster_allow_pubsubshard_when_down` (Bool). Permits Pub/Sub shard operations when cluster is down. Can be either true or false.
  - `cluster_allow_reads_when_down` (Bool). Allows read operations when cluster is down. Can be either true or false.
  - `cluster_require_full_coverage` (Bool). Controls whether all hash slots must be covered by nodes. Can be either true or false.
  - `databases` (Number). Number of database buckets on a single redis-server process.
  - `io_threads_allowed` (Bool). Allow redis to use io-threads. Can be either true or false.
  - `lfu_decay_time` (Number). The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10).
  - `lfu_log_factor` (Number). Determines how the frequency counter represents key hits.
  - `lua_time_limit` (Number). Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism.
  - `maxmemory_percent` (Number). Redis maxmemory percent
  - `maxmemory_policy` (String). Redis key eviction policy for a dataset that reaches maximum memory, available to the host.
  - `notify_keyspace_events` (String). String setting for pub\sub functionality.
  - `password` (**Required**)(String). Authentication password.
  - `repl_backlog_size_percent` (Number). Replication backlog size as a percentage of flavor maxmemory.
  - `slowlog_log_slower_than` (Number). Threshold for logging slow requests to server in microseconds (log only slower than it).
  - `slowlog_max_len` (Number). Max slow requests number to log.
  - `timeout` (Number). Time that Redis keeps the connection open while the client is idle.
  - `turn_before_switchover` (Bool). Allows to turn before switchover in RDSync. Can be either true or false.
  - `use_luajit` (Bool). Use JIT for lua scripts and functions. Can be either true or false.
  - `version` (**Required**)(String). Redis version.
  - `zset_max_listpack_entries` (Number). Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the symmetric encryption key used to encrypt the disk of the cluster.
- `disk_size_autoscaling` [FW-Block]. Disk size autoscaling settings.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `environment` (**Required**)(String). Deployment environment of the Redis cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hosts` [FW-Block]. A hosts of the Redis cluster as label:host_info pairs.
  - `assign_public_ip` (Bool). Assign a public IP address to the host. Can be either true or false.
  - `fqdn` (*Read-Only*) (String). Fully Qualified Domain Name. In other words, hostname.
  - `replica_priority` (Number). A replica with a low priority number is considered better for promotion.
  - `shard_name` (String). Shard Name of the host in the cluster.
  - `subnet_id` (String). ID of the subnet where the host is located.
  - `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [FW-Block]. Maintenance window settings of the Redis cluster.
  - `day` (String). Day of week for maintenance window if window type is weekly.
  - `hour` (Number). Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.
  - `type` (**Required**)(String). Type of maintenance window.
- `modules` [FW-Block]. Valkey modules.
  - `valkey_bloom` [FW-Block]. Valkey bloom module settings.
    - `enabled` (Bool). Enable Valkey bloom module.
  - `valkey_json` [FW-Block]. Valkey json module settings.
    - `enabled` (Bool). Enable Valkey json module.
  - `valkey_search` [FW-Block]. Valkey search module settings.
    - `enabled` (Bool). Enable Valkey search module.
    - `reader_threads` (Number). Number of reader threads.
    - `writer_threads` (Number). Number of writer threads.
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `persistence_mode` (String). Persistence mode.
- `resources` [FW-Block]. Resources allocated to hosts of the Redis cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a host, in gigabytes.
  - `disk_type_id` (String). ID of the disk type that determines the disk performance characteristics.
  - `resource_preset_id` (**Required**)(String). ID of the resource preset that determines the number of CPU cores and memory size for the host.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `sharded` (Bool). Redis sharded mode. Can be either true or false.
- `tls_enabled` (Bool). TLS port and functionality. Can be either true or false.


