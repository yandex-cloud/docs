---
subcategory: Managed Service for MySQL
---

# yandex_mdb_mysql_cluster (Resource)

Manages a MySQL cluster within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mysql/).

## Example usage

```terraform
//
// Create a new MDB MySQL Cluster.
//
resource "yandex_mdb_mysql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true

  }

  host {
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.foo.id
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
```terraform
//
// Create a new MDB High Availability MySQL Cluster.
//
resource "yandex_mdb_mysql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.foo.id
  }

  host {
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.bar.id
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "bar" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}
```
```terraform
//
// Create a new MDB HA MySQL Cluster with cascade replicas.
//
resource "yandex_mdb_mysql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = "ru-central1-b"
    name      = "na-1"
    subnet_id = yandex_vpc_subnet.foo.id
  }
  host {
    zone      = "ru-central1-d"
    name      = "na-2"
    subnet_id = yandex_vpc_subnet.foo.id
  }
  host {
    zone                    = "ru-central1-b"
    name                    = "nb-1"
    replication_source_name = "na-1"
    subnet_id               = yandex_vpc_subnet.bar.id
  }
  host {
    zone                    = "ru-central1-d"
    name                    = "nb-2"
    replication_source_name = "nb-1"
    subnet_id               = yandex_vpc_subnet.bar.id
  }

}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "bar" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}
```
```terraform
//
// Create a new MDB MySQL Cluster with different backup priorities.
//
resource "yandex_mdb_mysql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = "ru-central1-b"
    name      = "na-1"
    subnet_id = yandex_vpc_subnet.foo.id
  }
  host {
    zone            = "ru-central1-d"
    name            = "nb-1"
    backup_priority = 5
    subnet_id       = yandex_vpc_subnet.bar.id
  }
  host {
    zone            = "ru-central1-d"
    name            = "nb-2"
    backup_priority = 10
    subnet_id       = yandex_vpc_subnet.bar.id
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "bar" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}
```
```terraform
//
// Create a new MDB MySQL Cluster with different host priorities.
//
resource "yandex_mdb_mysql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = "ru-central1-b"
    name      = "na-1"
    subnet_id = yandex_vpc_subnet.foo.id
  }
  host {
    zone      = "ru-central1-d"
    name      = "nb-1"
    priority  = 5
    subnet_id = yandex_vpc_subnet.bar.id
  }
  host {
    zone      = "ru-central1-d"
    name      = "nb-2"
    priority  = 10
    subnet_id = yandex_vpc_subnet.bar.id
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "bar" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}
```
```terraform
//
// Create a new MDB MySQL Cluster with user's params.
//
resource "yandex_mdb_mysql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  maintenance_window {
    type = "ANYTIME"
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.foo.id
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

## Arguments & Attributes Reference

