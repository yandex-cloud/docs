---
subcategory: Managed Service for PostgreSQL
---

# yandex_mdb_postgresql_cluster (DataSource)

Get information about a Yandex Managed PostgreSQL cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/). [How to connect to the DB](https://yandex.cloud/docs/managed-postgresql/quickstart#connect). To connect, use port 6432. The port number is not configurable.

{% note warning %}

Either `cluster_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing MDB PostgreSQL Cluster.
//
data "yandex_mdb_postgresql_cluster" "my_cluster" {
  name = "test"
}

output "fqdn" {
  value = data.yandex_mdb_postgresql_cluster.my_cluster.host.0.fqdn
}
```

## Arguments & Attributes Reference

- `cluster_id` (String). The ID of the PostgreSQL cluster.
- `config` (*Read-Only*) (List Of Object). Configuration of the PostgreSQL cluster.
  - `access` . 
    - `data_lens` . 
    - `data_transfer` . 
    - `serverless` . 
    - `web_sql` . 
    - `yandex_query` . 
  - `backup_retain_period_days` . 
  - `backup_window_start` . 
    - `hours` . 
    - `minutes` . 
  - `connection_manager` . 
    - `connections_folder_id` . 
    - `enabled` . 
    - `secrets_folder_id` . 
  - `disk_size_autoscaling` . 
    - `disk_size_limit` . 
    - `emergency_usage_threshold` . 
    - `planned_usage_threshold` . 
  - `managed_repack` . 
    - `enabled` . 
  - `performance_diagnostics` . 
    - `advanced_mode` . 
    - `enabled` . 
    - `sessions_sampling_interval` . 
    - `statements_sampling_interval` . 
  - `pooler_config` . 
    - `pool_discard` . 
    - `pooler_pool_discard` . 
    - `pooling_mode` . 
  - `postgresql_config` . 
  - `resources` . 
    - `disk_size` . 
    - `disk_type_id` . 
    - `resource_preset_id` . 
  - `version` . 
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database` (*Read-Only*) (Set Of Object). 

    {% note warning %}

    Deprecated! To manage databases, please switch to using a separate resource type `yandex_mdb_postgresql_database`.

    {% endnote %}
  - `extension` . 
    - `name` . 
    - `version` . 
  - `lc_collate` . 
  - `lc_type` . 
  - `name` . 
  - `owner` . 
  - `template_db` . 
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `disk_encryption_key_id` (*Read-Only*) (String). ID of the KMS key used for cluster disk encryption. Encryption can`t be disabled for an existing cluster. If the source cluster is encrypted and you leave this field empty when restoring, the restored cluster will be created without encryption.
- `environment` (*Read-Only*) (String). Deployment environment of the PostgreSQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `host` (*Read-Only*) (List Of Object). A host of the PostgreSQL cluster.
  - `assign_public_ip` . 
  - `fqdn` . 
  - `priority` . 
  - `replication_source` . 
  - `replication_source_name` . 
  - `role` . 
  - `subnet_id` . 
  - `zone` . 
- `host_group_ids` (*Read-Only*) (Set Of String). Host Group IDs.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` (*Read-Only*) (List Of Object). Maintenance policy of the PostgreSQL cluster.
  - `day` . 
  - `hour` . 
  - `type` . 
- `name` (String). The name of PostgreSQL cluster.
- `network_id` (*Read-Only*) (String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the cluster.
- `user` (*Read-Only*) (List Of Object). 

    {% note warning %}

    Deprecated! To manage users, please switch to using a separate resource type `yandex_mdb_postgresql_user`.

    {% endnote %}
  - `conn_limit` . 
  - `grants` . 
  - `login` . 
  - `name` . 
  - `permission` . 
    - `database_name` . 
  - `settings` .


