# Managed Service for YDB API, REST: Database.Backup

## HTTP request

```
POST https://ydb.api.cloud.yandex.net/ydb/v1/databases:backup
```

## Body parameters {#yandex.cloud.ydb.v1.BackupDatabaseRequest}

```json
{
  "databaseId": "string",
  "backupSettings": {
    "name": "string",
    "description": "string",
    "backupSchedule": {
      // Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`
      "dailyBackupSchedule": {
        "executeTime": {
          "hours": "integer",
          "minutes": "integer",
          "seconds": "integer",
          "nanos": "integer"
        }
      },
      "weeklyBackupSchedule": {
        "daysOfWeek": [
          {
            "days": [
              "string"
            ],
            "executeTime": {
              "hours": "integer",
              "minutes": "integer",
              "seconds": "integer",
              "nanos": "integer"
            }
          }
        ]
      },
      "recurringBackupSchedule": {
        "startTime": "string",
        "recurrence": "string"
      },
      // end of the list of possible fields
      "nextExecuteTime": "string"
    },
    "backupTimeToLive": "string",
    "sourcePaths": [
      "string"
    ],
    "sourcePathsToExclude": [
      "string"
    ],
    "type": "string",
    "storageClass": "string"
  }
}
```

#|
||Field | Description ||
|| databaseId | **string** ||
|| backupSettings | **[BackupSettings](#yandex.cloud.ydb.v1.BackupSettings)**

custom backup options, if required. ||
|#

## BackupSettings {#yandex.cloud.ydb.v1.BackupSettings}

#|
||Field | Description ||
|| name | **string**

name of backup settings

The maximum string length in characters is 256. ||
|| description | **string**

human readable description.

The maximum string length in characters is 256. ||
|| backupSchedule | **[BackupSchedule](#yandex.cloud.ydb.v1.BackupSchedule)**

provide schedule. if empty, backup will be disabled. ||
|| backupTimeToLive | **string** (duration)

provide time to live of backup. ||
|| sourcePaths[] | **string**

provide a list of source paths. Each path can be directory, table or even database itself.
Each directory (or database) will be traversed recursively and all childs of directory will be included to backup.
By default, backup will be created for full database.

The maximum number of elements is 256. ||
|| sourcePathsToExclude[] | **string**

provide a list of paths to exclude from backup.
Each path is a directory, table, or database.
Each directory (or database) will be traversed recursively and all childs of directory will be excluded.

The maximum number of elements is 256. ||
|| type | **enum** (Type)

- `SYSTEM`
- `USER` ||
|| storageClass | **enum** (StorageClass)

- `STANDARD`
- `REDUCED_REDUNDANCY`
- `STANDARD_IA`
- `ONEZONE_IA`
- `INTELLIGENT_TIERING`
- `GLACIER`
- `DEEP_ARCHIVE`
- `OUTPOSTS` ||
|#

## BackupSchedule {#yandex.cloud.ydb.v1.BackupSchedule}

#|
||Field | Description ||
|| dailyBackupSchedule | **[DailyBackupSchedule](#yandex.cloud.ydb.v1.DailyBackupSchedule)**

Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`. ||
|| weeklyBackupSchedule | **[WeeklyBackupSchedule](#yandex.cloud.ydb.v1.WeeklyBackupSchedule)**

Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`. ||
|| recurringBackupSchedule | **[RecurringBackupSchedule](#yandex.cloud.ydb.v1.RecurringBackupSchedule)**

Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`. ||
|| nextExecuteTime | **string** (date-time)

output only field: when next backup will be executed
using provided schedule.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## DailyBackupSchedule {#yandex.cloud.ydb.v1.DailyBackupSchedule}

#|
||Field | Description ||
|| executeTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## WeeklyBackupSchedule {#yandex.cloud.ydb.v1.WeeklyBackupSchedule}

#|
||Field | Description ||
|| daysOfWeek[] | **[DaysOfWeekBackupSchedule](#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule)**

The number of elements must be in the range 1-7. ||
|#

## DaysOfWeekBackupSchedule {#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule}

#|
||Field | Description ||
|| days[] | **enum** (DayOfWeek)

The number of elements must be in the range 1-7.

- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| executeTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field. ||
|#

## RecurringBackupSchedule {#yandex.cloud.ydb.v1.RecurringBackupSchedule}

#|
||Field | Description ||
|| startTime | **string** (date-time)

Required field. Timestamp of the first recurrence.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| recurrence | **string**

Required field. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how
this backup reccurs.
The FREQ values of MINUTELY, and SECONDLY are not supported. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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