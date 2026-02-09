---
subcategory: Managed Service for MySQL
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_mysql_cluster.md
---

# yandex_mdb_mysql_cluster (DataSource)

Get information about a Yandex Managed MySQL cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mysql/).

{% note warning %}

Either `cluster_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing MDB MySQL Cluster.
//
data "yandex_mdb_mysql_cluster" "my_cluster" {
  name = "test"
}

output "network_id" {
  value = data.yandex_mdb_mysql_cluster.my_cluster.network_id
}
```

## Arguments & Attributes Reference

- `backup_retain_period_days` (Number). The period in days during which backups are stored.
- `backup_window_start` [Block]. Time to start the daily backup, in the UTC.
  - `hours` (Number). The hour at which backup will be started (UTC).
  - `minutes` (Number). The minute at which backup will be started (UTC).
- `cluster_id` (String). The ID of the MySQL cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database` [Block]. To manage databases, please switch to using a separate resource type `yandex_mdb_mysql_databases`.
  - `name` (**Required**)(String). The name of the database.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption. Restoring without an encryption key will disable encryption if any exists.
- `disk_size_autoscaling` [Block]. Cluster disk size autoscaling settings.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `environment` (**Required**)(String). Deployment environment of the MySQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `host` [Block]. A host of the MySQL cluster.
  - `assign_public_ip` (Bool). Sets whether the host should get a public IP address. It can be changed on the fly only when `name` is set.
  - `backup_priority` (Number). Host backup priority. Value is between 0 and 100, default is 0.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `priority` (Number). Host master promotion priority. Value is between 0 and 100, default is 0.
  - `replication_source` (*Read-Only*) (String). Host replication source (fqdn), when replication_source is empty then host is in HA group.
  - `subnet_id` (String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `host_group_ids` (Set Of String). A list of host group IDs to place VMs of the cluster on.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [Block]. Maintenance policy of the MySQL cluster.
  - `day` (String). Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`
  - `hour` (Number). Hour of the day in UTC (in `HH` format). Allowed value is between 1 and 24.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `mysql_config` (Map Of String). MySQL cluster configuration. For detailed information specific to your MySQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/mysql/v1/config).
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `performance_diagnostics` [Block]. Cluster performance diagnostics settings. [YC Documentation](https://yandex.cloud/docs/managed-mysql/api-ref/grpc/cluster_service#PerformanceDiagnostics).
  - `enabled` (Bool). Enable performance diagnostics.
  - `sessions_sampling_interval` (**Required**)(Number). Interval (in seconds) for my_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
  - `statements_sampling_interval` (**Required**)(Number). Interval (in seconds) for my_stat_statements sampling Acceptable values are 1 to 86400, inclusive.
- `resources` [Block]. Resources allocated to hosts of the MySQL cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a MySQL host, in gigabytes.
  - `disk_type_id` (**Required**)(String). Type of the storage of MySQL hosts.
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a MySQL host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mysql/concepts/instance-types).
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the cluster.
- `user` [Block]. To manage users, please switch to using a separate resource type `yandex_mdb_mysql_user`.
  - `authentication_plugin` (String). Authentication plugin. Allowed values: `MYSQL_NATIVE_PASSWORD`, `CACHING_SHA2_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH` (for version 5.7 `MYSQL_NATIVE_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH`).
  - `connection_limits` [Block]. User's connection limits. If not specified there will be no changes. Default value is -1. When these parameters are set to -1, backend default values will be actually used.
    - `max_connections_per_hour` (Number). Max connections per hour.
    - `max_questions_per_hour` (Number). Max questions per hour.
    - `max_updates_per_hour` (Number). Max updates per hour.
    - `max_user_connections` (Number). Max user connections.
  - `global_permissions` (Set Of String). List user's global permissions. Allowed permissions: `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `PROCESS`, `FLUSH_OPTIMIZER_COSTS`, `SHOW_ROUTINE`, `MDB_ADMIN` for clear list use empty list. If the attribute is not specified there will be no changes.
  - `name` (**Required**)(String). The name of the user.
  - `password` (**Required**)(String). The password of the user.
  - `permission` [Block]. Set of permissions granted to the user.
    - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
    - `roles` (List Of String). List user's roles in the database. Allowed roles: `ALL`,`ALTER`,`ALTER_ROUTINE`,`CREATE`,`CREATE_ROUTINE`,`CREATE_TEMPORARY_TABLES`, `CREATE_VIEW`,`DELETE`,`DROP`,`EVENT`,`EXECUTE`,`INDEX`,`INSERT`,`LOCK_TABLES`,`SELECT`,`SHOW_VIEW`,`TRIGGER`,`UPDATE`,`REFERENCES`.
- `version` (**Required**)(String). Version of the MySQL cluster. (allowed versions are: 5.7, 8.0, 8.4).
- `access` [Block]. Access policy to the MySQL cluster.
  - `data_lens` (Bool). Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
  - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
  - `web_sql` (Bool). Allows access for [SQL queries in the management console](https://yandex.cloud/docs/managed-mysql/operations/web-sql-query).
  - `yandex_query` (Bool). Allow access for [YandexQuery](https://yandex.cloud/services/query).


