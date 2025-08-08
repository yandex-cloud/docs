---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/databases/{databaseId}
    method: get
    path:
      type: object
      properties:
        databaseId:
          description: |-
            **string**
            Required field. Required. ID of the YDB cluster.
          type: string
      required:
        - databaseId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/ydb/v1/api-ref/Database/get.md
---

# Managed Service for YDB API, REST: Database.Get

Returns the specified database.

## HTTP request

```
GET https://ydb.{{ api-host }}/ydb/v1/databases/{databaseId}
```

## Path parameters

#|
||Field | Description ||
|| databaseId | **string**

Required field. Required. ID of the YDB cluster. ||
|#

## Response {#yandex.cloud.ydb.v1.Database}

**HTTP Code: 200 - OK**

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
    // Includes only one of the fields `fixedScale`, `autoScale`
    "fixedScale": {
      "size": "string"
    },
    "autoScale": {
      "minSize": "string",
      "maxSize": "string",
      // Includes only one of the fields `targetTracking`
      "targetTracking": {
        // Includes only one of the fields `cpuUtilizationPercent`
        "cpuUtilizationPercent": "string"
        // end of the list of possible fields
      }
      // end of the list of possible fields
    }
    // end of the list of possible fields
  },
  "networkId": "string",
  "subnetIds": [
    "string"
  ],
  // Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`
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
      // Includes only one of the fields `fixedScale`, `autoScale`
      "fixedScale": {
        "size": "string"
      },
      "autoScale": {
        "minSize": "string",
        "maxSize": "string",
        // Includes only one of the fields `targetTracking`
        "targetTracking": {
          // Includes only one of the fields `cpuUtilizationPercent`
          "cpuUtilizationPercent": "string"
          // end of the list of possible fields
        }
        // end of the list of possible fields
      }
      // end of the list of possible fields
    },
    "networkId": "string",
    "subnetIds": [
      "string"
    ],
    "assignPublicIps": "boolean",
    "securityGroupIds": [
      "string"
    ]
  },
  "serverlessDatabase": {
    "throttlingRcuLimit": "string",
    "storageSizeLimit": "string",
    "enableThrottlingRcuLimit": "boolean",
    "provisionedRcuLimit": "string",
    "topicWriteQuota": "string"
  },
  // end of the list of possible fields
  "assignPublicIps": "boolean",
  "locationId": "string",
  "labels": "object",
  "backupConfig": {
    "backupSettings": [
      {
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
            // Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`
            "doubleParameterValue": {
              "name": "string",
              "value": "string"
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
            }
            // end of the list of possible fields
          }
        ],
        "alertThresholds": [
          {
            // Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`
            "doubleParameterValue": {
              "name": "string",
              "value": "string"
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
            }
            // end of the list of possible fields
          }
        ]
      }
    ]
  },
  "deletionProtection": "boolean",
  "securityGroupIds": [
    "string"
  ]
}
```

YDB database.

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| status | **enum** (Status)

- `STATUS_UNSPECIFIED`
- `PROVISIONING`
- `RUNNING`
- `UPDATING`
- `ERROR`
- `DELETING`
- `STARTING`
- `STOPPED` ||
|| endpoint | **string** ||
|| resourcePresetId | **string** ||
|| storageConfig | **[StorageConfig](#yandex.cloud.ydb.v1.StorageConfig)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ydb.v1.ScalePolicy)** ||
|| networkId | **string** ||
|| subnetIds[] | **string** ||
|| zonalDatabase | **[ZonalDatabase](#yandex.cloud.ydb.v1.ZonalDatabase)**

deprecated field

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| regionalDatabase | **[RegionalDatabase](#yandex.cloud.ydb.v1.RegionalDatabase)**

deprecated field

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| dedicatedDatabase | **[DedicatedDatabase](#yandex.cloud.ydb.v1.DedicatedDatabase)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| serverlessDatabase | **[ServerlessDatabase](#yandex.cloud.ydb.v1.ServerlessDatabase)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| assignPublicIps | **boolean** ||
|| locationId | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| backupConfig | **[BackupConfig](#yandex.cloud.ydb.v1.BackupConfig)** ||
|| documentApiEndpoint | **string** ||
|| kinesisApiEndpoint | **string** ||
|| kafkaApiEndpoint | **string** ||
|| monitoringConfig | **[MonitoringConfig](#yandex.cloud.ydb.v1.MonitoringConfig)** ||
|| deletionProtection | **boolean** ||
|| securityGroupIds[] | **string** ||
|#

## StorageConfig {#yandex.cloud.ydb.v1.StorageConfig}

#|
||Field | Description ||
|| storageOptions[] | **[StorageOption](#yandex.cloud.ydb.v1.StorageOption)** ||
|| storageSizeLimit | **string** (int64)

output only field: storage size limit of dedicated database. ||
|#

## StorageOption {#yandex.cloud.ydb.v1.StorageOption}

#|
||Field | Description ||
|| storageTypeId | **string** ||
|| groupCount | **string** (int64) ||
|#

## ScalePolicy {#yandex.cloud.ydb.v1.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.ydb.v1.ScalePolicy.FixedScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.ydb.v1.ScalePolicy.AutoScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScale {#yandex.cloud.ydb.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64) ||
|#

## AutoScale {#yandex.cloud.ydb.v1.ScalePolicy.AutoScale}

Scale policy that dynamically changes the number of database nodes within a user-defined range.

#|
||Field | Description ||
|| minSize | **string** (int64)

Minimum number of nodes to which autoscaling can scale the database. ||
|| maxSize | **string** (int64)

Maximum number of nodes to which autoscaling can scale the database. ||
|| targetTracking | **[TargetTracking](#yandex.cloud.ydb.v1.ScalePolicy.AutoScale.TargetTracking)**

Includes only one of the fields `targetTracking`.

Type of autoscaling algorithm. ||
|#

## TargetTracking {#yandex.cloud.ydb.v1.ScalePolicy.AutoScale.TargetTracking}

Autoscaling algorithm that tracks metric and reactively scale database nodes to keep metric
close to the specified target value.

#|
||Field | Description ||
|| cpuUtilizationPercent | **string** (int64)

A percentage of database nodes average CPU utilization.

Includes only one of the fields `cpuUtilizationPercent`. ||
|#

## ZonalDatabase {#yandex.cloud.ydb.v1.ZonalDatabase}

#|
||Field | Description ||
|| zoneId | **string**

Required field.  ||
|#

## RegionalDatabase {#yandex.cloud.ydb.v1.RegionalDatabase}

#|
||Field | Description ||
|| regionId | **string**

Required field.  ||
|#

## DedicatedDatabase {#yandex.cloud.ydb.v1.DedicatedDatabase}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| storageConfig | **[StorageConfig](#yandex.cloud.ydb.v1.StorageConfig)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ydb.v1.ScalePolicy)** ||
|| networkId | **string** ||
|| subnetIds[] | **string** ||
|| assignPublicIps | **boolean** ||
|| securityGroupIds[] | **string** ||
|#

## ServerlessDatabase {#yandex.cloud.ydb.v1.ServerlessDatabase}

#|
||Field | Description ||
|| throttlingRcuLimit | **string** (int64)

Let's define 1 RU  - 1 request unit
Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second.
If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value.
Otherwise, the database is throttled using the cloud quotas.
If zero, all requests will be blocked until non zero value is set. ||
|| storageSizeLimit | **string** (int64)

Specify serverless database storage size limit. If zero, default value is applied. ||
|| enableThrottlingRcuLimit | **boolean**

If false, the database is throttled by cloud value. ||
|| provisionedRcuLimit | **string** (int64)

Specify the number of provisioned RCUs to pay less if the database has predictable load.
You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed.
You will be charged for the on-demand consumption only if provisioned capacity is consumed. ||
|| topicWriteQuota | **string** (int64)

write quota for topic service, defined in bytes per second. ||
|#

## BackupConfig {#yandex.cloud.ydb.v1.BackupConfig}

#|
||Field | Description ||
|| backupSettings[] | **[BackupSettings](#yandex.cloud.ydb.v1.BackupSettings)** ||
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
|| backupTimeToLive | **string** (duration)

provide time to live of backup. ||
|| sourcePaths[] | **string**

provide a list of source paths. Each path can be directory, table or even database itself.
Each directory (or database) will be traversed recursively and all childs of directory will be included to backup.
By default, backup will be created for full database. ||
|| sourcePathsToExclude[] | **string**

provide a list of paths to exclude from backup.
Each path is a directory, table, or database.
Each directory (or database) will be traversed recursively and all childs of directory will be excluded. ||
|| type | **enum** (Type)

- `TYPE_UNSPECIFIED`
- `SYSTEM`
- `USER` ||
|| storageClass | **enum** (StorageClass)

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

Required field.  ||
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
|| daysOfWeek[] | **[DaysOfWeekBackupSchedule](#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule)** ||
|#

## DaysOfWeekBackupSchedule {#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule}

#|
||Field | Description ||
|| days[] | **enum** (DayOfWeek)

- `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| executeTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field.  ||
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

