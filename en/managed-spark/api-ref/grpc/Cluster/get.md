---
editable: false
sourcePath: en/_api-ref-grpc/spark/v1/api-ref/grpc/Cluster/get.md
---

# Managed Spark API, gRPC: ClusterService.Get

Returns the specified Spark cluster.

## gRPC request

**rpc Get ([GetClusterRequest](#yandex.cloud.spark.v1.GetClusterRequest)) returns ([Cluster](#yandex.cloud.spark.v1.Cluster))**

## GetClusterRequest {#yandex.cloud.spark.v1.GetClusterRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Spark cluster to return. ||
|#

## Cluster {#yandex.cloud.spark.v1.Cluster}

```json
{
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
```

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