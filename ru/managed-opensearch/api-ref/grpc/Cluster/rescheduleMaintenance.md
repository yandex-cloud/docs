---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/rescheduleMaintenance.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.RescheduleMaintenance

Reschedules a planned maintenance operation.

## gRPC request

**rpc RescheduleMaintenance ([RescheduleMaintenanceRequest](#yandex.cloud.mdb.opensearch.v1.RescheduleMaintenanceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RescheduleMaintenanceRequest {#yandex.cloud.mdb.opensearch.v1.RescheduleMaintenanceRequest}

```json
{
  "cluster_id": "string",
  "reschedule_type": "RescheduleType",
  "delayed_until": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the OpenSearch cluster to reschedule the maintenance operation for.

To get the ID, use a [ClusterService.List](/docs/managed-opensearch/api-ref/grpc/Cluster/list#List) request. ||
|| reschedule_type | enum **RescheduleType**

Required field. The type of the reschedule request.

- `RESCHEDULE_TYPE_UNSPECIFIED`: Time of the maintenance is not specified..
- `IMMEDIATE`: Start the maintenance operation immediately.
- `NEXT_AVAILABLE_WINDOW`: Start the maintenance operation within the next available maintenance window.
- `SPECIFIC_TIME`: Start the maintenance operation at the specific time. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time until which this maintenance operation should be delayed.
The value should be ahead of the first time when the maintenance operation has been scheduled for no more than two weeks.
The value can also point to a moment in the past if [reschedule_type.IMMEDIATE](/docs/managed-opensearch/api-ref/grpc/Cluster/rescheduleMaintenance#yandex.cloud.mdb.opensearch.v1.RescheduleMaintenanceRequest.RescheduleType) reschedule type is selected. ||
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
    "cluster_id": "string",
    "delayed_until": "google.protobuf.Timestamp"
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
      "opensearch": {
        "plugins": [
          "string"
        ],
        "node_groups": [
          {
            "name": "string",
            "resources": {
              "resource_preset_id": "string",
              "disk_size": "int64",
              "disk_type_id": "string"
            },
            "hosts_count": "int64",
            "zone_ids": [
              "string"
            ],
            "subnet_ids": [
              "string"
            ],
            "assign_public_ip": "bool",
            "roles": [
              "GroupRole"
            ],
            "disk_size_autoscaling": {
              "planned_usage_threshold": "int64",
              "emergency_usage_threshold": "int64",
              "disk_size_limit": "int64"
            }
          }
        ],
        // Includes only one of the fields `opensearch_config_set_2`
        "opensearch_config_set_2": {
          "effective_config": {
            "max_clause_count": "google.protobuf.Int64Value",
            "fielddata_cache_size": "string",
            "reindex_remote_whitelist": "string"
          },
          "user_config": {
            "max_clause_count": "google.protobuf.Int64Value",
            "fielddata_cache_size": "string",
            "reindex_remote_whitelist": "string"
          },
          "default_config": {
            "max_clause_count": "google.protobuf.Int64Value",
            "fielddata_cache_size": "string",
            "reindex_remote_whitelist": "string"
          }
        },
        // end of the list of possible fields
        "keystore_settings": [
          "string"
        ]
      },
      "dashboards": {
        "node_groups": [
          {
            "name": "string",
            "resources": {
              "resource_preset_id": "string",
              "disk_size": "int64",
              "disk_type_id": "string"
            },
            "hosts_count": "int64",
            "zone_ids": [
              "string"
            ],
            "subnet_ids": [
              "string"
            ],
            "assign_public_ip": "bool",
            "disk_size_autoscaling": {
              "planned_usage_threshold": "int64",
              "emergency_usage_threshold": "int64",
              "disk_size_limit": "int64"
            }
          }
        ]
      },
      "access": {
        "data_transfer": "bool",
        "serverless": "bool"
      }
    },
    "network_id": "string",
    "health": "Health",
    "status": "Status",
    "security_group_ids": [
      "string"
    ],
    "service_account_id": "string",
    "deletion_protection": "bool",
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
|| metadata | **[RescheduleMaintenanceMetadata](#yandex.cloud.mdb.opensearch.v1.RescheduleMaintenanceMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.opensearch.v1.Cluster)**

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

## RescheduleMaintenanceMetadata {#yandex.cloud.mdb.opensearch.v1.RescheduleMaintenanceMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the OpenSearch cluster where the reschedule is applied. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time until which this maintenance operation is to be delayed. ||
|#

## Cluster {#yandex.cloud.mdb.opensearch.v1.Cluster}

An OpenSearch cluster resource.

#|
||Field | Description ||
|| id | **string**

ID of the OpenSearch cluster.
This ID is assigned by the platform at the moment of cluster creation. ||
|| folder_id | **string**

ID of the folder that the OpenSearch cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was created. ||
|| name | **string**

Name of the OpenSearch cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the OpenSearch cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the OpenSearch cluster as `key:value` pairs.
Maximum 64 labels per resource. ||
|| environment | enum **Environment**

Deployment environment of the OpenSearch cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.opensearch.v1.Monitoring)**

Description of monitoring systems relevant to the OpenSearch cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.opensearch.v1.ClusterConfig)**

Configuration of the OpenSearch cluster. ||
|| network_id | **string**

ID of the cloud network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-opensearch/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.opensearch.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster has encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster has stopped.
- `STARTING`: Cluster is starting. ||
|| security_group_ids[] | **string**

User security groups. ||
|| service_account_id | **string**

ID of the service account used to access Object Storage. ||
|| deletion_protection | **bool**

Determines whether the cluster is protected from being deleted. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenance_window`. ||
|#

## Monitoring {#yandex.cloud.mdb.opensearch.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the OpenSearch cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.opensearch.v1.ClusterConfig}

The OpenSearch cluster configuration.

#|
||Field | Description ||
|| version | **string**

Version of the OpenSearch server software. ||
|| opensearch | **[OpenSearch](#yandex.cloud.mdb.opensearch.v1.OpenSearch)**

OpenSearch configuration. ||
|| dashboards | **[Dashboards](#yandex.cloud.mdb.opensearch.v1.Dashboards)**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|#

## OpenSearch {#yandex.cloud.mdb.opensearch.v1.OpenSearch}

The OpenSearch host group type configuration.

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| node_groups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup)**

Host groups of the OpenSearch type. ||
|| opensearch_config_set_2 | **[OpenSearchConfigSet2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2)**

Includes only one of the fields `opensearch_config_set_2`. ||
|| keystore_settings[] | **string**

Keystore entries names. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup}

Configuration of the host group.

#|
||Field | Description ||
|| name | **string**

Name of the group. Must be 1-63 characters long. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hosts_count | **int64**

Number of hosts in the group. ||
|| zone_ids[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnet_ids[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assign_public_ip | **bool**

Determines whether a public IP is assigned to the hosts in the group. ||
|| roles[] | enum **GroupRole**

Roles of the host group.

- `GROUP_ROLE_UNSPECIFIED`
- `DATA`
- `MANAGER` ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources allocated to a host. ||
|| disk_size | **int64**

Volume of the storage used by the host, in bytes. ||
|| disk_type_id | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **int64**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergency_usage_threshold | **int64**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| disk_size_limit | **int64**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## OpenSearchConfigSet2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2}

#|
||Field | Description ||
|| effective_config | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

Required field.  ||
|| user_config | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)** ||
|| default_config | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)** ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

#|
||Field | Description ||
|| max_clause_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

the maximum number of allowed boolean clauses in a query ||
|| fielddata_cache_size | **string**

the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata ||
|| reindex_remote_whitelist | **string** ||
|#

## Dashboards {#yandex.cloud.mdb.opensearch.v1.Dashboards}

The Dashboards host group type configuration.

#|
||Field | Description ||
|| node_groups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup)**

Host groups of the Dashboards type. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup}

#|
||Field | Description ||
|| name | **string**

Name of the group. 1-63 characters long. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hosts_count | **int64**

Number of hosts in the group. ||
|| zone_ids[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnet_ids[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assign_public_ip | **bool**

Determines whether a public IP is assigned to the hosts in the group. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

Access policy for external services.

#|
||Field | Description ||
|| data_transfer | **bool**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **bool**

Determines whether the access to Serverless is allowed. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow)**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow}

An any-time maintenance window.

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week.

- `WEEK_DAY_UNSPECIFIED`
- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **int64**

Hour of the day in the UTC timezone. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Delay time for the maintenance operation. ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the last maintenance window. ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the next maintenance window. ||
|#