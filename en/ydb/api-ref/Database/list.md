---
editable: false
sourcePath: en/_api-ref/ydb/api-ref/Database/list.md
---

# Method list
Retrieves a list of databases.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/databases
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | 
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``page_size``, the service returns a ``next_page_token`` that can be used to get the next page of results in subsequent ListDatabases requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. Set ``page_token`` to the ``next_page_token`` returned by a previous ListDatabases request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
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

              // `databases[].backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`
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
              // end of the list of possible fields`databases[].backupConfig.backupSettings[].backupSchedule`

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
      "monitoringConfig": {
        "alerts": [
          {
            "alertId": "string",
            "alertTemplateId": "string",
            "name": "string",
            "description": "string",
            "notificationChannels": [
              {
                "notificationChannelId": "string",
                "notifyAboutStatuses": [
                  "string"
                ],
                "repeateNotifyDelayMs": "string"
              }
            ],
            "alertParameters": [
              {

                // `databases[].monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`
                "doubleParameterValue": {
                  "name": "string",
                  "value": "number"
                },
                "integerParameterValue": {
                  "name": "string",
                  "value": "string"
                },
                "textParameterValue": {
                  "name": "string",
                  "value": "string"
                },
                "textListParameterValue": {
                  "name": "string",
                  "values": [
                    "string"
                  ]
                },
                "labelListParameterValue": {
                  "name": "string",
                  "values": [
                    "string"
                  ]
                },
                // end of the list of possible fields`databases[].monitoringConfig.alerts[].alertParameters[]`

              }
            ],
            "alertThresholds": [
              {

                // `databases[].monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`
                "doubleParameterValue": {
                  "name": "string",
                  "value": "number"
                },
                "integerParameterValue": {
                  "name": "string",
                  "value": "string"
                },
                "textParameterValue": {
                  "name": "string",
                  "value": "string"
                },
                "textListParameterValue": {
                  "name": "string",
                  "values": [
                    "string"
                  ]
                },
                "labelListParameterValue": {
                  "name": "string",
                  "values": [
                    "string"
                  ]
                },
                // end of the list of possible fields`databases[].monitoringConfig.alerts[].alertThresholds[]`

              }
            ]
          }
        ]
      },
      "deletionProtection": true,

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
        "throttlingRcuLimit": "string",
        "storageSizeLimit": "string",
        "enableThrottlingRcuLimit": true,
        "provisionedRcuLimit": "string"
      },
      // end of the list of possible fields`databases[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
