---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Cluster/create.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService.Create

Creates a PostgreSQL cluster in the specified folder.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.mdb.postgresql.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.mdb.postgresql.v1.CreateClusterRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "environment": "Environment",
  "config_spec": {
    "version": "string",
    // Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`
    "postgresql_config_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6",
    "postgresql_config_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C",
    "postgresql_config_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10",
    "postgresql_config_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11",
    "postgresql_config_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C",
    "postgresql_config_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12",
    "postgresql_config_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C",
    "postgresql_config_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13",
    "postgresql_config_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C",
    "postgresql_config_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14",
    "postgresql_config_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C",
    "postgresql_config_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15",
    "postgresql_config_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C",
    "postgresql_config_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16",
    "postgresql_config_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C",
    "postgresql_config_17": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17",
    "postgresql_config_17_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C",
    // end of the list of possible fields
    "pooler_config": {
      "pooling_mode": "PoolingMode",
      "pool_discard": "google.protobuf.BoolValue"
    },
    "resources": {
      "resource_preset_id": "string",
      "disk_size": "int64",
      "disk_type_id": "string"
    },
    "autofailover": "google.protobuf.BoolValue",
    "backup_window_start": "google.type.TimeOfDay",
    "backup_retain_period_days": "google.protobuf.Int64Value",
    "access": {
      "data_lens": "bool",
      "web_sql": "bool",
      "serverless": "bool",
      "data_transfer": "bool",
      "yandex_query": "bool"
    },
    "performance_diagnostics": {
      "enabled": "bool",
      "sessions_sampling_interval": "int64",
      "statements_sampling_interval": "int64"
    },
    "disk_size_autoscaling": {
      "planned_usage_threshold": "int64",
      "emergency_usage_threshold": "int64",
      "disk_size_limit": "int64"
    }
  },
  "database_specs": [
    {
      "name": "string",
      "owner": "string",
      "lc_collate": "string",
      "lc_ctype": "string",
      "extensions": [
        {
          "name": "string",
          "version": "string"
        }
      ],
      "template_db": "string",
      "deletion_protection": "google.protobuf.BoolValue"
    }
  ],
  "user_specs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "database_name": "string"
        }
      ],
      "conn_limit": "google.protobuf.Int64Value",
      "settings": {
        "default_transaction_isolation": "TransactionIsolation",
        "lock_timeout": "google.protobuf.Int64Value",
        "log_min_duration_statement": "google.protobuf.Int64Value",
        "synchronous_commit": "SynchronousCommit",
        "temp_file_limit": "google.protobuf.Int64Value",
        "log_statement": "LogStatement",
        "pool_mode": "PoolingMode",
        "prepared_statements_pooling": "google.protobuf.BoolValue",
        "catchup_timeout": "google.protobuf.Int64Value",
        "wal_sender_timeout": "google.protobuf.Int64Value",
        "idle_in_transaction_session_timeout": "google.protobuf.Int64Value",
        "statement_timeout": "google.protobuf.Int64Value",
        "pgaudit": {
          "log": [
            "PGAuditSettingsLog"
          ]
        }
      },
      "login": "google.protobuf.BoolValue",
      "grants": [
        "string"
      ],
      "deletion_protection": "google.protobuf.BoolValue",
      "user_password_encryption": "UserPasswordEncryption",
      "generate_password": "google.protobuf.BoolValue"
    }
  ],
  "host_specs": [
    {
      "zone_id": "string",
      "subnet_id": "string",
      "assign_public_ip": "bool",
      "replication_source": "string",
      "priority": "google.protobuf.Int64Value",
      "config_spec": {
        // Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`
        "postgresql_config_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6",
        "postgresql_config_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C",
        "postgresql_config_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10",
        "postgresql_config_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11",
        "postgresql_config_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C",
        "postgresql_config_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12",
        "postgresql_config_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C",
        "postgresql_config_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13",
        "postgresql_config_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C",
        "postgresql_config_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14",
        "postgresql_config_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C",
        "postgresql_config_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15",
        "postgresql_config_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C",
        "postgresql_config_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16",
        "postgresql_config_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C",
        "postgresql_config_17": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17",
        "postgresql_config_17_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C"
        // end of the list of possible fields
      }
    }
  ],
  "network_id": "string",
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "host_group_ids": [
    "string"
  ],
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "retention_policies": [
    {
      "policy_name": "string",
      "cron": {
        "day_of_month": "string",
        "month": "string",
        "day_of_week": "string"
      },
      "retain_for_days": "int64",
      "description": "string"
    }
  ],
  "disk_encryption_key_id": "google.protobuf.StringValue"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create the PostgreSQL cluster in. ||
