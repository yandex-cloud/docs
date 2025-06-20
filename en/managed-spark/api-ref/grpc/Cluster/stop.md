---
editable: false
sourcePath: en/_api-ref-grpc/spark/v1/api-ref/grpc/Cluster/stop.md
---

# Managed Spark API, gRPC: ClusterService.Stop

Stops the specified Spark cluster

## gRPC request

**rpc Stop ([StopClusterRequest](#yandex.cloud.spark.v1.StopClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StopClusterRequest {#yandex.cloud.spark.v1.StopClusterRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Spark cluster that is being stopped. ||
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
    "config": {
      "resource_pools": {
        "driver": {
          "resource_preset_id": "string",
          "scale_policy": {
            // Includes only one of the fields `fixed_scale`, `auto_scale`
            "fixed_scale": {
              "size": "int64"
            },
            "auto_scale": {
              "min_size": "int64",
              "max_size": "int64"
            }
            // end of the list of possible fields
          }
        },
        "executor": {
          "resource_preset_id": "string",
          "scale_policy": {
            // Includes only one of the fields `fixed_scale`, `auto_scale`
            "fixed_scale": {
              "size": "int64"
            },
            "auto_scale": {
              "min_size": "int64",
              "max_size": "int64"
            }
            // end of the list of possible fields
          }
        }
      },
      "history_server": {
        "enabled": "bool"
      },
      "dependencies": {
        "pip_packages": [
          "string"
        ],
        "deb_packages": [
          "string"
        ]
      },
      "metastore": {
        "cluster_id": "string"
      }
    },
    "status": "Status",
    "network": {
      "subnet_ids": [
        "string"
      ],
      "security_group_ids": [
        "string"
      ]
    },
    "deletion_protection": "bool",
    "service_account_id": "string",
    "logging": {
      "enabled": "bool",
      // Includes only one of the fields `folder_id`, `log_group_id`
      "folder_id": "string",
      "log_group_id": "string"
      // end of the list of possible fields
    },
    "health": "Health",
    "links": [
      {
        "name": "string",
        "url": "string"
      }
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
|| metadata | **[StopClusterMetadata](#yandex.cloud.spark.v1.StopClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.spark.v1.Cluster)**

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

## StopClusterMetadata {#yandex.cloud.spark.v1.StopClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Spark cluster. ||
|#

## Cluster {#yandex.cloud.spark.v1.Cluster}

Spark cluster.

#|
||Field | Description ||
|| id | **string**

Required field. Unique ID of the Spark cluster.
This ID is assigned by Cloud in the process of creating a Spark cluster. ||
|| folder_id | **string**

ID of the folder that the Spark cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Spark cluster was created. ||
|| name | **string**

Name of the Spark cluster.
The name is unique within the folder. 1-64 characters long. ||
|| description | **string**

Description of the Spark cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>) ||
|| config | **[ClusterConfig](#yandex.cloud.spark.v1.ClusterConfig)**

Configuration of the Spark cluster. ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster status is unknown
- `CREATING`: Cluster is being created
- `RUNNING`: Cluster is running normally.
- `UPDATING`: Cluster is being updated.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster is stopped.
- `STARTING`: Cluster is starting. ||
|| network | **[NetworkConfig](#yandex.cloud.spark.v1.NetworkConfig)** ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| service_account_id | **string**

Service account that will be used to access a YC resources ||
|| logging | **[LoggingConfig](#yandex.cloud.spark.v1.LoggingConfig)**

Cloud logging configuration. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data).
- `ALIVE`: Cluster is alive and well.
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions). ||
|| links[] | **[UILink](#yandex.cloud.spark.v1.UILink)**

UI URLs ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.spark.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.spark.v1.MaintenanceOperation)**

Maintenance operation planned at nearest maintenance_window. ||
|#

## ClusterConfig {#yandex.cloud.spark.v1.ClusterConfig}

#|
||Field | Description ||
|| resource_pools | **[ResourcePools](#yandex.cloud.spark.v1.ResourcePools)**

Required field.  ||
|| history_server | **[HistoryServerConfig](#yandex.cloud.spark.v1.HistoryServerConfig)**

Configuration for HistoryServer ||
|| dependencies | **[Dependencies](#yandex.cloud.spark.v1.Dependencies)**

Container custom environment dependencies ||
|| metastore | **[Metastore](#yandex.cloud.spark.v1.Metastore)**

Metastore Cluster ||
|#

## ResourcePools {#yandex.cloud.spark.v1.ResourcePools}

#|
||Field | Description ||
|| driver | **[ResourcePool](#yandex.cloud.spark.v1.ResourcePool)**

Required field.  ||
|| executor | **[ResourcePool](#yandex.cloud.spark.v1.ResourcePool)**

Required field.  ||
|#

## ResourcePool {#yandex.cloud.spark.v1.ResourcePool}

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.). ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.spark.v1.ScalePolicy)**

Required field.  ||
|#

## ScalePolicy {#yandex.cloud.spark.v1.ScalePolicy}

#|
||Field | Description ||
|| fixed_scale | **[FixedScale](#yandex.cloud.spark.v1.ScalePolicy.FixedScale)**

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|| auto_scale | **[AutoScale](#yandex.cloud.spark.v1.ScalePolicy.AutoScale)**

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|#

## FixedScale {#yandex.cloud.spark.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **int64** ||
|#

## AutoScale {#yandex.cloud.spark.v1.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| min_size | **int64** ||
|| max_size | **int64** ||
|#

## HistoryServerConfig {#yandex.cloud.spark.v1.HistoryServerConfig}

#|
||Field | Description ||
|| enabled | **bool** ||
|#

## Dependencies {#yandex.cloud.spark.v1.Dependencies}

#|
||Field | Description ||
|| pip_packages[] | **string** ||
|| deb_packages[] | **string** ||
|#

## Metastore {#yandex.cloud.spark.v1.Metastore}

#|
||Field | Description ||
|| cluster_id | **string** ||
|#

## NetworkConfig {#yandex.cloud.spark.v1.NetworkConfig}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| security_group_ids[] | **string**

User security groups ||
|#

## LoggingConfig {#yandex.cloud.spark.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **bool** ||
|| folder_id | **string**

Includes only one of the fields `folder_id`, `log_group_id`. ||
|| log_group_id | **string**

Includes only one of the fields `folder_id`, `log_group_id`. ||
|#

## UILink {#yandex.cloud.spark.v1.UILink}

#|
||Field | Description ||
|| name | **string** ||
|| url | **string** ||
|#

## MaintenanceWindow {#yandex.cloud.spark.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.spark.v1.AnytimeMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.spark.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.spark.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.spark.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.spark.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string** ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#