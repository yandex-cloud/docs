---
editable: false
---

# Managed Service for Apache Airflow™ API, gRPC: ClusterService.Update

Updates the specified Apache Airflow cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.airflow.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.airflow.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "config_spec": {
    "airflow": {
      "config": "map<string, string>"
    },
    "webserver": {
      "count": "int64",
      "resources": {
        "resource_preset_id": "string"
      }
    },
    "scheduler": {
      "count": "int64",
      "resources": {
        "resource_preset_id": "string"
      }
    },
    "triggerer": {
      "count": "int64",
      "resources": {
        "resource_preset_id": "string"
      }
    },
    "worker": {
      "min_count": "int64",
      "max_count": "int64",
      "resources": {
        "resource_preset_id": "string"
      }
    },
    "dependencies": {
      "pip_packages": [
        "string"
      ],
      "deb_packages": [
        "string"
      ]
    },
    "lockbox": {
      "enabled": "bool"
    },
    "airflow_version": "string",
    "python_version": "string",
    "dag_processor": {
      "count": "int64",
      "resources": {
        "resource_preset_id": "string"
      }
    },
    "datacatalog": {
      "enabled": "bool"
    }
  },
  "code_sync": {
    // Includes only one of the fields `s3`, `git_sync`
    "s3": {
      "bucket": "string"
    },
    "git_sync": {
      "repo": "string",
      "branch": "string",
      "sub_path": "string",
      "ssh_key": "string"
    }
    // end of the list of possible fields
  },
  "network_spec": {
    "security_group_ids": [
      "string"
    ]
  },
  "deletion_protection": "bool",
  "service_account_id": "string",
  "logging": {
    // Includes only one of the fields `folder_id`, `log_group_id`
    "folder_id": "string",
    "log_group_id": "string",
    // end of the list of possible fields
    "enabled": "bool",
    "min_level": "Level"
  },
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Airflow Cluster resource to update.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Apache Airflow Cluster resource should be updated. ||
|| name | **string**

New name of the cluster.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

New description of the Apache Airflow cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod".
The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](/docs/managed-airflow/api-ref/grpc/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| config_spec | **[UpdateClusterConfigSpec](#yandex.cloud.airflow.v1.UpdateClusterConfigSpec)**

Configuration of Apache Airflow components. ||
|| code_sync | **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**

Parameters of the location and access to the code that will be executed in the cluster. ||
|| network_spec | **[UpdateNetworkConfigSpec](#yandex.cloud.airflow.v1.UpdateNetworkConfigSpec)**

Network related configuration options. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| service_account_id | **string**

Service account used to access Cloud resources.
For more information, see [documentation](/docs/managed-airflow/concepts/impersonation).

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig)**

Cloud Logging configuration. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|#

## UpdateClusterConfigSpec {#yandex.cloud.airflow.v1.UpdateClusterConfigSpec}

#|
||Field | Description ||
|| airflow | **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig)**

Configuration of the Apache Airflow application itself. ||
|| webserver | **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig)**

Configuration of webserver instances. ||
|| scheduler | **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig)**

Configuration of scheduler instances. ||
|| triggerer | **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig)**

Configuration of triggerer instances. ||
|| worker | **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig)**

