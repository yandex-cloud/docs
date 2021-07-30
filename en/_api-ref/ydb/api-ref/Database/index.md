---
editable: false
---

# Database
A set of methods for managing databases.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "status": "string",
  "endpoint": "string",
  "resourcePresetId": "string",
  "storageConfig": {
    "storageOptions": [
      {
        "storageTypeId": "string",
        "groupCount": "string"
      }
    ],
    "storageSizeLimit": "string"
  },
  "scalePolicy": {
    "fixedScale": {
      "size": "string"
    }
  },
  "networkId": "string",
  "subnetIds": [
    "string"
  ],
  "assignPublicIps": true,
  "locationId": "string",
  "labels": "object",
  "backupConfig": {
    "backupSettings": [
      {
        "name": "string",
        "description": "string",
        "backupSchedule": {
          "nextExecuteTime": "string",

          // `backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`
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
          // end of the list of possible fields`backupConfig.backupSettings[].backupSchedule`

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
    ]
  },
  "documentApiEndpoint": "string",
  "kinesisApiEndpoint": "string",

  //  includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`
  "zonalDatabase": {
    "zoneId": "string"
  },
  "regionalDatabase": {
    "regionId": "string"
  },
  "dedicatedDatabase": {
    "resourcePresetId": "string",
    "storageConfig": {
      "storageOptions": [
        {
          "storageTypeId": "string",
          "groupCount": "string"
        }
      ],
      "storageSizeLimit": "string"
    },
    "scalePolicy": {
      "fixedScale": {
        "size": "string"
      }
    },
    "networkId": "string",
    "subnetIds": [
      "string"
    ],
    "assignPublicIps": true
  },
  "serverlessDatabase": {
    "requestUnitsPerSecondLimit": "string",
    "storageSizeLimit": "string"
  },
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
status | **string**<br>
endpoint | **string**<br>
resourcePresetId | **string**<br>
storageConfig | **object**<br>
storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
storageConfig.<br>storageSizeLimit | **string** (int64)<br><p>output only field: storage size limit of dedicated database.</p> 
scalePolicy | **object**<br>
scalePolicy.<br>fixedScale | **object**<br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
networkId | **string**<br>
subnetIds[] | **string**<br>
assignPublicIps | **boolean** (boolean)<br>
locationId | **string**<br>
labels | **object**<br>
backupConfig | **object**<br>
backupConfig.<br>backupSettings[] | **object**<br>
backupConfig.<br>backupSettings[].<br>name | **string**<br><p>name of backup settings</p> <p>The maximum string length in characters is 256.</p> 
backupConfig.<br>backupSettings[].<br>description | **string**<br><p>human readable description.</p> <p>The maximum string length in characters is 256.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule | **object**<br><p>provide schedule. if empty, backup will be disabled.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>nextExecuteTime | **string** (date-time)<br><p>output only field: when next backup will be executed using provided schedule.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br><br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br><br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[] | **object**<br><p>Required. The number of elements must be in the range 1-7.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>days[] | **string**<br><p>Represents a day of week.</p> <ul> <li>DAY_OF_WEEK_UNSPECIFIED: The unspecified day-of-week.</li> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br><br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule.<br>startTime | **string** (date-time)<br><p>Required. Timestamp of the first recurrence.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule.<br>recurrence | **string**<br><p>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported.</p> 
backupConfig.<br>backupSettings[].<br>backupTimeToLive | **string**<br><p>provide time to live of backup.</p> 
backupConfig.<br>backupSettings[].<br>sourcePaths[] | **string**<br><p>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.</p> <p>The maximum number of elements is 256.</p> 
backupConfig.<br>backupSettings[].<br>sourcePathsToExclude[] | **string**<br><p>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.</p> <p>The maximum number of elements is 256.</p> 
backupConfig.<br>backupSettings[].<br>type | **string**<br>
backupConfig.<br>backupSettings[].<br>storageClass | **string**<br>
documentApiEndpoint | **string**<br>
kinesisApiEndpoint | **string**<br>
zonalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
regionalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
dedicatedDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
dedicatedDatabase.<br>resourcePresetId | **string**<br>
dedicatedDatabase.<br>storageConfig | **object**<br>
dedicatedDatabase.<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
dedicatedDatabase.<br>storageConfig.<br>storageSizeLimit | **string** (int64)<br><p>output only field: storage size limit of dedicated database.</p> 
dedicatedDatabase.<br>scalePolicy | **object**<br>
dedicatedDatabase.<br>scalePolicy.<br>fixedScale | **object**<br>
dedicatedDatabase.<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
dedicatedDatabase.<br>networkId | **string**<br>
dedicatedDatabase.<br>subnetIds[] | **string**<br>
dedicatedDatabase.<br>assignPublicIps | **boolean** (boolean)<br>
serverlessDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
serverlessDatabase.<br>requestUnitsPerSecondLimit | **string** (int64)<br><p>Specify explicit limit of request units for database. Default value is 0. If zero, then request units are unlimited for this database and units are limited by cloud quota value.</p> 
serverlessDatabase.<br>storageSizeLimit | **string** (int64)<br><p>Specify serverless database storage size limit. If zero, default value is applied.</p> 

## Methods {#methods}
Method | Description
--- | ---
[backup](backup.md) | 
[create](create.md) | Creates a new database.
[delete](delete.md) | Deletes the specified database.
[get](get.md) | Returns the specified database.
[list](list.md) | Retrieves a list of databases.
[restore](restore.md) | Restores the specified backup
[start](start.md) | Starts the specified database.
[stop](stop.md) | Stops the specified database.
[update](update.md) | Modifies the specified database.