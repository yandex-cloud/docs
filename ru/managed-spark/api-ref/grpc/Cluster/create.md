---
editable: false
---

# Managed Spark API, gRPC: ClusterService.Create

Creates a Spark cluster.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.spark.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.spark.v1.CreateClusterRequest}

```json
{
  "folder_id": "string",
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
    },
    "spark_version": "string",
    "environment_id": "string"
  },
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

Create Cluster Request.

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create Spark cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the Spark cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ `. ||
|| description | **string**

Description of the Spark cluster. 0-256 characters long.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Cluster Labels.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| config | **[ClusterConfig](#yandex.cloud.spark.v1.ClusterConfig)**

Required field. Configuration of the Spark cluster. ||
|| network | **[NetworkConfig](#yandex.cloud.spark.v1.NetworkConfig)**

Required field. Cluster Network Configuration. ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster. ||
|| service_account_id | **string**

Required field. Service account that will be used to access YC resources.

The maximum string length in characters is 50. ||
|| logging | **[LoggingConfig](#yandex.cloud.spark.v1.LoggingConfig)**

Cloud logging configuration. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.spark.v1.MaintenanceWindow)**

Window of maintenance operations. ||
|#

## ClusterConfig {#yandex.cloud.spark.v1.ClusterConfig}

Configuration of the Spark cluster.

#|
||Field | Description ||
|| resource_pools | **[ResourcePools](#yandex.cloud.spark.v1.ResourcePools)**

Required field. Resource Pools. ||
|| history_server | **[HistoryServerConfig](#yandex.cloud.spark.v1.HistoryServerConfig)**

Configuration for HistoryServer. ||
|| dependencies | **[Dependencies](#yandex.cloud.spark.v1.Dependencies)**

Container custom environment dependencies. ||
|| metastore | **[Metastore](#yandex.cloud.spark.v1.Metastore)**

Metastore Cluster. ||
|| spark_version | **string**

Spark version. Format: "Major.Minor". ||
|| environment_id | **string**

Job Environment ID.

The maximum string length in characters is 50. ||
|#

## ResourcePools {#yandex.cloud.spark.v1.ResourcePools}

Resource Pools.

#|
||Field | Description ||
|| driver | **[ResourcePool](#yandex.cloud.spark.v1.ResourcePool)**

Required field. Driver Resource Pool. ||
|| executor | **[ResourcePool](#yandex.cloud.spark.v1.ResourcePool)**

Required field. Executor Resource Pool. ||
|#

## ResourcePool {#yandex.cloud.spark.v1.ResourcePool}

Resource Pool.

#|
||Field | Description ||
|| resource_preset_id | **string**

Required field. ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).

The maximum string length in characters is 50. ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.spark.v1.ScalePolicy)**

Required field. Scale Policy. ||
|#

## ScalePolicy {#yandex.cloud.spark.v1.ScalePolicy}

Scale Policy.

#|
||Field | Description ||
|| fixed_scale | **[FixedScale](#yandex.cloud.spark.v1.ScalePolicy.FixedScale)**

Fixed Scale Policy.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Scale Type. ||
|| auto_scale | **[AutoScale](#yandex.cloud.spark.v1.ScalePolicy.AutoScale)**

Auto Scale Policy.

Includes only one of the fields `fixed_scale`, `auto_scale`.

Scale Type. ||
|#

## FixedScale {#yandex.cloud.spark.v1.ScalePolicy.FixedScale}

Fixed Scale Policy.

#|
||Field | Description ||
|| size | **int64**

Fixed Size.

Acceptable values are 1 to 100, inclusive. ||
|#

## AutoScale {#yandex.cloud.spark.v1.ScalePolicy.AutoScale}

Auto Scale Policy.

#|
||Field | Description ||
|| min_size | **int64**

Min Size.

Acceptable values are 0 to 100, inclusive. ||
|| max_size | **int64**

Max Size.

Acceptable values are 1 to 100, inclusive. ||
|#

## HistoryServerConfig {#yandex.cloud.spark.v1.HistoryServerConfig}

Configuration for HistoryServer.

#|
||Field | Description ||
|| enabled | **bool**

History Server is enabled. ||
|#

## Dependencies {#yandex.cloud.spark.v1.Dependencies}

Cluster Dependencies.

#|
||Field | Description ||
|| pip_packages[] | **string**

Pip Packages. ||
|| deb_packages[] | **string**

Deb Packages. ||
|#

## Metastore {#yandex.cloud.spark.v1.Metastore}

Metastore Cluster.

#|
||Field | Description ||
|| cluster_id | **string**

Cluster ID.

The maximum string length in characters is 50. ||
|#

## NetworkConfig {#yandex.cloud.spark.v1.NetworkConfig}

Cluster Network Configuration.

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of VPC network subnets where instances of the cluster are attached. ||
|| security_group_ids[] | **string**

User security groups. ||
|#

## LoggingConfig {#yandex.cloud.spark.v1.LoggingConfig}

Logging Config.

#|
||Field | Description ||
|| enabled | **bool**

Logging is enabled. ||
|| folder_id | **string**

Folder ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination. ||
|| log_group_id | **string**

Logging Group ID.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folder_id`, `log_group_id`.

Destination. ||
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