---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Cluster/restore.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService.Restore {#Restore}

Creates a new PostgreSQL cluster using the specified backup.

## gRPC request

**rpc Restore ([RestoreClusterRequest](#yandex.cloud.mdb.postgresql.v1.RestoreClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RestoreClusterRequest {#yandex.cloud.mdb.postgresql.v1.RestoreClusterRequest}

```json
{
  "backupId": "string",
  "time": "google.protobuf.Timestamp",
  "timeInclusive": "bool",
  "name": "string",
  "description": "string",
  "labels": "string",
  "environment": "Environment",
  "configSpec": {
    "version": "string",
    // Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`
    "postgresqlConfig_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6",
    "postgresqlConfig_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C",
    "postgresqlConfig_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10",
    "postgresqlConfig_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11",
    "postgresqlConfig_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C",
    "postgresqlConfig_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12",
    "postgresqlConfig_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C",
    "postgresqlConfig_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13",
    "postgresqlConfig_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C",
    "postgresqlConfig_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14",
    "postgresqlConfig_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C",
    "postgresqlConfig_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15",
    "postgresqlConfig_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C",
    "postgresqlConfig_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16",
    "postgresqlConfig_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C",
    "postgresqlConfig_17": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17",
    "postgresqlConfig_17_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C",
    // end of the list of possible fields
    "poolerConfig": {
      "poolingMode": "PoolingMode",
      "poolDiscard": "google.protobuf.BoolValue"
    },
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "int64",
      "diskTypeId": "string"
    },
    "autofailover": "google.protobuf.BoolValue",
    "backupWindowStart": "google.type.TimeOfDay",
    "backupRetainPeriodDays": "google.protobuf.Int64Value",
    "access": {
      "dataLens": "bool",
      "webSql": "bool",
      "serverless": "bool",
      "dataTransfer": "bool",
      "yandexQuery": "bool"
    },
    "performanceDiagnostics": {
      "enabled": "bool",
      "sessionsSamplingInterval": "int64",
      "statementsSamplingInterval": "int64"
    },
    "diskSizeAutoscaling": {
      "plannedUsageThreshold": "int64",
      "emergencyUsageThreshold": "int64",
      "diskSizeLimit": "int64"
    }
  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "bool",
      "replicationSource": "string",
      "priority": "google.protobuf.Int64Value",
      "configSpec": {
        // Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`
        "postgresqlConfig_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6",
        "postgresqlConfig_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C",
        "postgresqlConfig_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10",
        "postgresqlConfig_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11",
        "postgresqlConfig_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C",
        "postgresqlConfig_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12",
        "postgresqlConfig_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C",
        "postgresqlConfig_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13",
        "postgresqlConfig_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C",
        "postgresqlConfig_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14",
        "postgresqlConfig_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C",
        "postgresqlConfig_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15",
        "postgresqlConfig_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C",
        "postgresqlConfig_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16",
        "postgresqlConfig_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C",
        "postgresqlConfig_17": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17",
        "postgresqlConfig_17_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C"
        // end of the list of possible fields
      }
    }
  ],
  "networkId": "string",
  "folderId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "bool",
  "hostGroupIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to create a cluster from.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-postgresql/api-ref/grpc/Cluster/listBackups#ListBackups) request. ||
|| time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the moment to which the PostgreSQL cluster should be restored. ||
|| timeInclusive | **bool**

Flag that indicates whether a database should be restored to the first backup point
available just after the timestamp specified in the `time` field instead of just before.

Possible values:
* false (default) - the restore point refers to the first backup moment before `time`.
* true - the restore point refers to the first backup point after `time`. ||
|| name | **string**

Required field. Name of the new PostgreSQL cluster. The name must be unique within the folder. ||
|| description | **string**

Description of the new PostgreSQL cluster. ||
|| labels | **string**

Custom labels for the PostgreSQL cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary". ||
|| environment | enum **Environment**

Required field. Deployment environment of the new PostgreSQL cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| configSpec | **[ConfigSpec](#yandex.cloud.mdb.postgresql.v1.ConfigSpec)**

Required field. Configuration for the PostgreSQL cluster to be created. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.postgresql.v1.HostSpec)**

Configurations for PostgreSQL hosts that should be created for
the cluster that is being created from the backup. ||
|| networkId | **string**

Required field. ID of the network to create the PostgreSQL cluster in. ||
|| folderId | **string**

ID of the folder to create the PostgreSQL cluster in. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
|#

## ConfigSpec {#yandex.cloud.mdb.postgresql.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of PostgreSQL used in the cluster.
Possible values: `9.6`, `10`, `10_1c`, `11`, `12`, `13`, `14`, `15`, `16`, `17` ||
|| postgresqlConfig_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**

Configuration for a PostgreSQL 9.6 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**

Configuration for a PostgreSQL 10 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**

Configuration for a PostgreSQL 10 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**

Configuration for a PostgreSQL 11 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**

Configuration for a PostgreSQL 11 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**

Configuration for a PostgreSQL 12 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**

Configuration for a PostgreSQL 12 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**

