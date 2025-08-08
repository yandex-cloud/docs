---
editable: false
sourcePath: en/_api-ref-grpc/airflow/v1/api-ref/grpc/Cluster/list.md
---

# Managed Service for Apache Airflow™ API, gRPC: ClusterService.List

Retrieves a list of Apache Airflow Cluster resources.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.airflow.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.airflow.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.airflow.v1.ListClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list Apache Airflow clusters in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#yandex.cloud.airflow.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListClustersResponse.next_page_token](#yandex.cloud.airflow.v1.ListClustersResponse)
returned by the previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.airflow.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## ListClustersResponse {#yandex.cloud.airflow.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
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
      "config": {
        "version_id": "string",
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
        "python_version": "string"
      },
      "health": "Health",
      "status": "Status",
      "network": {
        "subnet_ids": [
          "string"
        ],
        "security_group_ids": [
          "string"
        ]
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
      "deletion_protection": "bool",
      "webserver_url": "string",
      "service_account_id": "string",
      "logging": {
        "enabled": "bool",
        // Includes only one of the fields `folder_id`, `log_group_id`
        "folder_id": "string",
        "log_group_id": "string",
        // end of the list of possible fields
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
      },
      "planned_operation": {
        "info": "string",
        "delayed_until": "google.protobuf.Timestamp",
        "latest_maintenance_time": "google.protobuf.Timestamp",
        "next_maintenance_window_time": "google.protobuf.Timestamp"
      }
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.airflow.v1.Cluster)**

List of Apache Airflow Cluster resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.page_size](#yandex.cloud.airflow.v1.ListClustersRequest), use the `next_page_token` as the value
for the [ListClustersRequest.page_token](#yandex.cloud.airflow.v1.ListClustersRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.airflow.v1.Cluster}

Apache Airflow cluster.

#|
||Field | Description ||
|| id | **string**

Unique ID of the Apache Airflow cluster.
This ID is assigned by Cloud during cluster creation. ||
|| folder_id | **string**

ID of the folder that the Apache Airflow cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Apache Airflow cluster was created. ||
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
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).
- `ALIVE`: Cluster is alive and well.
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions). ||
|| status | enum **Status**

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
|| code_sync | **[CodeSyncConfig](#yandex.cloud.airflow.v1.CodeSyncConfig)**

Parameters of the location and access to the code that will be executed in the cluster. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster. ||
|| webserver_url | **string**

Address of Apache Airflow web UI. ||
|| service_account_id | **string**

Service account used to access Cloud resources.
For more information, see [documentation](/docs/managed-airflow/concepts/impersonation). ||
|| logging | **[LoggingConfig](#yandex.cloud.airflow.v1.LoggingConfig)**

Cloud Logging configuration. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.airflow.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.airflow.v1.MaintenanceOperation)**

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
|| version_id | **string**

Version of Apache Airflow that runs on the cluster.
Use `airflow_version` instead. ||
|| airflow | **[AirflowConfig](#yandex.cloud.airflow.v1.AirflowConfig)**

Configuration of the Apache Airflow application itself. ||
|| webserver | **[WebserverConfig](#yandex.cloud.airflow.v1.WebserverConfig)**

Required field. Configuration of webserver instances. ||
|| scheduler | **[SchedulerConfig](#yandex.cloud.airflow.v1.SchedulerConfig)**

Required field. Configuration of scheduler instances. ||
|| triggerer | **[TriggererConfig](#yandex.cloud.airflow.v1.TriggererConfig)**

Configuration of triggerer instances. ||
|| worker | **[WorkerConfig](#yandex.cloud.airflow.v1.WorkerConfig)**

Required field. Configuration of worker instances. ||
|| dependencies | **[Dependencies](#yandex.cloud.airflow.v1.Dependencies)**

The list of additional packages installed in the cluster. ||
|| lockbox | **[LockboxConfig](#yandex.cloud.airflow.v1.LockboxConfig)**

Configuration of Lockbox Secret Backend. ||
|| airflow_version | **string**

Apache Airflow version. Format: "Major.Minor" ||
|| python_version | **string**

Python version. Format: "Major.Minor" ||
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

The number of webserver instances in the cluster. ||
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

The number of scheduler instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to scheduler instances. ||
|#

## TriggererConfig {#yandex.cloud.airflow.v1.TriggererConfig}

#|
||Field | Description ||
|| count | **int64**

The number of triggerer instances in the cluster. ||
|| resources | **[Resources](#yandex.cloud.airflow.v1.Resources)**

Resources allocated to triggerer instances. ||
|#

## WorkerConfig {#yandex.cloud.airflow.v1.WorkerConfig}

#|
||Field | Description ||
|| min_count | **int64**

The minimum number of worker instances in the cluster. ||
|| max_count | **int64**

The maximum number of worker instances in the cluster. ||
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

## NetworkConfig {#yandex.cloud.airflow.v1.NetworkConfig}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| security_group_ids[] | **string**

User security groups. ||
|#

## CodeSyncConfig {#yandex.cloud.airflow.v1.CodeSyncConfig}

#|
||Field | Description ||
|| s3 | **[S3Config](#yandex.cloud.airflow.v1.S3Config)**

Includes only one of the fields `s3`, `git_sync`. ||
|| git_sync | **[GitSyncConfig](#yandex.cloud.airflow.v1.GitSyncConfig)**

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

## LoggingConfig {#yandex.cloud.airflow.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **bool**

Logs generated by the Airflow components are delivered to Cloud Logging. ||
|| folder_id | **string**

Logs should be written to default log group for specified folder.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| log_group_id | **string**

Logs should be written to log group resolved by ID.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination of log records. ||
|| min_level | enum **Level**

Minimum log entry level.

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

## MaintenanceOperation {#yandex.cloud.airflow.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#