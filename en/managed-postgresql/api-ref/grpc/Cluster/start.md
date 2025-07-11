---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Cluster/start.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService.Start

Start the specified PostgreSQL cluster.

## gRPC request

**rpc Start ([StartClusterRequest](#yandex.cloud.mdb.postgresql.v1.StartClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StartClusterRequest {#yandex.cloud.mdb.postgresql.v1.StartClusterRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster to start. ||
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
    "cluster_id": "string"
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
|| metadata | **[StartClusterMetadata](#yandex.cloud.mdb.postgresql.v1.StartClusterMetadata)**

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

## StartClusterMetadata {#yandex.cloud.mdb.postgresql.v1.StartClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the PostgreSQL cluster. ||
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
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.postgresql.v1.MaintenanceWindow)**

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

## MaintenanceOperation {#yandex.cloud.mdb.postgresql.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#