---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for YDB API, gRPC: BackupService.List

Retrieves a list of backups.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.ydb.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.ydb.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.ydb.v1.ListBackupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string** ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListBackups requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups
request to get the next page of results. ||
|#

## ListBackupsResponse {#yandex.cloud.ydb.v1.ListBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "name": "string",
      "folder_id": "string",
      "database_id": "string",
      "description": "string",
      "created_at": "google.protobuf.Timestamp",
      "started_at": "google.protobuf.Timestamp",
      "completed_at": "google.protobuf.Timestamp",
      "status": "Status",
      "backup_settings": {
        "name": "string",
        "description": "string",
        "backup_schedule": {
          // Includes only one of the fields `daily_backup_schedule`, `weekly_backup_schedule`, `recurring_backup_schedule`
          "daily_backup_schedule": {
            "execute_time": "google.type.TimeOfDay"
          },
          "weekly_backup_schedule": {
            "days_of_week": [
              {
                "days": [
                  "DayOfWeek"
                ],
                "execute_time": "google.type.TimeOfDay"
              }
            ]
          },
          "recurring_backup_schedule": {
            "start_time": "google.protobuf.Timestamp",
            "recurrence": "string"
          },
          // end of the list of possible fields
          "next_execute_time": "google.protobuf.Timestamp"
        },
        "backup_time_to_live": "google.protobuf.Duration",
        "source_paths": [
          "string"
        ],
        "source_paths_to_exclude": [
          "string"
        ],
        "type": "Type",
        "storage_class": "StorageClass"
      },
      "type": "Type",
      "size": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.ydb.v1.Backup)** ||
|| next_page_token | **string**

This token allows you to get the next page of results for ListBackups requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListBackups request. Subsequent ListBackups
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.ydb.v1.Backup}

#|
||Field | Description ||
|| id | **string** ||
|| name | **string**

human readable backup name. ||
|| folder_id | **string** ||
|| database_id | **string** ||
|| description | **string**

description of backup. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

indicates when backup started. ||
|| completed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

indicates when backup completed. ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `ERROR`
- `CANCELLED` ||
|| backup_settings | **[BackupSettings](#yandex.cloud.ydb.v1.BackupSettings)**

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
|| backup_schedule | **[BackupSchedule](#yandex.cloud.ydb.v1.BackupSchedule)**

provide schedule. if empty, backup will be disabled. ||
|| backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

provide time to live of backup. ||
|| source_paths[] | **string**

provide a list of source paths. Each path can be directory, table or even database itself.
Each directory (or database) will be traversed recursively and all childs of directory will be included to backup.
By default, backup will be created for full database. ||
|| source_paths_to_exclude[] | **string**

provide a list of paths to exclude from backup.
Each path is a directory, table, or database.
Each directory (or database) will be traversed recursively and all childs of directory will be excluded. ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `SYSTEM`
- `USER` ||
|| storage_class | enum **StorageClass**

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
|| daily_backup_schedule | **[DailyBackupSchedule](#yandex.cloud.ydb.v1.DailyBackupSchedule)**

Includes only one of the fields `daily_backup_schedule`, `weekly_backup_schedule`, `recurring_backup_schedule`. ||
|| weekly_backup_schedule | **[WeeklyBackupSchedule](#yandex.cloud.ydb.v1.WeeklyBackupSchedule)**

Includes only one of the fields `daily_backup_schedule`, `weekly_backup_schedule`, `recurring_backup_schedule`. ||
|| recurring_backup_schedule | **[RecurringBackupSchedule](#yandex.cloud.ydb.v1.RecurringBackupSchedule)**

Includes only one of the fields `daily_backup_schedule`, `weekly_backup_schedule`, `recurring_backup_schedule`. ||
|| next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

output only field: when next backup will be executed
using provided schedule. ||
|#

## DailyBackupSchedule {#yandex.cloud.ydb.v1.DailyBackupSchedule}

#|
||Field | Description ||
|| execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field.  ||
|#

## WeeklyBackupSchedule {#yandex.cloud.ydb.v1.WeeklyBackupSchedule}

#|
||Field | Description ||
|| days_of_week[] | **[DaysOfWeekBackupSchedule](#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule)** ||
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
|| execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field.  ||
|#

## RecurringBackupSchedule {#yandex.cloud.ydb.v1.RecurringBackupSchedule}

#|
||Field | Description ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Timestamp of the first recurrence. ||
|| recurrence | **string**

Required field. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how
this backup reccurs.
The FREQ values of MINUTELY, and SECONDLY are not supported. ||
|#