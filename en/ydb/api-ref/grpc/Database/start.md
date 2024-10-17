---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/Database/start.md
---

# Managed Service for YDB API, gRPC: DatabaseService.Start {#Start}

Starts the specified database.

## gRPC request

**rpc Start ([StartDatabaseRequest](#yandex.cloud.ydb.v1.StartDatabaseRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StartDatabaseRequest {#yandex.cloud.ydb.v1.StartDatabaseRequest}

```json
{
  "databaseId": "string"
}
```

#|
||Field | Description ||
|| databaseId | **string**

Required field.  ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "databaseId": "string",
    "databaseName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "status": "Status",
    "endpoint": "string",
    "resourcePresetId": "string",
    "storageConfig": {
      "storageOptions": [
        {
          "storageTypeId": "string",
          "groupCount": "int64"
        }
      ],
      "storageSizeLimit": "int64"
    },
    "scalePolicy": {
      // Includes only one of the fields `fixedScale`
      "fixedScale": {
        "size": "int64"
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
            "groupCount": "int64"
          }
        ],
        "storageSizeLimit": "int64"
      },
      "scalePolicy": {
        // Includes only one of the fields `fixedScale`
        "fixedScale": {
          "size": "int64"
        }
        // end of the list of possible fields
      },
      "networkId": "string",
      "subnetIds": [
        "string"
      ],
      "assignPublicIps": "bool"
    },
    "serverlessDatabase": {
      "throttlingRcuLimit": "int64",
      "storageSizeLimit": "int64",
      "enableThrottlingRcuLimit": "bool",
      "provisionedRcuLimit": "int64",
      "topicWriteQuota": "int64"
    },
    // end of the list of possible fields
    "assignPublicIps": "bool",
    "locationId": "string",
    "labels": "string",
    "backupConfig": {
      "backupSettings": [
        {
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
                "AlertEvaluationStatus"
              ],
              "repeateNotifyDelayMs": "int64"
            }
          ],
          "alertParameters": [
            {
              // Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`
              "doubleParameterValue": {
                "name": "string",
                "value": "double"
              },
              "integerParameterValue": {
                "name": "string",
                "value": "int64"
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
                "value": "double"
              },
              "integerParameterValue": {
                "name": "string",
                "value": "int64"
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
    "deletionProtection": "bool"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[StartDatabaseMetadata](#yandex.cloud.ydb.v1.StartDatabaseMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Database](#yandex.cloud.ydb.v1.Database)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## StartDatabaseMetadata {#yandex.cloud.ydb.v1.StartDatabaseMetadata}

#|
||Field | Description ||
|| databaseId | **string** ||
|| databaseName | **string** ||
|#

## Database {#yandex.cloud.ydb.v1.Database}

YDB database.

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string** ||
|| description | **string** ||
|| status | enum **Status**

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
|| assignPublicIps | **bool** ||
|| locationId | **string** ||
|| labels | **string** ||
|| backupConfig | **[BackupConfig](#yandex.cloud.ydb.v1.BackupConfig)** ||
|| documentApiEndpoint | **string** ||
|| kinesisApiEndpoint | **string** ||
|| kafkaApiEndpoint | **string** ||
|| monitoringConfig | **[MonitoringConfig](#yandex.cloud.ydb.v1.MonitoringConfig)** ||
|| deletionProtection | **bool** ||
|#

## StorageConfig {#yandex.cloud.ydb.v1.StorageConfig}

#|
||Field | Description ||
|| storageOptions[] | **[StorageOption](#yandex.cloud.ydb.v1.StorageOption)** ||
|| storageSizeLimit | **int64**

output only field: storage size limit of dedicated database. ||
|#

## StorageOption {#yandex.cloud.ydb.v1.StorageOption}

#|
||Field | Description ||
|| storageTypeId | **string** ||
|| groupCount | **int64** ||
|#

## ScalePolicy {#yandex.cloud.ydb.v1.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.ydb.v1.ScalePolicy.FixedScale)**

Includes only one of the fields `fixedScale`. ||
|#

## FixedScale {#yandex.cloud.ydb.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **int64** ||
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
|| assignPublicIps | **bool** ||
|#

## ServerlessDatabase {#yandex.cloud.ydb.v1.ServerlessDatabase}

#|
||Field | Description ||
|| throttlingRcuLimit | **int64**

Let's define 1 RU  - 1 request unit
Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second.
If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value.
Otherwise, the database is throttled using the cloud quotas.
If zero, all requests will be blocked until non zero value is set. ||
|| storageSizeLimit | **int64**

Specify serverless database storage size limit. If zero, default value is applied. ||
|| enableThrottlingRcuLimit | **bool**

If false, the database is throttled by cloud value. ||
|| provisionedRcuLimit | **int64**

Specify the number of provisioned RCUs to pay less if the database has predictable load.
You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed.
You will be charged for the on-demand consumption only if provisioned capacity is consumed. ||
|| topicWriteQuota | **int64**

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
|| notifyAboutStatuses[] | enum **AlertEvaluationStatus**

- `ALERT_EVALUATION_STATUS_UNSPECIFIED`
- `ALERT_EVALUATION_STATUS_OK`
- `ALERT_EVALUATION_STATUS_NO_DATA`
- `ALERT_EVALUATION_STATUS_ERROR`
- `ALERT_EVALUATION_STATUS_ALARM`
- `ALERT_EVALUATION_STATUS_WARN` ||
|| repeateNotifyDelayMs | **int64** ||
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
|| value | **double**

Required. Parameter value ||
|#

## IntegerParameterValue {#yandex.cloud.ydb.v1.AlertParameter.IntegerParameterValue}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| value | **int64**

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