# Managed Service for Apache Airflow™ API, REST: Cluster.List

Retrieves a list of Apache Airflow Cluster resources.

## HTTP request

```
GET https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters
```

## Query parameters {#yandex.cloud.airflow.v1.ListClustersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list Apache Airflow clusters in.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClustersResponse.nextPageToken](#yandex.cloud.airflow.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClustersResponse.nextPageToken](#yandex.cloud.airflow.v1.ListClustersResponse)
returned by the previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.airflow.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.airflow.v1.ListClustersResponse}

**HTTP Code: 200 - OK**

```json
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "versionId": "string",
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
        "dagProcessor": {
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
        "datacatalog": {
          "enabled": "boolean"
        }
      },
      "health": "string",
      "status": "string",
      "network": {
        "subnetIds": [
          "string"
        ],
        "securityGroupIds": [
          "string"
        ]
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
      "deletionProtection": "boolean",
      "webserverUrl": "string",
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
      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string",
        "latestMaintenanceTime": "string",
        "nextMaintenanceWindowTime": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.airflow.v1.Cluster)**

List of Apache Airflow Cluster resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.pageSize](#yandex.cloud.airflow.v1.ListClustersRequest), use the `nextPageToken` as the value
for the [ListClustersRequest.pageToken](#yandex.cloud.airflow.v1.ListClustersRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.airflow.v1.Cluster}

Apache Airflow cluster.

#|
||Field | Description ||
|| id | **string**

Required field. Unique ID of the Apache Airflow cluster.
This ID is assigned by Cloud during cluster creation.

The maximum string length in characters is 50. ||
|| folderId | **string**

ID of the folder that the Apache Airflow cluster belongs to. ||
|| createdAt | **string** (date-time)

The time when the Apache Airflow cluster was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Apache Airflow cluster.
The name is unique within the folder. 1-64 characters long. ||
|| description | **string**

Description of the Apache Airflow cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.airflow.v1.Monitoring)**

Monitoring systems relevant to the Apache Airflow cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.airflow.v1.ClusterConfig)**

Configuration of Apache Airflow components. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).
- `ALIVE`: Cluster is alive and well.
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions). ||
|| status | **enum** (Status)

Cluster status.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting.
- `UPDATING`: Cluster is being updated. ||
|| network | **[NetworkConfig](#yandex.cloud.airflow.v1.NetworkConfig)**

Network related configuration options. ||
|| codeSync | **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**

Parameters of the location and access to the code that will be executed in the cluster. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster. ||
|| webserverUrl | **string**

Address of Apache Airflow web UI. ||
|| serviceAccountId | **string**

Service account used to access Cloud resources.
For more information, see [documentation](../../concepts/impersonation.md).

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig)**

Cloud Logging configuration. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.airflow.v1.MaintenanceOperation)**

Maintenance operation planned at nearest maintenance_window. ||
|#

## Monitoring {#yandex.cloud.airflow.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system. ||
|#

## ClusterConfig {#yandex.cloud.airflow.v1.ClusterConfig}

#|
||Field | Description ||
|| versionId | **string**

Version of Apache Airflow that runs on the cluster.
Use `airflow_version` instead. ||
|| airflow | **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig)**

Configuration of the Apache Airflow application itself. ||
|| webserver | **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig)**

Required field. Configuration of webserver instances. ||
|| scheduler | **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig)**

Required field. Configuration of scheduler instances. ||
|| dagProcessor | **[DagProcessorConfig](#yandex.cloud.airflow.v1.DagProcessorConfig)**

Configuration of dag-processor instances. ||
|| triggerer | **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig)**

Configuration of triggerer instances. ||
|| worker | **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig)**

Required field. Configuration of worker instances. ||
|| dependencies | **[Dependencies](#yandex.cloud.airflow.v1.Dependencies)**

The list of additional packages installed in the cluster. ||
|| lockbox | **[LockboxConfig](#yandex.cloud.airflow.v1.LockboxConfig)**

Configuration of Lockbox Secret Backend. ||
|| airflowVersion | **string**

Apache Airflow version. Format: "Major.Minor" ||
|| pythonVersion | **string**

Python version. Format: "Major.Minor" ||
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

## DagProcessorConfig {#yandex.cloud.airflow.v1.DagProcessorConfig}

#|
||Field | Description ||
|| count | **string** (int64)

The number of dag-processor instances in the cluster.

Acceptable values are 1 to 512, inclusive. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to dag-processor instances. ||
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

## DatacatalogConfig {#yandex.cloud.airflow.v1.DatacatalogConfig}

#|
||Field | Description ||
|| enabled | **boolean**

The setting allows to enable sending data to Datacatalog Backend. ||
|#

## NetworkConfig {#yandex.cloud.airflow.v1.NetworkConfig}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| securityGroupIds[] | **string**

User security groups. ||
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

## MaintenanceOperation {#yandex.cloud.airflow.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#