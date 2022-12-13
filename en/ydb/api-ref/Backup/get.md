---
editable: false
sourcePath: en/_api-ref/ydb/api-ref/Backup/get.md
---

# Managed Service for YDB API, REST: Backup.get
Returns the specified backup.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/backups/{backupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
backupId | <p>Required. Required. ID of the YDB backup.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "name": "string",
  "folderId": "string",
  "databaseId": "string",
  "description": "string",
  "createdAt": "string",
  "startedAt": "string",
  "completedAt": "string",
  "status": "string",
  "backupSettings": {
    "name": "string",
    "description": "string",
    "backupSchedule": {
      "nextExecuteTime": "string",

      // `backupSettings.backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`
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
      // end of the list of possible fields`backupSettings.backupSchedule`

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
  },
  "type": "string",
  "size": "string"
}
```

 
Field | Description
--- | ---
id | **string**
name | **string**<br><p>human readable backup name.</p> 
folderId | **string**
databaseId | **string**
description | **string**<br><p>description of backup.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
startedAt | **string** (date-time)<br><p>indicates when backup started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
completedAt | **string** (date-time)<br><p>indicates when backup completed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
status | **string**<br><p>id of backup</p> 
backupSettings | **object**<br><p>settings used to make backup.</p> 
backupSettings.<br>name | **string**<br><p>name of backup settings</p> <p>The maximum string length in characters is 256.</p> 
backupSettings.<br>description | **string**<br><p>human readable description.</p> <p>The maximum string length in characters is 256.</p> 
backupSettings.<br>backupSchedule | **object**<br><p>provide schedule. if empty, backup will be disabled.</p> 
backupSettings.<br>backupSchedule.<br>nextExecuteTime | **string** (date-time)<br><p>output only field: when next backup will be executed using provided schedule.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backupSettings.<br>backupSchedule.<br>dailyBackupSchedule | **object** <br>`backupSettings.backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
backupSettings.<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupSettings.<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
backupSettings.<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupSettings.<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupSettings.<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule | **object** <br>`backupSettings.backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[] | **object**<br><p>Required. The number of elements must be in the range 1-7.</p> 
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupSettings.<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupSettings.<br>backupSchedule.<br>recurringBackupSchedule | **object** <br>`backupSettings.backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
backupSettings.<br>backupSchedule.<br>recurringBackupSchedule.<br>startTime | **string** (date-time)<br><p>Required. Timestamp of the first recurrence.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backupSettings.<br>backupSchedule.<br>recurringBackupSchedule.<br>recurrence | **string**<br><p>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported.</p> 
backupSettings.<br>backupTimeToLive | **string**<br><p>provide time to live of backup.</p> 
backupSettings.<br>sourcePaths[] | **string**<br><p>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.</p> <p>The maximum number of elements is 256.</p> 
backupSettings.<br>sourcePathsToExclude[] | **string**<br><p>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.</p> <p>The maximum number of elements is 256.</p> 
backupSettings.<br>type | **string**
backupSettings.<br>storageClass | **string**
type | **string**<br><ul> <li>SYSTEM: indicates that backup started by the system.</li> </ul> 
size | **string** (int64)<br><p>size of backup in bytes.</p> 