---
editable: false
sourcePath: en/_api-ref/ydb/v1/api-ref/Database/index.md
---

# Managed Service for YDB API, REST: Database methods
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
  "kafkaApiEndpoint": "string",
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

            // `monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`
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
            // end of the list of possible fields`monitoringConfig.alerts[].alertParameters[]`

          }
        ],
        "alertThresholds": [
          {

            // `monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`
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
            // end of the list of possible fields`monitoringConfig.alerts[].alertThresholds[]`

          }
        ]
      }
    ]
  },
  "deletionProtection": true,

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
    "throttlingRcuLimit": "string",
    "storageSizeLimit": "string",
    "enableThrottlingRcuLimit": true,
    "provisionedRcuLimit": "string",
    "topicWriteQuota": "string"
  },
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
id | **string**
folderId | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**
description | **string**
status | **string**
endpoint | **string**
resourcePresetId | **string**
storageConfig | **object**
storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
storageConfig.<br>storageOptions[].<br>storageTypeId | **string**
storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)
storageConfig.<br>storageSizeLimit | **string** (int64)<br><p>output only field: storage size limit of dedicated database.</p> 
scalePolicy | **object**
scalePolicy.<br>fixedScale | **object**
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
networkId | **string**
subnetIds[] | **string**
assignPublicIps | **boolean** (boolean)
locationId | **string**
labels | **object**
backupConfig | **object**
backupConfig.<br>backupSettings[] | **object**
backupConfig.<br>backupSettings[].<br>name | **string**<br><p>name of backup settings</p> <p>The maximum string length in characters is 256.</p> 
backupConfig.<br>backupSettings[].<br>description | **string**<br><p>human readable description.</p> <p>The maximum string length in characters is 256.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule | **object**<br><p>provide schedule. if empty, backup will be disabled.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>nextExecuteTime | **string** (date-time)<br><p>output only field: when next backup will be executed using provided schedule.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>dailyBackupSchedule.<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[] | **object**<br><p>Required. The number of elements must be in the range 1-7.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime | **object**<br><p>Required.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>weeklyBackupSchedule.<br>daysOfWeek[].<br>executeTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule | **object** <br>`backupConfig.backupSettings[].backupSchedule` includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`<br>
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule.<br>startTime | **string** (date-time)<br><p>Required. Timestamp of the first recurrence.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
backupConfig.<br>backupSettings[].<br>backupSchedule.<br>recurringBackupSchedule.<br>recurrence | **string**<br><p>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported.</p> 
backupConfig.<br>backupSettings[].<br>backupTimeToLive | **string**<br><p>provide time to live of backup.</p> 
backupConfig.<br>backupSettings[].<br>sourcePaths[] | **string**<br><p>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.</p> <p>The maximum number of elements is 256.</p> 
backupConfig.<br>backupSettings[].<br>sourcePathsToExclude[] | **string**<br><p>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.</p> <p>The maximum number of elements is 256.</p> 
backupConfig.<br>backupSettings[].<br>type | **string**
backupConfig.<br>backupSettings[].<br>storageClass | **string**
documentApiEndpoint | **string**
kinesisApiEndpoint | **string**
kafkaApiEndpoint | **string**
monitoringConfig | **object**
monitoringConfig.<br>alerts[] | **object**
monitoringConfig.<br>alerts[].<br>alertId | **string**<br><p>output only field.</p> 
monitoringConfig.<br>alerts[].<br>alertTemplateId | **string**<br><p>template of the alert.</p> 
monitoringConfig.<br>alerts[].<br>name | **string**<br><p>name of the alert.</p> 
monitoringConfig.<br>alerts[].<br>description | **string**<br><p>human readable description of the alert.</p> 
monitoringConfig.<br>alerts[].<br>notificationChannels[] | **object**<br><p>the notification channels of the alert.</p> 
monitoringConfig.<br>alerts[].<br>notificationChannels[].<br>notificationChannelId | **string**
monitoringConfig.<br>alerts[].<br>notificationChannels[].<br>notifyAboutStatuses[] | **string**
monitoringConfig.<br>alerts[].<br>notificationChannels[].<br>repeateNotifyDelayMs | **string** (int64)
monitoringConfig.<br>alerts[].<br>alertParameters[] | **object**<br><p>alert parameters to override.</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>doubleParameterValue | **object** <br>`monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>doubleParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>doubleParameterValue.<br>value | **number** (double)<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>integerParameterValue | **object** <br>`monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>integerParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>integerParameterValue.<br>value | **string** (int64)<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textParameterValue | **object** <br>`monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textParameterValue.<br>value | **string**<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textListParameterValue | **object** <br>`monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>textListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>labelListParameterValue | **object** <br>`monitoringConfig.alerts[].alertParameters[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>labelListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertParameters[].<br>labelListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[] | **object**<br><p>alert paratemers to override.</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>doubleParameterValue | **object** <br>`monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>doubleParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>doubleParameterValue.<br>value | **number** (double)<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>integerParameterValue | **object** <br>`monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>integerParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>integerParameterValue.<br>value | **string** (int64)<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textParameterValue | **object** <br>`monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textParameterValue.<br>value | **string**<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textListParameterValue | **object** <br>`monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>textListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>labelListParameterValue | **object** <br>`monitoringConfig.alerts[].alertThresholds[]` includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`<br>
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>labelListParameterValue.<br>name | **string**<br><p>Required. Parameter name</p> 
monitoringConfig.<br>alerts[].<br>alertThresholds[].<br>labelListParameterValue.<br>values[] | **string**<br><p>Required. Parameter value</p> 
deletionProtection | **boolean** (boolean)
zonalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
zonalDatabase.<br>zoneId | **string**<br><p>Required.</p> 
regionalDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
regionalDatabase.<br>regionId | **string**<br><p>Required.</p> 
dedicatedDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
dedicatedDatabase.<br>resourcePresetId | **string**
dedicatedDatabase.<br>storageConfig | **object**
dedicatedDatabase.<br>storageConfig.<br>storageOptions[] | **object**<br><p>Required. The minimum number of elements is 1.</p> 
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>storageTypeId | **string**
dedicatedDatabase.<br>storageConfig.<br>storageOptions[].<br>groupCount | **string** (int64)
dedicatedDatabase.<br>storageConfig.<br>storageSizeLimit | **string** (int64)<br><p>output only field: storage size limit of dedicated database.</p> 
dedicatedDatabase.<br>scalePolicy | **object**
dedicatedDatabase.<br>scalePolicy.<br>fixedScale | **object**
dedicatedDatabase.<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>The minimum value is 1.</p> 
dedicatedDatabase.<br>networkId | **string**
dedicatedDatabase.<br>subnetIds[] | **string**
dedicatedDatabase.<br>assignPublicIps | **boolean** (boolean)
serverlessDatabase | **object** <br> includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`<br>
serverlessDatabase.<br>throttlingRcuLimit | **string** (int64)<br><p>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If ``enable_throttling_rcu_limit`` flag is true, the database will be throttled using ``throttling_rcu_limit`` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set.</p> 
serverlessDatabase.<br>storageSizeLimit | **string** (int64)<br><p>Specify serverless database storage size limit. If zero, default value is applied.</p> 
serverlessDatabase.<br>enableThrottlingRcuLimit | **boolean** (boolean)<br><p>If false, the database is throttled by cloud value.</p> 
serverlessDatabase.<br>provisionedRcuLimit | **string** (int64)<br><p>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed.</p> 
serverlessDatabase.<br>topicWriteQuota | **string** (int64)<br><p>write quota for topic service, defined in bytes per second.</p> 

## Methods {#methods}
Method | Description
--- | ---
[backup](backup.md) | 
[create](create.md) | Creates a new database.
[delete](delete.md) | Deletes the specified database.
[get](get.md) | Returns the specified database.
[list](list.md) | Retrieves a list of databases.
[move](move.md) | 
[restore](restore.md) | Restores the specified backup
[start](start.md) | Starts the specified database.
[stop](stop.md) | Stops the specified database.
[update](update.md) | Modifies the specified database.