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
- `config` [Block]. Configuration of the PostgreSQL cluster.
  - `access` [Block]. Access policy to the PostgreSQL cluster.
    - `data_lens` (Bool). Allow access for [Yandex DataLens](https://yandex.cloud/services/datalens).
    - `data_transfer` (Bool). Allow access for [DataTransfer](https://yandex.cloud/services/data-transfer).
    - `serverless` (Bool). Allow access for [connection to managed databases from functions](https://yandex.cloud/docs/functions/operations/database-connection).
    - `web_sql` (Bool). Allow access for [SQL queries in the management console](https://yandex.cloud/docs/managed-postgresql/operations/web-sql-query).
    - `yandex_query` (Bool). Allow access for [YandexQuery](https://yandex.cloud/services/query).
  - `autofailover` (Bool). Configuration setting which enables/disables autofailover in cluster.
  - `backup_retain_period_days` (Number). The period in days during which backups are stored.
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
  - `postgresql_config` (Map Of String). PostgreSQL cluster configuration. For detailed information specific to your PostgreSQL version, please refer to the [API proto specifications](https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/mdb/postgresql/v1/config).
  - `resources` [Block]. Resources allocated to hosts of the PostgreSQL cluster.
    - `disk_size` (**Required**)(Number). Volume of the storage available to a PostgreSQL host, in gigabytes.
    - `disk_type_id` (String). Type of the storage of PostgreSQL hosts.
    - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a PostgreSQL host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-postgresql/concepts/instance-types).
  - `version` (**Required**)(String). Version of the PostgreSQL cluster. (allowed versions are: 13, 13-1c, 14, 14-1c, 15, 15-1c, 16, 17).
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database` [Block]. 

    {% note warning %}

    Deprecated! To manage databases, please switch to using a separate resource type `yandex_mdb_postgresql_database`.

    {% endnote %}
  - `extension` [Block]. Set of database extensions.
    - `name` (**Required**)(String). Name of the database extension. For more information on available extensions see [the official documentation](https://yandex.cloud/docs/managed-postgresql/operations/cluster-extensions).
    - `version` (String). Version of the extension.
  - `lc_collate` (String). POSIX locale for string sorting order. Forbidden to change in an existing database.
  - `lc_type` (String). POSIX locale for character classification. Forbidden to change in an existing database.
  - `name` (**Required**)(String). The resource name.
  - `owner` (**Required**)(String). Name of the user assigned as the owner of the database. Forbidden to change in an existing database.
  - `template_db` (String). Name of the template database.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key used for cluster disk encryption. Encryption can`t be disabled for an existing cluster. If the source cluster is encrypted and you leave this field empty when restoring, the restored cluster will be created without encryption.
- `environment` (**Required**)(String). Deployment environment of the PostgreSQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster.
- `host` [Block]. A host of the PostgreSQL cluster.
  - `assign_public_ip` (Bool). Whether the host should get a public IP address.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `priority` (Number). Host priority in HA group. It works only when `name` is set.
  - `replication_source` (*Read-Only*) (String). Host replication source (fqdn), when replication_source is empty then host is in HA group.
  - `replication_source_name` (String). Host replication source name points to host's `name` from which this host should replicate. When not set then host in HA group. It works only when `name` is set.
  - `role` (*Read-Only*) (String). Host's role (replica|primary), computed by server.
  - `subnet_id` (String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `zone` (**Required**)(String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.
- `host_group_ids` (Set Of String). Host Group IDs.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [Block]. Maintenance policy of the PostgreSQL cluster.
  - `day` (String). Day of the week (in `DDD` format). Allowed values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`
  - `hour` (Number). Hour of the day in UTC (in `HH` format). Allowed value is between 1 and 24.
  - `type` (**Required**)(String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour of window need to be specified with weekly window.
- `name` (**Required**)(String). The name of PostgreSQL cluster.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `status` (*Read-Only*) (String). Status of the cluster.
- `user` [Block]. 

    {% note warning %}

    Deprecated! To manage users, please switch to using a separate resource type `yandex_mdb_postgresql_user`.

    {% endnote %}
  - `conn_limit` (Number). The maximum number of connections per user. (Default 50).
  - `grants` (List Of String). List of the user's grants.
  - `login` (Bool). User's ability to login.
  - `name` (**Required**)(String). The name of the user.
  - `permission` [Block]. Set of permissions granted to the user.
    - `database_name` (**Required**)(String). The name of the database that the permission grants access to.
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


