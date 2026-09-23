[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for Greenplum® > Data Sources > mdb_greenplum_cluster

# yandex_mdb_greenplum_cluster (DataSource)

Get information about a Yandex Managed Greenplum cluster. For more information, see [the official documentation](../../managed-greenplum/index.md).

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

- `access` (*Read-Only*) (List Of Object). 
  - `data_lens` . 
  - `data_transfer` . 
  - `web_sql` . 
  - `yandex_query` . 
- `assign_public_ip` (*Read-Only*) (Bool). Sets whether the master hosts should get a public IP address on creation. Changing this parameter for an existing host is not supported at the moment.
- `backup_window_start` (*Read-Only*) (List Of Object). 
  - `hours` . 
  - `minutes` . 
- `cloud_storage` (*Read-Only*) (List Of Object). 
  - `enable` . 
- `cluster_id` (String). The ID of the Greenplum cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `environment` (*Read-Only*) (String). Deployment environment of the Greenplum cluster. (PRODUCTION, PRESTABLE)
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `greenplum_config` (Map Of String). 
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `logging` (*Read-Only*) (List Of Object). 
  - `command_center_enabled` . 
  - `enabled` . 
  - `folder_id` . 
  - `greenplum_enabled` . 
  - `log_group_id` . 
  - `pooler_enabled` . 
- `maintenance_window` (*Read-Only*) (List Of Object). 
  - `day` . 
  - `hour` . 
  - `type` . 
- `master_host_count` (*Read-Only*) (Number). Number of hosts in master subcluster (1 or 2).
- `master_host_group_ids` (Set Of String). A list of IDs of the host groups to place master subclusters' VMs of the cluster on.
- `master_hosts` (*Read-Only*) (List Of Object). 
  - `assign_public_ip` . 
  - `fqdn` . 
- `master_subcluster` (*Read-Only*) (List Of Object). 
  - `resources` . 
    - `disk_size` . 
    - `disk_type_id` . 
    - `resource_preset_id` . 
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `segment_host_count` (*Read-Only*) (Number). Number of hosts in segment subcluster (from 1 to 32).
- `segment_host_group_ids` (Set Of String). A list of IDs of the host groups to place segment subclusters' VMs of the cluster on.
- `segment_hosts` (*Read-Only*) (List Of Object). 
  - `fqdn` . 
- `segment_in_host` (*Read-Only*) (Number). Number of segments on segment host (not more then 1 + RAM/8).
- `segment_subcluster` (*Read-Only*) (List Of Object). 
  - `resources` . 
    - `disk_size` . 
    - `disk_type_id` . 
    - `resource_preset_id` . 
- `service_account_id` (*Read-Only*) (String). ID of service account to use with Yandex Cloud resources (e.g. S3, Cloud Logging).
- `status` (*Read-Only*) (String). Status of the cluster.
- `subnet_id` (*Read-Only*) (String). The ID of the subnet, to which the hosts belongs. The subnet must be a part of the network to which the cluster belongs.
- `user_name` (*Read-Only*) (String). Greenplum cluster admin user name.
- `version` (*Read-Only*) (String). Version of the Greenplum cluster.
- `zone` (*Read-Only*) (String). The [availability zone](../../overview/concepts/geo-scope.md) where resource is located. If it is not provided, the default provider zone will be used.
- `background_activities` [Block]. 
  - `analyze_and_vacuum` [Block]. 
    - `analyze_timeout` (Number). 
    - `start_time` (String). 
    - `vacuum_timeout` (Number). 
  - `query_killer_idle` [Block]. 
    - `enable` (Bool). 
    - `ignore_users` (List Of String). 
    - `max_age` (Number). 
  - `query_killer_idle_in_transaction` [Block]. 
    - `enable` (Bool). 
    - `ignore_users` (List Of String). 
    - `max_age` (Number). 
  - `query_killer_long_running` [Block]. 
    - `enable` (Bool). 
    - `ignore_users` (List Of String). 
    - `max_age` (Number). 
- `pooler_config` [Block]. 
  - `pool_client_idle_timeout` (Number). 
  - `pool_idle_in_transaction_timeout` (Number). 
  - `pool_size` (Number). 
  - `pooling_mode` (String). 
- `pxf_config` [Block]. 
  - `connection_timeout` (Number). 
  - `max_threads` (Number). 
  - `pool_allow_core_thread_timeout` (Bool). 
  - `pool_core_size` (Number). 
  - `pool_max_size` (Number). 
  - `pool_queue_capacity` (Number). 
  - `upload_timeout` (Number). 
  - `xms` (Number). 
  - `xmx` (Number).