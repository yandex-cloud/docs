---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/start.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.Start

Starts the specified Greenplum® cluster.

## gRPC request

**rpc Start ([StartClusterRequest](#yandex.cloud.mdb.greenplum.v1.StartClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StartClusterRequest {#yandex.cloud.mdb.greenplum.v1.StartClusterRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Greenplum® cluster to start.
To get the Greenplum® cluster ID, use a [ClusterService.List](/docs/managed-greenplum/api-ref/grpc/Cluster/list#List) request. ||
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
    "config": {
      "version": "string",
      "backup_window_start": "google.type.TimeOfDay",
      "backup_retain_period_days": "google.protobuf.Int64Value",
      "access": {
        "data_lens": "bool",
        "web_sql": "bool",
        "data_transfer": "bool",
        "yandex_query": "bool"
      },
      "zone_id": "string",
      "subnet_id": "string",
      "assign_public_ip": "bool"
    },
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
    "master_config": {
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      }
    },
    "segment_config": {
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      }
    },
    "master_host_count": "int64",
    "segment_host_count": "int64",
    "segment_in_host": "int64",
    "network_id": "string",
    "health": "Health",
    "status": "Status",
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
      "delayed_until": "google.protobuf.Timestamp"
    },
    "security_group_ids": [
      "string"
    ],
    "user_name": "string",
    "deletion_protection": "bool",
    "host_group_ids": [
      "string"
    ],
    "cluster_config": {
      // Includes only one of the fields `greenplum_config_set_6_17`, `greenplum_config_set_6_19`, `greenplum_config_set_6_21`, `greenplum_config_set_6_22`, `greenplum_config_set_6`
      "greenplum_config_set_6_17": {
        "effective_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue"
        },
        "user_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue"
        },
        "default_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue"
        }
      },
      "greenplum_config_set_6_19": {
        "effective_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement"
        },
        "user_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement"
        },
        "default_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement"
        }
      },
      "greenplum_config_set_6_21": {
        "effective_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        },
        "user_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        },
        "default_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        }
      },
      "greenplum_config_set_6_22": {
        "effective_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        },
        "user_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        },
        "default_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        }
      },
      "greenplum_config_set_6": {
        "effective_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        },
        "user_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        },
        "default_config": {
          "max_connections": "google.protobuf.Int64Value",
          "max_slot_wal_keep_size": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_segment": "google.protobuf.Int64Value",
          "gp_workfile_limit_per_query": "google.protobuf.Int64Value",
          "gp_workfile_limit_files_per_query": "google.protobuf.Int64Value",
          "max_prepared_transactions": "google.protobuf.Int64Value",
          "gp_workfile_compression": "google.protobuf.BoolValue",
          "max_statement_mem": "google.protobuf.Int64Value",
          "log_statement": "LogStatement",
          "gp_add_column_inherits_table_setting": "google.protobuf.BoolValue"
        }
      },
      // end of the list of possible fields
      "pool": {
        "effective_config": {
          "mode": "PoolMode",
          "size": "google.protobuf.Int64Value",
          "client_idle_timeout": "google.protobuf.Int64Value"
        },
        "user_config": {
          "mode": "PoolMode",
          "size": "google.protobuf.Int64Value",
          "client_idle_timeout": "google.protobuf.Int64Value"
        },
        "default_config": {
          "mode": "PoolMode",
          "size": "google.protobuf.Int64Value",
          "client_idle_timeout": "google.protobuf.Int64Value"
        }
      },
      "background_activities": {
        "table_sizes": {
          "starts": [
            {
              "hours": "int64",
              "minutes": "int64"
            }
          ]
        },
        "analyze_and_vacuum": {
          "start": {
            "hours": "int64",
            "minutes": "int64"
          },
          "analyze_timeout": "google.protobuf.Int64Value",
          "vacuum_timeout": "google.protobuf.Int64Value"
        },
        "query_killer_scripts": {
          "idle": {
            "enable": "google.protobuf.BoolValue",
            "max_age": "google.protobuf.Int64Value",
            "ignore_users": [
              "string"
            ]
          },
          "idle_in_transaction": {
            "enable": "google.protobuf.BoolValue",
            "max_age": "google.protobuf.Int64Value",
            "ignore_users": [
              "string"
            ]
          },
          "long_running": {
            "enable": "google.protobuf.BoolValue",
            "max_age": "google.protobuf.Int64Value",
            "ignore_users": [
              "string"
            ]
          }
        }
      },
      "pxf_config": {
        "effective_config": {
          "connection_timeout": "google.protobuf.Int64Value",
          "upload_timeout": "google.protobuf.Int64Value",
          "max_threads": "google.protobuf.Int64Value",
          "pool_allow_core_thread_timeout": "google.protobuf.BoolValue",
          "pool_core_size": "google.protobuf.Int64Value",
          "pool_queue_capacity": "google.protobuf.Int64Value",
          "pool_max_size": "google.protobuf.Int64Value",
          "xmx": "google.protobuf.Int64Value",
          "xms": "google.protobuf.Int64Value"
        },
        "user_config": {
          "connection_timeout": "google.protobuf.Int64Value",
          "upload_timeout": "google.protobuf.Int64Value",
          "max_threads": "google.protobuf.Int64Value",
          "pool_allow_core_thread_timeout": "google.protobuf.BoolValue",
          "pool_core_size": "google.protobuf.Int64Value",
          "pool_queue_capacity": "google.protobuf.Int64Value",
          "pool_max_size": "google.protobuf.Int64Value",
          "xmx": "google.protobuf.Int64Value",
          "xms": "google.protobuf.Int64Value"
        },
        "default_config": {
          "connection_timeout": "google.protobuf.Int64Value",
          "upload_timeout": "google.protobuf.Int64Value",
          "max_threads": "google.protobuf.Int64Value",
          "pool_allow_core_thread_timeout": "google.protobuf.BoolValue",
          "pool_core_size": "google.protobuf.Int64Value",
          "pool_queue_capacity": "google.protobuf.Int64Value",
          "pool_max_size": "google.protobuf.Int64Value",
          "xmx": "google.protobuf.Int64Value",
          "xms": "google.protobuf.Int64Value"
        }
      }
    },
    "cloud_storage": {
      "enable": "bool"
    },
    "master_host_group_ids": [
      "string"
    ],
    "segment_host_group_ids": [
      "string"
    ]
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
|| metadata | **[StartClusterMetadata](#yandex.cloud.mdb.greenplum.v1.StartClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.greenplum.v1.Cluster)**

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

## StartClusterMetadata {#yandex.cloud.mdb.greenplum.v1.StartClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Greenplum® cluster being started. ||
|#

## Cluster {#yandex.cloud.mdb.greenplum.v1.Cluster}

A Greenplum® cluster resource.

#|
||Field | Description ||
|| id | **string**

ID of the Greenplum® cluster.
This ID is assigned by the platform at the moment of cluster creation. ||
|| folder_id | **string**

ID of the folder that the Greenplum® cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the cluster was created. ||
|| name | **string**

Required field. Name of the Greenplum® cluster.
The name is unique within the folder. ||
|| config | **[GreenplumConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig)**

Greenplum® cluster configuration. ||
|| description | **string**

Description of the Greenplum® cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Greenplum® cluster as `key:value` pairs. Maximum 64 labels per resource. ||
|| environment | enum **Environment**

Deployment environment of the Greenplum® cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.greenplum.v1.Monitoring)**

