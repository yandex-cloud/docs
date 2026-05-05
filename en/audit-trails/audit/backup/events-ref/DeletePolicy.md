---
editable: false
---

# Cloud Backup Audit Trails Events: DeletePolicy

## Event JSON schema {#yandex.cloud.audit.backup.DeletePolicy2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "id": "string",
    "name": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "enabled": "boolean",
    "settings": {
      "compression": "string",
      "format": "string",
      "multiVolumeSnapshottingEnabled": "boolean",
      "preserveFileSecuritySettings": "boolean",
      "reattempts": {
        "enabled": "boolean",
        "interval": {
          "type": "string",
          "count": "string"
        },
        "maxAttempts": "string"
      },
      "silentModeEnabled": "boolean",
      "splitting": {
        "size": "string"
      },
      "vmSnapshotReattempts": {
        "enabled": "boolean",
        "interval": {
          "type": "string",
          "count": "string"
        },
        "maxAttempts": "string"
      },
      "vss": {
        "enabled": "boolean",
        "provider": "string"
      },
      "archive": {
        "name": "string"
      },
      "performanceWindow": {
        "enabled": "boolean"
      },
      "retention": {
        "rules": [
          {
            // Includes only one of the fields `maxAge`, `maxCount`
            "maxAge": {
              "type": "string",
              "count": "string"
            },
            "maxCount": "string",
            // end of the list of possible fields
            "backupSet": [
              "string"
            ]
          }
        ],
        "beforeBackup": "boolean"
      },
      "scheduling": {
        "backupSets": [
          {
            // Includes only one of the fields `time`, `sinceLastExecTime`
            "time": {
              "weekdays": [
                "string"
              ],
              "repeatAt": [
                {
                  "hour": "string",
                  "minute": "string"
                }
              ],
              "repeatEvery": {
                "type": "string",
                "count": "string"
              },
              "timeFrom": {
                "hour": "string",
                "minute": "string"
              },
              "timeTo": {
                "hour": "string",
                "minute": "string"
              },
              "monthdays": [
                "string"
              ],
              "includeLastDayOfMonth": "boolean",
              "months": [
                "string"
              ],
              "type": "string",
              "runLater": "boolean"
            },
            "sinceLastExecTime": {
              "delay": {
                "type": "string",
                "count": "string"
              }
            },
            // end of the list of possible fields
            "type": "string"
          }
        ],
        "enabled": "boolean",
        "maxParallelBackups": "string",
        "randMaxDelay": {
          "type": "string",
          "count": "string"
        },
        "scheme": "string",
        "weeklyBackupDay": "string",
        "taskFailure": {
          "enabled": "boolean",
          "interval": {
            "type": "string",
            "count": "string"
          },
          "maxAttempts": "string"
        }
      },
      "cbt": "string",
      "fastBackupEnabled": "boolean",
      "quiesceSnapshottingEnabled": "boolean",
      "fileFilters": {
        "exclusionMasks": [
          "string"
        ],
        "inclusionMasks": [
          "string"
        ]
      },
      "sectorBySector": "boolean",
      "validationEnabled": "boolean",
      "lvmSnapshottingEnabled": "boolean",
      "prePostCommands": [
        {
          "cmd": "string",
          "args": "string",
          "enabled": "boolean",
          "stopOnError": "boolean",
          "type": "string",
          "wait": "boolean",
          "workdir": "string"
        }
      ]
    },
    "folderId": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.backup.DeletePolicy2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[Policy](#yandex.cloud.backup.v1.Policy)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## Policy {#yandex.cloud.backup.v1.Policy}

#|
||Field | Description ||
|| id | **string**

The maximum string length in characters is 50. ||
|| name | **string**

The maximum string length in characters is 50. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| enabled | **boolean** ||
|| settings | **[PolicySettings](#yandex.cloud.backup.v1.PolicySettings)** ||
|| folderId | **string** ||
|#

## PolicySettings {#yandex.cloud.backup.v1.PolicySettings}

#|
||Field | Description ||
|| compression | **enum** (Compression)

- `NORMAL`
- `HIGH`
- `MAX`
- `OFF` ||
|| format | **enum** (Format)

- `VERSION_11`
- `VERSION_12`
- `AUTO` ||
|| multiVolumeSnapshottingEnabled | **boolean** ||
|| preserveFileSecuritySettings | **boolean** ||
|| reattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)** ||
|| silentModeEnabled | **boolean** ||
|| splitting | **[Splitting](#yandex.cloud.backup.v1.PolicySettings.Splitting)** ||
|| vmSnapshotReattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)** ||
|| vss | **[VolumeShadowCopyServiceSettings](#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings)** ||
|| archive | **[ArchiveProperties](#yandex.cloud.backup.v1.PolicySettings.ArchiveProperties)** ||
|| performanceWindow | **[PerformanceWindow](#yandex.cloud.backup.v1.PolicySettings.PerformanceWindow)** ||
|| retention | **[Retention](#yandex.cloud.backup.v1.PolicySettings.Retention)** ||
|| scheduling | **[Scheduling](#yandex.cloud.backup.v1.PolicySettings.Scheduling)** ||
|| cbt | **enum** (ChangedBlockTracking)

- `USE_IF_ENABLED`
- `ENABLE_AND_USE`
- `DO_NOT_USE` ||
|| fastBackupEnabled | **boolean** ||
|| quiesceSnapshottingEnabled | **boolean** ||
|| fileFilters | **[FileFilters](#yandex.cloud.backup.v1.PolicySettings.FileFilters)** ||
|| sectorBySector | **boolean** ||
|| validationEnabled | **boolean** ||
|| lvmSnapshottingEnabled | **boolean** ||
|| prePostCommands[] | **[PrePostCommand](#yandex.cloud.backup.v1.PolicySettings.PrePostCommand)** ||
|#

## RetriesConfiguration {#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| interval | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)** ||
|| maxAttempts | **string** (int64)

Value must be greater than 0. ||
|#

## Interval {#yandex.cloud.backup.v1.PolicySettings.Interval}

#|
||Field | Description ||
|| type | **enum** (Type)

- `SECONDS`
- `MINUTES`
- `HOURS`
- `DAYS`
- `WEEKS`
- `MONTHS` ||
|| count | **string** (int64)

Value must be greater than 0. ||
|#

## Splitting {#yandex.cloud.backup.v1.PolicySettings.Splitting}

#|
||Field | Description ||
|| size | **string** (int64) ||
|#

## VolumeShadowCopyServiceSettings {#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| provider | **enum** (VSSProvider)

- `NATIVE`
- `TARGET_SYSTEM_DEFINED` ||
|#

## ArchiveProperties {#yandex.cloud.backup.v1.PolicySettings.ArchiveProperties}

#|
||Field | Description ||
|| name | **string** ||
|#

## PerformanceWindow {#yandex.cloud.backup.v1.PolicySettings.PerformanceWindow}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## Retention {#yandex.cloud.backup.v1.PolicySettings.Retention}

#|
||Field | Description ||
|| rules[] | **[RetentionRule](#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule)** ||
|| beforeBackup | **boolean** ||
|#

## RetentionRule {#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule}

#|
||Field | Description ||
|| maxAge | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Includes only one of the fields `maxAge`, `maxCount`. ||
|| maxCount | **string** (int64)

Includes only one of the fields `maxAge`, `maxCount`. ||
|| backupSet[] | **enum** (RepeatePeriod)

- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|#

## Scheduling {#yandex.cloud.backup.v1.PolicySettings.Scheduling}

#|
||Field | Description ||
|| backupSets[] | **[BackupSet](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet)**

The number of elements must be greater than 0. ||
|| enabled | **boolean** ||
|| maxParallelBackups | **string** (int64) ||
|| randMaxDelay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)** ||
|| scheme | **enum** (Scheme)

- `SIMPLE`
- `ALWAYS_FULL`
- `ALWAYS_INCREMENTAL`
- `WEEKLY_INCREMENTAL`
- `WEEKLY_FULL_DAILY_INCREMENTAL`
- `CUSTOM`
- `CDP` ||
|| weeklyBackupDay | **enum** (Day)

- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| taskFailure | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)** ||
|#

## BackupSet {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet}

#|
||Field | Description ||
|| time | **[Time](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| sinceLastExecTime | **[SinceLastExecTime](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| type | **enum** (Type)

- `TYPE_AUTO`
- `TYPE_FULL`
- `TYPE_INCREMENTAL`
- `TYPE_DIFFERENTIAL` ||
|#

## Time {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time}

#|
||Field | Description ||
|| weekdays[] | **enum** (Day)

- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| repeatAt[] | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)** ||
|| repeatEvery | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)** ||
|| timeFrom | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)** ||
|| timeTo | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)** ||
|| monthdays[] | **string** (int64) ||
|| includeLastDayOfMonth | **boolean** ||
|| months[] | **string** (int64) ||
|| type | **enum** (RepeatePeriod)

- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|| runLater | **boolean** ||
|#

## TimeOfDay {#yandex.cloud.backup.v1.PolicySettings.TimeOfDay}

#|
||Field | Description ||
|| hour | **string** (int64) ||
|| minute | **string** (int64) ||
|#

## SinceLastExecTime {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime}

#|
||Field | Description ||
|| delay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)** ||
|#

## FileFilters {#yandex.cloud.backup.v1.PolicySettings.FileFilters}

#|
||Field | Description ||
|| exclusionMasks[] | **string** ||
|| inclusionMasks[] | **string** ||
|#

## PrePostCommand {#yandex.cloud.backup.v1.PolicySettings.PrePostCommand}

#|
||Field | Description ||
|| cmd | **string** ||
|| args | **string** ||
|| enabled | **boolean** ||
|| stopOnError | **boolean** ||
|| type | **enum** (CommandType)

- `PRE_COMMAND`
- `POST_COMMAND`
- `PRE_DATA_COMMAND`
- `POST_DATA_COMMAND` ||
|| wait | **boolean** ||
|| workdir | **string** ||
|#