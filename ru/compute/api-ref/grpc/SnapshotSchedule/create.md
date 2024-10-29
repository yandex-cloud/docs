---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/SnapshotSchedule/create.md
---

# Compute Cloud API, gRPC: SnapshotScheduleService.Create {#Create}

Creates a snapshot schedule in the specified folder.

## gRPC request

**rpc Create ([CreateSnapshotScheduleRequest](#yandex.cloud.compute.v1.CreateSnapshotScheduleRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSnapshotScheduleRequest {#yandex.cloud.compute.v1.CreateSnapshotScheduleRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "schedulePolicy": {
    "startAt": "google.protobuf.Timestamp",
    "expression": "string"
  },
  // Includes only one of the fields `retentionPeriod`, `snapshotCount`
  "retentionPeriod": "google.protobuf.Duration",
  "snapshotCount": "int64",
  // end of the list of possible fields
  "snapshotSpec": {
    "description": "string",
    "labels": "string"
  },
  "diskIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create a snapshot schedule in.

Snapshots are created in the same folder as the schedule, even if disks from other folders are attached
to the schedule.

To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the snapshot schedule.

The name must be unique within the folder. ||
|| description | **string**

Description of the snapshot schedule. ||
|| labels | **string**

Snapshot schedule labels as `key:value` pairs. ||
|| schedulePolicy | **[SchedulePolicy](#yandex.cloud.compute.v1.SchedulePolicy)**

Frequency settings of the snapshot schedule. ||
|| retentionPeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is
automatically deleted.

Includes only one of the fields `retentionPeriod`, `snapshotCount`.

Retention policy of the snapshot schedule. ||
|| snapshotCount | **int64**

Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this
number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted
after the sixth one is created, the second is deleted after the seventh one is created, and so on.

Includes only one of the fields `retentionPeriod`, `snapshotCount`.

Retention policy of the snapshot schedule. ||
|| snapshotSpec | **[SnapshotSpec](#yandex.cloud.compute.v1.SnapshotSpec)**

Attributes of snapshots created by the snapshot schedule. ||
|| diskIds[] | **string**

List of IDs of the disks attached to the snapshot schedule.

To get a disk ID, make a [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/grpc/Disk/list#List) request. ||
|#

## SchedulePolicy {#yandex.cloud.compute.v1.SchedulePolicy}

A resource for frequency settings of a snapshot schedule.

#|
||Field | Description ||
|| startAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "snapshotScheduleId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "status": "Status",
    "schedulePolicy": {
      "startAt": "google.protobuf.Timestamp",
      "expression": "string"
    },
    // Includes only one of the fields `retentionPeriod`, `snapshotCount`
    "retentionPeriod": "google.protobuf.Duration",
    "snapshotCount": "int64",
    // end of the list of possible fields
    "snapshotSpec": {
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSnapshotScheduleMetadata](#yandex.cloud.compute.v1.CreateSnapshotScheduleMetadata)**

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

## CreateSnapshotScheduleMetadata {#yandex.cloud.compute.v1.CreateSnapshotScheduleMetadata}

#|
||Field | Description ||
|| snapshotScheduleId | **string**

ID of the snapshot schedule that is being created. ||
|#

## SnapshotSchedule {#yandex.cloud.compute.v1.SnapshotSchedule}

A snapshot schedule. For details about the concept, see [documentation](/docs/compute/concepts/snapshot-schedule).

#|
||Field | Description ||
|| id | **string**

ID of the snapshot schedule. ||
|| folderId | **string**

ID of the folder that the snapshot schedule belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
(if [SnapshotSchedule.retentionPolicy](/docs/compute/api-ref/grpc/Disk/listSnapshotSchedules#yandex.cloud.compute.v1.SnapshotSchedule.retentionPolicy) is specified).
- `INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.
- `DELETING`: The schedule is being deleted.
- `UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks. ||
|| schedulePolicy | **[SchedulePolicy](#yandex.cloud.compute.v1.SchedulePolicy2)**

Frequency settings of the snapshot schedule. ||
|| retentionPeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is
automatically deleted.

Includes only one of the fields `retentionPeriod`, `snapshotCount`.

Retention policy of the snapshot schedule. ||
|| snapshotCount | **int64**

Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this
number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted
after the sixth one is created, the second is deleted after the seventh one is created, and so on.

Includes only one of the fields `retentionPeriod`, `snapshotCount`.

Retention policy of the snapshot schedule. ||
|| snapshotSpec | **[SnapshotSpec](#yandex.cloud.compute.v1.SnapshotSpec2)**

Attributes of snapshots created by the snapshot schedule. ||
|#

## SchedulePolicy {#yandex.cloud.compute.v1.SchedulePolicy2}

A resource for frequency settings of a snapshot schedule.

#|
||Field | Description ||
|| startAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for creating the first snapshot. ||
|| expression | **string**

Cron expression for the snapshot schedule (UTC+0).

The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of
nonstandard predefined expressions (e.g. `@hourly`). For details about the format,
see [documentation](/docs/compute/concepts/snapshot-schedule#cron) ||
|#

## SnapshotSpec {#yandex.cloud.compute.v1.SnapshotSpec2}

A resource for attributes of snapshots created by the snapshot schedule.

#|
||Field | Description ||
|| description | **string**

Description of the created snapshot. ||
|| labels | **string**

Snapshot labels as `key:value` pairs. ||
|#