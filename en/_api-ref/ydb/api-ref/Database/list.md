---
editable: false
---

# Method list
Retrieves a list of databases.
 

 
## HTTP request {#https-request}
```
GET https://ydb.api.cloud.yandex.net/ydb/v1/databases
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | 
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListDatabases requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListDatabases request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "databases": [
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

              // `databases[].backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`
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
              // end of the list of possible fields`databases[].backupConfig.backupSettings[].backupSchedule`

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
      "documentApiEndpoint": "string",
      "kinesisApiEndpoint": "string",

      // `databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`
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
      // end of the list of possible fields`databases[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
databases[] | **object**<br><p>YDB database.</p> 
databases[].<br>id | **string**<br>
databases[].<br>folderId | **string**<br>
databases[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
databases[].<br>name | **string**<br>
databases[].<br>description | **string**<br>
databases[].<br>status | **string**<br>
databases[].<br>endpoint | **string**<br>
databases[].<br>resourcePresetId | **string**<br>
databases[].<br>storageConfig | **object**<br>
databases[].<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
databases[].<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
databases[].<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
databases[].<br>scalePolicy | **object**<br>
databases[].<br>scalePolicy.<br>fixedScale | **object**<br>
databases[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
databases[].<br>networkId | **string**<br>
databases[].<br>subnetIds[] | **string**<br>
databases[].<br>assignPublicIps | **boolean** (boolean)<br>
databases[].<br>locationId | **string**<br>
databases[].<br>labels | **object**<br>
databases[].<br>backupConfig | **object**<br>
databases[].<br>backupConfig.<br>backupSettings[] | **object**<br>
databases[].<br>backupConfig.<br>backupSettings[].<br>name | **string**<br><p>name of backup settings</p> <p>The maximum string length in characters is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>description | **string**<br><p>human readable description.</p> <p>The maximum string length in characters is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule | **object**<br><p>provide schedule. if empty, backup will be disabled.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>nextExecuteTime | **string** (date-time)<br><p>output only field: when next backup will be executed using provided schedule.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule | **object** <br>`databases[].backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`<br><br>
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule | **object** <br>`databases[].backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`<br><br>
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[] | **object**<br><p>Required. The number of elements must be in the range 1-7.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>days[] | **string**<br><p>Represents a day of week.</p> <ul> <li>DAY_OF_WEEK_UNSPECIFIED: The unspecified day-of-week.</li> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupTimeToLive | **string**<br><p>provide time to live of backup.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>sourcePaths[] | **string**<br><p>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.</p> <p>The maximum number of elements is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>sourcePathsToExclude[] | **string**<br><p>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.</p> <p>The maximum number of elements is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>type | **string**<br>
databases[].<br>documentApiEndpoint | **string**<br>
databases[].<br>kinesisApiEndpoint | **string**<br>
databases[].<br>zonalDatabase | **object**<br>deprecated field <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
databases[].<br>zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
databases[].<br>regionalDatabase | **object**<br>deprecated field <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
databases[].<br>regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
databases[].<br>dedicatedDatabase | **object** <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
databases[].<br>dedicatedDatabase.<br>resourcePresetId | **string**<br>
databases[].<br>dedicatedDatabase.<br>storageConfig | **object**<br>
databases[].<br>dedicatedDatabase.<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
databases[].<br>dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**<br>
databases[].<br>dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)<br>
databases[].<br>dedicatedDatabase.<br>scalePolicy | **object**<br>
databases[].<br>dedicatedDatabase.<br>scalePolicy.<br>fixedScale | **object**<br>
databases[].<br>dedicatedDatabase.<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
databases[].<br>dedicatedDatabase.<br>networkId | **string**<br>
databases[].<br>dedicatedDatabase.<br>subnetIds[] | **string**<br>
databases[].<br>dedicatedDatabase.<br>assignPublicIps | **boolean** (boolean)<br>
databases[].<br>serverlessDatabase | **object** <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br><br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListDatabases requests, if the number of results is larger than ``page_size`` specified in the request. To get the next page, specify the value of ``next_page_token`` as a value for the ``page_token`` parameter in the next ListDatabases request. Subsequent ListDatabases requests will have their own ``next_page_token`` to continue paging through the results.</p> 