|| name | **string**

Required field. Name of the PostgreSQL cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the PostgreSQL cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary". ||
|| environment | enum **Environment**

Required field. Deployment environment of the PostgreSQL cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.postgresql.v1.ConfigSpec)**

Required field. Configuration and resources for hosts that should be created for the PostgreSQL cluster. ||
|| database_specs[] | **[DatabaseSpec](#yandex.cloud.mdb.postgresql.v1.DatabaseSpec)**

Required field. Descriptions of databases to be created in the PostgreSQL cluster. ||
|| user_specs[] | **[UserSpec](#yandex.cloud.mdb.postgresql.v1.UserSpec)**

Required field. Descriptions of database users to be created in the PostgreSQL cluster. ||
|| host_specs[] | **[HostSpec](#yandex.cloud.mdb.postgresql.v1.HostSpec)**

Required field. Individual configurations for hosts that should be created for the PostgreSQL cluster. ||
|| network_id | **string**

Required field. ID of the network to create the cluster in. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| host_group_ids[] | **string**

Host groups hosting VMs of the cluster. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| retention_policies[] | **[BackupRetentionPolicySpec](#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicySpec)**

Backup long-term retention policies setting. ||
|| disk_encryption_key_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the key to encrypt cluster disks. ||
|#

## ConfigSpec {#yandex.cloud.mdb.postgresql.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of PostgreSQL used in the cluster.
Possible values: `9.6`, `10`, `10_1c`, `11`, `12`, `13`, `14`, `15`, `16`, `17` ||
|| postgresql_config_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**

Configuration for a PostgreSQL 9.6 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**

Configuration for a PostgreSQL 10 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**

Configuration for a PostgreSQL 10 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**

Configuration for a PostgreSQL 11 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**

Configuration for a PostgreSQL 11 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**

Configuration for a PostgreSQL 12 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**

Configuration for a PostgreSQL 12 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**

Configuration for a PostgreSQL 13 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**

Configuration for a PostgreSQL 13 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**

Configuration for a PostgreSQL 14 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**

Configuration for a PostgreSQL 14 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**

Configuration for a PostgreSQL 15 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**

Configuration for a PostgreSQL 15 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16.proto)**

Configuration for a PostgreSQL 16 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16_1c.proto)**

Configuration for a PostgreSQL 16 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_17 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17.proto)**

Configuration for a PostgreSQL 17 cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresql_config_17_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17_1c.proto)**

Configuration for a PostgreSQL 17 1C cluster.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| pooler_config | **[ConnectionPoolerConfig](#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig)**

Configuration of the connection pooler. ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources)**

Resources allocated to PostgreSQL hosts. ||
|| autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Configuration setting which enables/disables autofailover in cluster. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.postgresql.v1.Access)**

Access policy to DB ||
|| performance_diagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics)**

Configuration of the performance diagnostics service. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling)**

Disk size autoscaling ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| pooling_mode | enum **PoolingMode**