Description of monitoring systems relevant to the Greenplum® cluster. ||
|| master_config | **[MasterSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig)**

Configuration of the Greenplum® master subcluster. ||
|| segment_config | **[SegmentSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig)**

Configuration of the Greenplum® segment subcluster. ||
|| master_host_count | **int64**

Number of hosts in the master subcluster. ||
|| segment_host_count | **int64**

Number of hosts in the segment subcluster. ||
|| segment_in_host | **int64**

Number of segments per host. ||
|| network_id | **string**

ID of the cloud network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Health of the cluster is unknown ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is working normally ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is not ALIVE).
- `UNBALANCED`: Cluster is working below capacity ([Host.health](/docs/managed-greenplum/api-ref/grpc/Cluster/listMasterHosts#yandex.cloud.mdb.greenplum.v1.Host) for at least one host in the cluster is UNBALANCED). ||
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
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)**

A Greenplum® cluster maintenance window. Should be defined by either one of the two options. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation)**

Maintenance operation planned at nearest `maintenance_window`. ||
|| security_group_ids[] | **string**

User security groups. ||
|| user_name | **string**

Owner user name. ||
|| deletion_protection | **bool**

Determines whether the cluster is protected from being deleted. ||
|| host_group_ids[] | **string**

Host groups hosting VMs of the cluster. ||
|| cluster_config | **[ClusterConfigSet](#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet)**

Greenplum® and Odyssey® configuration. ||
|| cloud_storage | **[CloudStorage](#yandex.cloud.mdb.greenplum.v1.CloudStorage)**

Cloud storage settings ||
|| master_host_group_ids[] | **string**

Host groups hosting VMs of the master subcluster. ||
|| segment_host_group_ids[] | **string**

Host groups hosting VMs of the segment subcluster. ||
|#

## GreenplumConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig}

#|
||Field | Description ||
|| version | **string**

Version of the Greenplum® server software. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retention policy of automated backups. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access)**

Access policy for external services. ||
|| zone_id | **string**

ID of the availability zone the cluster belongs to.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| subnet_id | **string**

ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see [Cluster.network_id](#yandex.cloud.mdb.greenplum.v1.Cluster)). ||
|| assign_public_ip | **bool**

Determines whether the cluster has a public IP address.

After the cluster has been created, this setting cannot be changed. ||
|#

## Access {#yandex.cloud.mdb.greenplum.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allows data export from the cluster to DataLens. ||
|| web_sql | **bool**

Allows SQL queries to the cluster databases from the management console. ||
|| data_transfer | **bool**

Allows access for DataTransfer. ||
|| yandex_query | **bool**

Allow access for YandexQuery. ||
|#

## Monitoring {#yandex.cloud.mdb.greenplum.v1.Monitoring}

Monitoring system metadata.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Greenplum® cluster. ||
|#

## MasterSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Computational resources allocated to Greenplum® master subcluster hosts. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources allocated to a host.

Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage used by the host, in bytes. ||
|| disk_type_id | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## SegmentSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Computational resources allocated to Greenplum® segment subcluster hosts. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.AnytimeMaintenanceWindow)**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.AnytimeMaintenanceWindow}

An any-time maintenance window.

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Delay time for the maintenance operation. ||
|#

## ClusterConfigSet {#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet}

#|
||Field | Description ||
|| greenplum_config_set_6_17 | **[GreenplumConfigSet6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_17)**

Includes only one of the fields `greenplum_config_set_6_17`, `greenplum_config_set_6_19`, `greenplum_config_set_6_21`, `greenplum_config_set_6_22`, `greenplum_config_set_6`. ||
|| greenplum_config_set_6_19 | **[GreenplumConfigSet6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_19)**

Includes only one of the fields `greenplum_config_set_6_17`, `greenplum_config_set_6_19`, `greenplum_config_set_6_21`, `greenplum_config_set_6_22`, `greenplum_config_set_6`. ||
|| greenplum_config_set_6_21 | **[GreenplumConfigSet6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_21)**

Includes only one of the fields `greenplum_config_set_6_17`, `greenplum_config_set_6_19`, `greenplum_config_set_6_21`, `greenplum_config_set_6_22`, `greenplum_config_set_6`. ||
|| greenplum_config_set_6_22 | **[GreenplumConfigSet6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_22)**

Includes only one of the fields `greenplum_config_set_6_17`, `greenplum_config_set_6_19`, `greenplum_config_set_6_21`, `greenplum_config_set_6_22`, `greenplum_config_set_6`. ||
|| greenplum_config_set_6 | **[GreenplumConfigSet6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6)**

Includes only one of the fields `greenplum_config_set_6_17`, `greenplum_config_set_6_19`, `greenplum_config_set_6_21`, `greenplum_config_set_6_22`, `greenplum_config_set_6`. ||
|| pool | **[ConnectionPoolerConfigSet](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet)**

Odyssey® pool settings. ||
|| background_activities | **[BackgroundActivitiesConfig](#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig)**

Managed Greenplum® background tasks configuration. ||
|| pxf_config | **[PXFConfigSet](#yandex.cloud.mdb.greenplum.v1.PXFConfigSet)** ||
|#

## GreenplumConfigSet6_17 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_17}

Configuration settings version 6.17

#|
||Field | Description ||
|| effective_config | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

Required field. Effective settings for a Greenplum® cluster (a combination of settings defined in `user_config` and `default_config`). ||
|| user_config | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

User-defined settings for a Greenplum® cluster. ||
|| default_config | **[GreenplumConfig6_17](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_17 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_17}

#|
||Field | Description ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment. ||
|| max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment). ||
|| gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query). ||
|| gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of temporary spill files allowed per query at each segment.

Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.

The current query is terminated if the limit is exceeded.

Set to zero to disable the limit.

Master session reloads if the parameter changes.

Default value is 10000.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query). ||
|| max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of transactions that can be in the `prepared` state simultaneously.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). ||
|| gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether the spill files are compressed or not.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression). ||
|#