- `allow_regeneration_host` (Bool). Deprecated field. You can safely remove this option. There is no need to recreate host if assign_public_ip is changed.
Regenerate hosts after changing the assign_public_ip parameter.
- `backup_retain_period_days` (Number). The period in days during which backups are stored.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption. Restoring without an encryption key will disable encryption if any exists.
- `environment` (**Required**)(String). Deployment environment of the MySQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `host_group_ids` (Set Of String). A list of host group IDs to place VMs of the cluster on.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `mysql_config` (Map Of String). MySQL cluster configuration. For detailed information specific to your MySQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/mysql/v1/config).
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the cluster.
- `version` (**Required**)(String). Version of the MySQL cluster. (allowed versions are: 5.7, 8.0, 8.4).
- `access` [Block]. Access policy to the MySQL cluster.
  - `data_lens` (Bool). Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
  - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
  - `web_sql` (Bool). Allows access for [SQL queries in the management console](https://yandex.cloud/docs/managed-mysql/operations/web-sql-query).
  - `yandex_query` (Bool). Allow access for [YandexQuery](https://yandex.cloud/services/query).
- `backup_window_start` [Block]. Time to start the daily backup, in the UTC.
  - `hours` (Number). The hour at which backup will be started (UTC).
  - `minutes` (Number). The minute at which backup will be started (UTC).
- `database` [Block]. To manage databases, please switch to using a separate resource type `yandex_mdb_mysql_databases`.
  - `name` (**Required**)(String). The name of the database.
- `disk_size_autoscaling` [Block]. Cluster disk size autoscaling settings.
  - `disk_size_limit` (**Required**)(Number). Limit of disk size after autoscaling (GiB).
  - `emergency_usage_threshold` (Number). Immediate autoscaling disk usage (percent).
  - `planned_usage_threshold` (Number). Maintenance window autoscaling disk usage (percent).
- `host` [Block]. A host of the MySQL cluster.
  - `assign_public_ip` (Bool). Sets whether the host should get a public IP address. It can be changed on the fly only when `name` is set.
  - `backup_priority` (Number). Host backup priority. Value is between 0 and 100, default is 0.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `name` (String). Host state name. It should be set for all hosts or unset for all hosts. This field can be used by another host, to select which host will be its replication source. Please refer to `replication_source_name` parameter.
  - `priority` (Number). Host master promotion priority. Value is between 0 and 100, default is 0.
  - `replication_source` (*Read-Only*) (String). Host replication source (fqdn), when replication_source is empty then host is in HA group.
  - `replication_source_name` (String). Host replication source name points to host's `name` from which this host should replicate. When not set then host in HA group. It works only when `name` is set.
  - `subnet_id` (String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `maintenance_window` [Block]. Maintenance policy of the MySQL cluster.
  - `day` (String). Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`
  - `hour` (Number). Hour of the day in UTC (in `HH` format). Allowed value is between 1 and 24.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `performance_diagnostics` [Block]. Cluster performance diagnostics settings. [YC Documentation](https://yandex.cloud/docs/managed-mysql/api-ref/grpc/cluster_service#PerformanceDiagnostics).
  - `enabled` (Bool). Enable performance diagnostics.
  - `sessions_sampling_interval` (**Required**)(Number). Interval (in seconds) for my_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
  - `statements_sampling_interval` (**Required**)(Number). Interval (in seconds) for my_stat_statements sampling Acceptable values are 1 to 86400, inclusive.
- `resources` [Block]. Resources allocated to hosts of the MySQL cluster.
  - `disk_size` (**Required**)(Number). Volume of the storage available to a MySQL host, in gigabytes.
  - `disk_type_id` (**Required**)(String). Type of the storage of MySQL hosts.
  - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a MySQL host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mysql/concepts/instance-types).
- `restore` [Block]. The cluster will be created from the specified backup.
  - `backup_id` (**Required**)(String). Backup ID. The cluster will be created from the specified backup. [How to get a list of MySQL backups](https://yandex.cloud/docs/managed-mysql/operations/cluster-backups).
  - `time` (String). Timestamp of the moment to which the MySQL cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.
- `user` [Block]. To manage users, please switch to using a separate resource type `yandex_mdb_mysql_user`.
  - `authentication_plugin` (String). Authentication plugin. Allowed values: `MYSQL_NATIVE_PASSWORD`, `CACHING_SHA2_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH` (for version 5.7 `MYSQL_NATIVE_PASSWORD`, `SHA256_PASSWORD`, `MYSQL_NO_LOGIN`, `MDB_IAMPROXY_AUTH`).
  - `global_permissions` (Set Of String). List user's global permissions. Allowed permissions: `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `PROCESS`, `FLUSH_OPTIMIZER_COSTS`, `SHOW_ROUTINE`, `MDB_ADMIN` for clear list use empty list. If the attribute is not specified there will be no changes.
  - `name` (**Required**)(String). The name of the user.
  - `password` (**Required**)(String). The password of the user.
  - `connection_limits` [Block]. User's connection limits. If not specified there will be no changes. Default value is -1. When these parameters are set to -1, backend default values will be actually used.
    - `max_connections_per_hour` (Number). Max connections per hour.
    - `max_questions_per_hour` (Number). Max questions per hour.
    - `max_updates_per_hour` (Number). Max updates per hour.
    - `max_user_connections` (Number). Max user connections.
  - `permission` [Block]. Set of permissions granted to the user.
    - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
    - `roles` (List Of String). List user's roles in the database. Allowed roles: `ALL`,`ALTER`,`ALTER_ROUTINE`,`CREATE`,`CREATE_ROUTINE`,`CREATE_TEMPORARY_TABLES`, `CREATE_VIEW`,`DELETE`,`DROP`,`EVENT`,`EXECUTE`,`INDEX`,`INSERT`,`LOCK_TABLES`,`SELECT`,`SHOW_VIEW`,`TRIGGER`,`UPDATE`,`REFERENCES`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mysql_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_mysql_cluster.my_cluster ...
```
