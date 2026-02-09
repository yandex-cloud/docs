---
subcategory: Managed Service for ValKey
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_redis_cluster.md
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

- `announce_hostnames` (Bool). Announce fqdn instead of ip address.
- `auth_sentinel` (Bool). Allows to use ACL users to auth in sentinel
- `cluster_id` (String). The ID of the Redis cluster.
- `config` [Block]. Configuration of the Redis cluster.
  - `allow_data_loss` (Bool). Allows some data to be lost in favor of faster switchover/restart by RDSync.
  - `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
    - `hours` (Number). The hour at which backup will be started.
    - `minutes` (Number). The minute at which backup will be started.
  - `client_output_buffer_limit_normal` (String). Normal clients output buffer limits. See [redis config file](https://github.com/redis/redis/blob/6.2/redis.conf#L1841).
  - `client_output_buffer_limit_pubsub` (String). Pubsub clients output buffer limits. See [redis config file](https://github.com/redis/redis/blob/6.2/redis.conf#L1843).
  - `cluster_allow_pubsubshard_when_down` (Bool). Permits Pub/Sub shard operations when cluster is down.
  - `cluster_allow_reads_when_down` (Bool). Allows read operations when cluster is down.
  - `cluster_require_full_coverage` (Bool). Controls whether all hash slots must be covered by nodes.
  - `databases` (Number). Number of databases (changing requires redis-server restart).
  - `io_threads_allowed` (Bool). Allow Redis to use io-threads.
  - `lfu_decay_time` (Number). The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10).
  - `lfu_log_factor` (Number). Determines how the frequency counter represents key hits.
  - `lua_time_limit` (Number). Maximum time in milliseconds for Lua scripts.
  - `maxmemory_percent` (Number). Redis maxmemory usage in percent
  - `maxmemory_policy` (String). Redis key eviction policy for a dataset that reaches maximum memory. Can be any of the listed in [the official RedisDB documentation](https://docs.redislabs.com/latest/rs/administering/database-operations/eviction-policy/).
  - `notify_keyspace_events` (String). Select the events that Redis will notify among a set of classes.
  - `repl_backlog_size_percent` (Number). Replication backlog size as a percentage of flavor maxmemory.
  - `slowlog_log_slower_than` (Number). Log slow queries below this number in microseconds.
  - `slowlog_max_len` (Number). Slow queries log length.
  - `timeout` (Number). Close the connection after a client is idle for N seconds.
  - `turn_before_switchover` (Bool). Allows to turn before switchover in RDSync.
  - `use_luajit` (Bool). Use JIT for lua scripts and functions.
  - `version` (**Required**)(String). Version of Redis.
  - `zset_max_listpack_entries` (Number). Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption.
- `disk_size_autoscaling` [Block]. Disk size autoscaling settings.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `environment` (**Required**)(String). Deployment environment of the Redis cluster. Can be either `PRESTABLE` or `PRODUCTION`.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster. Can be either `ALIVE`, `DEGRADED`, `DEAD` or `HEALTH_UNKNOWN`. For more information see `health` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-redis/api-ref/Cluster/).
- `host` [Block]. A host of the Redis cluster.
  - `assign_public_ip` (Bool). Sets whether the host should get a public IP address or not.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `replica_priority` (Number). Replica priority of a current replica (usable for non-sharded only).
  - `shard_name` (String). The name of the shard to which the host belongs.
  - `subnet_id` (String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [Block]. Maintenance window settings.
  - `day` (String). Day of week for maintenance window if window type is weekly. Possible values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
  - `hour` (Number). Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `persistence_mode` (String). Persistence mode. Possible values: `ON`, `OFF`.
- `resources` [Block]. Resources allocated to hosts of the Redis cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a host, in gigabytes.
  - `disk_type_id` (String). Type of the storage of Redis hosts - environment default is used if missing.
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-redis/concepts).
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `sharded` (Bool). Redis Cluster mode enabled/disabled. Enables sharding when cluster non-sharded. If cluster is sharded - disabling is not allowed.
- `status` (*Read-Only*) (String). Status of the cluster. Can be either `CREATING`, `STARTING`, `RUNNING`, `UPDATING`, `STOPPING`, `STOPPED`, `ERROR` or `STATUS_UNKNOWN`. For more information see `status` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-redis/api-ref/Cluster/).
- `tls_enabled` (Bool). TLS support mode enabled/disabled.


