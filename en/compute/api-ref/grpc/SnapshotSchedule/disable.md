---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/SnapshotSchedule/disable.md
---

# Compute Cloud API, gRPC: SnapshotScheduleService.Disable

Disables the specified snapshot schedule.

The [SnapshotSchedule.status](#yandex.cloud.compute.v1.SnapshotSchedule) is changed to `INACTIVE`: the schedule is interrupted, snapshots won't be created
or deleted.

The schedule is disabled only after all snapshot creations and deletions triggered by the schedule are completed.

## gRPC request

**rpc Disable ([DisableSnapshotScheduleRequest](#yandex.cloud.compute.v1.DisableSnapshotScheduleRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DisableSnapshotScheduleRequest {#yandex.cloud.compute.v1.DisableSnapshotScheduleRequest}

```json
{
  "snapshot_schedule_id": "string"
}
```

#|
||Field | Description ||
|| snapshot_schedule_id | **string**

ID of the snapshot schedule to disable.

To get a snapshot schedule ID, make a [SnapshotScheduleService.List](/docs/compute/api-ref/grpc/SnapshotSchedule/list#List) request. ||
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
    "snapshot_schedule_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "status": "Status",
    "schedule_policy": {
      "start_at": "google.protobuf.Timestamp",
      "expression": "string"
    },
    // Includes only one of the fields `retention_period`, `snapshot_count`
    "retention_period": "google.protobuf.Duration",
    "snapshot_count": "int64",
    // end of the list of possible fields
    "snapshot_spec": {
      "description": "string",
      "labels": "string"
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
|| metadata | **[DisableSnapshotScheduleMetadata](#yandex.cloud.compute.v1.DisableSnapshotScheduleMetadata)**

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
|| response | **[SnapshotSchedule](#yandex.cloud.compute.v1.SnapshotSchedule)**

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

## DisableSnapshotScheduleMetadata {#yandex.cloud.compute.v1.DisableSnapshotScheduleMetadata}

#|
||Field | Description ||
|| snapshot_schedule_id | **string**

ID of the snapshot schedule that is being disabled. ||
|#

## SnapshotSchedule {#yandex.cloud.compute.v1.SnapshotSchedule}

A snapshot schedule. For details about the concept, see [documentation](/docs/compute/concepts/snapshot-schedule).

#|
||Field | Description ||
|| id | **string**

ID of the snapshot schedule. ||
|| folder_id | **string**

ID of the folder that the snapshot schedule belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the snapshot schedule.

The name is unique within the folder. ||
|| description | **string**

Description of the snapshot schedule. ||
|| labels | **string**

Snapshot schedule labels as `key:value` pairs. ||
|| status | enum **Status**

Status of the snapshot schedule.

- `STATUS_UNSPECIFIED`
- `CREATING`: The snapshot schedule is being created.
- `ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted
(if [SnapshotSchedule.retention_policy](/docs/compute/api-ref/grpc/Disk/listSnapshotSchedules#yandex.cloud.compute.v1.SnapshotSchedule.retention_policy) is specified).
- `INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.
- `DELETING`: The schedule is being deleted.
- `UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks. ||
|| schedule_policy | **[SchedulePolicy](#yandex.cloud.compute.v1.SchedulePolicy)**

Frequency settings of the snapshot schedule. ||
|| retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is
automatically deleted.

Includes only one of the fields `retention_period`, `snapshot_count`.

Retention policy of the snapshot schedule. ||
|| snapshot_count | **int64**

Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this
number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted
after the sixth one is created, the second is deleted after the seventh one is created, and so on.

Includes only one of the fields `retention_period`, `snapshot_count`.

Retention policy of the snapshot schedule. ||
|| snapshot_spec | **[SnapshotSpec](#yandex.cloud.compute.v1.SnapshotSpec)**

Attributes of snapshots created by the snapshot schedule. ||
|#

## SchedulePolicy {#yandex.cloud.compute.v1.SchedulePolicy}

A resource for frequency settings of a snapshot schedule.

#|
||Field | Description ||
|| start_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for creating the first snapshot. ||
|| expression | **string**

Cron expression for the snapshot schedule (UTC+0).

The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of
nonstandard predefined expressions (e.g. `@hourly`). For details about the format,
see [documentation](/docs/compute/concepts/snapshot-schedule#cron) ||
|#

## SnapshotSpec {#yandex.cloud.compute.v1.SnapshotSpec}

A resource for attributes of snapshots created by the snapshot schedule.

#|
||Field | Description ||
|| description | **string**

Description of the created snapshot. ||
|| labels | **string**

Snapshot labels as `key:value` pairs. ||
|#