## GreenplumConfigSet6_19 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_19}

Configuration settings version 6.19

#|
||Field | Description ||
|| effective_config | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

Required field. Effective settings for a Greenplum® cluster (a combination of settings defined in `user_config` and `default_config`). ||
|| user_config | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

User-defined settings for a Greenplum® cluster. ||
|| default_config | **[GreenplumConfig6_19](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_19 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_19}

#|
||Field | Description ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment. ||
|| max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum size of WAL files that replication slots are allowed to retain in the `pg_wal` directory at checkpoint time.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/current/runtime-config-replication.html). ||
|| gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment). ||
|| gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.

The default value is 0 (no limit).

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query). ||
|| gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of temporary spill files allowed per query at each segment.

Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.

The current query is terminated if the limit is exceeded.

Set to zero to disable the limit.

Master session reloads if the parameter changes.

Default value is 10000.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query). ||
|| max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of transactions that can be in the `prepared` state simultaneously.

More info in [PostgreSQL® documentation](https://www.postgresql.org/docs/9.6/runtime-config-resource.html). ||
|| gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether the spill files are compressed or not.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression). ||
|| max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum memory limit for a query, in bytes.

Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting `statement_mem` too high.

Taking into account the configuration of a single segment host, calculate `max_statement_mem` as follows: `seghost_physical_memory` / `average_number_concurrent_queries`.

