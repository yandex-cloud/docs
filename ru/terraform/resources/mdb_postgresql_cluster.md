---
subcategory: Managed Service for PostgreSQL
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/mdb_postgresql_cluster.md
---

# yandex_mdb_postgresql_cluster (Resource)

Manages a PostgreSQL cluster within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/). [How to connect to the DB](https://yandex.cloud/docs/managed-postgresql/quickstart#connect). To connect, use port 6432. The port number is not configurable.

{% note warning %}

Historically, `user` and `database` blocks of the `yandex_mdb_postgresql_cluster` resource were used to manage users and databases of the PostgreSQL cluster. However, this approach has many disadvantages. In particular, adding and removing a resource from the terraform recipe worked wrong because terraform misleads the user about the planned changes. Now, the recommended way to manage databases and users is using `yandex_mdb_postgresql_user` and `yandex_mdb_postgresql_database` resources.

{% endnote %}


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

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key used for cluster disk encryption. Encryption can`t be disabled for an existing cluster. If the source cluster is encrypted and you leave this field empty when restoring, the restored cluster will be created without encryption.
- `environment` (**Required**)(String). Deployment environment of the PostgreSQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `host_group_ids` (Set Of String). Host Group IDs.
- `host_master_name` (String). Deprecated field. Will be removed in future versions.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The name of PostgreSQL cluster.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the cluster.
- `config` [Block]. Configuration of the PostgreSQL cluster.
  - `autofailover` (Bool). Configuration setting which enables/disables autofailover in cluster.
  - `backup_retain_period_days` (Number). The period in days during which backups are stored.
  - `postgresql_config` (Map Of String). PostgreSQL cluster configuration. For detailed information specific to your PostgreSQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/postgresql/v1/config).
  - `version` (**Required**)(String). Version of the PostgreSQL cluster. (allowed versions are: 13, 13-1c, 14, 14-1c, 15, 15-1c, 16, 17).
  - `access` [Block]. Access policy to the PostgreSQL cluster.
    - `data_lens` (Bool). Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
    - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
    - `serverless` (Bool). Allow access for [connection to managed databases from functions](https://yandex.cloud/docs/functions/operations/database-connection).
    - `web_sql` (Bool). Allow access for [SQL queries in the management console](https://yandex.cloud/docs/managed-postgresql/operations/web-sql-query).
    - `yandex_query` (Bool). Allow access for [YandexQuery](https://yandex.cloud/services/query).
  - `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
    - `hours` (Number). The hour at which backup will be started (UTC).
    - `minutes` (Number). The minute at which backup will be started.
  - `disk_size_autoscaling` [Block]. Cluster disk size autoscaling settings.
    - `disk_size_limit` (**Required**)(Number). The overall maximum for disk size that limit all autoscaling iterations. See the [documentation](https://yandex.cloud/en/docs/managed-postgresql/concepts/storage#auto-rescale) for details.
    - `emergency_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
    - `planned_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
  - `performance_diagnostics` [Block]. Cluster performance diagnostics settings. [YC Documentation](https://yandex.cloud/docs/managed-postgresql/api-ref/grpc/cluster_service#PerformanceDiagnostics).
    - `enabled` (Bool). Enable performance diagnostics.
    - `sessions_sampling_interval` (**Required**)(Number). Interval (in seconds) for pg_stat_activity sampling. Acceptable values are 1 to 86400, inclusive.
    - `statements_sampling_interval` (**Required**)(Number). Interval (in seconds) for pg_stat_statements sampling. Acceptable values are 1 to 86400, inclusive.
  - `pooler_config` [Block]. Configuration of the connection pooler.
    - `pool_discard` (Bool). Setting `pool_discard` [parameter in Odyssey](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool_discard-yesno).
    - `pooling_mode` (String). Mode that the connection pooler is working in. See descriptions of all modes in the [documentation for Odyssey](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string.
  - `resources` [Block]. Resources allocated to hosts of the PostgreSQL cluster.
    - `disk_size` (**Required**)(Number). Volume of the storage available to a PostgreSQL host, in gigabytes.
    - `disk_type_id` (String). Type of the storage of PostgreSQL hosts.
    - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a PostgreSQL host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/concepts/instance-types).
- `database` [Block]. 

    {% note warning %}

    Deprecated! To manage databases, please switch to using a separate resource type `yandex_mdb_postgresql_database`.

    {% endnote %}
  - `lc_collate` (String). POSIX locale for string sorting order. Forbidden to change in an existing database.
  - `lc_type` (String). POSIX locale for character classification. Forbidden to change in an existing database.
  - `name` (**Required**)(String). The resource name.
  - `owner` (**Required**)(String). Name of the user assigned as the owner of the database. Forbidden to change in an existing database.
  - `template_db` (String). Name of the template database.
  - `extension` [Block]. Set of database extensions.
    - `name` (**Required**)(String). Name of the database extension. For more information on available extensions see [the official documentation](https://yandex.cloud/docs/managed-postgresql/operations/cluster-extensions).
    - `version` (String). Version of the extension.
- `host` [Block]. A host of the PostgreSQL cluster.
  - `assign_public_ip` (Bool). Whether the host should get a public IP address.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `name` (String). Host state name. It should be set for all hosts or unset for all hosts. This field can be used by another host, to select which host will be its replication source. Please see `replication_source_name` parameter.
  - `priority` (Number). Host priority in HA group. It works only when `name` is set.
  - `replication_source` (*Read-Only*) (String). Host replication source (fqdn), when replication_source is empty then host is in HA group.
  - `replication_source_name` (String). Host replication source name points to host's `name` from which this host should replicate. When not set then host in HA group. It works only when `name` is set.
  - `role` (*Read-Only*) (String). Host's role (replica|primary), computed by server.
  - `subnet_id` (String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `maintenance_window` [Block]. Maintenance policy of the PostgreSQL cluster.
  - `day` (String). Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`
  - `hour` (Number). Hour of the day in UTC (in `HH` format). Allowed value is between 1 and 24.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `restore` [Block]. The cluster will be created from the specified backup.
  - `backup_id` (**Required**)(String). Backup ID. The cluster will be created from the specified backup. [How to get a list of PostgreSQL backups](https://yandex.cloud/docs/managed-postgresql/operations/cluster-backups).
  - `time` (String). Timestamp of the moment to which the PostgreSQL cluster should be restored. (Format: `2006-01-02T15:04:05` - UTC). When not set, current time is used.
  - `time_inclusive` (Bool). Flag that indicates whether a database should be restored to the first backup point available just after the timestamp specified in the [time] field instead of just before. Possible values:
* `false` (default) — the restore point refers to the first backup moment before [time].
* `true` — the restore point refers to the first backup point after [time].

- `user` [Block]. 

     {% note warning %}

     Deprecated! To manage users, please switch to using a separate resource type `yandex_mdb_postgresql_user`.

     {% endnote %}
  - `conn_limit` (Number). The maximum number of connections per user. (Default 50).
  - `grants` (List Of String). List of the user's grants.
  - `login` (Bool). User's ability to login.
  - `name` (**Required**)(String). The name of the user.
  - `password` (**Required**)(String). The password of the user.
  - `settings` (Map Of String). Map of user settings. [Full description](https://yandex.cloud/docs/managed-postgresql/api-ref/grpc/Cluster/create#yandex.cloud.mdb.postgresql.v1.UserSettings).

* `default_transaction_isolation` - defines the default isolation level to be set for all new SQL transactions. One of:
  - 1: `read uncommitted`
  - 2: `read committed`
  - 3: `repeatable read`
  - 4: `serializable`

* `lock_timeout` - The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object (default 0).

* `log_min_duration_statement` - This setting controls logging of the duration of statements. Default -1 disables logging of the duration of statements.

* `synchronous_commit` - This setting defines whether DBMS will commit transaction in a synchronous way. One of:
  - 1: `on`
  - 2: `off`
  - 3: `local`
  - 4: `remote write`
  - 5: `remote apply`

* `temp_file_limit` - The maximum storage space size (in kilobytes) that a single process can use to create temporary files.

* `log_statement` - This setting specifies which SQL statements should be logged (on the user level). One of:
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

* `wal_sender_timeout` - The maximum time (in milliseconds) to wait for WAL replication. Terminate replication connections that are inactive for longer than this amount of time. Integer.

* `idle_in_transaction_session_timeout` - Sets the maximum allowed idle time (in milliseconds) between queries, when in a transaction. Value of 0 (default) disables the timeout. Integer.

* `statement_timeout` - The maximum time (in milliseconds) to wait for statement. Value of 0 (default) disables the timeout. Integer.
  - `permission` [Block]. Set of permissions granted to the user.
    - `database_name` (**Required**)(String). The name of the database that the permission grants access to.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_postgresql_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_postgresql_cluster.my_cluster ...
```
