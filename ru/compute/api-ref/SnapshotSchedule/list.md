---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/SnapshotSchedule/list.md
---

# Compute Cloud API, REST: SnapshotSchedule.List {#List}

Retrieves the list of snapshot schedules in the specified folder.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/snapshotSchedules
```

## Query parameters {#yandex.cloud.compute.v1.ListSnapshotSchedulesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list snapshot schedules in.

To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListSnapshotSchedulesResponse.nextPageToken](#yandex.cloud.compute.v1.ListSnapshotSchedulesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListSnapshotSchedulesResponse.nextPageToken](#yandex.cloud.compute.v1.ListSnapshotSchedulesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters snapshot schedules listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [SnapshotSchedule.name](#yandex.cloud.compute.v1.SnapshotSchedule) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-schedule`. ||
|| orderBy | **string**

A sorting expression that sorts snapshot schedules listed in the response.

The expression must specify the field name from [SnapshotSchedule](#yandex.cloud.compute.v1.SnapshotSchedule) and `asc`ending or `desc`ending order,
e.g. `createdAt desc`.

Default value: `id asc`. ||
|#

## Response {#yandex.cloud.compute.v1.ListSnapshotSchedulesResponse}

**HTTP Code: 200 - OK**

```json
{
  "snapshotSchedules": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
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
        "labels": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| snapshotSchedules[] | **[SnapshotSchedule](#yandex.cloud.compute.v1.SnapshotSchedule)**

List of snapshot schedules in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListSnapshotSchedulesRequest.pageSize](#yandex.cloud.compute.v1.ListSnapshotSchedulesRequest), use `next_page_token` as the value
for the [ListSnapshotSchedulesRequest.pageToken](#yandex.cloud.compute.v1.ListSnapshotSchedulesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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
|| labels | **string**

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
|| labels | **string**

Snapshot labels as `key:value` pairs. ||
|#