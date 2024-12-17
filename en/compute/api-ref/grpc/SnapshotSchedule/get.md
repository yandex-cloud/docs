---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/SnapshotSchedule/get.md
---

# Compute Cloud API, gRPC: SnapshotScheduleService.Get

Returns the specified snapshot schedule.

To get the list of available snapshot schedules, make a [List](/docs/compute/api-ref/grpc/SnapshotSchedule/list#List) request.

## gRPC request

**rpc Get ([GetSnapshotScheduleRequest](#yandex.cloud.compute.v1.GetSnapshotScheduleRequest)) returns ([SnapshotSchedule](#yandex.cloud.compute.v1.SnapshotSchedule))**

## GetSnapshotScheduleRequest {#yandex.cloud.compute.v1.GetSnapshotScheduleRequest}

```json
{
  "snapshot_schedule_id": "string"
}
```

#|
||Field | Description ||
|| snapshot_schedule_id | **string**

ID of the snapshot schedule to return.

To get a schedule ID, make a [SnapshotScheduleService.List](/docs/compute/api-ref/grpc/SnapshotSchedule/list#List) request. ||
|#

## SnapshotSchedule {#yandex.cloud.compute.v1.SnapshotSchedule}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
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
    "labels": "map<string, string>"
  }
}
```

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
|| labels | **object** (map<**string**, **string**>)

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
|| labels | **object** (map<**string**, **string**>)

Snapshot labels as `key:value` pairs. ||
|#