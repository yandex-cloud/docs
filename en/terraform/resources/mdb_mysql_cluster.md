---
subcategory: Managed Service for MySQL
page_title: 'Yandex: yandex_mdb_mysql_cluster'
description: Manages a MySQL cluster within Yandex Cloud.
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_mysql_cluster.md
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

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `environment` (String) Deployment environment of the MySQL cluster.
- `host` (Block List, Min: 1) A host of the MySQL cluster. (see [below for nested schema](#nestedblock--host))
- `name` (String) The resource name.
- `network_id` (String) The `VPC Network ID` of subnets which resource attached to.
- `resources` (Block List, Min: 1, Max: 1) Resources allocated to hosts of the MySQL cluster. (see [below for nested schema](#nestedblock--resources))
- `version` (String) Version of the MySQL cluster. (allowed versions are: 5.7, 8.0).

### Optional

- `access` (Block List, Max: 1) Access policy to the MySQL cluster. (see [below for nested schema](#nestedblock--access))
- `allow_regeneration_host` (Boolean, Deprecated) Deprecated field. You can safely remove this option. There is no need to recreate host if assign_public_ip is changed.
Regenerate hosts after changing the assign_public_ip parameter.
- `backup_retain_period_days` (Number) The period in days during which backups are stored.
- `backup_window_start` (Block List, Max: 1) Time to start the daily backup, in the UTC. (see [below for nested schema](#nestedblock--backup_window_start))
- `database` (Block Set, Deprecated) To manage databases, please switch to using a separate resource type `yandex_mdb_mysql_databases`. (see [below for nested schema](#nestedblock--database))
- `deletion_protection` (Boolean) The `true` value means that resource is protected from accidental deletion.
- `description` (String) The resource description.
- `folder_id` (String) The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `host_group_ids` (Set of String)
- `labels` (Map of String) A set of key/value label pairs which assigned to resource.
- `maintenance_window` (Block List, Max: 1) Maintenance policy of the MySQL cluster. (see [below for nested schema](#nestedblock--maintenance_window))
- `mysql_config` (Map of String) MySQL cluster config block.
- `performance_diagnostics` (Block List, Max: 1) Cluster performance diagnostics settings. [YC Documentation](https://yandex.cloud/docs/managed-mysql/api-ref/grpc/cluster_service#PerformanceDiagnostics). (see [below for nested schema](#nestedblock--performance_diagnostics))
- `restore` (Block List, Max: 1) The cluster will be created from the specified backup. (see [below for nested schema](#nestedblock--restore))
- `security_group_ids` (Set of String) The list of security groups applied to resource or their components.
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `user` (Block List, Deprecated) To manage users, please switch to using a separate resource type `yandex_mdb_mysql_user`. (see [below for nested schema](#nestedblock--user))

### Read-Only

- `created_at` (String) The creation timestamp of the resource.
- `health` (String) Aggregated health of the cluster.
- `id` (String) The ID of this resource.
- `status` (String) Status of the cluster.

<a id="nestedblock--host"></a>
### Nested Schema for `host`

Required:

- `zone` (String) The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.

Optional:

- `assign_public_ip` (Boolean) Sets whether the host should get a public IP address. It can be changed on the fly only when `name` is set.
- `backup_priority` (Number) Host backup priority. Value is between 0 and 100, default is 0.
- `name` (String) Host state name. It should be set for all hosts or unset for all hosts. This field can be used by another host, to select which host will be its replication source. Please refer to `replication_source_name` parameter.
- `priority` (Number) Host master promotion priority. Value is between 0 and 100, default is 0.
- `replication_source_name` (String) Host replication source name points to host's `name` from which this host should replicate. When not set then host in HA group. It works only when `name` is set.
- `subnet_id` (String) The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.

Read-Only:

- `fqdn` (String) The fully qualified domain name of the host.
- `replication_source` (String) Host replication source (fqdn), when replication_source is empty then host is in HA group.


<a id="nestedblock--resources"></a>
### Nested Schema for `resources`

Required:

- `disk_size` (Number) Volume of the storage available to a MySQL host, in gigabytes.
- `disk_type_id` (String) Type of the storage of MySQL hosts.
- `resource_preset_id` (String) The ID of the preset for computational resources available to a MySQL host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-mysql/concepts/instance-types).


<a id="nestedblock--access"></a>
### Nested Schema for `access`

Optional:

- `data_lens` (Boolean) Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
- `data_transfer` (Boolean) Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
- `web_sql` (Boolean) Allows access for [SQL queries in the management console](https://yandex.cloud/docs/managed-mysql/operations/web-sql-query).


<a id="nestedblock--backup_window_start"></a>
### Nested Schema for `backup_window_start`

Optional:

- `hours` (Number) The hour at which backup will be started.
- `minutes` (Number) The minute at which backup will be started.


<a id="nestedblock--database"></a>
### Nested Schema for `database`

Required:

- `name` (String) The name of the database.


<a id="nestedblock--maintenance_window"></a>
### Nested Schema for `maintenance_window`

Required:

- `type` (String) Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.

Optional:

- `day` (String) Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`
- `hour` (Number) Hour of the day in UTC (in `HH` format). Allowed value is between 1 and 24.


<a id="nestedblock--performance_diagnostics"></a>
### Nested Schema for `performance_diagnostics`

Required:

- `sessions_sampling_interval` (Number) Interval (in seconds) for my_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
- `statements_sampling_interval` (Number) Interval (in seconds) for my_stat_statements sampling Acceptable values are 1 to 86400, inclusive.

Optional:

- `enabled` (Boolean) Enable performance diagnostics.


<a id="nestedblock--restore"></a>
### Nested Schema for `restore`

Required:

- `backup_id` (String) Backup ID. The cluster will be created from the specified backup. [How to get a list of MySQL backups](https://yandex.cloud/docs/managed-mysql/operations/cluster-backups).

Optional:

- `time` (String) Timestamp of the moment to which the MySQL cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.


<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String) A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `delete` (String) A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
- `update` (String) A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


<a id="nestedblock--user"></a>
### Nested Schema for `user`

Required:

- `name` (String) The name of the user.
- `password` (String, Sensitive) The password of the user.

Optional:

- `authentication_plugin` (String) Authentication plugin. Allowed values: `MYSQL_NATIVE_PASSWORD`, `CACHING_SHA2_PASSWORD`, `SHA256_PASSWORD` (for version 5.7 `MYSQL_NATIVE_PASSWORD`, `SHA256_PASSWORD`).
- `connection_limits` (Block List, Max: 1) User's connection limits. If not specified there will be no changes. Default value is -1. When these parameters are set to -1, backend default values will be actually used. (see [below for nested schema](#nestedblock--user--connection_limits))
- `global_permissions` (Set of String) List user's global permissions. Allowed permissions: `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `PROCESS` for clear list use empty list. If the attribute is not specified there will be no changes.
- `permission` (Block Set) Set of permissions granted to the user. (see [below for nested schema](#nestedblock--user--permission))

<a id="nestedblock--user--connection_limits"></a>
### Nested Schema for `user.connection_limits`

Optional:

- `max_connections_per_hour` (Number) Max connections per hour.
- `max_questions_per_hour` (Number) Max questions per hour.
- `max_updates_per_hour` (Number) Max updates per hour.
- `max_user_connections` (Number) Max user connections.


<a id="nestedblock--user--permission"></a>
### Nested Schema for `user.permission`

Required:

- `database_name` (String) The name of the database that the permission grants access to.

Optional:

- `roles` (List of String) List user's roles in the database. Allowed roles: `ALL`,`ALTER`,`ALTER_ROUTINE`,`CREATE`,`CREATE_ROUTINE`,`CREATE_TEMPORARY_TABLES`, `CREATE_VIEW`,`DELETE`,`DROP`,`EVENT`,`EXECUTE`,`INDEX`,`INSERT`,`LOCK_TABLES`,`SELECT`,`SHOW_VIEW`,`TRIGGER`,`UPDATE`.

## Import

The resource can be imported by using their `resource ID`. For getting the resource ID you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or [YC CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mysql_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_mysql_cluster.my_cluster ...
```