When changing both `max_statement_mem` and `statement_mem`, `max_statement_mem` must be changed first, or listed first in the `postgresql.conf` file.

Default value is 2097152000 (2000 MB).

More info in [Greenplum® documentation](https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem). ||
|| log_statement | enum **LogStatement**

Logged SQL statements.

`PREPARE` and `EXPLAIN ANALYZE` statements are also logged if their contained command belongs to an appropriate type.

More info in [Greenplum® documentation](https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement).

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|#

## GreenplumConfigSet6_21 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_21}

#|
||Field | Description ||
|| effective_config | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

Required field. Effective settings for a Greenplum®  cluster (a combination of settings defined in `user_config` and `default_config`). ||
|| user_config | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

User-defined settings for a Greenplum® cluster. ||
|| default_config | **[GreenplumConfig6_21](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_21 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_21}

#|
||Field | Description ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment ||
|| max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment ||
|| gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query ||
|| gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression ||
|| max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| log_statement | enum **LogStatement**

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gp_add_column_inherits_table_setting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## GreenplumConfigSet6_22 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6_22}

#|
||Field | Description ||
|| effective_config | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

Required field. Effective settings for a Greenplum®  cluster (a combination of settings defined in `user_config` and `default_config`). ||
|| user_config | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

User-defined settings for a Greenplum® cluster. ||
|| default_config | **[GreenplumConfig6_22](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22)**

Default configuration for a Greenplum® cluster. ||
|#

## GreenplumConfig6_22 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6_22}

#|
||Field | Description ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment ||
|| max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment ||
|| gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query ||
|| gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression ||
|| max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| log_statement | enum **LogStatement**

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gp_add_column_inherits_table_setting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## GreenplumConfigSet6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6}

#|
||Field | Description ||
|| effective_config | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

Required field. Effective settings for a Greenplum (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

User-defined settings for a Greenplum. ||
|| default_config | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)**

Default configuration for a Greenplum. ||
|#

## GreenplumConfig6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6}

#|
||Field | Description ||
|| max_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of inbound connections on master segment ||
|| max_slot_wal_keep_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time.
https://www.postgresql.org/docs/current/runtime-config-replication.html ||
|| gp_workfile_limit_per_segment | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment ||
|| gp_workfile_limit_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment.
The default value is 0, which means a limit is not enforced.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query ||
|| gp_workfile_limit_files_per_query | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment.
Spill files are created when executing a query that requires more memory than it is allocated.
The current query is terminated when the limit is exceeded.
Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query
Default value is 10000 ||
|| max_prepared_transactions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum number of transactions that can be in the "prepared" state simultaneously
https://www.postgresql.org/docs/9.6/runtime-config-resource.html ||
|| gp_workfile_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression ||
|| max_statement_mem | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high.
Taking into account the configuration of a single segment host, calculate max_statement_mem as follows:
(seghost_physical_memory) / (average_number_concurrent_queries)
When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file.
https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem
Default value is 2097152000 (2000MB) ||
|| log_statement | enum **LogStatement**

Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands.
MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM.
PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type.
https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement
Default value is ddl

