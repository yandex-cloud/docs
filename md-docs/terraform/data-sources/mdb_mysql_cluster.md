[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for MySQL > Data Sources > mdb_mysql_cluster

# yandex_mdb_mysql_cluster (DataSource)

Get information about a Yandex Managed MySQL cluster. For more information, see [the official documentation](../../managed-mysql/index.md).

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

- `backup_retain_period_days` (*Read-Only*) (Number). The period in days during which backups are stored.
- `backup_window_start` (*Read-Only*) (List Of Object). Time to start the daily backup, in the UTC.
  - `hours` . 
  - `minutes` . 
- `cluster_id` (String). The ID of the MySQL cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database` (*Read-Only*) (Set Of Object). To manage databases, please switch to using a separate resource type `yandex_mdb_mysql_databases`.
  - `name` . 
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption. Restoring without an encryption key will disable encryption if any exists.
- `disk_size_autoscaling` (*Read-Only*) (List Of Object). Cluster disk size autoscaling settings.
  - `disk_size_limit` . 
  - `emergency_usage_threshold` . 
  - `planned_usage_threshold` . 
- `environment` (*Read-Only*) (String). Deployment environment of the MySQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `host` (*Read-Only*) (List Of Object). A host of the MySQL cluster.
  - `assign_public_ip` . 
  - `backup_priority` . 
  - `fqdn` . 
  - `priority` . 
  - `replication_source` . 
  - `subnet_id` . 
  - `zone` . 
- `host_group_ids` (*Read-Only*) (Set Of String). A list of host group IDs to place VMs of the cluster on.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` (*Read-Only*) (List Of Object). Maintenance policy of the MySQL cluster.
  - `day` . 
  - `hour` . 
  - `type` . 
- `mysql_config` (Map Of String). MySQL cluster configuration. For detailed information specific to your MySQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/mysql/v1/config).
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). The `VPC Network ID` of subnets which resource attached to.
- `performance_diagnostics` (*Read-Only*) (List Of Object). Cluster performance diagnostics settings. [YC Documentation](../../managed-mysql/api-ref/grpc/cluster_service#PerformanceDiagnostics).
  - `enabled` . 
  - `sessions_sampling_interval` . 
  - `statements_sampling_interval` . 
- `resources` (*Read-Only*) (List Of Object). Resources allocated to hosts of the MySQL cluster.
  - `disk_size` . 
  - `disk_type_id` . 
  - `resource_preset_id` . 
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the cluster.
- `user` (*Read-Only*) (List Of Object). To manage users, please switch to using a separate resource type `yandex_mdb_mysql_user`.
  - `authentication_plugin` . 
  - `connection_limits` . 
    - `max_connections_per_hour` . 
    - `max_questions_per_hour` . 
    - `max_updates_per_hour` . 
    - `max_user_connections` . 
  - `global_permissions` . 
  - `name` . 
  - `password` . 
  - `permission` . 
    - `database_name` . 
    - `roles` . 
- `version` (*Read-Only*) (String). Version of the MySQL cluster. (allowed versions are: 5.7, 8.0, 8.4).
- `access` [Block]. Access policy to the MySQL cluster.
  - `data_lens` (Bool). Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
  - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
  - `web_sql` (Bool). Allows access for [SQL queries in the management console](../../managed-mysql/operations/web-sql-query.md).
  - `yandex_query` (Bool). Allow access for [YandexQuery](https://yandex.cloud/services/query).