Configuration for a PostgreSQL 13 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**

Configuration for a PostgreSQL 13 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**

Configuration for a PostgreSQL 14 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**

Configuration for a PostgreSQL 14 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**

Configuration for a PostgreSQL 15 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**

Configuration for a PostgreSQL 15 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16.proto)**

Configuration for a PostgreSQL 16 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16_1c.proto)**

Configuration for a PostgreSQL 16 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_17 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17.proto)**

Configuration for a PostgreSQL 17 cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| postgresqlConfig_17_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfig17_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17_1c.proto)**

Configuration for a PostgreSQL 17 1C cluster.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration of a PostgreSQL cluster. ||
|| poolerConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig)**

Configuration of the connection pooler. ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources)**

Resources allocated to PostgreSQL hosts. ||
|| autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Configuration setting which enables/disables autofailover in cluster. ||
|| backupWindowStart | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.postgresql.v1.Access)**

Access policy to DB ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics)**

Configuration of the performance diagnostics service. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling)**

Disk size autoscaling ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| poolingMode | enum **PoolingMode**

Mode that the connection pooler is working in.
See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Session pooling mode.
- `TRANSACTION`: Transaction pooling mode.
- `STATEMENT`: Statement pooling mode. ||
|| poolDiscard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting `server_reset_query_always` parameter in PgBouncer. ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). ||
|| diskSize | **int64**

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Access {#yandex.cloud.mdb.postgresql.v1.Access}

#|
||Field | Description ||
|| dataLens | **bool**

Allow access for DataLens ||
|| webSql | **bool**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. ||
|| serverless | **bool**

Allow access for Serverless ||
|| dataTransfer | **bool**

Allow access for DataTransfer. ||
|| yandexQuery | **bool**

Allow access for YandexQuery. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics}

#|
||Field | Description ||
|| enabled | **bool**

Configuration setting which enables/disables performance diagnostics service in cluster. ||
|| sessionsSamplingInterval | **int64**

Interval (in seconds) for pg_stat_activity sampling ||
|| statementsSamplingInterval | **int64**

Interval (in seconds) for pg_stat_statements sampling ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **int64**

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergencyUsageThreshold | **int64**

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| diskSizeLimit | **int64**

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## HostSpec {#yandex.cloud.mdb.postgresql.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.networkId](#yandex.cloud.mdb.postgresql.v1.Cluster). ||
|| assignPublicIp | **bool**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| replicationSource | **string**

[Host.name](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) of the host to be used as the replication source (for cascading replication). ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Priority of the host as a replica. A higher value corresponds to higher priority.

The host with the highest priority is the synchronous replica. All others are asynchronous.
The synchronous replica replaces the master when needed.

When a replica becomes the master, its priority is ignored. ||
|| configSpec | **[ConfigHostSpec](#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec)**

Configuration of a PostgreSQL server for the host. ||
|#

## ConfigHostSpec {#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec}

#|
||Field | Description ||
|| postgresqlConfig_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**

Configuration for a host with PostgreSQL 9.6 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**

Configuration for a host with PostgreSQL 10 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**

Configuration for a host with PostgreSQL 10 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**

Configuration for a host with PostgreSQL 11 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**

Configuration for a host with PostgreSQL 12 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16.proto)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16_1c.proto)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_17 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host17.proto)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|| postgresqlConfig_17_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host17_1c.proto)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "backupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
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
      // Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`
      "postgresqlConfig_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet9_6",
      "postgresqlConfig_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10_1C",
      "postgresqlConfig_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10",
      "postgresqlConfig_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11",
      "postgresqlConfig_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11_1C",
      "postgresqlConfig_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12",
      "postgresqlConfig_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12_1C",
      "postgresqlConfig_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13",
      "postgresqlConfig_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C",
      "postgresqlConfig_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14",
      "postgresqlConfig_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C",
      "postgresqlConfig_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15",
      "postgresqlConfig_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C",
      "postgresqlConfig_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16",
      "postgresqlConfig_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C",
      "postgresqlConfig_17": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17",
      "postgresqlConfig_17_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C",
      // end of the list of possible fields
      "poolerConfig": {
        "poolingMode": "PoolingMode",
        "poolDiscard": "google.protobuf.BoolValue"
      },
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "int64",
        "diskTypeId": "string"
      },
      "autofailover": "google.protobuf.BoolValue",
      "backupWindowStart": "google.type.TimeOfDay",
      "backupRetainPeriodDays": "google.protobuf.Int64Value",
      "access": {
        "dataLens": "bool",
        "webSql": "bool",
        "serverless": "bool",
        "dataTransfer": "bool",
        "yandexQuery": "bool"
      },
      "performanceDiagnostics": {
        "enabled": "bool",
        "sessionsSamplingInterval": "int64",
        "statementsSamplingInterval": "int64"
      },
      "diskSizeAutoscaling": {
        "plannedUsageThreshold": "int64",
        "emergencyUsageThreshold": "int64",
        "diskSizeLimit": "int64"
      }
    },
    "networkId": "string",
    "health": "Health",
    "status": "Status",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "AnytimeMaintenanceWindow",
      "weeklyMaintenanceWindow": {
        "day": "WeekDay",
        "hour": "int64"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "google.protobuf.Timestamp"
    },
    "securityGroupIds": [
      "string"
    ],
    "deletionProtection": "bool",
    "hostGroupIds": [
      "string"
    ]
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[RestoreClusterMetadata](#yandex.cloud.mdb.postgresql.v1.RestoreClusterMetadata)**

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

## RestoreClusterMetadata {#yandex.cloud.mdb.postgresql.v1.RestoreClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the new PostgreSQL cluster that is being created from a backup. ||
|| backupId | **string**

ID of the backup that is being used for creating a cluster. ||
|#

## Cluster {#yandex.cloud.mdb.postgresql.v1.Cluster}

A PostgreSQL Cluster resource. For more information, see
the [Concepts](/docs/managed-postgresql/concepts) section of the documentation.

#|
||Field | Description ||
|| id | **string**

ID of the PostgreSQL cluster.
This ID is assigned by MDB at creation time. ||
|| folderId | **string**

ID of the folder that the PostgreSQL cluster belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the PostgreSQL cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the PostgreSQL cluster. 0-256 characters long. ||
|| labels | **string**

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
|| networkId | **string**

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
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| hostGroupIds[] | **string**

Host groups hosting VMs of the cluster. ||
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
|| postgresqlConfig_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**

Configuration of a PostgreSQL 9.6 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**

Configuration of a PostgreSQL 10 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**

Configuration of a PostgreSQL 10 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**

Configuration of a PostgreSQL 11 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11_1c.proto)**

