[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Sharded PostgreSQL](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Cluster](index.md) > Update

# Managed Service for SPQR API, gRPC: ClusterService.Update

Updates the specified SPQR cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.mdb.spqr.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.mdb.spqr.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
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
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "network_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the SPQR Cluster resource to update.
To get the SPQR cluster ID use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the SPQR Cluster resource should be updated. ||
|| name | **string**

New name for the cluster.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

New description of the SPQR cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".
The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](get.md#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.spqr.v1.ConfigSpec)**

New configuration and resources for hosts in the cluster. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.spqr.v1.MaintenanceWindow)**

New maintenance window settings for the cluster. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| network_id | **string**

ID of the network to move the cluster to.

The maximum string length in characters is 150. ||
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
All available presets are listed in the [documentation](../../../concepts/instance-types.md). ||
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

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format).

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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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