Mode that the connection pooler is working in.
See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Session pooling mode.
- `TRANSACTION`: Transaction pooling mode.
- `STATEMENT`: Statement pooling mode. ||
|| pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting `server_reset_query_always` parameter in PgBouncer. ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Access {#yandex.cloud.mdb.postgresql.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens ||
|| web_sql | **bool**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. ||
|| serverless | **bool**

Allow access for Serverless ||
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|| yandex_query | **bool**

Allow access for YandexQuery. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **bool**

Configuration setting which enables/disables performance diagnostics service in cluster. ||
|| sessions_sampling_interval | **int64**

Interval (in seconds) for pg_stat_activity sampling ||
|| statements_sampling_interval | **int64**

Interval (in seconds) for pg_stat_statements sampling ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergency_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| disk_size_limit | **int64**

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## DatabaseSpec {#yandex.cloud.mdb.postgresql.v1.DatabaseSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the PostgreSQL database. 1-63 characters long. ||
|| owner | **string**

Required field. Name of the user to be assigned as the owner of the database.
To get the list of available PostgreSQL users, make a [UserService.List](/docs/managed-postgresql/api-ref/grpc/User/list#List) request. ||
|| lc_collate | **string**

POSIX locale for string sorting order.
Can only be set at creation time. ||
|| lc_ctype | **string**

POSIX locale for character classification.
Can only be set at creation time. ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension)**

PostgreSQL extensions to be enabled for the database. ||
|| template_db | **string**

Name of the PostgreSQL database template. ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Deletion Protection inhibits deletion of the database

Default value: `unspecified` (inherits cluster's deletion_protection) ||
|#

## Extension {#yandex.cloud.mdb.postgresql.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension, e.g. `pg_trgm` or `pg_btree`.
Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/extensions/cluster-extensions). ||
|| version | **string**

Version of the extension. The setting is deprecated and has no effect. ||
|#

## UserSpec {#yandex.cloud.mdb.postgresql.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the PostgreSQL user. ||
|| password | **string**

Required field. Password of the PostgreSQL user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.postgresql.v1.Permission)**

Set of permissions to grant to the user to access specific databases. ||
|| conn_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of database connections that should be available to the user.

When used in session pooling, this setting limits the number of connections to every single host in PostgreSQL cluster. In this case, the setting's value must be greater than the total number of connections that backend services can open to access the PostgreSQL cluster. The setting's value should not exceed the value of the [Cluster.config.postgresql_config_12.effective_config.max_connections](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.max_connections.proto) setting.

When used in transaction pooling, this setting limits the number of user's active transactions; therefore, in this mode user can open thousands of connections, but only `N` concurrent connections will be opened, where `N` is the value of the setting.

Minimum value: `10` (default: `50`), when used in session pooling. ||
|| settings | **[UserSettings](#yandex.cloud.mdb.postgresql.v1.UserSettings)**

PostgreSQL settings for the user. ||
|| login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

This flag defines whether the user can login to a PostgreSQL database.

Default value: `true` (login is allowed). ||
|| grants[] | **string**

A set of roles and privileges that are granted to the user.

For more information, see [the documentation](/docs/managed-postgresql/operations/grant). ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Deletion Protection inhibits deletion of the user

Default value: `unspecified` (inherits cluster's deletion_protection) ||
|| user_password_encryption | enum **UserPasswordEncryption**

Password-based authentication method for user.
Possible values are `` USER_PASSWORD_ENCRYPTION_MD5 `` or `` USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256 ``.
The default is `` password_encryption `` setting for cluster.

- `USER_PASSWORD_ENCRYPTION_UNSPECIFIED`
- `USER_PASSWORD_ENCRYPTION_MD5`
- `USER_PASSWORD_ENCRYPTION_SCRAM_SHA_256` ||
|| generate_password | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Generate password using Connection Manager. ||
|#

## Permission {#yandex.cloud.mdb.postgresql.v1.Permission}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|#

## UserSettings {#yandex.cloud.mdb.postgresql.v1.UserSettings}

PostgreSQL user settings.

#|
||Field | Description ||
|| default_transaction_isolation | enum **TransactionIsolation**

SQL sets an isolation level for each transaction.
This setting defines the default isolation level to be set for all new SQL transactions.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/transaction-iso.html).

- `TRANSACTION_ISOLATION_UNSPECIFIED`
- `TRANSACTION_ISOLATION_READ_UNCOMMITTED`: This level behaves like `TRANSACTION_ISOLATION_READ_COMMITTED` in PostgreSQL.
- `TRANSACTION_ISOLATION_READ_COMMITTED`: On this level query sees only data committed before the query began. Default value.
- `TRANSACTION_ISOLATION_REPEATABLE_READ`: On this level all subsequent queries in a transaction will see the same rows, that were read by the first `SELECT` or `INSERT` query in this transaction, unchanged (these rows are locked during the first query).
- `TRANSACTION_ISOLATION_SERIALIZABLE`: This level provides the strictest transaction isolation.
All queries in the current transaction see only the rows that were fixed prior to execution of the first `SELECT` or `INSERT` query in this transaction.
If read and write operations in a concurrent set of serializable transactions overlap and this may cause an inconsistency that is not possible during the serial transaction execution, then one of the transaction will be rolled back, triggering a serialization failure. ||
|| lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) for any statement to wait for acquiring a lock on an table, index, row or other database object.
If the wait time is longer than the specified amount, then this statement is aborted.

