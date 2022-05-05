---
editable: false
---

# BackupService

A set of methods for managing backups.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified backup. |
| [ListPaths](#ListPaths) |  |
| [List](#List) | Retrieves a list of backups. |
| [Delete](#Delete) | Deletes the specified backup. |

## Calls BackupService {#calls}

## Get {#Get}

Returns the specified backup.

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup))**

### GetBackupRequest {#GetBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Required. ID of the YDB backup. The maximum string length in characters is 50.


### Backup {#Backup}

Field | Description
--- | ---
id | **string**<br>id of backup 
name | **string**<br>human readable backup name. 
folder_id | **string**<br> 
database_id | **string**<br> 
description | **string**<br>description of backup. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>indicates when backup started. 
completed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>indicates when backup completed. 
status | enum **Status**<br> 
backup_settings | **[BackupSettings](#BackupSettings)**<br>settings used to make backup. 
type | enum **[Type](./storage_type#undefined)**<br> <ul><li>`SYSTEM`: indicates that backup started by the system.</li></ul>
size | **int64**<br>size of backup in bytes. 


### BackupSettings {#BackupSettings}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


## ListPaths {#ListPaths}



**rpc ListPaths ([ListPathsRequest](#ListPathsRequest)) returns ([ListPathsResponse](#ListPathsResponse))**

### ListPathsRequest {#ListPathsRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Required. ID of the YDB backup. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListPaths requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListPaths request to get the next page of results. The maximum string length in characters is 100.


### ListPathsResponse {#ListPathsResponse}

Field | Description
--- | ---
paths[] | **string**<br> 
next_page_token | **string**<br> 


## List {#List}

Retrieves a list of backups.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListBackups requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups request to get the next page of results. The maximum string length in characters is 100.


### ListBackupsResponse {#ListBackupsResponse}

Field | Description
--- | ---
backups[] | **[Backup](#Backup1)**<br> 
next_page_token | **string**<br>This token allows you to get the next page of results for ListBackups requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListBackups request. Subsequent ListBackups requests will have their own `next_page_token` to continue paging through the results. 


### Backup {#Backup1}

Field | Description
--- | ---
id | **string**<br>id of backup 
name | **string**<br>human readable backup name. 
folder_id | **string**<br> 
database_id | **string**<br> 
description | **string**<br>description of backup. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>indicates when backup started. 
completed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>indicates when backup completed. 
status | enum **Status**<br> 
backup_settings | **[BackupSettings](#BackupSettings1)**<br>settings used to make backup. 
type | enum **[Type](./storage_type#undefined)**<br> <ul><li>`SYSTEM`: indicates that backup started by the system.</li></ul>
size | **int64**<br>size of backup in bytes. 


### BackupSettings {#BackupSettings1}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule1)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule1}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule1)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule1)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule1)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule1}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule1}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule1)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule1}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule1}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


## Delete {#Delete}

Deletes the specified backup.

**rpc Delete ([DeleteBackupRequest](#DeleteBackupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteBackupMetadata](#DeleteBackupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteBackupRequest {#DeleteBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteBackupMetadata](#DeleteBackupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteBackupMetadata {#DeleteBackupMetadata}

Field | Description
--- | ---
backup_id | **string**<br> 
database_id | **string**<br> 


