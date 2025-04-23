---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/restore.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.Restore

Creates a new OpenSearch cluster using the specified backup.

## gRPC request

**rpc Restore ([RestoreClusterRequest](#yandex.cloud.mdb.opensearch.v1.RestoreClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RestoreClusterRequest {#yandex.cloud.mdb.opensearch.v1.RestoreClusterRequest}

```json
{
  "backup_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "environment": "Environment",
  "config_spec": {
    "version": "string",
    "admin_password": "string",
    "opensearch_spec": {
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
      // Includes only one of the fields `opensearch_config_2`
      "opensearch_config_2": {
        "max_clause_count": "google.protobuf.Int64Value",
        "fielddata_cache_size": "string",
        "reindex_remote_whitelist": "string"
      },
      // end of the list of possible fields
      "keystore_settings": [
        {
          "name": "string",
          "value": "string"
        }
      ]
    },
    "dashboards_spec": {
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
    },
    "snapshot_management": {
      "snapshot_schedule": {
        // Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`
        "hourly_snapshot_schedule": {
          "minute": "int64"
        },
        "daily_snapshot_schedule": {
          "hour": "int64",
          "minute": "int64"
        },
        "weekly_snapshot_schedule": {
          "day": "WeekDay",
          "hour": "int64",
          "minute": "int64"
        }
        // end of the list of possible fields
      },
      "snapshot_max_age_days": "google.protobuf.Int64Value"
    }
  },
  "network_id": "string",
  "security_group_ids": [
    "string"
  ],
  "service_account_id": "string",
  "deletion_protection": "bool",
  "folder_id": "string",
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
|| backup_id | **string**

Required field. ID of the backup to create a new cluster from.

To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-opensearch/api-ref/grpc/Cluster/listBackups#ListBackups) request. ||
|| name | **string**

Required field. Name of the new OpenSearch cluster to be created from the backup. The name must be unique within the folder. ||
|| description | **string**

Description of the new OpenSearch cluster to be created from the backup. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the new OpenSearch cluster to be created from the backup as `key:value` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary". ||
|| environment | enum **Environment**

Deployment environment of the new OpenSearch cluster to be created from the backup.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| config_spec | **[ConfigCreateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigCreateSpec)**

Required field. Configuration for the new OpenSearch cluster to be created from the backup. ||
|| network_id | **string**

Required field. ID of the network to create the cluster in. ||
|| security_group_ids[] | **string**

User security groups. ||
|| service_account_id | **string**

ID of the service account used to access Object Storage. ||
|| deletion_protection | **bool**

Determines whether the cluster is protected from being deleted. ||
|| folder_id | **string**

Required field. ID of the folder to create the OpenSearch cluster in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|#

## ConfigCreateSpec {#yandex.cloud.mdb.opensearch.v1.ConfigCreateSpec}

#|
||Field | Description ||
|| version | **string**

OpenSearch version. ||
|| admin_password | **string**

Required field. OpenSearch admin password. ||
|| opensearch_spec | **[OpenSearchCreateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec)**

OpenSearch configuration. ||
|| dashboards_spec | **[DashboardsCreateSpec](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec)**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|| snapshot_management | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**

Snapshot management configuration ||
|#

## OpenSearchCreateSpec {#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec}

OpenSearch create-time configuration.

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| node_groups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup)**

OpenSearch type host groups of the cluster. ||
|| opensearch_config_2 | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

Includes only one of the fields `opensearch_config_2`. ||
|| keystore_settings[] | **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**

Initial cluster keystore settings. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup}

Configuration of the host group.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the group. ||
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

Roles of the hosts in the group.

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

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

#|
||Field | Description ||
|| max_clause_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

the maximum number of allowed boolean clauses in a query ||
|| fielddata_cache_size | **string**

the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata ||
|| reindex_remote_whitelist | **string** ||
|#

## KeystoreSetting {#yandex.cloud.mdb.opensearch.v1.KeystoreSetting}

Single keystore entry.

#|
||Field | Description ||
|| name | **string**

Keystore entry name. ||
|| value | **string**

Keystore entry value. ||
|#

## DashboardsCreateSpec {#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec}

Dashboards create-time configuration.

#|
||Field | Description ||
|| node_groups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup)**

Dashboards type host groups of the cluster. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the group. ||
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

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement}

Snapshot management configuration

#|
||Field | Description ||
|| snapshot_schedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**

Snapshot creation schedule ||
|| snapshot_max_age_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Snapshot max age in days ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule}

Snapshot creation schedule

#|
||Field | Description ||
|| hourly_snapshot_schedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**

Hourly based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|| daily_snapshot_schedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**

Daily based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|| weekly_snapshot_schedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**

Weekly based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **int64**

The minute of the hour at which the backup should be created. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **int64**

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **int64**

The minute of the hour at which the backup should be created. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **int64**

The minute of the hour at which the backup should be created. ||
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
    "backup_id": "string"
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
      },
      "snapshot_management": {
        "snapshot_schedule": {
          // Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`
          "hourly_snapshot_schedule": {
            "minute": "int64"
          },
          "daily_snapshot_schedule": {
            "hour": "int64",
            "minute": "int64"
          },
          "weekly_snapshot_schedule": {
            "day": "WeekDay",
            "hour": "int64",
            "minute": "int64"
          }
          // end of the list of possible fields
        },
        "snapshot_max_age_days": "google.protobuf.Int64Value"
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
|| metadata | **[RestoreClusterMetadata](#yandex.cloud.mdb.opensearch.v1.RestoreClusterMetadata)**

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

## RestoreClusterMetadata {#yandex.cloud.mdb.opensearch.v1.RestoreClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the new OpenSearch cluster being created from a backup. ||
|| backup_id | **string**

ID of the backup being used for creating a cluster. ||
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
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow2)**

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
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access2)**

Access policy for external services. ||
|| snapshot_management | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement2)**

Snapshot management configuration ||
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
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources2)**

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
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources2}

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

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling2}

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
|| effective_config | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22)**

Required field.  ||
|| user_config | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22)** ||
|| default_config | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22)** ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig22}

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
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources2)**

Resources allocated to the hosts. ||
|| hosts_count | **int64**

Number of hosts in the group. ||
|| zone_ids[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnet_ids[] | **string**

IDs of the subnets that the hosts belong to. ||
|| assign_public_ip | **bool**

Determines whether a public IP is assigned to the hosts in the group. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access2}

Access policy for external services.

#|
||Field | Description ||
|| data_transfer | **bool**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **bool**

Determines whether the access to Serverless is allowed. ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement2}

Snapshot management configuration

#|
||Field | Description ||
|| snapshot_schedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule2)**

Snapshot creation schedule ||
|| snapshot_max_age_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Snapshot max age in days ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule2}

Snapshot creation schedule

#|
||Field | Description ||
|| hourly_snapshot_schedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule2)**

Hourly based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|| daily_snapshot_schedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule2)**

Daily based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|| weekly_snapshot_schedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule2)**

Weekly based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule2}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **int64**

The minute of the hour at which the backup should be created. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule2}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **int64**

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **int64**

The minute of the hour at which the backup should be created. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule2}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

The hour of the day in UTC timezone at which the backup should be created. ||
|| minute | **int64**

The minute of the hour at which the backup should be created. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow2}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow2)**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow2)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow2}

An any-time maintenance window.

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow2}

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