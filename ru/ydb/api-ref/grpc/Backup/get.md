---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for YDB API, gRPC: BackupService.Get {#Get}

Returns the specified backup.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.ydb.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.ydb.v1.Backup))**

## GetBackupRequest {#yandex.cloud.ydb.v1.GetBackupRequest}

```json
{
  "backupId": "string"
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. Required. ID of the YDB backup. ||
|#

## Backup {#yandex.cloud.ydb.v1.Backup}

```json
{
  "id": "string",
  "name": "string",
  "folderId": "string",
  "databaseId": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "startedAt": "google.protobuf.Timestamp",
  "completedAt": "google.protobuf.Timestamp",
  "status": "Status",
  "backupSettings": {
    "name": "string",
    "description": "string",
    "backupSchedule": {
      // Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`
      "dailyBackupSchedule": {
        "executeTime": "google.type.TimeOfDay"
      },
      "weeklyBackupSchedule": {
        "daysOfWeek": [
          {
            "days": [
              "DayOfWeek"
            ],
            "executeTime": "google.type.TimeOfDay"
          }
        ]
      },
      "recurringBackupSchedule": {
        "startTime": "google.protobuf.Timestamp",
        "recurrence": "string"
      },
      // end of the list of possible fields
      "nextExecuteTime": "google.protobuf.Timestamp"
    },
    "backupTimeToLive": "google.protobuf.Duration",
    "sourcePaths": [
      "string"
    ],
    "sourcePathsToExclude": [
      "string"
    ],
    "type": "Type",
    "storageClass": "StorageClass"
  },
  "type": "Type",
  "size": "int64"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| name | **string**

human readable backup name. ||
|| folderId | **string** ||
|| databaseId | **string** ||
|| description | **string**

description of backup. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

indicates when backup started. ||
|| completedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

indicates when backup completed. ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `ERROR`
- `CANCELLED` ||
|| backupSettings | **[BackupSettings](#yandex.cloud.ydb.v1.BackupSettings)**

settings used to make backup. ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `SYSTEM`: indicates that backup started by the system.
- `USER` ||
|| size | **int64**

size of backup in bytes. ||
|#

## BackupSettings {#yandex.cloud.ydb.v1.BackupSettings}

#|
||Field | Description ||
|| name | **string**

name of backup settings ||
|| description | **string**

human readable description. ||
|| backupSchedule | **[BackupSchedule](#yandex.cloud.ydb.v1.BackupSchedule)**

provide schedule. if empty, backup will be disabled. ||
|| backupTimeToLive | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

provide time to live of backup. ||
|| sourcePaths[] | **string**

provide a list of source paths. Each path can be directory, table or even database itself.
Each directory (or database) will be traversed recursively and all childs of directory will be included to backup.
By default, backup will be created for full database. ||
|| sourcePathsToExclude[] | **string**

provide a list of paths to exclude from backup.
Each path is a directory, table, or database.
Each directory (or database) will be traversed recursively and all childs of directory will be excluded. ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `SYSTEM`
- `USER` ||
|| storageClass | enum **StorageClass**

- `STORAGE_CLASS_UNSPECIFIED`
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
|| nextExecuteTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

output only field: when next backup will be executed
using provided schedule. ||
|#

## DailyBackupSchedule {#yandex.cloud.ydb.v1.DailyBackupSchedule}

#|
||Field | Description ||
|| executeTime | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field.  ||
|#

## WeeklyBackupSchedule {#yandex.cloud.ydb.v1.WeeklyBackupSchedule}

#|
||Field | Description ||
|| daysOfWeek[] | **[DaysOfWeekBackupSchedule](#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule)** ||
|#

## DaysOfWeekBackupSchedule {#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule}

#|
||Field | Description ||
|| days[] | enum **DayOfWeek**

- `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| executeTime | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field.  ||
|#

## RecurringBackupSchedule {#yandex.cloud.ydb.v1.RecurringBackupSchedule}

#|
||Field | Description ||
|| startTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Timestamp of the first recurrence. ||
|| recurrence | **string**

Required field. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how
this backup reccurs.
The FREQ values of MINUTELY, and SECONDLY are not supported. ||
|#