- `LOG_STATEMENT_UNSPECIFIED`
- `NONE`: None statements are logged.
- `DDL`: Logs all data definition commands like `CREATE`, `ALTER`, and `DROP`. Default value.
- `MOD`: Logs all `DDL` statements, plus `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, and `COPY FROM`.
- `ALL`: Logs all statements. ||
|| gp_add_column_inherits_table_setting | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting ||
|#

## ConnectionPoolerConfigSet {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet}

#|
||Field | Description ||
|| effective_config | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

Required field. Effective settings for an Odyssey® pooler (a combination of settings defined in `ConnectionPoolerConfigSet.user_config` and `ConnectionPoolerConfigSet.default_config`). ||
|| user_config | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

User-defined settings for an Odyssey® pooler. ||
|| default_config | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)**

Default configuration for an Odyssey® pooler. ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| mode | enum **PoolMode**

Route server pool mode.

- `POOL_MODE_UNSPECIFIED`
- `SESSION`: Assign server connection to a client until it disconnects. Default value.
- `TRANSACTION`: Assign server connection to a client for a transaction processing. ||
|| size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.

Set to zero to disable the limit. ||
|| client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Server pool idle timeout, in seconds.

A server connection closes after being idle for the specified time.

Set to zero to disable the limit. ||
|#

## BackgroundActivitiesConfig {#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig}

#|
||Field | Description ||
|| table_sizes | **[TableSizes](#yandex.cloud.mdb.greenplum.v1.TableSizes)**

Enables scripts that collects tables sizes to `*_sizes` tables in `mdb_toolkit` schema. ||
|| analyze_and_vacuum | **[AnalyzeAndVacuum](#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum)**

Configuration for `ANALYZE` and `VACUUM` operations. ||
|| query_killer_scripts | **[QueryKillerScripts](#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts)**

Configuration for long running queries killer. ||
|#

## TableSizes {#yandex.cloud.mdb.greenplum.v1.TableSizes}

#|
||Field | Description ||
|| starts[] | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)** ||
|#

## BackgroundActivityStartAt {#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt}

#|
||Field | Description ||
|| hours | **int64** ||
|| minutes | **int64** ||
|#

## AnalyzeAndVacuum {#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum}

#|
||Field | Description ||
|| start | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)** ||
|| analyze_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum duration of the `ANALYZE` operation, in seconds. The default value is `36000`. As soon as this period expires, the `ANALYZE` operation will be forced to terminate. ||
|| vacuum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum duration of the `VACUUM` operation, in seconds. The default value is `36000`. As soon as this period expires, the `VACUUM` operation will be forced to terminate. ||
|#

## QueryKillerScripts {#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts}

#|
||Field | Description ||
|| idle | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle` state. ||
|| idle_in_transaction | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries that are in `idle in transaction` state. ||
|| long_running | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)**

Configuration of script that kills long running queries (in any state). ||
|#

## QueryKiller {#yandex.cloud.mdb.greenplum.v1.QueryKiller}

#|
||Field | Description ||
|| enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| max_age | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum duration for this type of queries (in seconds). ||
|| ignore_users[] | **string**

Ignore these users when considering queries to terminate ||
|#

## PXFConfigSet {#yandex.cloud.mdb.greenplum.v1.PXFConfigSet}

#|
||Field | Description ||
|| effective_config | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

Required field.  ||
|| user_config | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

User-defined settings. ||
|| default_config | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)**

Default configuration. ||
|#

## PXFConfig {#yandex.cloud.mdb.greenplum.v1.PXFConfig}

#|
||Field | Description ||
|| connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for connection to the Apache Tomcat® server when making read requests.

Specify values in seconds. ||
|| upload_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Timeout for connection to the Apache Tomcat® server when making write requests.

Specify the values in seconds. ||
|| max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of the Apache Tomcat® threads.

To prevent situations when requests get stuck or fail due to running out of memory or malfunctioning of the Java garbage collector, specify the number of the Apache Tomcat® threads. Learn more about adjusting the number of threads in the [VMware Greenplum® Platform Extension Framework](https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/cfg_mem.html) documentation. ||
|| pool_allow_core_thread_timeout | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines whether the timeout for core streaming threads is permitted. ||
|| pool_core_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of core streaming threads per pool. ||
|| pool_queue_capacity | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of requests you can add to a pool queue for core streaming threads.

If `0`, no pool queue is generated. ||
|| pool_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum allowed number of core streaming threads. ||
|| xmx | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Initial size, in megabytes, of the JVM heap for the PXF daemon. ||
|| xms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum size, in megabytes, of the JVM heap for the PXF daemon. ||
|#

## CloudStorage {#yandex.cloud.mdb.greenplum.v1.CloudStorage}

Cloud Storage Settings

#|
||Field | Description ||
|| enable | **bool**

enable Cloud Storage for cluster ||
|#