Default value: `0` (no control is enforced, a statement waiting time is unlimited). ||
|| log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

This setting controls logging of the duration of statements.

The duration of each completed statement will be logged if the statement ran for at least the specified amount of time (in milliseconds).
E.g., if this setting's value is set to `500`, a statement that took 300 milliseconds to complete will not be logged; on the other hand, the one that took 2000 milliseconds to complete, will be logged.

Value of `0` forces PostgreSQL to log the duration of all statements.

Value of `-1` (default) disables logging of the duration of statements.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html). ||
|| synchronous_commit | enum **SynchronousCommit**

This setting defines whether DBMS will commit transaction in a synchronous way.

When synchronization is enabled, cluster waits for the synchronous operations to be completed prior to reporting `success` to the client.
These operations guarantee different levels of the data safety and visibility in the cluster.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).

- `SYNCHRONOUS_COMMIT_UNSPECIFIED`
- `SYNCHRONOUS_COMMIT_ON`: Success is reported to the client if the data is in WAL (Write-Ahead Log), and WAL is written to the storage of both the master and its synchronous standby server. Default value.
- `SYNCHRONOUS_COMMIT_OFF`: Success is reported to the client even if the data is not in WAL.
There is no synchronous write operation, data may be loss in case of storage subsystem failure.
- `SYNCHRONOUS_COMMIT_LOCAL`: Success is reported to the client if the data is in WAL, and WAL is written to the storage of the master server.
The transaction may be lost due to storage subsystem failure on the master server.
- `SYNCHRONOUS_COMMIT_REMOTE_WRITE`: Success is reported to the client if the data is in WAL, WAL is written to the storage of the master server, and the server's synchronous standby indicates that it has received WAL and written it out to its operating system.
The transaction may be lost due to simultaneous storage subsystem failure on the master and operating system's failure on the synchronous standby.
- `SYNCHRONOUS_COMMIT_REMOTE_APPLY`: Success is reported to the client if the data is in WAL (Write-Ahead Log), WAL is written to the storage of the master server, and its synchronous standby indicates that it has received WAL and applied it.
The transaction may be lost due to irrecoverably failure of both the master and its synchronous standby. ||
|| temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum storage space size (in kilobytes) that a single process can use to create temporary files.
If a transaction exceeds this limit during execution, it will be aborted.

A huge query may not fit into a server's RAM, therefore PostgreSQL will use some storage to store and execute such a query. Too big queries can make excessive use of the storage system, effectively making other quieries to run slow. This setting prevents execution of a big queries that can influence other queries by limiting size of temporary files. ||
|| log_statement | enum **LogStatement**

This setting specifies which SQL statements should be logged (on the user level).

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- `LOG_STATEMENT_UNSPECIFIED`
- `LOG_STATEMENT_NONE`: Logs none of SQL statements. Default value.
- `LOG_STATEMENT_DDL`: Logs all data definition statements (such as `CREATE`, `ALTER`, `DROP` and others).
- `LOG_STATEMENT_MOD`: Logs all statements that fall in the `LOG_STATEMENT_DDL` category plus data-modifying statements (such as `INSERT`, `UPDATE` and others).
- `LOG_STATEMENT_ALL`: Logs all SQL statements. ||
|| pool_mode | enum **PoolingMode**

Mode that the connection pooler is working in with specified user.

For more information, see the [Odyssey documentation](https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Server connection will be assigned to it for the whole duration the client stays connected. Default value.
- `TRANSACTION`: Server connection is assigned to a client only during a transaction.
- `STATEMENT`: Server connection will be put back into the pool immediately after a query completes. ||
|| prepared_statements_pooling | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

User can use prepared statements with transaction pooling.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/sql-prepare.html). ||
|| catchup_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The connection pooler setting. It determines the maximum allowed replication lag (in seconds).
Pooler will reject connections to the replica with a lag above this threshold.
It can be useful to prevent application from reading stale data.

