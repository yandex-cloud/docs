---
editable: false
sourcePath: en/_api-ref-grpc/mdb/spqr/v1/api-ref/grpc/Cluster/restore.md
---

# Managed Service for SPQR API, gRPC: ClusterService.Restore

Creates a new SPQR cluster using the specified backup.

## gRPC request

**rpc Restore ([RestoreClusterRequest](#yandex.cloud.mdb.spqr.v1.RestoreClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RestoreClusterRequest {#yandex.cloud.mdb.spqr.v1.RestoreClusterRequest}

```json
{
  "backup_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "environment": "Environment",
  "config_spec": {
    "spqr_spec": {
      "router": {
        "config": {
          "show_notice_messages": "google.protobuf.BoolValue",
          "time_quantiles": [
            "double"
          ],
          "default_route_behavior": "DefaultRouteBehavior",
          "prefer_same_availability_zone": "google.protobuf.BoolValue"
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "coordinator": {
        "config": "CoordinatorSettings",
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "postgresql": {
        "config": "PostgreSQLSettings",
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        }
      },
      "infra": {
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "router": {
          "show_notice_messages": "google.protobuf.BoolValue",
          "time_quantiles": [
            "double"
          ],
          "default_route_behavior": "DefaultRouteBehavior",
          "prefer_same_availability_zone": "google.protobuf.BoolValue"
        },
        "coordinator": "CoordinatorSettings"
      },
      "console_password": "string",
      "log_level": "LogLevel",
      "balancer": {
        "cpu_threshold": "google.protobuf.DoubleValue",
        "space_threshold": "google.protobuf.DoubleValue",
        "stat_interval_sec": "google.protobuf.Int64Value",
        "max_move_count": "google.protobuf.Int64Value",
        "keys_per_move": "google.protobuf.Int64Value",
        "timeout": "google.protobuf.Int64Value"
      }
    },
    "backup_window_start": "google.type.TimeOfDay",
    "backup_retain_period_days": "google.protobuf.Int64Value",
    "access": {
      "data_lens": "bool",
      "web_sql": "bool",
      "data_transfer": "bool",
      "serverless": "bool"
    },
    "sox_audit": "google.protobuf.BoolValue"
  },
  "host_specs": [
    {
      "zone_id": "string",
      "subnet_id": "string",
      "assign_public_ip": "bool",
      "type": "Type",
      "shard_name": "string",
      "mdb_postgresql": {
        "cluster_id": "string"
      }
    }
  ],
  "network_id": "string",
  "folder_id": "string",
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "time": "google.protobuf.Timestamp",
  "time_inclusive": "bool"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. ID of the backup to create a cluster from.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-spqr/api-ref/grpc/Cluster/listBackups#ListBackups) request. ||
|| name | **string**

Required field. Name of the new SPQR cluster. The name must be unique within the folder.
The name can't be changed after the SPQR cluster is created. ||
|| description | **string**

Description of the new SPQR cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary". ||
|| environment | enum **Environment**

Required field. Deployment environment of the new SPQR cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.spqr.v1.ConfigSpec)**

Required field. Configuration for the SPQR cluster to be created. ||
|| host_specs[] | **[HostSpec](#yandex.cloud.mdb.spqr.v1.HostSpec)**

Configurations for SPQR hosts that should be created for
the cluster that is being created from the backup. ||
|| network_id | **string**

Required field. ID of the network to create the SPQR cluster in. ||
|| folder_id | **string**

Required. ID of the folder to create the SPQR cluster in. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the moment to which the SPQR cluster should be restored. ||
|| time_inclusive | **bool**

Flag that indicates whether a database should be restored to the first backup point
available just after the timestamp specified in the `time` field instead of just before.

Possible values:
* false (default) - the restore point refers to the first backup moment before `time`.
* true - the restore point refers to the first backup point after `time`. ||
|#

## ConfigSpec {#yandex.cloud.mdb.spqr.v1.ConfigSpec}

#|
||Field | Description ||
|| spqr_spec | **[SpqrSpec](#yandex.cloud.mdb.spqr.v1.SpqrSpec)**

Configuration and resource allocation for a SPQR Beta cluster. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access)**

Access policy to DB ||
|| sox_audit | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## SpqrSpec {#yandex.cloud.mdb.spqr.v1.SpqrSpec}

#|
||Field | Description ||
|| router | **[Router](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Router)**

Configuration and resource allocation for SPQR Router hosts. ||
|| coordinator | **[Coordinator](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Coordinator)**

Configuration and resource allocation for SPQR Coordinator hosts. ||
|| postgresql | **[PostgreSQL](#yandex.cloud.mdb.spqr.v1.SpqrSpec.PostgreSQL)**

Configuration and resource allocation for PostgreSQL hosts. ||
|| infra | **[Infra](#yandex.cloud.mdb.spqr.v1.SpqrSpec.Infra)**

Configuration and resource allocation for SPQR Infra (router+coordinator) hosts. ||
|| console_password | **string**

Password of the SPQR console. ||
|| log_level | enum **LogLevel**

- `LOG_LEVEL_UNSPECIFIED`
- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings)**

Configuration for SPQR Balancer. ||
|#

## Router {#yandex.cloud.mdb.spqr.v1.SpqrSpec.Router}

#|
||Field | Description ||
|| config | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)**

Configuration for router hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host. ||
|#

## RouterSettings {#yandex.cloud.mdb.spqr.v1.RouterSettings}

Configuration of a SPQR router.

#|
||Field | Description ||
|| show_notice_messages | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| time_quantiles[] | **double** ||
|| default_route_behavior | enum **DefaultRouteBehavior**

- `DEFAULT_ROUTE_BEHAVIOR_UNSPECIFIED`
- `BLOCK`
- `ALLOW` ||
|| prefer_same_availability_zone | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## Resources {#yandex.cloud.mdb.spqr.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-spqr/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Coordinator {#yandex.cloud.mdb.spqr.v1.SpqrSpec.Coordinator}

#|
||Field | Description ||
|| config | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings)**

Configuration for coordinator hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host. ||
|#

## CoordinatorSettings {#yandex.cloud.mdb.spqr.v1.CoordinatorSettings}

Configuration of a SPQR coordinator.

#|
||Field | Description ||
|| Empty | > ||
|#

## PostgreSQL {#yandex.cloud.mdb.spqr.v1.SpqrSpec.PostgreSQL}

#|
||Field | Description ||
|| config | **[PostgreSQLSettings](#yandex.cloud.mdb.spqr.v1.PostgreSQLSettings)**

Configuration for PostgreSQL hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host. ||
|#

## PostgreSQLSettings {#yandex.cloud.mdb.spqr.v1.PostgreSQLSettings}

Configuration of a PostgreSQL.

#|
||Field | Description ||
|| Empty | > ||
|#

## Infra {#yandex.cloud.mdb.spqr.v1.SpqrSpec.Infra}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to each host ||
|| router | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)**

Router related configuration ||
|| coordinator | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings)**

Coordinator related configuration ||
|#

## BalancerSettings {#yandex.cloud.mdb.spqr.v1.BalancerSettings}

#|
||Field | Description ||
|| cpu_threshold | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| space_threshold | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| stat_interval_sec | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_move_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| keys_per_move | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|#

## Access {#yandex.cloud.mdb.spqr.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens. ||
|| web_sql | **bool**

Allow access for Web SQL. ||
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|| serverless | **bool**

Allow access for Serverless.
NOTE: Do not propagate to public API until Serverless integration is required. ||
|#

## HostSpec {#yandex.cloud.mdb.spqr.v1.HostSpec}

#|
||Field | Description ||
|| zone_id | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The network ID is set in the [Cluster.network_id](#yandex.cloud.mdb.spqr.v1.Cluster) field. ||
|| assign_public_ip | **bool**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assign_public_ip` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| type | enum **Type**

Required field. Type of the host to be deployed.

- `TYPE_UNSPECIFIED`
- `ROUTER`: A SPQR Router host.
- `COORDINATOR`: A SPQR Coordinator host.
- `INFRA`: A SPQR Infra host (router+coordinator)
- `POSTGRESQL`: A PostgreSQL host.
- `EXTERNAL_POSTGRESQL`: An External PostgreSQL host.
- `MDB_POSTGRESQL`: A Managed PostgreSQL host ||
|| shard_name | **string**

Name of the shard that the host belongs to.
If empty, host doesn't belong to any shard ||
|| mdb_postgresql | **[MDBPostgreSQL](#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL)** ||
|#

## MDBPostgreSQL {#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL}

TODO move to hosts.proto when it's created
Configuration for MDB PostgreSQL host

#|
||Field | Description ||
|| cluster_id | **string**

Required field.  ||
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
      "spqr_config": {
        "router": {
          "config": {
            "show_notice_messages": "google.protobuf.BoolValue",
            "time_quantiles": [
              "double"
            ],
            "default_route_behavior": "DefaultRouteBehavior",
            "prefer_same_availability_zone": "google.protobuf.BoolValue"
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          }
        },
        "coordinator": {
          "config": "CoordinatorSettings",
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          }
        },
        "postgresql": {
          "config": "PostgreSQLSettings",
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          }
        },
        "infra": {
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "router": {
            "show_notice_messages": "google.protobuf.BoolValue",
            "time_quantiles": [
              "double"
            ],
            "default_route_behavior": "DefaultRouteBehavior",
            "prefer_same_availability_zone": "google.protobuf.BoolValue"
          },
          "coordinator": "CoordinatorSettings"
        },
        "log_level": "LogLevel",
        "balancer": {
          "cpu_threshold": "google.protobuf.DoubleValue",
          "space_threshold": "google.protobuf.DoubleValue",
          "stat_interval_sec": "google.protobuf.Int64Value",
          "max_move_count": "google.protobuf.Int64Value",
          "keys_per_move": "google.protobuf.Int64Value",
          "timeout": "google.protobuf.Int64Value"
        }
      },
      "backup_window_start": "google.type.TimeOfDay",
      "backup_retain_period_days": "google.protobuf.Int64Value",
      "access": {
        "data_lens": "bool",
        "web_sql": "bool",
        "data_transfer": "bool",
        "serverless": "bool"
      },
      "sox_audit": "google.protobuf.BoolValue"
    },
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
      "delayed_until": "google.protobuf.Timestamp",
      "latest_maintenance_time": "google.protobuf.Timestamp",
      "next_maintenance_window_time": "google.protobuf.Timestamp"
    },
    "security_group_ids": [
      "string"
    ],
    "deletion_protection": "bool"
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
|| metadata | **[RestoreClusterMetadata](#yandex.cloud.mdb.spqr.v1.RestoreClusterMetadata)**

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
|| response | **[Cluster](#yandex.cloud.mdb.spqr.v1.Cluster)**

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

## RestoreClusterMetadata {#yandex.cloud.mdb.spqr.v1.RestoreClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the new SPQR cluster that is being created from a backup. ||
|| backup_id | **string**

ID of the backup that is being used for creating a cluster. ||
|#

## Cluster {#yandex.cloud.mdb.spqr.v1.Cluster}

A managed SPQR cluster. For more information, see the [documentation](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the SPQR cluster.
This ID is assigned by MDB at creation time. ||
|| folder_id | **string**

ID of the folder that the SPQR cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the SPQR cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the SPQR cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource. ||
|| environment | enum **Environment**

Deployment environment of the SPQR cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.spqr.v1.Monitoring)**

Description of monitoring systems relevant to the SPQR cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.spqr.v1.ClusterConfig)**

Configuration of the SPQR cluster. ||
|| network_id | **string**

ID of the network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.spqr.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.spqr.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|#

## Monitoring {#yandex.cloud.mdb.spqr.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the SPQR cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.spqr.v1.ClusterConfig}

#|
||Field | Description ||
|| spqr_config | **[SPQRConfig](#yandex.cloud.mdb.spqr.v1.SPQRConfig)**

Configuration for SPQR servers in the cluster. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access2)**

Access policy to DB ||
|| sox_audit | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## SPQRConfig {#yandex.cloud.mdb.spqr.v1.SPQRConfig}

#|
||Field | Description ||
|| router | **[RouterConfig](#yandex.cloud.mdb.spqr.v1.RouterConfig)**

SPQR router settings. ||
|| coordinator | **[CoordinatorConfig](#yandex.cloud.mdb.spqr.v1.CoordinatorConfig)**

SPQR coordinator settings. ||
|| postgresql | **[PostgreSQLConfig](#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig)**

PostgreSQL settings. ||
|| infra | **[InfraConfig](#yandex.cloud.mdb.spqr.v1.InfraConfig)**

SPQR Infra (router+coordinator) settings. ||
|| log_level | enum **LogLevel**

SPQR default log level

- `LOG_LEVEL_UNSPECIFIED`
- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings2)**

SPQR Balancer settings. ||
|#

## RouterConfig {#yandex.cloud.mdb.spqr.v1.RouterConfig}

#|
||Field | Description ||
|| config | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|#

## RouterSettings {#yandex.cloud.mdb.spqr.v1.RouterSettings2}

Configuration of a SPQR router.

#|
||Field | Description ||
|| show_notice_messages | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| time_quantiles[] | **double** ||
|| default_route_behavior | enum **DefaultRouteBehavior**

- `DEFAULT_ROUTE_BEHAVIOR_UNSPECIFIED`
- `BLOCK`
- `ALLOW` ||
|| prefer_same_availability_zone | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## Resources {#yandex.cloud.mdb.spqr.v1.Resources2}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-spqr/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## CoordinatorConfig {#yandex.cloud.mdb.spqr.v1.CoordinatorConfig}

#|
||Field | Description ||
|| config | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|#

## CoordinatorSettings {#yandex.cloud.mdb.spqr.v1.CoordinatorSettings2}

Configuration of a SPQR coordinator.

#|
||Field | Description ||
|| Empty | > ||
|#

## PostgreSQLConfig {#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig}

#|
||Field | Description ||
|| config | **[PostgreSQLSettings](#yandex.cloud.mdb.spqr.v1.PostgreSQLSettings2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|#

## PostgreSQLSettings {#yandex.cloud.mdb.spqr.v1.PostgreSQLSettings2}

Configuration of a PostgreSQL.

#|
||Field | Description ||
|| Empty | > ||
|#

## InfraConfig {#yandex.cloud.mdb.spqr.v1.InfraConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources2)** ||
|| router | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings2)** ||
|| coordinator | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings2)** ||
|#

## BalancerSettings {#yandex.cloud.mdb.spqr.v1.BalancerSettings2}

#|
||Field | Description ||
|| cpu_threshold | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| space_threshold | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| stat_interval_sec | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_move_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| keys_per_move | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|#

## Access {#yandex.cloud.mdb.spqr.v1.Access2}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens. ||
|| web_sql | **bool**

Allow access for Web SQL. ||
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|| serverless | **bool**

Allow access for Serverless.
NOTE: Do not propagate to public API until Serverless integration is required. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.spqr.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.spqr.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.spqr.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.spqr.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#