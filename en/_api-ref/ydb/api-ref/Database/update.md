---
editable: false
---

# Method update
Modifies the specified database.
 

 
## HTTP request {#https-request}
```
PATCH https://ydb.api.cloud.yandex.net/ydb/v1/databases/{databaseId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
databaseId | 
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "resourcePresetId": "string",
  "storageConfig": {
    "storageOptions": [
      {
        "storageTypeId": "string",
        "groupCount": "string"
      }
    ]
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

          // `backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`
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
          // end of the list of possible fields`backupConfig.backupSettings[].backupSchedule`

        },
        "backupTimeToLive": "string",
        "sourcePaths": [
          "string"
        ],
        "sourcePathsToExclude": [
          "string"
        ],
        "type": "string"
      }
    ]
  },

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
      ]
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
  "serverlessDatabase": {},
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
folderId | **string**<br>
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in `` updateMask `` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If `` updateMask `` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br>
description | **string**<br>
resourcePresetId | **string**<br>
storageConfig | **object**<br>
storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
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
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`<br><br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`<br><br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[] | **object**<br><p>Required. The number of elements must be in the range 1-7.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>days[] | **string**<br><p>Represents a day of week.</p> <ul> <li>DAY_OF_WEEK_UNSPECIFIED: The unspecified day-of-week.</li> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupConfig.<br>backupSettings[].<br>backupTimeToLive | **string**<br><p>provide time to live of backup.</p> 
backupConfig.<br>backupSettings[].<br>sourcePaths[] | **string**<br><p>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.</p> <p>The maximum number of elements is 256.</p> 
backupConfig.<br>backupSettings[].<br>sourcePathsToExclude[] | **string**<br><p>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.</p> <p>The maximum number of elements is 256.</p> 
backupConfig.<br>backupSettings[].<br>type | **string**<br>
zonalDatabase | **object**<br>deprecated field <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
regionalDatabase | **object**<br>deprecated field <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
dedicatedDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
dedicatedDatabase.<br>resourcePresetId | **string**<br>
dedicatedDatabase.<br>storageConfig | **object**<br>
dedicatedDatabase.<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
dedicatedDatabase.<br>scalePolicy | **object**<br>
dedicatedDatabase.<br>scalePolicy.<br>fixedScale | **object**<br>
dedicatedDatabase.<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
dedicatedDatabase.<br>networkId | **string**<br>
dedicatedDatabase.<br>subnetIds[] | **string**<br>
dedicatedDatabase.<br>assignPublicIps | **boolean** (boolean)<br>
serverlessDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 