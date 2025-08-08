---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/snapshotSchedules
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to create a snapshot schedule in.
            Snapshots are created in the same folder as the schedule, even if disks from other folders are attached
            to the schedule.
            To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the snapshot schedule.
            The name must be unique within the folder.
          type: string
        description:
          description: |-
            **string**
            Description of the snapshot schedule.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Snapshot schedule labels as `key:value` pairs.
          type: string
        schedulePolicy:
          description: |-
            **[SchedulePolicy](/docs/compute/api-ref/SnapshotSchedule/get#yandex.cloud.compute.v1.SchedulePolicy)**
            Frequency settings of the snapshot schedule.
          $ref: '#/definitions/SchedulePolicy'
        retentionPeriod:
          description: |-
            **string** (duration)
            Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is
            automatically deleted.
            Includes only one of the fields `retentionPeriod`, `snapshotCount`.
            Retention policy of the snapshot schedule.
          type: string
          format: duration
        snapshotCount:
          description: |-
            **string** (int64)
            Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this
            number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted
            after the sixth one is created, the second is deleted after the seventh one is created, and so on.
            Includes only one of the fields `retentionPeriod`, `snapshotCount`.
            Retention policy of the snapshot schedule.
          type: string
          format: int64
        snapshotSpec:
          description: |-
            **[SnapshotSpec](/docs/compute/api-ref/SnapshotSchedule/get#yandex.cloud.compute.v1.SnapshotSpec)**
            Attributes of snapshots created by the snapshot schedule.
          $ref: '#/definitions/SnapshotSpec'
        diskIds:
          description: |-
            **string**
            List of IDs of the disks attached to the snapshot schedule.
            To get a disk ID, make a [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/Disk/list#List) request.
          type: array
          items:
            type: string
      additionalProperties: false
    definitions:
      SchedulePolicy:
        type: object
        properties:
          startAt:
            description: |-
              **string** (date-time)
              Timestamp for creating the first snapshot.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          expression:
            description: |-
              **string**
              Cron expression for the snapshot schedule (UTC+0).
              The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of
              nonstandard predefined expressions (e.g. `@hourly`). For details about the format,
              see [documentation](/docs/compute/concepts/snapshot-schedule#cron)
            type: string
      SnapshotSpec:
        type: object
        properties:
          description:
            description: |-
              **string**
              Description of the created snapshot.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Snapshot labels as `key:value` pairs.
            type: string
sourcePath: en/_api-ref/compute/v1/api-ref/SnapshotSchedule/create.md
---

# Compute Cloud API, REST: SnapshotSchedule.Create

Creates a snapshot schedule in the specified folder.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/snapshotSchedules
```

## Body parameters {#yandex.cloud.compute.v1.CreateSnapshotScheduleRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "schedulePolicy": {
    "startAt": "string",
    "expression": "string"
  },
  // Includes only one of the fields `retentionPeriod`, `snapshotCount`
  "retentionPeriod": "string",
  "snapshotCount": "string",
  // end of the list of possible fields
  "snapshotSpec": {
    "description": "string",
    "labels": "object"
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

To get a folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the snapshot schedule.

The name must be unique within the folder. ||
|| description | **string**

Description of the snapshot schedule. ||
|| labels | **object** (map<**string**, **string**>)

Snapshot schedule labels as `key:value` pairs. ||
|| schedulePolicy | **[SchedulePolicy](#yandex.cloud.compute.v1.SchedulePolicy)**

Frequency settings of the snapshot schedule. ||
|| retentionPeriod | **string** (duration)

Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is
automatically deleted.

Includes only one of the fields `retentionPeriod`, `snapshotCount`.

Retention policy of the snapshot schedule. ||
|| snapshotCount | **string** (int64)

Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this
number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted
after the sixth one is created, the second is deleted after the seventh one is created, and so on.

Includes only one of the fields `retentionPeriod`, `snapshotCount`.

Retention policy of the snapshot schedule. ||
|| snapshotSpec | **[SnapshotSpec](#yandex.cloud.compute.v1.SnapshotSpec)**

Attributes of snapshots created by the snapshot schedule. ||
|| diskIds[] | **string**

List of IDs of the disks attached to the snapshot schedule.

To get a disk ID, make a [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/Disk/list#List) request. ||
|#

## SchedulePolicy {#yandex.cloud.compute.v1.SchedulePolicy}

A resource for frequency settings of a snapshot schedule.

#|
||Field | Description ||
|| startAt | **string** (date-time)

Timestamp for creating the first snapshot.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "snapshotScheduleId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "status": "string",
    "schedulePolicy": {
      "startAt": "string",
      "expression": "string"
    },
    // Includes only one of the fields `retentionPeriod`, `snapshotCount`
    "retentionPeriod": "string",
    "snapshotCount": "string",
    // end of the list of possible fields
    "snapshotSpec": {
      "description": "string",
      "labels": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSnapshotScheduleMetadata](#yandex.cloud.compute.v1.CreateSnapshotScheduleMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## SnapshotSchedule {#yandex.cloud.compute.v1.SnapshotSchedule}

A snapshot schedule. For details about the concept, see [documentation](/docs/compute/concepts/snapshot-schedule).

#|
||Field | Description ||
|| id | **string**

ID of the snapshot schedule. ||
|| folderId | **string**

ID of the folder that the snapshot schedule belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the snapshot schedule.

The name is unique within the folder. ||
|| description | **string**

Description of the snapshot schedule. ||
|| labels | **object** (map<**string**, **string**>)

Snapshot schedule labels as `key:value` pairs. ||
|| status | **enum** (Status)

Status of the snapshot schedule.

- `STATUS_UNSPECIFIED`
- `CREATING`: The snapshot schedule is being created.
- `ACTIVE`: The snapshot schedule is on: new disk snapshots will be created, old ones deleted
(if [SnapshotSchedule.retentionPolicy](/docs/compute/api-ref/SnapshotSchedule/get#yandex.cloud.compute.v1.SnapshotSchedule.retentionPolicy) is specified).
- `INACTIVE`: The schedule is interrupted, snapshots won't be created or deleted.
- `DELETING`: The schedule is being deleted.
- `UPDATING`: Changes are being made to snapshot schedule settings or a list of attached disks. ||
|| schedulePolicy | **[SchedulePolicy](#yandex.cloud.compute.v1.SchedulePolicy2)**

Frequency settings of the snapshot schedule. ||
|| retentionPeriod | **string** (duration)

Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is
automatically deleted.

Includes only one of the fields `retentionPeriod`, `snapshotCount`.

Retention policy of the snapshot schedule. ||
|| snapshotCount | **string** (int64)

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
|| startAt | **string** (date-time)

Timestamp for creating the first snapshot.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| labels | **object** (map<**string**, **string**>)

Snapshot labels as `key:value` pairs. ||
|#