---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Cluster/move.md
---

# Managed Service for Redis API, gRPC: ClusterService.Move

Moves a Redis cluster to the specified folder.

## gRPC request

**rpc Move ([MoveClusterRequest](#yandex.cloud.mdb.redis.v1.MoveClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## MoveClusterRequest {#yandex.cloud.mdb.redis.v1.MoveClusterRequest}

```json
{
  "cluster_id": "string",
  "destination_folder_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Redis cluster to move. ||
|| destination_folder_id | **string**

Required field. ID of the destination folder. ||
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
    "source_folder_id": "string",
    "destination_folder_id": "string"
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
      // Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`
      "redis_config_5_0": {
        "effective_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          }
        },
        "user_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          }
        },
        "default_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          }
        }
      },
      "redis_config_6_0": {
        "effective_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          }
        },
        "user_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          }
        },
        "default_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          }
        }
      },
      "redis_config_6_2": {
        "effective_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value"
        },
        "user_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value"
        },
        "default_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value"
        }
      },
      "redis_config_7_0": {
        "effective_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value"
        },
        "user_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value"
        },
        "default_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value"
        }
      },
      // end of the list of possible fields
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      },
      "backup_window_start": "google.type.TimeOfDay",
      "access": {
        "data_lens": "bool",
        "web_sql": "bool"
      },
      "redis": {
        "effective_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value",
          "lua_time_limit": "google.protobuf.Int64Value",
          "repl_backlog_size_percent": "google.protobuf.Int64Value",
          "cluster_require_full_coverage": "google.protobuf.BoolValue",
          "cluster_allow_reads_when_down": "google.protobuf.BoolValue",
          "cluster_allow_pubsubshard_when_down": "google.protobuf.BoolValue",
          "lfu_decay_time": "google.protobuf.Int64Value",
          "lfu_log_factor": "google.protobuf.Int64Value",
          "turn_before_switchover": "google.protobuf.BoolValue",
          "allow_data_loss": "google.protobuf.BoolValue",
          "use_luajit": "google.protobuf.BoolValue",
          "io_threads_allowed": "google.protobuf.BoolValue",
          "zset_max_listpack_entries": "google.protobuf.Int64Value"
        },
        "user_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value",
          "lua_time_limit": "google.protobuf.Int64Value",
          "repl_backlog_size_percent": "google.protobuf.Int64Value",
          "cluster_require_full_coverage": "google.protobuf.BoolValue",
          "cluster_allow_reads_when_down": "google.protobuf.BoolValue",
          "cluster_allow_pubsubshard_when_down": "google.protobuf.BoolValue",
          "lfu_decay_time": "google.protobuf.Int64Value",
          "lfu_log_factor": "google.protobuf.Int64Value",
          "turn_before_switchover": "google.protobuf.BoolValue",
          "allow_data_loss": "google.protobuf.BoolValue",
          "use_luajit": "google.protobuf.BoolValue",
          "io_threads_allowed": "google.protobuf.BoolValue",
          "zset_max_listpack_entries": "google.protobuf.Int64Value"
        },
        "default_config": {
          "maxmemory_policy": "MaxmemoryPolicy",
          "timeout": "google.protobuf.Int64Value",
          "password": "string",
          "databases": "google.protobuf.Int64Value",
          "slowlog_log_slower_than": "google.protobuf.Int64Value",
          "slowlog_max_len": "google.protobuf.Int64Value",
          "notify_keyspace_events": "string",
          "client_output_buffer_limit_pubsub": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "client_output_buffer_limit_normal": {
            "hard_limit": "google.protobuf.Int64Value",
            "soft_limit": "google.protobuf.Int64Value",
            "soft_seconds": "google.protobuf.Int64Value"
          },
          "maxmemory_percent": "google.protobuf.Int64Value",
          "lua_time_limit": "google.protobuf.Int64Value",
          "repl_backlog_size_percent": "google.protobuf.Int64Value",
          "cluster_require_full_coverage": "google.protobuf.BoolValue",
          "cluster_allow_reads_when_down": "google.protobuf.BoolValue",
          "cluster_allow_pubsubshard_when_down": "google.protobuf.BoolValue",
          "lfu_decay_time": "google.protobuf.Int64Value",
          "lfu_log_factor": "google.protobuf.Int64Value",
          "turn_before_switchover": "google.protobuf.BoolValue",
          "allow_data_loss": "google.protobuf.BoolValue",
          "use_luajit": "google.protobuf.BoolValue",
          "io_threads_allowed": "google.protobuf.BoolValue",
          "zset_max_listpack_entries": "google.protobuf.Int64Value"
        }
      },
      "disk_size_autoscaling": {
        "planned_usage_threshold": "google.protobuf.Int64Value",
        "emergency_usage_threshold": "google.protobuf.Int64Value",
        "disk_size_limit": "google.protobuf.Int64Value"
      },
      "backup_retain_period_days": "google.protobuf.Int64Value"
    },
    "network_id": "string",
    "health": "Health",
    "status": "Status",
    "sharded": "bool",
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
    "tls_enabled": "bool",
    "deletion_protection": "bool",
    "persistence_mode": "PersistenceMode",
    "announce_hostnames": "bool",
    "auth_sentinel": "bool"
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
|| metadata | **[MoveClusterMetadata](#yandex.cloud.mdb.redis.v1.MoveClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.redis.v1.Cluster)**

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

## MoveClusterMetadata {#yandex.cloud.mdb.redis.v1.MoveClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the Redis cluster being moved. ||
|| source_folder_id | **string**

ID of the source folder. ||
|| destination_folder_id | **string**

ID of the destination folder. ||
|#

## Cluster {#yandex.cloud.mdb.redis.v1.Cluster}

Description of a Redis cluster. For more information, see
the Managed Service for Redis [documentation](/docs/managed-redis/concepts/).

#|
||Field | Description ||
|| id | **string**

ID of the Redis cluster.
This ID is assigned by MDB at creation time. ||
|| folder_id | **string**

ID of the folder that the Redis cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the Redis cluster.
The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Description of the Redis cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Redis cluster as `key:value` pairs.
Maximum 64 per cluster. ||
|| environment | enum **Environment**

Deployment environment of the Redis cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.redis.v1.Monitoring)**