Default value: 0

Value of `0` disables this mechanism ||
|| wal_sender_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) to wait for WAL replication (can be set only for PostgreSQL 12+)
Terminate replication connections that are inactive for longer than this amount of time.

Default value: `60000` (60 seconds).

Value of `0` disables the timeout mechanism.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| idle_in_transaction_session_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum allowed idle time, in milliseconds, between queries while in a transaction.

The default value is `0`, which disables the timeout.

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). ||
|| statement_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time (in milliseconds) to wait for statement.
The timeout is measured from the time a command arrives at the server until it is completed by the server.

If `log_min_error_statement` is set to ERROR or lower, the statement that timed out will also be logged.

Value of `0` (default) disables the timeout

For more information, see the [PostgreSQL documentation](https://www.postgresql.org/docs/current/runtime-config-client.html). ||
|| pgaudit | **[PGAuditSettings](#yandex.cloud.mdb.postgresql.v1.PGAuditSettings)**

Settings of the [PostgreSQL Audit Extension](https://www.pgaudit.org/) (pgaudit). ||
|#

## PGAuditSettings {#yandex.cloud.mdb.postgresql.v1.PGAuditSettings}

#|
||Field | Description ||
|| log[] | enum **PGAuditSettingsLog**

Defines which user queries will be written to the audit log. Corresponds to the [Pg audit log](https://yandex.cloud/en/docs/managed-postgresql/concepts/settings-list#setting-pg-audit-log) user setting.

The possible values are the following:

* PG_AUDIT_SETTINGS_LOG_READ: `SELECT` and `COPY` queries are logged if the data source is a relation or query.
* PG_AUDIT_SETTINGS_LOG_WRITE: `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY` queries are logged if the data target is a relation.
* PG_AUDIT_SETTINGS_LOG_FUNCTION: Function invocations and `DO` sections are logged.
* PG_AUDIT_SETTINGS_LOG_ROLE: Statements related to role and privilege management, such as `GRANT`, `REVOKE`, or `CREATE/ALTER/DROP ROLE`, are logged.
* PG_AUDIT_SETTINGS_LOG_DDL: Any `DDL` statements that do not belong to the `ROLE` class are logged.
* PG_AUDIT_SETTINGS_LOG_MISC: Miscellaneous commands, such as `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, and `SET`, are logged.
* PG_AUDIT_SETTINGS_LOG_MISC_SET: Miscellaneous `SET` commands, e.g., `SET ROLE`, are logged.

The default value is PG_AUDIT_SETTINGS_LOG_UNSPECIFIED. In this case, the parameter is not configured.

- `PG_AUDIT_SETTINGS_LOG_UNSPECIFIED`
- `PG_AUDIT_SETTINGS_LOG_READ`
- `PG_AUDIT_SETTINGS_LOG_WRITE`
- `PG_AUDIT_SETTINGS_LOG_FUNCTION`
- `PG_AUDIT_SETTINGS_LOG_ROLE`
- `PG_AUDIT_SETTINGS_LOG_DDL`
- `PG_AUDIT_SETTINGS_LOG_MISC`
- `PG_AUDIT_SETTINGS_LOG_MISC_SET` ||
|#

## HostSpec {#yandex.cloud.mdb.postgresql.v1.HostSpec}

#|
||Field | Description ||
|| zone_id | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.network_id](#yandex.cloud.mdb.postgresql.v1.Cluster). ||
|| assign_public_ip | **bool**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assign_public_ip` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| replication_source | **string**

[Host.name](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) of the host to be used as the replication source (for cascading replication). ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Priority of the host as a replica. A higher value corresponds to higher priority.

The host with the highest priority is the synchronous replica. All others are asynchronous.
The synchronous replica replaces the master when needed.

When a replica becomes the master, its priority is ignored. ||
|| config_spec | **[ConfigHostSpec](#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec)**

Configuration of a PostgreSQL server for the host. ||
|#

## ConfigHostSpec {#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec}

#|
||Field | Description ||
|| postgresql_config_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**

Configuration for a host with PostgreSQL 9.6 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**

Configuration for a host with PostgreSQL 10 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**

Configuration for a host with PostgreSQL 10 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**

Configuration for a host with PostgreSQL 11 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**

Configuration for a host with PostgreSQL 12 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16.proto)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16_1c.proto)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_17 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host17.proto)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|| postgresql_config_17_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host17_1c.proto)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## BackupRetentionPolicySpec {#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicySpec}

Message to describe a new retention policy for cluster backups.

#|
||Field | Description ||
|| policy_name | **string**

Required field. Required. Policy name. ||
|| cron | **[CronTab](#yandex.cloud.mdb.postgresql.v1.CronTab)**

CronTab schedule. ||
|| retain_for_days | **int64**

Retention duration. ||
|| description | **string**

Human-readable description. ||
|#

## CronTab {#yandex.cloud.mdb.postgresql.v1.CronTab}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| day_of_month | **string** ||
|| month | **string** ||
|| day_of_week | **string** ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "operation_log": {
      "entities": [
        {
          "cluster_id": "string",
          "action": "string",
          "started_at": "google.protobuf.Timestamp",
          "hosts": [
            {
              "fqdn": "string",
              "action": "string",
              "started_at": "google.protobuf.Timestamp"
            }
          ]
        }
      ]
    }
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "environment": "Environment",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version": "string",
      // Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`
      "postgresql_config_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet9_6",
      "postgresql_config_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10_1C",
      "postgresql_config_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10",
      "postgresql_config_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11",
      "postgresql_config_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11_1C",
      "postgresql_config_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12",
      "postgresql_config_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12_1C",
      "postgresql_config_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13",
      "postgresql_config_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C",
      "postgresql_config_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14",
      "postgresql_config_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C",
      "postgresql_config_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15",
      "postgresql_config_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C",
      "postgresql_config_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16",
      "postgresql_config_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C",
      "postgresql_config_17": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17",
      "postgresql_config_17_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C",
      // end of the list of possible fields
      "pooler_config": {
        "pooling_mode": "PoolingMode",
        "pool_discard": "google.protobuf.BoolValue"
      },
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      },
      "autofailover": "google.protobuf.BoolValue",
      "backup_window_start": "google.type.TimeOfDay",
      "backup_retain_period_days": "google.protobuf.Int64Value",
      "access": {
        "data_lens": "bool",
        "web_sql": "bool",
        "serverless": "bool",
        "data_transfer": "bool",
        "yandex_query": "bool"
      },
      "performance_diagnostics": {
        "enabled": "bool",
        "sessions_sampling_interval": "int64",
        "statements_sampling_interval": "int64"
      },
      "disk_size_autoscaling": {
        "planned_usage_threshold": "int64",
        "emergency_usage_threshold": "int64",
        "disk_size_limit": "int64"
      }
    },
    "network_id": "string",
    "health": "Health",
    "status": "Status",
    "maintenance_window": {
      // Includes only one of the fields `anytime`, `weekly_maintenance_window`
      "anytime": "AnytimeMaintenanceWindow",
      "weekly_maintenance_window": {
        "day": "WeekDay",
        "hour": "int64"
      }
      // end of the list of possible fields
    },
    "planned_operation": {
      "info": "string",
      "delayed_until": "google.protobuf.Timestamp"
    },
    "security_group_ids": [
      "string"
    ],
    "deletion_protection": "bool",
    "host_group_ids": [
      "string"
    ],
    "disk_encryption_key_id": "google.protobuf.StringValue"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateClusterMetadata](#yandex.cloud.mdb.postgresql.v1.CreateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.mdb.postgresql.v1.Cluster)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateClusterMetadata {#yandex.cloud.mdb.postgresql.v1.CreateClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the PostgreSQL cluster that is being created. ||
|| operation_log | **[OperationLog](#yandex.cloud.mdb.operationlog.v1.OperationLog)**

Log of actions during operation ||
|#

## OperationLog {#yandex.cloud.mdb.operationlog.v1.OperationLog}

#|
||Field | Description ||
|| entities[] | **[ClusterEntity](#yandex.cloud.mdb.operationlog.v1.ClusterEntity)** ||
|#

## ClusterEntity {#yandex.cloud.mdb.operationlog.v1.ClusterEntity}

#|
||Field | Description ||
|| cluster_id | **string** ||
|| action | **string** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| hosts[] | **[HostEntity](#yandex.cloud.mdb.operationlog.v1.HostEntity)** ||
|#

## HostEntity {#yandex.cloud.mdb.operationlog.v1.HostEntity}

#|
||Field | Description ||
|| fqdn | **string** ||
|| action | **string** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#

## Cluster {#yandex.cloud.mdb.postgresql.v1.Cluster}

A PostgreSQL Cluster resource. For more information, see
the [Concepts](/docs/managed-postgresql/concepts) section of the documentation.

#|
||Field | Description ||
|| id | **string**

ID of the PostgreSQL cluster.
This ID is assigned by MDB at creation time. ||
|| folder_id | **string**

ID of the folder that the PostgreSQL cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the PostgreSQL cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the PostgreSQL cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the PostgreSQL cluster as `` key:value `` pairs.
Maximum 64 per resource. ||
|| environment | enum **Environment**

Deployment environment of the PostgreSQL cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.postgresql.v1.Monitoring)**

Description of monitoring systems relevant to the PostgreSQL cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.postgresql.v1.ClusterConfig)**

Configuration of the PostgreSQL cluster. ||
|| network_id | **string**

ID of the network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow2)**

Maintenance window for the cluster. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| host_group_ids[] | **string**

Host groups hosting VMs of the cluster. ||
|| disk_encryption_key_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the key to encrypt cluster disks. ||
|#

## Monitoring {#yandex.cloud.mdb.postgresql.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the PostgreSQL cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.postgresql.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of PostgreSQL server software. ||
|| postgresql_config_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**

Configuration of a PostgreSQL 9.6 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**

Configuration of a PostgreSQL 10 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**

Configuration of a PostgreSQL 10 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**

Configuration of a PostgreSQL 11 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**

Configuration of a PostgreSQL 11 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**

Configuration of a PostgreSQL 12 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**

Configuration of a PostgreSQL 12 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**

Configuration of a PostgreSQL 13 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**

Configuration of a PostgreSQL 13 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**

Configuration of a PostgreSQL 14 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**

Configuration of a PostgreSQL 14 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**

Configuration of a PostgreSQL 15 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**

Configuration of a PostgreSQL 15 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16.proto)**

