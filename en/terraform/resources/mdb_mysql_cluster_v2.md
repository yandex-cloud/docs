---
subcategory: Managed Service for MySQL
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_mysql_cluster_v2.md
---

# yandex_mdb_mysql_cluster_v2 (Resource)

Manages a MySQL cluster within the Yandex Cloud. For more information, see [the official documentation](https://cloud.yandex.com/docs/managed-mysql/). [How to connect to the DB](https://yandex.cloud/docs/managed-mysql/quickstart#connect). To connect, use port 6432. The port number is not configurable.

## Example usage

```terraform
//
// Create a new MDB MySQL Cluster (v2).
//

resource "yandex_mdb_mysql_cluster_v2" "cluster" {
  name        = "mysql-cluster"
  description = "MySQL Test Cluster"
  network_id  = yandex_vpc_network.mdb-pg-test-net.id
  environment = "PRODUCTION"

  labels = {
    "key1" = "value1"
    "key2" = "value2"
    "key3" = "value3"
  }

  hosts = {
    "host" = {
      zone             = "ru-central1-a"
      subnet_id        = yandex_vpc_subnet.mdb-pg-test-subnet-a.id
      assign_public_ip = false
    }
  }

  version = "8.0"
  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  performance_diagnostics = {
    sessions_sampling_interval   = 60
    statements_sampling_interval = 600
  }

  access = {
    web_sql       = true
    data_transfer = true
    data_lens     = true
    yandex_query  = true
  }

  maintenance_window = {
    type = "WEEKLY"
    day  = "MON"
    hour = 3
  }

  backup_window_start = {
    hours   = 5
    minutes = 5
  }

  backup_retain_period_days = 8
  deletion_protection       = true
}

// Auxiliary resources
resource "yandex_vpc_network" "test-net" {}

resource "yandex_vpc_subnet" "test-subnet" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.mdb-pg-test-net.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_security_group" "test-sgroup" {
  description = "Test security group"
  network_id  = yandex_vpc_network.mdb-pg-test-net.id
}
```

## Arguments & Attributes Reference

- `access` [FW-Block]. Access policy to the MySQL cluster.
  - `data_lens` (Bool). Allow access for Yandex DataLens.
  - `data_transfer` (Bool). Allow access for DataTransfer
  - `web_sql` (Bool). Allow access for SQL queries in the management console
  - `yandex_query` (Bool). Allow access for YandexQuery
- `backup_retain_period_days` (Number). The period in days during which backups are stored.
- `backup_window_start` [FW-Block]. Time to start the daily backup, in the UTC timezone.
  - `hours` (Number). The hour at which backup will be started (UTC).
  - `minutes` (Number). The minute at which backup will be started (UTC).
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). Description of the MySQL cluster.
- `disk_encryption_key_id` (String). ID of the symmetric encryption key used to encrypt the disk of the cluster.
- `disk_size_autoscaling` [FW-Block]. Cluster disk size autoscaling settings.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `environment` (**Required**)(String). Deployment environment of the MySQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hosts` [FW-Block]. A host configuration of the MySQL cluster.
  - `assign_public_ip` (Bool). Assign a public IP address to the host.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `replication_source` (String). FQDN of the host that is used as a replication source.
  - `subnet_id` (String). ID of the subnet where the host is located.
  - `zone` (**Required**)(String). The availability zone where the host is located.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [FW-Block]. Maintenance policy of the MySQL cluster.
  - `day` (String). Day of the week (in DDD format). Allowed values: "MON", "TUE", "WED", "THU", "FRI", "SAT","SUN"
  - `hour` (Number). Hour of the day in UTC (in HH format). Allowed value is between 1 and 24.
  - `type` (String). Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window.
- `mysql_config` (Map Of String). MySQL cluster configuration. For detailed information specific to your MySQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/mysql/v1/config).
- `name` (**Required**)(String). Name of the MySQL cluster. Provided by the client when the cluster is created.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `performance_diagnostics` [FW-Block]. Cluster performance diagnostics settings. The structure is documented below.
  - `enabled` (Bool). Enable performance diagnostics
  - `sessions_sampling_interval` (**Required**)(Number). Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
  - `statements_sampling_interval` (**Required**)(Number). Interval (in seconds) for pg_stat_statements sampling Acceptable values are 60 to 86400, inclusive.
- `restore` [FW-Block]. The cluster will be created from the specified backup.
  - `backup_id` (**Required**)(String). Backup ID. The cluster will be created from the specified backup. [How to get a list of MySQL backups](https://yandex.cloud/docs/managed-mysql/operations/cluster-backups).
  - `time` (String). Timestamp of the moment to which the MySQL cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `version` (**Required**)(String). Version of the MySQL cluster.
- `resources` [Block]. Resources allocated to hosts of the MySQL cluster.
  - `disk_size` (**Required**)(Number). Size of the disk in bytes.
  - `disk_type_id` (**Required**)(String). ID of the disk type that determines the disk performance characteristics.
  - `resource_preset_id` (**Required**)(String). ID of the resource preset that determines the number of CPU cores and memory size for the host.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mysql_cluster_v2.<resource Name> <resource Id>
terraform import yandex_mdb_mysql_cluster_v2.my_v2_cluster ...
```
