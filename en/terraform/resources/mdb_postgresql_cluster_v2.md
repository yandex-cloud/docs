---
subcategory: Managed Service for PostgreSQL
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_postgresql_cluster_v2.md
---

# yandex_mdb_postgresql_cluster_v2 (Resource)

Manages a PostgreSQL cluster within the Yandex Cloud. For more information, see [the official documentation](https://cloud.yandex.com/docs/managed-postgresql/). [How to connect to the DB](https://yandex.cloud/docs/managed-postgresql/quickstart#connect). To connect, use port 6432. The port number is not configurable.

## Example usage

```terraform
//
// Create a new MDB PostgreSQL Cluster (v2).
//
resource "yandex_mdb_postgresql_cluster_v2" "my_v2_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 17
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
    postgresql_config = {
      max_connections                = 395
      enable_parallel_hash           = true
      autovacuum_vacuum_scale_factor = 0.34
      default_transaction_isolation  = "TRANSACTION_ISOLATION_READ_COMMITTED"
      shared_preload_libraries       = "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN,SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN"
    }
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  hosts = {
    "host1d" = {
      zone      = "ru-central1-d"
      subnet_id = yandex_vpc_subnet.foo.id
    }
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

## Arguments & Attributes Reference

- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). Description of the PostgreSQL cluster.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption.
- `environment` (**Required**)(String). Deployment environment of the PostgreSQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hosts` [Block]. A host configuration of the PostgreSQL cluster.
  - `assign_public_ip` (Bool). Whether the host should get a public IP address.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `replication_source` (String). FQDN of the host that is used as a replication source.
  - `subnet_id` (String). ID of the subnet where the host is located.
  - `zone` (**Required**)(String). The availability zone where the host is located.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [Block]. Maintenance policy of the PostgreSQL cluster.
  - `day` (String). Day of the week (in DDD format). Allowed values: "MON", "TUE", "WED", "THU", "FRI", "SAT","SUN"
  - `hour` (Number). Hour of the day in UTC (in HH format). Allowed value is between 1 and 24.
  - `type` (String). Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window.
- `name` (**Required**)(String). Name of the PostgreSQL cluster. Provided by the client when the cluster is created.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `restore` [Block]. The cluster will be created from the specified backup.
  - `backup_id` (**Required**)(String). Backup ID. The cluster will be created from the specified backup. [How to get a list of PostgreSQL backups](https://yandex.cloud/docs/managed-postgresql/operations/cluster-backups).
  - `time` (String). Timestamp of the moment to which the PostgreSQL cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.
  - `time_inclusive` (Bool). Flag that indicates whether a database should be restored to the first backup point available just after the timestamp specified in the [time] field instead of just before. Possible values:
* `false` (default) — the restore point refers to the first backup moment before [time].
* `true` — the restore point refers to the first backup point after [time].
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `config` [Block]. Configuration of the PostgreSQL cluster.
  - `access` [Block]. Access policy to the PostgreSQL cluster.
    - `data_lens` (Bool). Allow access for Yandex DataLens.
    - `data_transfer` (Bool). Allow access for DataTransfer
    - `serverless` (Bool). Allow access for connection to managed databases from functions
    - `web_sql` (Bool). Allow access for SQL queries in the management console
    - `yandex_query` (Bool). Allow access for YandexQuery
  - `autofailover` (Bool). Configuration setting which enables/disables automatic failover in the cluster.
  - `backup_retain_period_days` (Number). The period in days during which backups are stored.
  - `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
    - `hours` (Number). The hour at which backup will be started (UTC).
    - `minutes` (Number). The minute at which backup will be started.
  - `disk_size_autoscaling` [Block]. Cluster disk size autoscaling settings.
    - `disk_size_limit` (**Required**)(Number). The overall maximum for disk size that limit all autoscaling iterations. See the [documentation](https://yandex.cloud/en/docs/managed-postgresql/concepts/storage#auto-rescale) for details.
    - `emergency_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
    - `planned_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
  - `performance_diagnostics` [Block]. Cluster performance diagnostics settings. The structure is documented below.
    - `enabled` (Bool). Enable performance diagnostics
    - `sessions_sampling_interval` (**Required**)(Number). Interval (in seconds) for pg_stat_activity sampling. Acceptable values are 1 to 86400, inclusive.
    - `statements_sampling_interval` (**Required**)(Number). Interval (in seconds) for pg_stat_statements sampling. Acceptable values are 60 to 86400, inclusive.
  - `pooler_config` [Block]. Configuration of the connection pooler.
    - `pool_discard` (Bool). Setting pool_discard parameter in Odyssey.
    - `pooling_mode` (String). Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for Odyssey](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string.)
  - `postgresql_config` (Map Of String). PostgreSQL cluster configuration. For detailed information specific to your PostgreSQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/postgresql/v1/config).
  - `version` (**Required**)(String). Version of the PostgreSQL cluster.
  - `resources` [Block]. Resources allocated to hosts of the PostgreSQL cluster.
    - `disk_size` (**Required**)(Number). Size of the disk in bytes.
    - `disk_type_id` (**Required**)(String). ID of the disk type that determines the disk performance characteristics.
    - `resource_preset_id` (**Required**)(String). ID of the resource preset that determines the number of CPU cores and memory size for the host.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_postgresql_cluster_v2.<resource Name> <resource Id>
terraform import yandex_mdb_postgresql_cluster_v2.my_v2_cluster ...
```