Description of monitoring systems relevant to the Redis cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.redis.v1.ClusterConfig)**

Configuration of the Redis cluster. ||
|| network_id | **string** ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: Cluster is in unknown state (we have no data)
- `ALIVE`: Cluster is alive and well (all hosts are alive)
- `DEAD`: Cluster is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Cluster is partially alive (it can perform some of its essential functions) ||
|| status | enum **Status**

Cluster status.

- `STATUS_UNKNOWN`: Cluster status is unknown
- `CREATING`: Cluster is being created
- `RUNNING`: Cluster is running
- `ERROR`: Cluster failed
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| sharded | **bool**

Redis cluster mode on/off. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.redis.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.redis.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. ||
|| security_group_ids[] | **string**

User security groups ||
|| tls_enabled | **bool**

TLS port and functionality on\off ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| persistence_mode | enum **PersistenceMode**

Persistence mode

- `ON`: cluster persistence mode on
- `OFF`: cluster persistence mode off ||
|| announce_hostnames | **bool**

Enable FQDN instead of ip ||
|| auth_sentinel | **bool**

Allows to use ACL users to auth in sentinel ||
|#

## Monitoring {#yandex.cloud.mdb.redis.v1.Monitoring}

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the Redis cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.redis.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of Redis server software. ||
|| redis_config_5_0 | **[RedisConfigSet5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet5_0)**

Configuration of a Redis 5.0 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration for Redis servers in the cluster. ||
|| redis_config_6_0 | **[RedisConfigSet6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_0)**

Configuration of a Redis 6.0 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration for Redis servers in the cluster. ||
|| redis_config_6_2 | **[RedisConfigSet6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_2)**

Configuration of a Redis 6.2 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration for Redis servers in the cluster. ||
|| redis_config_7_0 | **[RedisConfigSet7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet7_0)**

Configuration of a Redis 7.0 server.

Includes only one of the fields `redis_config_5_0`, `redis_config_6_0`, `redis_config_6_2`, `redis_config_7_0`.

Configuration for Redis servers in the cluster. ||
|| resources | **[Resources](#yandex.cloud.mdb.redis.v1.Resources)**

Resources allocated to Redis hosts. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.redis.v1.Access)**

