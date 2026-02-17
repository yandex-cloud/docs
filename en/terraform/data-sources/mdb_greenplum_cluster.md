---
subcategory: Managed Service for Greenplum®
---

# yandex_mdb_greenplum_cluster (DataSource)

Get information about a Yandex Managed Greenplum cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-greenplum/).

{% note warning %}

Either `cluster_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing MDB Greenplum Cluster.
//
data "yandex_mdb_greenplum_cluster" "foo" {
  name = "test"
}

output "network_id" {
  value = data.yandex_mdb_greenplum_cluster.foo.network_id
}
```

## Arguments & Attributes Reference

- `access` [Block]. Access policy to the Greenplum cluster.
  - `data_lens` (Bool). Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
  - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer)
  - `web_sql` (Bool). Allows access for [SQL queries in the management console](https://yandex.cloud/docs/managed-mysql/operations/web-sql-query).
  - `yandex_query` (Bool). Allow access for [Yandex Query](https://yandex.cloud/services/query)
- `assign_public_ip` (**Required**)(Bool). Sets whether the master hosts should get a public IP address on creation. Changing this parameter for an existing host is not supported at the moment.
- `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
  - `hours` (Number). The hour at which backup will be started (UTC).
  - `minutes` (Number). The minute at which backup will be started (UTC).
- `cloud_storage` [Block]. Cloud Storage settings of the Greenplum cluster.
  - `enable` (Bool). Whether to use cloud storage or not.
- `cluster_id` (String). The ID of the Greenplum cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `environment` (**Required**)(String). Deployment environment of the Greenplum cluster. (PRODUCTION, PRESTABLE)
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `greenplum_config` (Map Of String). Greenplum cluster config. Detail info in `Greenplum cluster settings` block.
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `logging` [Block]. Cloud Logging settings.
  - `command_center_enabled` (Bool). Deliver Yandex Command Center's logs to Cloud Logging.
  - `enabled` (Bool). Flag that indicates whether log delivery to Cloud Logging is enabled.
  - `folder_id` (String). ID of folder to which deliver logs.
  - `greenplum_enabled` (Bool). Deliver Greenplum's logs to Cloud Logging.
  - `log_group_id` (String). Cloud Logging group ID to send logs to.
  - `pooler_enabled` (Bool). Deliver connection pooler's logs to Cloud Logging.
- `maintenance_window` [Block]. Maintenance policy of the Greenplum cluster.
  - `day` (String). Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
  - `hour` (Number). Hour of the day in UTC (in `HH` format). Allowed value is between 0 and 23.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `master_host_count` (**Required**)(Number). Number of hosts in master subcluster (1 or 2).
- `master_host_group_ids` (Set Of String). A list of IDs of the host groups to place master subclusters' VMs of the cluster on.
- `master_hosts` (*Read-Only*) (List Of Object). Info about hosts in master subcluster.
  - `assign_public_ip` . 
  - `fqdn` . 
- `master_subcluster` [Block]. Settings for master subcluster.
  - `resources` [Block]. Resources allocated to hosts for master subcluster of the Greenplum cluster.
    - `disk_size` (**Required**)(Number). Volume of the storage available to a host, in gigabytes.
    - `disk_type_id` (**Required**)(String). Type of the storage of Greenplum hosts - environment default is used if missing.
    - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/ru/docs/managed-greenplum/concepts/instance-types).
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `segment_host_count` (**Required**)(Number). Number of hosts in segment subcluster (from 1 to 32).
- `segment_host_group_ids` (Set Of String). A list of IDs of the host groups to place segment subclusters' VMs of the cluster on.
- `segment_hosts` (*Read-Only*) (List Of Object). Info about hosts in segment subcluster.
  - `fqdn` . 
- `segment_in_host` (**Required**)(Number). Number of segments on segment host (not more then 1 + RAM/8).
- `segment_subcluster` [Block]. Settings for segment subcluster.
  - `resources` [Block]. Resources allocated to hosts for segment subcluster of the Greenplum cluster.
    - `disk_size` (**Required**)(Number). Volume of the storage available to a host, in gigabytes.
    - `disk_type_id` (**Required**)(String). Type of the storage of Greenplum hosts - environment default is used if missing.
    - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/ru/docs/managed-greenplum/concepts/instance-types).
- `service_account_id` (String). ID of service account to use with Yandex Cloud resources (e.g. S3, Cloud Logging).
- `status` (*Read-Only*) (String). Status of the cluster.
- `subnet_id` (**Required**)(String). The ID of the subnet, to which the hosts belongs. The subnet must be a part of the network to which the cluster belongs.
- `user_name` (**Required**)(String). Greenplum cluster admin user name.
- `version` (**Required**)(String). Version of the Greenplum cluster. (`6.28`)
- `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `background_activities` [Block]. Background activities settings.
  - `analyze_and_vacuum` [Block]. Block to configure 'ANALYZE' and 'VACUUM' daily operations.
    - `analyze_timeout` (Number). Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate.
    - `start_time` (String). Time of day in 'HH:MM' format when scripts should run.
    - `vacuum_timeout` (Number). Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate.
  - `query_killer_idle` [Block]. Block to configure script that kills long running queries that are in `idle` state.
    - `enable` (Bool). Flag that indicates whether script is enabled.
    - `ignore_users` (List Of String). List of users to ignore when considering queries to terminate.
    - `max_age` (Number). Maximum duration for this type of queries (in seconds).
  - `query_killer_idle_in_transaction` [Block]. Block to configure script that kills long running queries that are in `idle in transaction` state.
    - `enable` (Bool). Flag that indicates whether script is enabled.
    - `ignore_users` (List Of String). List of users to ignore when considering queries to terminate.
    - `max_age` (Number). Maximum duration for this type of queries (in seconds).
  - `query_killer_long_running` [Block]. Block to configure script that kills long running queries (in any state).
    - `enable` (Bool). Flag that indicates whether script is enabled.
    - `ignore_users` (List Of String). List of users to ignore when considering queries to terminate.
    - `max_age` (Number). Maximum duration for this type of queries (in seconds).
- `pooler_config` [Block]. Configuration of the connection pooler.
  - `pool_client_idle_timeout` (Number). Value for `pool_client_idle_timeout` [parameter in Odyssey](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_client_idle_timeout).
  - `pool_idle_in_transaction_timeout` (Number). Value for `pool_idle_in_transaction_timeout` [parameter in Odyssey](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_idle_in_transaction_timeout).
  - `pool_size` (Number). Value for `pool_size` [parameter in Odyssey](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_size).
  - `pooling_mode` (String). Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for Odyssey](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool).
- `pxf_config` [Block]. Configuration of the PXF daemon.
  - `connection_timeout` (Number). The Tomcat server connection timeout for read operations in seconds. Value is between 5 and 600.
  - `max_threads` (Number). The maximum number of PXF tomcat threads. Value is between 1 and 1024.
  - `pool_allow_core_thread_timeout` (Bool). Identifies whether or not core streaming threads are allowed to time out.
  - `pool_core_size` (Number). The number of core streaming threads. Value is between 1 and 1024.
  - `pool_max_size` (Number). The maximum allowed number of core streaming threads. Value is between 1 and 1024.
  - `pool_queue_capacity` (Number). The capacity of the core streaming thread pool queue. Value is positive.
  - `upload_timeout` (Number). The Tomcat server connection timeout for write operations in seconds. Value is between 5 and 600.
  - `xms` (Number). Maximum JVM heap size for PXF daemon. Value is between 64 and 16384.
  - `xmx` (Number). Initial JVM heap size for PXF daemon. Value is between 64 and 16384.