Configuration of a PostgreSQL 11 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**

Configuration of a PostgreSQL 12 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12_1c.proto)**

Configuration of a PostgreSQL 12 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13.proto)**

Configuration of a PostgreSQL 13 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql13_1c.proto)**

Configuration of a PostgreSQL 13 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14.proto)**

Configuration of a PostgreSQL 14 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql14_1c.proto)**

Configuration of a PostgreSQL 14 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15.proto)**

Configuration of a PostgreSQL 15 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql15_1c.proto)**

Configuration of a PostgreSQL 15 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16.proto)**

Configuration of a PostgreSQL 16 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql16_1c.proto)**

Configuration of a PostgreSQL 16 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_17 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17.proto)**

Configuration of a PostgreSQL 17 server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| postgresqlConfig_17_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlConfigSet17_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql17_1c.proto)**

Configuration of a PostgreSQL 17 1C server.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`, `postgresqlConfig_17`, `postgresqlConfig_17_1c`.

Configuration for PostgreSQL servers in the cluster. ||
|| poolerConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig2)**

Configuration of the connection pooler. ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources2)**

Resources allocated to PostgreSQL hosts. ||
|| autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Configuration setting which enables/disables autofailover in cluster. ||
|| backupWindowStart | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.postgresql.v1.Access2)**

Access policy to DB ||
|| performanceDiagnostics | **[PerformanceDiagnostics](#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics2)**

Configuration of the performance diagnostics service. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling2)**

Disk size autoscaling ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.postgresql.v1.ConnectionPoolerConfig2}

#|
||Field | Description ||
|| poolingMode | enum **PoolingMode**

Mode that the connection pooler is working in.
See descriptions of all modes in the [documentation for PgBouncer](https://pgbouncer.github.io/usage).

- `POOLING_MODE_UNSPECIFIED`
- `SESSION`: Session pooling mode.
- `TRANSACTION`: Transaction pooling mode.
- `STATEMENT`: Statement pooling mode. ||
|| poolDiscard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Setting `server_reset_query_always` parameter in PgBouncer. ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources2}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). ||
|| diskSize | **int64**

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Access {#yandex.cloud.mdb.postgresql.v1.Access2}

#|
||Field | Description ||
|| dataLens | **bool**

Allow access for DataLens ||
|| webSql | **bool**

Allow SQL queries to the cluster databases from the management console.

See [SQL queries in the management console](/docs/managed-postgresql/operations/web-sql-query) for more details. ||
|| serverless | **bool**

Allow access for Serverless ||
|| dataTransfer | **bool**

Allow access for DataTransfer. ||
|| yandexQuery | **bool**

Allow access for YandexQuery. ||
|#

## PerformanceDiagnostics {#yandex.cloud.mdb.postgresql.v1.PerformanceDiagnostics2}

#|
||Field | Description ||
|| enabled | **bool**

Configuration setting which enables/disables performance diagnostics service in cluster. ||
|| sessionsSamplingInterval | **int64**

Interval (in seconds) for pg_stat_activity sampling ||
|| statementsSamplingInterval | **int64**

Interval (in seconds) for pg_stat_statements sampling ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.postgresql.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| plannedUsageThreshold | **int64**

Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold. ||
|| emergencyUsageThreshold | **int64**

Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold. ||
|| diskSizeLimit | **int64**

New storage size (in bytes) that is set when one of the thresholds is achieved. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

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

## MaintenanceOperation {#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#