Access policy to DB ||
|| redis | **[RedisConfigSet](#yandex.cloud.mdb.redis.v1.config.RedisConfigSet)**

Unified configuration of a Redis cluster. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|#

## RedisConfigSet5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet5_0}

#|
||Field | Description ||
|| effective_config | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

Effective settings for a Redis 5.0 cluster (a combination of settings
defined in `user_config` and `default_config`). ||
|| user_config | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

User-defined settings for a Redis 5.0 cluster. ||
|| default_config | **[RedisConfig5_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0)**

Default configuration for a Redis 5.0 cluster. ||
|#

## RedisConfig5_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig5_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit. ||
|#

## RedisConfigSet6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_0}

#|
||Field | Description ||
|| effective_config | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

Effective settings for a Redis 6.0 cluster (a combination of settings
defined in `user_config` and `default_config`). ||
|| user_config | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

User-defined settings for a Redis 6.0 cluster. ||
|| default_config | **[RedisConfig6_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0)**

Default configuration for a Redis 6.0 cluster. ||
|#

## RedisConfig6_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit. ||
|#

## RedisConfigSet6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet6_2}

#|
||Field | Description ||
|| effective_config | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

Effective settings for a Redis 6.2 cluster (a combination of settings
defined in `user_config` and `default_config`). ||
|| user_config | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

User-defined settings for a Redis 6.2 cluster. ||
|| default_config | **[RedisConfig6_2](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2)**

Default configuration for a Redis 6.2 cluster. ||
|#

## RedisConfig6_2 {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemory_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig6_2.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit. ||
|#

## RedisConfigSet7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet7_0}

#|
||Field | Description ||
|| effective_config | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

Effective settings for a Redis 7.0 cluster (a combination of settings
defined in `user_config` and `default_config`). ||
|| user_config | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

User-defined settings for a Redis 7.0 cluster. ||
|| default_config | **[RedisConfig7_0](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0)**

Default configuration for a Redis 7.0 cluster. ||
|#

## RedisConfig7_0 {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemory_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig7_0.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit. ||
|#

## Resources {#yandex.cloud.mdb.redis.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Access {#yandex.cloud.mdb.redis.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens ||
|| web_sql | **bool**

Allow access for Web SQL. ||
|#

## RedisConfigSet {#yandex.cloud.mdb.redis.v1.config.RedisConfigSet}

#|
||Field | Description ||
|| effective_config | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

Effective settings for a Redis cluster (a combination of settings
defined in `user_config` and `default_config`). ||
|| user_config | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

User-defined settings for a Redis cluster. ||
|| default_config | **[RedisConfig](#yandex.cloud.mdb.redis.v1.config.RedisConfig)**

Default configuration for a Redis cluster. ||
|#

## RedisConfig {#yandex.cloud.mdb.redis.v1.config.RedisConfig}

Fields and structure of `RedisConfig` reflects Redis configuration file
parameters.

#|
||Field | Description ||
|| maxmemory_policy | enum **MaxmemoryPolicy**

Redis key eviction policy for a dataset that reaches maximum memory,
available to the host. Redis maxmemory setting depends on Managed
Service for Redis [host class](/docs/managed-redis/concepts/instance-types).

All policies are described in detail in [Redis documentation](https://redis.io/topics/lru-cache).

- `MAXMEMORY_POLICY_UNSPECIFIED`
- `VOLATILE_LRU`: Try to remove less recently used (LRU) keys with `expire set`.
- `ALLKEYS_LRU`: Remove less recently used (LRU) keys.
- `VOLATILE_LFU`: Try to remove least frequently used (LFU) keys with `expire set`.
- `ALLKEYS_LFU`: Remove least frequently used (LFU) keys.
- `VOLATILE_RANDOM`: Try to remove keys with `expire set` randomly.
- `ALLKEYS_RANDOM`: Remove keys randomly.
- `VOLATILE_TTL`: Try to remove less recently used (LRU) keys with `expire set`
and shorter TTL first.
- `NOEVICTION`: Return errors when memory limit was reached and commands could require
more memory to be used. ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time that Redis keeps the connection open while the client is idle.
If no new command is sent during that time, the connection is closed. ||
|| password | **string**

Authentication password. ||
|| databases | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Number of database buckets on a single redis-server process. ||
|| slowlog_log_slower_than | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Threshold for logging slow requests to server in microseconds (log only slower than it). ||
|| slowlog_max_len | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Max slow requests number to log. ||
|| notify_keyspace_events | **string**

String setting for pub\sub functionality. ||
|| client_output_buffer_limit_pubsub | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for pubsub operations. ||
|| client_output_buffer_limit_normal | **[ClientOutputBufferLimit](#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit)**

Redis connection output buffers limits for clients. ||
|| maxmemory_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Redis maxmemory percent ||
|| lua_time_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time in milliseconds for Lua scripts, 0 - disabled mechanism ||
|| repl_backlog_size_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Replication backlog size as a percentage of flavor maxmemory ||
|| cluster_require_full_coverage | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls whether all hash slots must be covered by nodes ||
|| cluster_allow_reads_when_down | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows read operations when cluster is down ||
|| cluster_allow_pubsubshard_when_down | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Permits Pub/Sub shard operations when cluster is down ||
|| lfu_decay_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time, in minutes, that must elapse in order for the key counter to be divided by two (or decremented if it has a value less <= 10) ||
|| lfu_log_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Determines how the frequency counter represents key hits. ||
|| turn_before_switchover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows to turn before switchover in RDSync ||
|| allow_data_loss | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows some data to be lost in favor of faster switchover/restart ||
|| use_luajit | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Use JIT for lua scripts and functions ||
|| io_threads_allowed | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allow redis to use io-threads ||
|| zset_max_listpack_entries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Controls max number of entries in zset before conversion from memory-efficient listpack to CPU-efficient hash table and skiplist ||
|#

## ClientOutputBufferLimit {#yandex.cloud.mdb.redis.v1.config.RedisConfig.ClientOutputBufferLimit}

#|
||Field | Description ||
|| hard_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Total limit in bytes. ||
|| soft_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit in bytes during certain time period. ||
|| soft_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Seconds for soft limit. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.redis.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergency_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| disk_size_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.redis.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.redis.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.redis.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.redis.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.redis.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#