Configuration of a PostgreSQL 16 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16_1c.proto)**

Configuration of a PostgreSQL 16 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_17 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17.proto)**

Configuration of a PostgreSQL 17 server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresql_config_17_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17_1c.proto)**

Configuration of a PostgreSQL 17 1C server.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| pooler_config | **[ConnectionPoolerConfig](#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig2)**

Configuration of the connection pooler. ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources2)**

Resources allocated to PostgreSQL hosts. ||
|| autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Configuration setting which enables/disables autofailover in cluster. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.postgresql.v1.Access2)**

Access policy to DB ||
|| performance_diagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics2)**

Configuration of the performance diagnostics service. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling2)**

Disk size autoscaling ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig2}

#|
||Field | Description ||
|| pooling_mode | enum **PoolingMode**

Mode that the connection pooler is working in.
See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Session pooling mode.
- `TRANSACTION`: Transaction pooling mode.
- `STATEMENT`: Statement pooling mode. ||
|| pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting `server_reset_query_always` parameter in PgBouncer. ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources2}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Access {#yandex.cloud.mdb.postgresql.v1.Access2}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens ||
|| web_sql | **bool**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. ||
|| serverless | **bool**

Allow access for Serverless ||
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|| yandex_query | **bool**

Allow access for YandexQuery. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics2}

#|
||Field | Description ||
|| enabled | **bool**

Configuration setting which enables/disables performance diagnostics service in cluster. ||
|| sessions_sampling_interval | **int64**

Interval (in seconds) for pg_stat_activity sampling ||
|| statements_sampling_interval | **int64**

Interval (in seconds) for pg_stat_statements sampling ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| planned_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergency_usage_threshold | **int64**

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| disk_size_limit | **int64**

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow2}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.AnytimeMaintenanceWindow2)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow2)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.AnytimeMaintenanceWindow2}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow2}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#