databases[] | **object**<br><p>YDB database.</p> 
databases[].<br>id | **string**
databases[].<br>folderId | **string**
databases[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
databases[].<br>name | **string**
databases[].<br>description | **string**
databases[].<br>status | **string**
databases[].<br>endpoint | **string**
databases[].<br>resourcePresetId | **string**
databases[].<br>storageConfig | **object**
databases[].<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
databases[].<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**
databases[].<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)
databases[].<br>storageConfig.<br>storageSizeLimit | **string** (int64)<br><p>output only field: storage size limit of dedicated database.</p> 
databases[].<br>scalePolicy | **object**
databases[].<br>scalePolicy.<br>fixedScale | **object**
databases[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
databases[].<br>networkId | **string**
databases[].<br>subnetIds[] | **string**
databases[].<br>assignPublicIps | **boolean** (boolean)
databases[].<br>locationId | **string**
databases[].<br>labels | **object**
databases[].<br>backupConfig | **object**
databases[].<br>backupConfig.<br>backupSettings[] | **object**
databases[].<br>backupConfig.<br>backupSettings[].<br>name | **string**<br><p>name of backup settings</p> <p>The maximum string length in characters is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>description | **string**<br><p>human readable description.</p> <p>The maximum string length in characters is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule | **object**<br><p>provide schedule. if empty, backup will be disabled.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>nextExecuteTime | **string** (date-time)<br><p>output only field: when next backup will be executed using provided schedule.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule | **object** <br>`databases[].backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule | **object** <br>`databases[].backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[] | **object**<br><p>Required. The number of elements must be in the range 1-7.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule | **object** <br>`databases[].backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule.<br>startTime | **string** (date-time)<br><p>Required. Timestamp of the first recurrence.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule.<br>recurrence | **string**<br><p>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>backupTimeToLive | **string**<br><p>provide time to live of backup.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>sourcePaths[] | **string**<br><p>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.</p> <p>The maximum number of elements is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>sourcePathsToExclude[] | **string**<br><p>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.</p> <p>The maximum number of elements is 256.</p> 
databases[].<br>backupConfig.<br>backupSettings[].<br>type | **string**
databases[].<br>backupConfig.<br>backupSettings[].<br>storageClass | **string**
databases[].<br>documentApiEndpoint | **string**
databases[].<br>kinesisApiEndpoint | **string**
databases[].<br>monitoringConfig | **object**
databases[].<br>monitoringConfig.<br>alerts[] | **object**
databases[].<br>monitoringConfig.<br>alerts[].<br>alertId | **string**<br><p>output only field.</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertTemplateId | **string**<br><p>template of the alert.</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>name | **string**<br><p>name of the alert.</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>description | **string**<br><p>human readable description of the alert.</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>notificationChannels[] | **object**<br><p>the notification channels of the alert.</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>notificationChannels[].<br>notificationChannelId | **string**
databases[].<br>monitoringConfig.<br>alerts[].<br>notificationChannels[].<br>notifyAboutStatuses[] | **string**
databases[].<br>monitoringConfig.<br>alerts[].<br>notificationChannels[].<br>repeateNotifyDelayMs | **string** (int64)
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[] | **object**<br><p>alert parameters to override.</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>doubleParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>doubleParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>doubleParameterValue.<br>value | **number** (double)<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>integerParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>integerParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>integerParameterValue.<br>value | **string** (int64)<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textParameterValue.<br>value | **string**<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textListParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>labelListParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>labelListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertParameters[].<br>labelListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[] | **object**<br><p>alert paratemers to override.</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>doubleParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>doubleParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>doubleParameterValue.<br>value | **number** (double)<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>integerParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>integerParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>integerParameterValue.<br>value | **string** (int64)<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textParameterValue.<br>value | **string**<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textListParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>labelListParameterValue | **object** <br>`databases[].monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>labelListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
databases[].<br>monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>labelListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
databases[].<br>deletionProtection | **boolean** (boolean)
databases[].<br>zonalDatabase | **object**<br>deprecated field <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
databases[].<br>zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
databases[].<br>regionalDatabase | **object**<br>deprecated field <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
databases[].<br>regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
databases[].<br>dedicatedDatabase | **object** <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
databases[].<br>dedicatedDatabase.<br>resourcePresetId | **string**
databases[].<br>dedicatedDatabase.<br>storageConfig | **object**
databases[].<br>dedicatedDatabase.<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
databases[].<br>dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**
databases[].<br>dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)
databases[].<br>dedicatedDatabase.<br>storageConfig.<br>storageSizeLimit | **string** (int64)<br><p>output only field: storage size limit of dedicated database.</p> 
databases[].<br>dedicatedDatabase.<br>scalePolicy | **object**
databases[].<br>dedicatedDatabase.<br>scalePolicy.<br>fixedScale | **object**
databases[].<br>dedicatedDatabase.<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
databases[].<br>dedicatedDatabase.<br>networkId | **string**
databases[].<br>dedicatedDatabase.<br>subnetIds[] | **string**
databases[].<br>dedicatedDatabase.<br>assignPublicIps | **boolean** (boolean)
databases[].<br>serverlessDatabase | **object** <br>`databases[]` includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
databases[].<br>serverlessDatabase.<br>throttlingRcuLimit | **string** (int64)<br><p>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If ``enable_throttling_rcu_limit`` flag is true, the database will be throttled using ``throttling_rcu_limit`` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set.</p> 
databases[].<br>serverlessDatabase.<br>storageSizeLimit | **string** (int64)<br><p>Specify serverless database storage size limit. If zero, default value is applied.</p> 
databases[].<br>serverlessDatabase.<br>enableThrottlingRcuLimit | **boolean** (boolean)<br><p>If false, the database is throttled by cloud value.</p> 
databases[].<br>serverlessDatabase.<br>provisionedRcuLimit | **string** (int64)<br><p>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListDatabases requests, if the number of results is larger than ``page_size`` specified in the request. To get the next page, specify the value of ``next_page_token`` as a value for the ``page_token`` parameter in the next ListDatabases request. Subsequent ListDatabases requests will have their own ``next_page_token`` to continue paging through the results.</p> 