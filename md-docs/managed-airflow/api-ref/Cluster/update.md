# Managed Service for Apache Airflow™ API, REST: Cluster.Update

Updates the specified Apache Airflow cluster.

## HTTP request

```
PATCH https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Airflow Cluster resource to update.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.airflow.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "airflow": {
      "config": "object"
    },
    "webserver": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "scheduler": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "triggerer": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "worker": {
      "minCount": "string",
      "maxCount": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "dependencies": {
      "pipPackages": [
        "string"
      ],
      "debPackages": [
        "string"
      ]
    },
    "lockbox": {
      "enabled": "boolean"
    },
    "airflowVersion": "string",
    "pythonVersion": "string",
    "dagProcessor": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "datacatalog": {
      "enabled": "boolean"
    }
  },
  "codeSync": {
    // Includes only one of the fields `s3`, `gitSync`
    "s3": {
      "bucket": "string"
    },
    "gitSync": {
      "repo": "string",
      "branch": "string",
      "subPath": "string",
      "sshKey": "string"
    }
    // end of the list of possible fields
  },
  "networkSpec": {
    "securityGroupIds": [
      "string"
    ]
  },
  "deletionProtection": "boolean",
  "serviceAccountId": "string",
  "logging": {
    // Includes only one of the fields `folderId`, `logGroupId`
    "folderId": "string",
    "logGroupId": "string",
    // end of the list of possible fields
    "enabled": "boolean",
    "minLevel": "string"
  },
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the cluster.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

New description of the Apache Airflow cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Apache Airflow cluster as `` key:value `` pairs. For example, "env": "prod".
The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](get.md#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| configSpec | **[UpdateClusterConfigSpec](#yandex.cloud.airflow.v1.UpdateClusterConfigSpec)**

Configuration of Apache Airflow components. ||
|| codeSync | **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**

Parameters of the location and access to the code that will be executed in the cluster. ||
|| networkSpec | **[UpdateNetworkConfigSpec](#yandex.cloud.airflow.v1.UpdateNetworkConfigSpec)**

Network related configuration options. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| serviceAccountId | **string**

Service account used to access Cloud resources.
For more information, see [documentation](../../concepts/impersonation.md).

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig)**

Cloud Logging configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow)**

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
|| airflowVersion | **string**

Apache Airflow version. Format: "Major.Minor" ||
|| pythonVersion | **string**

Python version. Format: "Major.Minor" ||
|| dagProcessor | **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig)**

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
|| count | **string** (int64)

The number of webserver instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to webserver instances. ||
|#

## Resources {#yandex.cloud.airflow.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to an instance (CPU, memory etc.). ||
|#

## SchedulerConfig {#yandex.cloud.airflow.v1.SchedulerConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of scheduler instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to scheduler instances. ||
|#

## TriggererConfig {#yandex.cloud.airflow.v1.TriggererConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of triggerer instances in the cluster.

Acceptable values are 0 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to triggerer instances. ||
|#

## WorkerConfig {#yandex.cloud.airflow.v1.WorkerConfig}

#|
||Field | Description ||
|| minCount | **string** (int64)

The minimum number of worker instances in the cluster.

Acceptable values are 0 to 512, inclusive. ||
|| maxCount | **string** (int64)

The maximum number of worker instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to worker instances. ||
|#

## Dependencies {#yandex.cloud.airflow.v1.Dependencies}

#|
||Field | Description ||
|| pipPackages[] | **string**

Python packages that are installed in the cluster. ||
|| debPackages[] | **string**

System packages that are installed in the cluster. ||
|#

## LockboxConfig {#yandex.cloud.airflow.v1.LockboxConfig}

#|
||Field | Description ||
|| enabled | **boolean**

The setting allows to enable Lockbox Secret Backend. ||
|#

## DagProcessorConfig {#yandex.cloud.airflow.v1.DagProcessorConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of dag-processor instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to dag-processor instances. ||
|#

## DatacatalogConfig {#yandex.cloud.airflow.v1.DatacatalogConfig}

#|
||Field | Description ||
|| enabled | **boolean**

The setting allows to enable sending data to Datacatalog Backend. ||
|#

## CodeSyncConfig {#yandex.cloud.airflow.v1.CodeSyncConfig}

#|
||Field | Description ||
|| s3 | **[S3Config](#yandex.cloud.airflow.v1.S3Config)**

Configuration for s3 folder for dags

Includes only one of the fields `s3`, `gitSync`. ||
|| gitSync | **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig)**

Configuration for git repository for dags

Includes only one of the fields `s3`, `gitSync`. ||
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
|| subPath | **string**

Subdirectory path within the repository containing DAG files. ||
|| sshKey | **string**

SSH private key for repository authentication. ||
|#

## UpdateNetworkConfigSpec {#yandex.cloud.airflow.v1.UpdateNetworkConfigSpec}

#|
||Field | Description ||
|| securityGroupIds[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.airflow.v1.LoggingConfig}

#|
||Field | Description ||
|| folderId | **string**

Logs should be written to default log group for specified folder.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| logGroupId | **string**

Logs should be written to log group resolved by ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`.

Destination of log records. ||
|| enabled | **boolean**

Logs generated by the Airflow components are delivered to Cloud Logging. ||
|| minLevel | **enum** (Level)

Minimum log entry level.
See [LogLevel.Level](../../../logging/api-ref/Export/get.md#yandex.cloud.logging.v1.LogLevel.Level) for details.

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
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.airflow.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC.

Acceptable values are 1 to 24, inclusive. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#