## MonitoringConfig {#yandex.cloud.ydb.v1.MonitoringConfig}

#|
||Field | Description ||
|| alerts[] | **[Alert](#yandex.cloud.ydb.v1.Alert)** ||
|#

## Alert {#yandex.cloud.ydb.v1.Alert}

#|
||Field | Description ||
|| alertId | **string**

output only field. ||
|| alertTemplateId | **string**

template of the alert. ||
|| name | **string**

name of the alert. ||
|| description | **string**

human readable description of the alert. ||
|| notificationChannels[] | **[NotificationChannel](#yandex.cloud.ydb.v1.NotificationChannel)**

the notification channels of the alert. ||
|| alertParameters[] | **[AlertParameter](#yandex.cloud.ydb.v1.AlertParameter)**

alert parameters to override. ||
|| alertThresholds[] | **[AlertParameter](#yandex.cloud.ydb.v1.AlertParameter)**

alert paratemers to override. ||
|#

## NotificationChannel {#yandex.cloud.ydb.v1.NotificationChannel}

#|
||Field | Description ||
|| notificationChannelId | **string** ||
|| notifyAboutStatuses[] | **enum** (AlertEvaluationStatus)

- `ALERT_EVALUATION_STATUS_UNSPECIFIED`
- `ALERT_EVALUATION_STATUS_OK`
- `ALERT_EVALUATION_STATUS_NO_DATA`
- `ALERT_EVALUATION_STATUS_ERROR`
- `ALERT_EVALUATION_STATUS_ALARM`
- `ALERT_EVALUATION_STATUS_WARN` ||
|| repeateNotifyDelayMs | **string** (int64) ||
|#

## AlertParameter {#yandex.cloud.ydb.v1.AlertParameter}

#|
||Field | Description ||
|| doubleParameterValue | **[DoubleParameterValue](#yandex.cloud.ydb.v1.AlertParameter.DoubleParameterValue)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| integerParameterValue | **[IntegerParameterValue](#yandex.cloud.ydb.v1.AlertParameter.IntegerParameterValue)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| textParameterValue | **[TextParameterValue](#yandex.cloud.ydb.v1.AlertParameter.TextParameterValue)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| textListParameterValue | **[TextListParameterValue](#yandex.cloud.ydb.v1.AlertParameter.TextListParameterValue)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| labelListParameterValue | **[LabelListParameterValue](#yandex.cloud.ydb.v1.AlertParameter.LabelListParameterValue)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|#

## DoubleParameterValue {#yandex.cloud.ydb.v1.AlertParameter.DoubleParameterValue}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| value | **string**

Required. Parameter value ||
|#

## IntegerParameterValue {#yandex.cloud.ydb.v1.AlertParameter.IntegerParameterValue}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| value | **string** (int64)

Required. Parameter value ||
|#

## TextParameterValue {#yandex.cloud.ydb.v1.AlertParameter.TextParameterValue}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| value | **string**

Required. Parameter value ||
|#

## TextListParameterValue {#yandex.cloud.ydb.v1.AlertParameter.TextListParameterValue}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| values[] | **string**

Required. Parameter value ||
|#

## LabelListParameterValue {#yandex.cloud.ydb.v1.AlertParameter.LabelListParameterValue}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| values[] | **string**

Required. Parameter value ||
|#