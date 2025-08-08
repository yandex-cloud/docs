---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/databases/{databaseId}
    method: patch
    path:
      type: object
      properties:
        databaseId:
          description: '**string**'
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        folderId:
          description: '**string**'
          type: string
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: '**string**'
          type: string
        description:
          description: '**string**'
          type: string
        resourcePresetId:
          description: '**string**'
          type: string
        storageConfig:
          description: '**[StorageConfig](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.StorageConfig)**'
          $ref: '#/definitions/StorageConfig'
        scalePolicy:
          description: '**[ScalePolicy](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy)**'
          oneOf:
            - type: object
              properties:
                fixedScale:
                  description: |-
                    **[FixedScale](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy.FixedScale)**
                    Includes only one of the fields `fixedScale`, `autoScale`.
                  $ref: '#/definitions/FixedScale'
                autoScale:
                  description: |-
                    **[AutoScale](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy.AutoScale)**
                    Includes only one of the fields `fixedScale`, `autoScale`.
                  oneOf:
                    - type: object
                      properties:
                        targetTracking:
                          description: |-
                            **[TargetTracking](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy.AutoScale.TargetTracking)**
                            Includes only one of the fields `targetTracking`.
                            Type of autoscaling algorithm.
                          oneOf:
                            - type: object
                              properties:
                                cpuUtilizationPercent:
                                  description: |-
                                    **string** (int64)
                                    A percentage of database nodes average CPU utilization.
                                    Includes only one of the fields `cpuUtilizationPercent`.
                                  type: string
                                  format: int64
        networkId:
          description: '**string**'
          type: string
        subnetIds:
          description: '**string**'
          type: array
          items:
            type: string
        zonalDatabase:
          description: |-
            **[ZonalDatabase](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ZonalDatabase)**
            Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`.
          $ref: '#/definitions/ZonalDatabase'
        regionalDatabase:
          description: |-
            **[RegionalDatabase](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.RegionalDatabase)**
            Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`.
          $ref: '#/definitions/RegionalDatabase'
        dedicatedDatabase:
          description: |-
            **[DedicatedDatabase](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.DedicatedDatabase)**
            Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`.
          $ref: '#/definitions/DedicatedDatabase'
        serverlessDatabase:
          description: |-
            **[ServerlessDatabase](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ServerlessDatabase)**
            Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`.
          $ref: '#/definitions/ServerlessDatabase'
        assignPublicIps:
          description: '**boolean**'
          type: boolean
        locationId:
          description: '**string**'
          type: string
        labels:
          description: '**object** (map<**string**, **string**>)'
          type: string
        backupConfig:
          description: '**[BackupConfig](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.BackupConfig)**'
          $ref: '#/definitions/BackupConfig'
        monitoringConfig:
          description: '**[MonitoringConfig](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.MonitoringConfig)**'
          $ref: '#/definitions/MonitoringConfig'
        deletionProtection:
          description: '**boolean**'
          type: boolean
        securityGroupIds:
          description: '**string**'
          type: array
          items:
            type: string
      additionalProperties: false
    definitions:
      StorageOption:
        type: object
        properties:
          storageTypeId:
            description: '**string**'
            type: string
          groupCount:
            description: '**string** (int64)'
            type: string
            format: int64
      StorageConfig:
        type: object
        properties:
          storageOptions:
            description: '**[StorageOption](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.StorageOption)**'
            type: array
            items:
              $ref: '#/definitions/StorageOption'
          storageSizeLimit:
            description: |-
              **string** (int64)
              output only field: storage size limit of dedicated database.
            type: string
            format: int64
      FixedScale:
        type: object
        properties:
          size:
            description: '**string** (int64)'
            type: string
            format: int64
      ZonalDatabase:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              Required field. 
            type: string
        required:
          - zoneId
      RegionalDatabase:
        type: object
        properties:
          regionId:
            description: |-
              **string**
              Required field. 
            type: string
        required:
          - regionId
      DedicatedDatabase:
        type: object
        properties:
          resourcePresetId:
            description: '**string**'
            type: string
          storageConfig:
            description: '**[StorageConfig](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.StorageConfig)**'
            $ref: '#/definitions/StorageConfig'
          scalePolicy:
            description: '**[ScalePolicy](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy)**'
            oneOf:
              - type: object
                properties:
                  fixedScale:
                    description: |-
                      **[FixedScale](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy.FixedScale)**
                      Includes only one of the fields `fixedScale`, `autoScale`.
                    $ref: '#/definitions/FixedScale'
                  autoScale:
                    description: |-
                      **[AutoScale](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy.AutoScale)**
                      Includes only one of the fields `fixedScale`, `autoScale`.
                    oneOf:
                      - type: object
                        properties:
                          targetTracking:
                            description: |-
                              **[TargetTracking](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.ScalePolicy.AutoScale.TargetTracking)**
                              Includes only one of the fields `targetTracking`.
                              Type of autoscaling algorithm.
                            oneOf:
                              - type: object
                                properties:
                                  cpuUtilizationPercent:
                                    description: |-
                                      **string** (int64)
                                      A percentage of database nodes average CPU utilization.
                                      Includes only one of the fields `cpuUtilizationPercent`.
                                    type: string
                                    format: int64
          networkId:
            description: '**string**'
            type: string
          subnetIds:
            description: '**string**'
            type: array
            items:
              type: string
          assignPublicIps:
            description: '**boolean**'
            type: boolean
          securityGroupIds:
            description: '**string**'
            type: array
            items:
              type: string
      ServerlessDatabase:
        type: object
        properties:
          throttlingRcuLimit:
            description: |-
              **string** (int64)
              Let's define 1 RU  - 1 request unit
              Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second.
              If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value.
              Otherwise, the database is throttled using the cloud quotas.
              If zero, all requests will be blocked until non zero value is set.
            type: string
            format: int64
          storageSizeLimit:
            description: |-
              **string** (int64)
              Specify serverless database storage size limit. If zero, default value is applied.
            type: string
            format: int64
          enableThrottlingRcuLimit:
            description: |-
              **boolean**
              If false, the database is throttled by cloud value.
            type: boolean
          provisionedRcuLimit:
            description: |-
              **string** (int64)
              Specify the number of provisioned RCUs to pay less if the database has predictable load.
              You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed.
              You will be charged for the on-demand consumption only if provisioned capacity is consumed.
            type: string
            format: int64
          topicWriteQuota:
            description: |-
              **string** (int64)
              write quota for topic service, defined in bytes per second.
            type: string
            format: int64
      TimeOfDay:
        type: object
        properties:
          hours:
            description: |-
              **integer** (int32)
              Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
              to allow the value "24:00:00" for scenarios like business closing time.
            type: integer
            format: int32
          minutes:
            description: |-
              **integer** (int32)
              Minutes of hour of day. Must be from 0 to 59.
            type: integer
            format: int32
          seconds:
            description: |-
              **integer** (int32)
              Seconds of minutes of the time. Must normally be from 0 to 59. An API may
              allow the value 60 if it allows leap-seconds.
            type: integer
            format: int32
          nanos:
            description: |-
              **integer** (int32)
              Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.
            type: integer
            format: int32
      DailyBackupSchedule:
        type: object
        properties:
          executeTime:
            description: |-
              **`TimeOfDay`**
              Required field. 
            $ref: '#/definitions/TimeOfDay'
        required:
          - executeTime
      DaysOfWeekBackupSchedule:
        type: object
        properties:
          days:
            description: |-
              **enum** (DayOfWeek)
              - `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
              - `MONDAY`: The day-of-week of Monday.
              - `TUESDAY`: The day-of-week of Tuesday.
              - `WEDNESDAY`: The day-of-week of Wednesday.
              - `THURSDAY`: The day-of-week of Thursday.
              - `FRIDAY`: The day-of-week of Friday.
              - `SATURDAY`: The day-of-week of Saturday.
              - `SUNDAY`: The day-of-week of Sunday.
            type: array
            items:
              type: string
              enum:
                - DAY_OF_WEEK_UNSPECIFIED
                - MONDAY
                - TUESDAY
                - WEDNESDAY
                - THURSDAY
                - FRIDAY
                - SATURDAY
                - SUNDAY
          executeTime:
            description: |-
              **`TimeOfDay`**
              Required field. 
            $ref: '#/definitions/TimeOfDay'
        required:
          - executeTime
      WeeklyBackupSchedule:
        type: object
        properties:
          daysOfWeek:
            description: '**[DaysOfWeekBackupSchedule](/docs/ydb/api-ref/Backup/get#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule)**'
            type: array
            items:
              $ref: '#/definitions/DaysOfWeekBackupSchedule'
      RecurringBackupSchedule:
        type: object
        properties:
          startTime:
            description: |-
              **string** (date-time)
              Required field. Timestamp of the first recurrence.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          recurrence:
            description: |-
              **string**
              Required field. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how
              this backup reccurs.
              The FREQ values of MINUTELY, and SECONDLY are not supported.
            type: string
        required:
          - startTime
          - recurrence
      BackupSettings:
        type: object
        properties:
          name:
            description: |-
              **string**
              name of backup settings
            type: string
          description:
            description: |-
              **string**
              human readable description.
            type: string
          backupSchedule:
            description: |-
              **[BackupSchedule](/docs/ydb/api-ref/Backup/get#yandex.cloud.ydb.v1.BackupSchedule)**
              provide schedule. if empty, backup will be disabled.
            oneOf:
              - type: object
                properties:
                  dailyBackupSchedule:
                    description: |-
                      **[DailyBackupSchedule](/docs/ydb/api-ref/Backup/get#yandex.cloud.ydb.v1.DailyBackupSchedule)**
                      Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`.
                    $ref: '#/definitions/DailyBackupSchedule'
                  weeklyBackupSchedule:
                    description: |-
                      **[WeeklyBackupSchedule](/docs/ydb/api-ref/Backup/get#yandex.cloud.ydb.v1.WeeklyBackupSchedule)**
                      Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`.
                    $ref: '#/definitions/WeeklyBackupSchedule'
                  recurringBackupSchedule:
                    description: |-
                      **[RecurringBackupSchedule](/docs/ydb/api-ref/Backup/get#yandex.cloud.ydb.v1.RecurringBackupSchedule)**
                      Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`.
                    $ref: '#/definitions/RecurringBackupSchedule'
          backupTimeToLive:
            description: |-
              **string** (duration)
              provide time to live of backup.
            type: string
            format: duration
          sourcePaths:
            description: |-
              **string**
              provide a list of source paths. Each path can be directory, table or even database itself.
              Each directory (or database) will be traversed recursively and all childs of directory will be included to backup.
              By default, backup will be created for full database.
            type: array
            items:
              type: string
          sourcePathsToExclude:
            description: |-
              **string**
              provide a list of paths to exclude from backup.
              Each path is a directory, table, or database.
              Each directory (or database) will be traversed recursively and all childs of directory will be excluded.
            type: array
            items:
              type: string
          type:
            description: |-
              **enum** (Type)
              - `TYPE_UNSPECIFIED`
              - `SYSTEM`
              - `USER`
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - SYSTEM
              - USER
          storageClass:
            description: |-
              **enum** (StorageClass)
              - `STORAGE_CLASS_UNSPECIFIED`
              - `STANDARD`
              - `REDUCED_REDUNDANCY`
              - `STANDARD_IA`
              - `ONEZONE_IA`
              - `INTELLIGENT_TIERING`
              - `GLACIER`
              - `DEEP_ARCHIVE`
              - `OUTPOSTS`
            type: string
            enum:
              - STORAGE_CLASS_UNSPECIFIED
              - STANDARD
              - REDUCED_REDUNDANCY
              - STANDARD_IA
              - ONEZONE_IA
              - INTELLIGENT_TIERING
              - GLACIER
              - DEEP_ARCHIVE
              - OUTPOSTS
      BackupConfig:
        type: object
        properties:
          backupSettings:
            description: '**[BackupSettings](/docs/ydb/api-ref/Backup/get#yandex.cloud.ydb.v1.BackupSettings)**'
            type: array
            items:
              $ref: '#/definitions/BackupSettings'
      NotificationChannel:
        type: object
        properties:
          notificationChannelId:
            description: '**string**'
            type: string
          notifyAboutStatuses:
            description: |-
              **enum** (AlertEvaluationStatus)
              - `ALERT_EVALUATION_STATUS_UNSPECIFIED`
              - `ALERT_EVALUATION_STATUS_OK`
              - `ALERT_EVALUATION_STATUS_NO_DATA`
              - `ALERT_EVALUATION_STATUS_ERROR`
              - `ALERT_EVALUATION_STATUS_ALARM`
              - `ALERT_EVALUATION_STATUS_WARN`
            type: array
            items:
              type: string
              enum:
                - ALERT_EVALUATION_STATUS_UNSPECIFIED
                - ALERT_EVALUATION_STATUS_OK
                - ALERT_EVALUATION_STATUS_NO_DATA
                - ALERT_EVALUATION_STATUS_ERROR
                - ALERT_EVALUATION_STATUS_ALARM
                - ALERT_EVALUATION_STATUS_WARN
          repeateNotifyDelayMs:
            description: '**string** (int64)'
            type: string
            format: int64
      DoubleParameterValue:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required. Parameter name
            type: string
          value:
            description: |-
              **string**
              Required. Parameter value
            type: string
      IntegerParameterValue:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required. Parameter name
            type: string
          value:
            description: |-
              **string** (int64)
              Required. Parameter value
            type: string
            format: int64
      TextParameterValue:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required. Parameter name
            type: string
          value:
            description: |-
              **string**
              Required. Parameter value
            type: string
      TextListParameterValue:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required. Parameter name
            type: string
          values:
            description: |-
              **string**
              Required. Parameter value
            type: array
            items:
              type: string
      LabelListParameterValue:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required. Parameter name
            type: string
          values:
            description: |-
              **string**
              Required. Parameter value
            type: array
            items:
              type: string
      Alert:
        type: object
        properties:
          alertId:
            description: |-
              **string**
              output only field.
            type: string
          alertTemplateId:
            description: |-
              **string**
              template of the alert.
            type: string
          name:
            description: |-
              **string**
              name of the alert.
            type: string
          description:
            description: |-
              **string**
              human readable description of the alert.
            type: string
          notificationChannels:
            description: |-
              **[NotificationChannel](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.NotificationChannel)**
              the notification channels of the alert.
            type: array
            items:
              $ref: '#/definitions/NotificationChannel'
          alertParameters:
            description: |-
              **[AlertParameter](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter)**
              alert parameters to override.
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    doubleParameterValue:
                      description: |-
                        **[DoubleParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.DoubleParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/DoubleParameterValue'
                    integerParameterValue:
                      description: |-
                        **[IntegerParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.IntegerParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/IntegerParameterValue'
                    textParameterValue:
                      description: |-
                        **[TextParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.TextParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/TextParameterValue'
                    textListParameterValue:
                      description: |-
                        **[TextListParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.TextListParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/TextListParameterValue'
                    labelListParameterValue:
                      description: |-
                        **[LabelListParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.LabelListParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/LabelListParameterValue'
          alertThresholds:
            description: |-
              **[AlertParameter](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter)**
              alert paratemers to override.
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    doubleParameterValue:
                      description: |-
                        **[DoubleParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.DoubleParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/DoubleParameterValue'
                    integerParameterValue:
                      description: |-
                        **[IntegerParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.IntegerParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/IntegerParameterValue'
                    textParameterValue:
                      description: |-
                        **[TextParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.TextParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/TextParameterValue'
                    textListParameterValue:
                      description: |-
                        **[TextListParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.TextListParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/TextListParameterValue'
                    labelListParameterValue:
                      description: |-
                        **[LabelListParameterValue](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.AlertParameter.LabelListParameterValue)**
                        Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`.
                      $ref: '#/definitions/LabelListParameterValue'
      MonitoringConfig:
        type: object
        properties:
          alerts:
            description: '**[Alert](/docs/ydb/api-ref/Database/get#yandex.cloud.ydb.v1.Alert)**'
            type: array
            items:
              $ref: '#/definitions/Alert'
sourcePath: en/_api-ref/ydb/v1/api-ref/Database/update.md
---

# Managed Service for YDB API, REST: Database.Update

Modifies the specified database.

## HTTP request

```
PATCH https://ydb.{{ api-host }}/ydb/v1/databases/{databaseId}
```

## Path parameters

#|
||Field | Description ||
|| databaseId | **string**

Required field.  ||
|#

## Body parameters {#yandex.cloud.ydb.v1.UpdateDatabaseRequest}

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

#|
||Field | Description ||
|| folderId | **string** ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string** ||
|| description | **string** ||
|| resourcePresetId | **string** ||
|| storageConfig | **[StorageConfig](#yandex.cloud.ydb.v1.StorageConfig)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ydb.v1.ScalePolicy)** ||
|| networkId | **string** ||
|| subnetIds[] | **string** ||
|| zonalDatabase | **[ZonalDatabase](#yandex.cloud.ydb.v1.ZonalDatabase)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| regionalDatabase | **[RegionalDatabase](#yandex.cloud.ydb.v1.RegionalDatabase)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| dedicatedDatabase | **[DedicatedDatabase](#yandex.cloud.ydb.v1.DedicatedDatabase)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| serverlessDatabase | **[ServerlessDatabase](#yandex.cloud.ydb.v1.ServerlessDatabase)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| assignPublicIps | **boolean** ||
|| locationId | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| backupConfig | **[BackupConfig](#yandex.cloud.ydb.v1.BackupConfig)** ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "databaseId": "string",
    "databaseName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateDatabaseMetadata](#yandex.cloud.ydb.v1.UpdateDatabaseMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## UpdateDatabaseMetadata {#yandex.cloud.ydb.v1.UpdateDatabaseMetadata}

#|
||Field | Description ||
|| databaseId | **string** ||
|| databaseName | **string** ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Database {#yandex.cloud.ydb.v1.Database}

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
|| storageConfig | **[StorageConfig](#yandex.cloud.ydb.v1.StorageConfig2)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ydb.v1.ScalePolicy2)** ||
|| networkId | **string** ||
|| subnetIds[] | **string** ||
|| zonalDatabase | **[ZonalDatabase](#yandex.cloud.ydb.v1.ZonalDatabase2)**

deprecated field

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| regionalDatabase | **[RegionalDatabase](#yandex.cloud.ydb.v1.RegionalDatabase2)**

deprecated field

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| dedicatedDatabase | **[DedicatedDatabase](#yandex.cloud.ydb.v1.DedicatedDatabase2)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| serverlessDatabase | **[ServerlessDatabase](#yandex.cloud.ydb.v1.ServerlessDatabase2)**

Includes only one of the fields `zonalDatabase`, `regionalDatabase`, `dedicatedDatabase`, `serverlessDatabase`. ||
|| assignPublicIps | **boolean** ||
|| locationId | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| backupConfig | **[BackupConfig](#yandex.cloud.ydb.v1.BackupConfig2)** ||
|| documentApiEndpoint | **string** ||
|| kinesisApiEndpoint | **string** ||
|| kafkaApiEndpoint | **string** ||
|| monitoringConfig | **[MonitoringConfig](#yandex.cloud.ydb.v1.MonitoringConfig2)** ||
|| deletionProtection | **boolean** ||
|| securityGroupIds[] | **string** ||
|#

## StorageConfig {#yandex.cloud.ydb.v1.StorageConfig2}

#|
||Field | Description ||
|| storageOptions[] | **[StorageOption](#yandex.cloud.ydb.v1.StorageOption2)** ||
|| storageSizeLimit | **string** (int64)

output only field: storage size limit of dedicated database. ||
|#

## StorageOption {#yandex.cloud.ydb.v1.StorageOption2}

#|
||Field | Description ||
|| storageTypeId | **string** ||
|| groupCount | **string** (int64) ||
|#

## ScalePolicy {#yandex.cloud.ydb.v1.ScalePolicy2}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.ydb.v1.ScalePolicy.FixedScale2)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.ydb.v1.ScalePolicy.AutoScale2)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScale {#yandex.cloud.ydb.v1.ScalePolicy.FixedScale2}

#|
||Field | Description ||
|| size | **string** (int64) ||
|#

## AutoScale {#yandex.cloud.ydb.v1.ScalePolicy.AutoScale2}

Scale policy that dynamically changes the number of database nodes within a user-defined range.

#|
||Field | Description ||
|| minSize | **string** (int64)

Minimum number of nodes to which autoscaling can scale the database. ||
|| maxSize | **string** (int64)

Maximum number of nodes to which autoscaling can scale the database. ||
|| targetTracking | **[TargetTracking](#yandex.cloud.ydb.v1.ScalePolicy.AutoScale.TargetTracking2)**

Includes only one of the fields `targetTracking`.

Type of autoscaling algorithm. ||
|#

## TargetTracking {#yandex.cloud.ydb.v1.ScalePolicy.AutoScale.TargetTracking2}

Autoscaling algorithm that tracks metric and reactively scale database nodes to keep metric
close to the specified target value.

#|
||Field | Description ||
|| cpuUtilizationPercent | **string** (int64)

A percentage of database nodes average CPU utilization.

Includes only one of the fields `cpuUtilizationPercent`. ||
|#

## ZonalDatabase {#yandex.cloud.ydb.v1.ZonalDatabase2}

#|
||Field | Description ||
|| zoneId | **string**

Required field.  ||
|#

## RegionalDatabase {#yandex.cloud.ydb.v1.RegionalDatabase2}

#|
||Field | Description ||
|| regionId | **string**

Required field.  ||
|#

## DedicatedDatabase {#yandex.cloud.ydb.v1.DedicatedDatabase2}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| storageConfig | **[StorageConfig](#yandex.cloud.ydb.v1.StorageConfig2)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.ydb.v1.ScalePolicy2)** ||
|| networkId | **string** ||
|| subnetIds[] | **string** ||
|| assignPublicIps | **boolean** ||
|| securityGroupIds[] | **string** ||
|#

## ServerlessDatabase {#yandex.cloud.ydb.v1.ServerlessDatabase2}

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

## BackupConfig {#yandex.cloud.ydb.v1.BackupConfig2}

#|
||Field | Description ||
|| backupSettings[] | **[BackupSettings](#yandex.cloud.ydb.v1.BackupSettings2)** ||
|#

## BackupSettings {#yandex.cloud.ydb.v1.BackupSettings2}

#|
||Field | Description ||
|| name | **string**

name of backup settings ||
|| description | **string**

human readable description. ||
|| backupSchedule | **[BackupSchedule](#yandex.cloud.ydb.v1.BackupSchedule2)**

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

## BackupSchedule {#yandex.cloud.ydb.v1.BackupSchedule2}

#|
||Field | Description ||
|| dailyBackupSchedule | **[DailyBackupSchedule](#yandex.cloud.ydb.v1.DailyBackupSchedule2)**

Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`. ||
|| weeklyBackupSchedule | **[WeeklyBackupSchedule](#yandex.cloud.ydb.v1.WeeklyBackupSchedule2)**

Includes only one of the fields `dailyBackupSchedule`, `weeklyBackupSchedule`, `recurringBackupSchedule`. ||
|| recurringBackupSchedule | **[RecurringBackupSchedule](#yandex.cloud.ydb.v1.RecurringBackupSchedule2)**

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

## DailyBackupSchedule {#yandex.cloud.ydb.v1.DailyBackupSchedule2}

#|
||Field | Description ||
|| executeTime | **[TimeOfDay](#google.type.TimeOfDay2)**

Required field.  ||
|#

## TimeOfDay {#google.type.TimeOfDay2}

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

## WeeklyBackupSchedule {#yandex.cloud.ydb.v1.WeeklyBackupSchedule2}

#|
||Field | Description ||
|| daysOfWeek[] | **[DaysOfWeekBackupSchedule](#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule2)** ||
|#

## DaysOfWeekBackupSchedule {#yandex.cloud.ydb.v1.DaysOfWeekBackupSchedule2}

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
|| executeTime | **[TimeOfDay](#google.type.TimeOfDay2)**

Required field.  ||
|#

## RecurringBackupSchedule {#yandex.cloud.ydb.v1.RecurringBackupSchedule2}

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

## MonitoringConfig {#yandex.cloud.ydb.v1.MonitoringConfig2}

#|
||Field | Description ||
|| alerts[] | **[Alert](#yandex.cloud.ydb.v1.Alert2)** ||
|#

## Alert {#yandex.cloud.ydb.v1.Alert2}

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
|| notificationChannels[] | **[NotificationChannel](#yandex.cloud.ydb.v1.NotificationChannel2)**

the notification channels of the alert. ||
|| alertParameters[] | **[AlertParameter](#yandex.cloud.ydb.v1.AlertParameter2)**

alert parameters to override. ||
|| alertThresholds[] | **[AlertParameter](#yandex.cloud.ydb.v1.AlertParameter2)**

alert paratemers to override. ||
|#

## NotificationChannel {#yandex.cloud.ydb.v1.NotificationChannel2}

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

## AlertParameter {#yandex.cloud.ydb.v1.AlertParameter2}

#|
||Field | Description ||
|| doubleParameterValue | **[DoubleParameterValue](#yandex.cloud.ydb.v1.AlertParameter.DoubleParameterValue2)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| integerParameterValue | **[IntegerParameterValue](#yandex.cloud.ydb.v1.AlertParameter.IntegerParameterValue2)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| textParameterValue | **[TextParameterValue](#yandex.cloud.ydb.v1.AlertParameter.TextParameterValue2)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| textListParameterValue | **[TextListParameterValue](#yandex.cloud.ydb.v1.AlertParameter.TextListParameterValue2)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|| labelListParameterValue | **[LabelListParameterValue](#yandex.cloud.ydb.v1.AlertParameter.LabelListParameterValue2)**

Includes only one of the fields `doubleParameterValue`, `integerParameterValue`, `textParameterValue`, `textListParameterValue`, `labelListParameterValue`. ||
|#

## DoubleParameterValue {#yandex.cloud.ydb.v1.AlertParameter.DoubleParameterValue2}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| value | **string**

Required. Parameter value ||
|#

## IntegerParameterValue {#yandex.cloud.ydb.v1.AlertParameter.IntegerParameterValue2}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| value | **string** (int64)

Required. Parameter value ||
|#

## TextParameterValue {#yandex.cloud.ydb.v1.AlertParameter.TextParameterValue2}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| value | **string**

Required. Parameter value ||
|#

## TextListParameterValue {#yandex.cloud.ydb.v1.AlertParameter.TextListParameterValue2}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| values[] | **string**

Required. Parameter value ||
|#

## LabelListParameterValue {#yandex.cloud.ydb.v1.AlertParameter.LabelListParameterValue2}

#|
||Field | Description ||
|| name | **string**

Required. Parameter name ||
|| values[] | **string**

Required. Parameter value ||
|#