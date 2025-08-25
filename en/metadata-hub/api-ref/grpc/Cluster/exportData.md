---
editable: false
sourcePath: en/_api-ref-grpc/metastore/v1/api-ref/grpc/Cluster/exportData.md
---

# Managed Service for Hive Metastore™ API, gRPC: ClusterService.ExportData

Exports data from the specified Metastore Cluster.

## gRPC request

**rpc ExportData ([ExportDataRequest](#yandex.cloud.metastore.v1.ExportDataRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ExportDataRequest {#yandex.cloud.metastore.v1.ExportDataRequest}

```json
{
  "cluster_id": "string",
  "bucket": "string",
  "filepath": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Metastore Cluster from which data will be exported. ||
|| bucket | **string**

Required field. S3 bucket to export backup to. ||
|| filepath | **string**

Required field. Path to the export dump in the bucket. ||
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
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "health": "Health",
    "status": "Status",
    "deletion_protection": "bool",
    "version": "string",
    "network_id": "string",
    "endpoint_ip": "string",
    "cluster_config": {
      "resources": {
        "resource_preset_id": "string"
      }
    },
    "service_account_id": "string",
    "logging": {
      "enabled": "bool",
      // Includes only one of the fields `folder_id`, `log_group_id`
      "folder_id": "string",
      "log_group_id": "string",
      // end of the list of possible fields
      "min_level": "Level"
    },
    "network": {
      "subnet_ids": [
        "string"
      ],
      "security_group_ids": [
        "string"
      ]
    },
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
      "delayed_until": "google.protobuf.Timestamp",
      "latest_maintenance_time": "google.protobuf.Timestamp",
      "next_maintenance_window_time": "google.protobuf.Timestamp"
    }
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
|| metadata | **[ExportDataMetadata](#yandex.cloud.metastore.v1.ExportDataMetadata)**

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
|| response | **[Cluster](#yandex.cloud.metastore.v1.Cluster)**

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

## ExportDataMetadata {#yandex.cloud.metastore.v1.ExportDataMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Metastore Cluster from which data is being exported. ||
|#

## Cluster {#yandex.cloud.metastore.v1.Cluster}

Metastore Cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Metastore Cluster.
This ID is assigned by Cloud in the process of creating a Trino cluster. ||
|| folder_id | **string**

ID of the folder that the Metastore Cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time the Metastore Cluster was created at. ||
|| name | **string**

Name of the Metastore Cluster.
The name is unique within the folder. ||
|| description | **string**

Description of the Metastore Cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Metastore Cluster as `` key:value `` pairs. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.metastore.v1.Monitoring)**

Monitoring systems relevant to the Metastore Cluster. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).
- `ALIVE`: Cluster is alive and operates properly.
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions). ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| deletion_protection | **bool**

Deletion Protection prevents deletion of the cluster. ||
|| version | **string**

Metastore server version. ||
|| network_id | **string**

Metastore network ID. ||
|| endpoint_ip | **string**

IP address of the Metastore server load balancer. ||
|| cluster_config | **[ClusterConfig](#yandex.cloud.metastore.v1.ClusterConfig)**

Configuration of the Metastore Cluster. ||
|| service_account_id | **string**

Service account used to access Cloud resources. ||
|| logging | **[LoggingConfig](#yandex.cloud.metastore.v1.LoggingConfig)**

Cloud logging configuration. ||
|| network | **[NetworkConfig](#yandex.cloud.metastore.v1.NetworkConfig)**

Network-related configuration options. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.metastore.v1.MaintenanceWindow)**

Maintenance window. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.metastore.v1.MaintenanceOperation)**

Maintenance operation scheduled for the nearest maintenance window. ||
|#

## Monitoring {#yandex.cloud.metastore.v1.Monitoring}

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## ClusterConfig {#yandex.cloud.metastore.v1.ClusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.metastore.v1.Resources)**

Configuration for computational resources for Metastore server instances. ||
|#

## Resources {#yandex.cloud.metastore.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the preset for computational resources allocated to an instance (e.g., CPU, memory, etc.). ||
|#

## LoggingConfig {#yandex.cloud.metastore.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **bool**

Logs generated by the Metastore server are delivered to Cloud Logging. ||
|| folder_id | **string**

Logs will be written to the default log group of the specified folder.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| log_group_id | **string**

Logs will be written to the log group specified by its ID.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| min_level | enum **Level**

Minimum severity level for log entries.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#

## NetworkConfig {#yandex.cloud.metastore.v1.NetworkConfig}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| security_group_ids[] | **string**

User security groups. ||
|#

## MaintenanceWindow {#yandex.cloud.metastore.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.metastore.v1.AnytimeMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.metastore.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.metastore.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC. ||
|#

## MaintenanceOperation {#yandex.cloud.metastore.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#