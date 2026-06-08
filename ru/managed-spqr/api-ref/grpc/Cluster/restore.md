---
editable: false
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
          "prefer_same_availability_zone": "google.protobuf.BoolValue",
          "enhanced_multishard_processing": "google.protobuf.BoolValue",
          "default_target_session_attrs": "TargetSessionAttrs",
          "default_commit_strategy": "CommitStrategy"
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
          "prefer_same_availability_zone": "google.protobuf.BoolValue",
          "enhanced_multishard_processing": "google.protobuf.BoolValue",
          "default_target_session_attrs": "TargetSessionAttrs",
          "default_commit_strategy": "CommitStrategy"
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
The name can't be changed after the SPQR cluster is created.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the new SPQR cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| environment | enum **Environment**

Required field. Deployment environment of the new SPQR cluster.

- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.spqr.v1.ConfigSpec)**

Required field. Configuration for the SPQR cluster to be created. ||
|| host_specs[] | **[HostSpec](#yandex.cloud.mdb.spqr.v1.HostSpec)**

Configurations for SPQR hosts that should be created for
the cluster that is being created from the backup.

The number of elements must be greater than 0. ||
|| network_id | **string**

Required field. ID of the network to create the SPQR cluster in.

The maximum string length in characters is 150. ||
|| folder_id | **string**

Required. ID of the folder to create the SPQR cluster in.

The maximum string length in characters is 50. ||
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

- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL` ||
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

- `BLOCK`
- `ALLOW` ||
|| prefer_same_availability_zone | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| enhanced_multishard_processing | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| default_target_session_attrs | enum **TargetSessionAttrs**

- `READ_WRITE`
- `SMART_READ_WRITE`
- `READ_ONLY`
- `PREFER_STANDBY`
- `ANY` ||
|| default_commit_strategy | enum **CommitStrategy**

- `BEST_EFFORT`
- `ONE_PC`
- `TWO_PC` ||
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
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request.

The maximum string length in characters is 50. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The network ID is set in the [Cluster.network_id](/docs/managed-spqr/api-ref/grpc/Cluster/get#yandex.cloud.mdb.spqr.v1.Cluster) field.

The maximum string length in characters is 50. ||
|| assign_public_ip | **bool**

Whether the host should get a public IP address on creation.
After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assign_public_ip` set as needed.
Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| type | enum **Type**

Required field. Type of the host to be deployed.

- `ROUTER`: A SPQR Router host.
- `COORDINATOR`: A SPQR Coordinator host.
- `INFRA`: A SPQR Infra host (router+coordinator)
- `POSTGRESQL`: A PostgreSQL host.
- `EXTERNAL_POSTGRESQL`: An External PostgreSQL host.
- `MDB_POSTGRESQL`: A Managed PostgreSQL host ||
|| shard_name | **string**

Name of the shard that the host belongs to.
If empty, host doesn't belong to any shard

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| mdb_postgresql | **[MDBPostgreSQL](#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL)** ||
|#

## MDBPostgreSQL {#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL}

TODO move to hosts.proto when it's created
Configuration for MDB PostgreSQL host

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ||
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