Configuration of worker instances. ||
|| dependencies | **[Dependencies](#yandex.cloud.airflow.v1.Dependencies)**

The list of additional packages installed in the cluster. ||
|| lockbox | **[LockboxConfig](#yandex.cloud.airflow.v1.LockboxConfig)**

Configuration of Lockbox Secret Backend. ||
|| airflow_version | **string**

Apache Airflow version. Format: "Major.Minor" ||
|| python_version | **string**

Python version. Format: "Major.Minor" ||
|| dag_processor | **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig)**

Configuration of dag-processor instances. ||
|| datacatalog | **[DatacatalogConfig](#yandex.cloud.airflow.v1.DatacatalogConfig)**

Configuration for datacatalog integration. ||
|#

## AirflowConfig {#yandex.cloud.airflow.v1.AirflowConfig}

#|
||Field | Description ||
|| config | **object** (map<**string**, **string**>)

Properties to be passed to Apache Airflow configuration file. ||
|#

## WebserverConfig {#yandex.cloud.airflow.v1.WebserverConfig}

#|
||Field | Description ||
|| count | **int64**

The number of webserver instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to webserver instances. ||
|#

## Resources {#yandex.cloud.airflow.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to an instance (CPU, memory etc.). ||
|#

## SchedulerConfig {#yandex.cloud.airflow.v1.SchedulerConfig}

#|
||Field | Description ||
|| count | **int64**

The number of scheduler instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to scheduler instances. ||
|#

## TriggererConfig {#yandex.cloud.airflow.v1.TriggererConfig}

#|
||Field | Description ||
|| count | **int64**

The number of triggerer instances in the cluster.

Acceptable values are 0 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to triggerer instances. ||
|#

## WorkerConfig {#yandex.cloud.airflow.v1.WorkerConfig}

#|
||Field | Description ||
|| min_count | **int64**

The minimum number of worker instances in the cluster.

Acceptable values are 0 to 512, inclusive. ||
|| max_count | **int64**

The maximum number of worker instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to worker instances. ||
|#

## Dependencies {#yandex.cloud.airflow.v1.Dependencies}

#|
||Field | Description ||
|| pip_packages[] | **string**

Python packages that are installed in the cluster. ||
|| deb_packages[] | **string**

System packages that are installed in the cluster. ||
|#

## LockboxConfig {#yandex.cloud.airflow.v1.LockboxConfig}

#|
||Field | Description ||
|| enabled | **bool**

The setting allows to enable Lockbox Secret Backend. ||
|#

## DagProcessorConfig {#yandex.cloud.airflow.v1.DagProcessorConfig}

#|
||Field | Description ||
|| count | **int64**

The number of dag-processor instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to dag-processor instances. ||
|#

## DatacatalogConfig {#yandex.cloud.airflow.v1.DatacatalogConfig}

#|
||Field | Description ||
|| enabled | **bool**

The setting allows to enable sending data to Datacatalog Backend. ||
|#

## CodeSyncConfig {#yandex.cloud.airflow.v1.CodeSyncConfig}

#|
||Field | Description ||
|| s3 | **[S3Config](#yandex.cloud.airflow.v1.S3Config)**

Configuration for s3 folder for dags

Includes only one of the fields `s3`, `git_sync`. ||
|| git_sync | **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig)**

Configuration for git repository for dags

Includes only one of the fields `s3`, `git_sync`. ||
|#

## S3Config {#yandex.cloud.airflow.v1.S3Config}

#|
||Field | Description ||
|| bucket | **string**

The name of the Object Storage bucket that stores DAG files used in the cluster. ||
|#

## GitSyncConfig {#yandex.cloud.airflow.v1.GitSyncConfig}

#|
||Field | Description ||
|| repo | **string**

Required field. Git repository URL. ||
|| branch | **string**

Required field. Git branch name to sync from. ||
|| sub_path | **string**

Subdirectory path within the repository containing DAG files. ||
|| ssh_key | **string**

SSH private key for repository authentication. ||
|#

## UpdateNetworkConfigSpec {#yandex.cloud.airflow.v1.UpdateNetworkConfigSpec}

#|
||Field | Description ||
|| security_group_ids[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.airflow.v1.LoggingConfig}

#|
||Field | Description ||
|| folder_id | **string**

Logs should be written to default log group for specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| log_group_id | **string**

Logs should be written to log group resolved by ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| enabled | **bool**

Logs generated by the Airflow components are delivered to Cloud Logging. ||
|| min_level | enum **Level**

Minimum log entry level.
See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/get#yandex.cloud.logging.v1.LogLevel.Level) for details.

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

## MaintenanceWindow {#yandex.cloud.airflow.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.airflow.v1.AnytimeMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.airflow.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | enum **WeekDay**

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC.

Acceptable values are 1 to 24, inclusive. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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