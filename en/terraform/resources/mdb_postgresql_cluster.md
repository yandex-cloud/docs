---
subcategory: Managed Service for PostgreSQL
page_title: 'Yandex: yandex_mdb_postgresql_cluster'
description: Manages a PostgreSQL cluster within Yandex Cloud.
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_postgresql_cluster.md
---

# yandex_mdb_postgresql_cluster (Resource)

Manages a PostgreSQL cluster within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/). [How to connect to the DB](https://yandex.cloud/docs/managed-postgresql/quickstart#connect). To connect, use port 6432. The port number is not configurable.

~> Historically, `user` and `database` blocks of the `yandex_mdb_postgresql_cluster` resource were used to manage users and databases of the PostgreSQL cluster. However, this approach has many disadvantages. In particular, adding and removing a resource from the terraform recipe worked wrong because terraform misleads the user about the planned changes. Now, the recommended way to manage databases and users is using `yandex_mdb_postgresql_user` and `yandex_mdb_postgresql_database` resources.

## Example usage

```terraform
//
// Create a new MDB PostgreSQL Cluster.
//
resource "yandex_mdb_postgresql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 15
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
// Create a new MDB High Availability PostgreSQL Cluster.
//
resource "yandex_mdb_postgresql_cluster" "my_cluster" {
  name        = "ha"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 15
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }
  }

  maintenance_window {
    type = "ANYTIME"
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
// Create a new MDB High Availability PostgreSQL Cluster.
//
resource "yandex_mdb_postgresql_cluster" "my_cluster" {
  name        = "test_ha"
  description = "test High-Availability (HA) PostgreSQL Cluster"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 15
    resources {
      resource_preset_id = "s2.micro"
      disk_size          = 10
      disk_type_id       = "network-ssd"
    }
  }

  host {
    zone      = "ru-central1-a"
    name      = "host_name_a"
    subnet_id = yandex_vpc_subnet.a.id
  }

  host {
    zone                    = "ru-central1-b"
    name                    = "host_name_b"
    replication_source_name = "host_name_d"
    subnet_id               = yandex_vpc_subnet.b.id
  }

  host {
    zone      = "ru-central1-d"
    name      = "host_name_d"
    subnet_id = yandex_vpc_subnet.d.id
  }

  host {
    zone      = "ru-central1-d"
    name      = "host_name_d_2"
    subnet_id = yandex_vpc_subnet.d.id
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "a" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "b" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}

resource "yandex_vpc_subnet" "d" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.3.0.0/24"]
}
```

```terraform
//
// Create a new MDB PostgreSQL Single Node Cluster from backup.
//
resource "yandex_mdb_postgresql_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  restore {
    backup_id = "c9q99999999999999994cm:base_000000010000005F000000B4"
    time      = "2021-02-11T15:04:05"
  }

  config {
    version = 15
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

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `config` (Block List, Min: 1, Max: 1) Configuration of the PostgreSQL cluster. (see [below for nested schema](#nestedblock--config))
- `environment` (String) Deployment environment of the PostgreSQL cluster.
- `host` (Block List, Min: 1) A host of the PostgreSQL cluster. (see [below for nested schema](#nestedblock--host))
- `name` (String) The resource name.
- `network_id` (String) The `VPC Network ID` of subnets which resource attached to.

### Optional

- `database` (Block List, Deprecated) ~> Deprecated! To manage databases, please switch to using a separate resource type `yandex_mdb_postgresql_database`. (see [below for nested schema](#nestedblock--database))
- `deletion_protection` (Boolean) The `true` value means that resource is protected from accidental deletion.
- `description` (String) The resource description.
- `folder_id` (String) The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `host_group_ids` (Set of String) Host Group IDs.
- `host_master_name` (String, Deprecated) Deprecated field. Will be removed in future versions.
- `labels` (Map of String) A set of key/value label pairs which assigned to resource.
- `maintenance_window` (Block List, Max: 1) Maintenance policy of the PostgreSQL cluster. (see [below for nested schema](#nestedblock--maintenance_window))
- `restore` (Block List, Max: 1) The cluster will be created from the specified backup. (see [below for nested schema](#nestedblock--restore))
- `security_group_ids` (Set of String) The list of security groups applied to resource or their components.
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `user` (Block List, Deprecated) ~> Deprecated! To manage users, please switch to using a separate resource type `yandex_mdb_postgresql_user`. (see [below for nested schema](#nestedblock--user))

### Read-Only

- `created_at` (String) The creation timestamp of the resource.
- `health` (String) Aggregated health of the cluster.
- `id` (String) The ID of this resource.
- `status` (String) Status of the cluster.

<a id="nestedblock--config"></a>
### Nested Schema for `config`

Required:

- `resources` (Block List, Min: 1, Max: 1) Resources allocated to hosts of the PostgreSQL cluster. (see [below for nested schema](#nestedblock--config--resources))
- `version` (String) Version of the PostgreSQL cluster. (allowed versions are: 10, 10-1c, 11, 11-1c, 12, 12-1c, 13, 13-1c, 14, 14-1c, 15, 15-1c, 16, 17).

Optional:

- `access` (Block List, Max: 1) Access policy to the PostgreSQL cluster. (see [below for nested schema](#nestedblock--config--access))
- `autofailover` (Boolean) Configuration setting which enables/disables autofailover in cluster.
- `backup_retain_period_days` (Number) The period in days during which backups are stored.
- `backup_window_start` (Block List, Max: 1) Time to start the daily backup, in the UTC timezone. (see [below for nested schema](#nestedblock--config--backup_window_start))
- `disk_size_autoscaling` (Block List, Max: 1) Cluster disk size autoscaling settings. (see [below for nested schema](#nestedblock--config--disk_size_autoscaling))
- `performance_diagnostics` (Block List, Max: 1) Cluster performance diagnostics settings. [YC Documentation](https://yandex.cloud/docs/managed-postgresql/api-ref/grpc/cluster_service#PerformanceDiagnostics). (see [below for nested schema](#nestedblock--config--performance_diagnostics))
- `pooler_config` (Block List, Max: 1) Configuration of the connection pooler. (see [below for nested schema](#nestedblock--config--pooler_config))
- `postgresql_config` (Map of String) PostgreSQL cluster configuration. For detailed information specific to your PostgreSQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/postgresql/v1/config).

<a id="nestedblock--config--resources"></a>
### Nested Schema for `config.resources`

Required:

- `disk_size` (Number) Volume of the storage available to a PostgreSQL host, in gigabytes.
- `resource_preset_id` (String) The ID of the preset for computational resources available to a PostgreSQL host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/concepts/instance-types).

Optional:

- `disk_type_id` (String) Type of the storage of PostgreSQL hosts.


<a id="nestedblock--config--access"></a>
### Nested Schema for `config.access`

Optional:

- `data_lens` (Boolean) Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
- `data_transfer` (Boolean) Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
- `serverless` (Boolean) Allow access for [connection to managed databases from functions](https://yandex.cloud/docs/functions/operations/database-connection).
- `web_sql` (Boolean) Allow access for [SQL queries in the management console](https://yandex.cloud/docs/managed-postgresql/operations/web-sql-query).


<a id="nestedblock--config--backup_window_start"></a>
### Nested Schema for `config.backup_window_start`

Optional:

- `hours` (Number) The hour at which backup will be started (UTC).
- `minutes` (Number) The hour at which backup will be started (UTC).


<a id="nestedblock--config--disk_size_autoscaling"></a>
### Nested Schema for `config.disk_size_autoscaling`

Required:

- `disk_size_limit` (Number) Limit of disk size after autoscaling (GiB).

Optional:

- `emergency_usage_threshold` (Number) Immediate autoscaling disk usage (percent).
- `planned_usage_threshold` (Number) Maintenance window autoscaling disk usage (percent).


<a id="nestedblock--config--performance_diagnostics"></a>
### Nested Schema for `config.performance_diagnostics`

Required:

- `sessions_sampling_interval` (Number) Interval (in seconds) for pg_stat_activity sampling Acceptable values are 1 to 86400, inclusive.
- `statements_sampling_interval` (Number) Interval (in seconds) for pg_stat_statements sampling Acceptable values are 1 to 86400, inclusive.

Optional:

- `enabled` (Boolean) Enable performance diagnostics.


<a id="nestedblock--config--pooler_config"></a>
### Nested Schema for `config.pooler_config`

Optional:

- `pool_discard` (Boolean) Setting `pool_discard` [parameter in Odyssey](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool_discard-yesno).
- `pooling_mode` (String) Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for Odyssey](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string.



<a id="nestedblock--host"></a>
### Nested Schema for `host`

Required:

- `zone` (String) The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.

Optional:

- `assign_public_ip` (Boolean) Sets whether the host should get a public IP address on creation. It can be changed on the fly only when `name` is set.
- `name` (String) Host state name. It should be set for all hosts or unset for all hosts. This field can be used by another host, to select which host will be its replication source. Please see `replication_source_name` parameter.
- `priority` (Number, Deprecated) Host priority in HA group. It works only when `name` is set.
- `replication_source_name` (String) Host replication source name points to host's `name` from which this host should replicate. When not set then host in HA group. It works only when `name` is set.
- `subnet_id` (String) The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.

Read-Only:

- `fqdn` (String) The fully qualified domain name of the host.
- `replication_source` (String) Host replication source (fqdn), when replication_source is empty then host is in HA group.
- `role` (String) Host's role (replica|primary), computed by server.


<a id="nestedblock--database"></a>
### Nested Schema for `database`

Required:

- `name` (String) The resource name.
- `owner` (String) Name of the user assigned as the owner of the database. Forbidden to change in an existing database.

Optional:

- `extension` (Block Set) Set of database extensions. (see [below for nested schema](#nestedblock--database--extension))
- `lc_collate` (String) POSIX locale for string sorting order. Forbidden to change in an existing database.
- `lc_type` (String) POSIX locale for character classification. Forbidden to change in an existing database.
- `template_db` (String) Name of the template database.

<a id="nestedblock--database--extension"></a>
### Nested Schema for `database.extension`

Required:

- `name` (String) Name of the database extension. For more information on available extensions see [the official documentation](https://yandex.cloud/docs/managed-postgresql/operations/cluster-extensions).

Optional:

- `version` (String) Version of the extension.



<a id="nestedblock--maintenance_window"></a>
### Nested Schema for `maintenance_window`

Required:

- `type` (String) Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.

Optional:

- `day` (String) Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`
- `hour` (Number) Hour of the day in UTC (in `HH` format). Allowed value is between 1 and 24.


<a id="nestedblock--restore"></a>
### Nested Schema for `restore`

Required:

- `backup_id` (String) Backup ID. The cluster will be created from the specified backup. [How to get a list of PostgreSQL backups](https://yandex.cloud/docs/managed-postgresql/operations/cluster-backups).

Optional:

- `time` (String) Timestamp of the moment to which the PostgreSQL cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.
- `time_inclusive` (Boolean) Flag that indicates whether a database should be restored to the first backup point available just after the timestamp specified in the [time] field instead of just before. Possible values:
* `false` (default) — the restore point refers to the first backup moment before [time].
* `true` — the restore point refers to the first backup point after [time].


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

- `conn_limit` (Number) The maximum number of connections per user. (Default 50).
- `grants` (List of String) List of the user's grants.
- `login` (Boolean) User's ability to login.
- `permission` (Block Set) Set of permissions granted to the user. (see [below for nested schema](#nestedblock--user--permission))
- `settings` (Map of String) Map of user settings. [Full description](https://yandex.cloud/docs/managed-postgresql/api-ref/grpc/Cluster/create#yandex.cloud.mdb.postgresql.v1.UserSettings).

* `default_transaction_isolation` - defines the default isolation level to be set for all new SQL transactions. One of:  - 0: `unspecified`
  - 1: `read uncommitted`
  - 2: `read committed`
  - 3: `repeatable read`
  - 4: `serializable`

* `lock_timeout` - The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object (default 0)

* `log_min_duration_statement` - This setting controls logging of the duration of statements. (default -1 disables logging of the duration of statements.)

* `synchronous_commit` - This setting defines whether DBMS will commit transaction in a synchronous way. One of:
  - 0: `unspecified`
  - 1: `on`
  - 2: `off`
  - 3: `local`
  - 4: `remote write`
  - 5: `remote apply`

* `temp_file_limit` - The maximum storage space size (in kilobytes) that a single process can use to create temporary files.

* `log_statement` - This setting specifies which SQL statements should be logged (on the user level). One of:
  - 0: `unspecified`
  - 1: `none`
  - 2: `ddl`
  - 3: `mod`
  - 4: `all`

* `pool_mode` - Mode that the connection pooler is working in with specified user. One of:
  - 1: `session`
  - 2: `transaction`
  - 3: `statement`

* `prepared_statements_pooling` - This setting allows user to use prepared statements with transaction pooling. Boolean.

* `catchup_timeout` - The connection pooler setting. It determines the maximum allowed replication lag (in seconds). Pooler will reject connections to the replica with a lag above this threshold. Default value is 0, which disables this feature. Integer.

* `wal_sender_timeout` - The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+). Terminate replication connections that are inactive for longer than this amount of time. Integer.

* `idle_in_transaction_session_timeout` - Sets the maximum allowed idle time (in milliseconds) between queries, when in a transaction. Value of 0 (default) disables the timeout. Integer.

* `statement_timeout` - The maximum time (in milliseconds) to wait for statement. Value of 0 (default) disables the timeout. Integer

<a id="nestedblock--user--permission"></a>
### Nested Schema for `user.permission`

Required:

- `database_name` (String) The name of the database that the permission grants access to.

## Import

The resource can be imported by using their `resource ID`. For getting the resource ID you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or [YC CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_postgresql_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_postgresql_cluster.my_cluster ...
```
