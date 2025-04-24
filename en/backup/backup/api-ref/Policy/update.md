---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Policy/update.md
---

# Cloud Backup API, REST: Policy.Update

Update specific policy.

## HTTP request

```
PATCH https://backup.{{ api-host }}/backup/v1/policies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Policy ID. ||
|#

## Body parameters {#yandex.cloud.backup.v1.UpdatePolicyRequest}

```json
{
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
          "backupSet": [
            "string"
          ],
          // Includes only one of the fields `maxAge`, `maxCount`
          "maxAge": {
            "type": "string",
            "count": "string"
          },
          "maxCount": "string"
          // end of the list of possible fields
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
    "lvmSnapshottingEnabled": "boolean"
  }
}
```

#|
||Field | Description ||
|| settings | **[PolicySettings](#yandex.cloud.backup.v1.PolicySettings)**

Required field.  ||
|#

## PolicySettings {#yandex.cloud.backup.v1.PolicySettings}

Set of policy settings

#|
||Field | Description ||
|| compression | **enum** (Compression)

Required field. Archive compression level.

- `COMPRESSION_UNSPECIFIED`
- `NORMAL`
- `HIGH`
- `MAX`
- `OFF` ||
|| format | **enum** (Format)

Required field. Format of the Acronis backup archive.

- `FORMAT_UNSPECIFIED`
- `VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.
- `VERSION_12`: A new format recommended in most cases for fast backup and recovery.
- `AUTO`: Automatic version selection. Will be used version 12 unless the protection
plan (policy) appends backups to the ones created by earlier product
versions. ||
|| multiVolumeSnapshottingEnabled | **boolean**

If true, snapshots of multiple volumes will be taken simultaneously. ||
|| preserveFileSecuritySettings | **boolean**

If true, the file security settings will be preserved.
Deprecated. ||
|| reattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)**

Required field. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. ||
|| silentModeEnabled | **boolean**

If true, a user interaction will be avoided when possible. Equals to false if value is not specified. ||
|| splitting | **[Splitting](#yandex.cloud.backup.v1.PolicySettings.Splitting)**

Required field. Determines the size to split backups on. Splitting is not performed if value is not specified. ||
|| vmSnapshotReattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)**

Required field. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set. ||
|| vss | **[VolumeShadowCopyServiceSettings](#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings)**

Required field. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used. ||
|| archive | **[ArchiveProperties](#yandex.cloud.backup.v1.PolicySettings.ArchiveProperties)**

The archive properties. ||
|| performanceWindow | **[PerformanceWindow](#yandex.cloud.backup.v1.PolicySettings.PerformanceWindow)**

Required field. Time windows for performance limitations of backup and storage maintenance operations. ||
|| retention | **[Retention](#yandex.cloud.backup.v1.PolicySettings.Retention)**

Required field. Configuration of backup retention rules. ||
|| scheduling | **[Scheduling](#yandex.cloud.backup.v1.PolicySettings.Scheduling)**

Required field. Configuration of the backup schedule. ||
|| cbt | **enum** (ChangedBlockTracking)

Required field. A configuration of Changed Block Tracking (CBT).

- `CHANGED_BLOCK_TRACKING_UNSPECIFIED`
- `USE_IF_ENABLED`
- `ENABLE_AND_USE`
- `DO_NOT_USE` ||
|| fastBackupEnabled | **boolean**

If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. ||
|| quiesceSnapshottingEnabled | **boolean**

If true, a quiesced snapshot of the virtual machine will be taken.
Deprecated. ||
|| fileFilters | **[FileFilters](#yandex.cloud.backup.v1.PolicySettings.FileFilters)**

File filters to specify masks of files to backup or to exclude of backuping ||
|| sectorBySector | **boolean**

A sector-by-sector backup of a disk or volume creates a backup copy of all sectors of the disk or volume,
including those that do not contain data.
Therefore, the size of such a backup copy will be equal to the size of the original disk or volume.
This method can be used to back up a disk or volume with an unsupported file system. ||
|| validationEnabled | **boolean**

Validation is a time-consuming process, even with incremental or differential backups of small amounts of data.
This is because not only the data physically contained in the backup copy is verified,
but all data restored when it is selected.
This option requires access to previously created backup copies. ||
|| lvmSnapshottingEnabled | **boolean**

LVM will be used to create the volume snapshot.
If LVM fails to create a snapshot (for example, because there is not enough free space),
the software will create the snapshot itself. ||
|#

## RetriesConfiguration {#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration}

#|
||Field | Description ||
|| enabled | **boolean**

If true, enables retry on errors. ||
|| interval | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Required field. An interval between retry attempts. ||
|| maxAttempts | **string** (int64)

Max number of retry attempts. Operation will be considered as failed
when max number of retry attempts is reached. ||
|#

## Interval {#yandex.cloud.backup.v1.PolicySettings.Interval}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. A type of the interval.

- `TYPE_UNSPECIFIED`
- `SECONDS`
- `MINUTES`
- `HOURS`
- `DAYS`
- `WEEKS`
- `MONTHS` ||
|| count | **string** (int64)

The amount of value specified in `Interval.Type`. ||
|#

## Splitting {#yandex.cloud.backup.v1.PolicySettings.Splitting}

#|
||Field | Description ||
|| size | **string** (int64)

The size of split backup file in bytes. ||
|#

## VolumeShadowCopyServiceSettings {#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings}

Settings for Volume Shadow Copy Services which allows to notify
VSS-aware applications that backup is about to start. This will
ensure the consistent state of all data used by the applications.

#|
||Field | Description ||
|| enabled | **boolean**

If true, the VSS will be enabled. ||
|| provider | **enum** (VSSProvider)

Required field. A type of VSS provider to use in backup.

- `VSS_PROVIDER_UNSPECIFIED`
- `NATIVE`
- `TARGET_SYSTEM_DEFINED` ||
|#

## ArchiveProperties {#yandex.cloud.backup.v1.PolicySettings.ArchiveProperties}

#|
||Field | Description ||
|| name | **string**

The name of the generated archive. The name may use the following variables: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, `[Virtualization Server Type]`.
Default value: `[Machine Name]-[Plan ID]-[Unique ID]A`. ||
|#

## PerformanceWindow {#yandex.cloud.backup.v1.PolicySettings.PerformanceWindow}

#|
||Field | Description ||
|| enabled | **boolean**

If true, the time windows will be enabled. ||
|#

## Retention {#yandex.cloud.backup.v1.PolicySettings.Retention}

#|
||Field | Description ||
|| rules[] | **[RetentionRule](#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule)**

A list of retention rules. ||
|| beforeBackup | **boolean**

If true, retention rules will be applied before backup is finished. ||
|#

## RetentionRule {#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule}

#|
||Field | Description ||
|| backupSet[] | **enum** (RepeatePeriod)

A list of backup sets where rules are effective.

- `REPEATE_PERIOD_UNSPECIFIED`
- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|| maxAge | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Includes only one of the fields `maxAge`, `maxCount`. ||
|| maxCount | **string** (int64)

Includes only one of the fields `maxAge`, `maxCount`. ||
|#

## Scheduling {#yandex.cloud.backup.v1.PolicySettings.Scheduling}

#|
||Field | Description ||
|| backupSets[] | **[BackupSet](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet)**

A list of schedules with backup sets that compose the whole scheme. ||
|| enabled | **boolean**

If true, the backup schedule will be enabled. ||
|| maxParallelBackups | **string** (int64)

Max number of backup processes allowed to run in parallel. Unlimited if not set. ||
|| randMaxDelay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Required field. Configuration of the random delay between the execution of parallel tasks. ||
|| scheme | **enum** (Scheme)

Required field. A backup scheme. Available values: `simple`, `always_full`, `always_incremental`, `weekly_incremental`, `weekly_full_daily_incremental`, `custom`, `cdp`.

- `SCHEME_UNSPECIFIED`
- `SIMPLE`
- `ALWAYS_FULL`
- `ALWAYS_INCREMENTAL`
- `WEEKLY_INCREMENTAL`
- `WEEKLY_FULL_DAILY_INCREMENTAL`
- `CUSTOM`: Custom will require to specify schedules for full, differential
and incremental backups additionally.
- `CDP` ||
|| weeklyBackupDay | **enum** (Day)

Required field. A day of week to start weekly backups.

- `DAY_UNSPECIFIED`
- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| taskFailure | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)**

Task failure settings in case of failure of scheduled task, not applicable to  manually launched tasks ||
|#

## BackupSet {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet}

#|
||Field | Description ||
|| time | **[Time](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| sinceLastExecTime | **[SinceLastExecTime](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| type | **enum** (Type)

BackupSet type -- one of incr, full, differential or auto.
if custom scheme is used the BackupSet type should be specified

- `TYPE_UNSPECIFIED`
- `TYPE_AUTO`
- `TYPE_FULL`
- `TYPE_INCREMENTAL`
- `TYPE_DIFFERENTIAL` ||
|#

## Time {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time}

#|
||Field | Description ||
|| weekdays[] | **enum** (Day)

Days in a week to perform a backup.

- `DAY_UNSPECIFIED`
- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| repeatAt[] | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)**

Time to repeat the backup. ||
|| repeatEvery | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Frequency of backup repetition. ||
|| timeFrom | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)**

The start time of the backup time interval. ||
|| timeTo | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)**

The end time of the backup time interval. ||
|| monthdays[] | **string** (int64)

Days in a month to perform a backup.
Allowed values are from 1 to 31. ||
|| includeLastDayOfMonth | **boolean**

If set to true, last day of month will activate
the policy. ||
|| months[] | **string** (int64)

Set of values. Allowed values form 1 to 12. ||
|| type | **enum** (RepeatePeriod)

Required field. Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`.

- `REPEATE_PERIOD_UNSPECIFIED`
- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|| runLater | **boolean**

If the machine is off, launch missed tasks on boot up. ||
|#

## TimeOfDay {#yandex.cloud.backup.v1.PolicySettings.TimeOfDay}

#|
||Field | Description ||
|| hour | **string** (int64)

Hours. ||
|| minute | **string** (int64)

Minutes. ||
|#

## SinceLastExecTime {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime}

#|
||Field | Description ||
|| delay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Required field. The interval between backups. ||
|#

## FileFilters {#yandex.cloud.backup.v1.PolicySettings.FileFilters}

#|
||Field | Description ||
|| exclusionMasks[] | **string**

Do not backup files that match the following criteria ||
|| inclusionMasks[] | **string**

Backup only files that match the following criteria ||
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
    "policyId": "string"
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
            "backupSet": [
              "string"
            ],
            // Includes only one of the fields `maxAge`, `maxCount`
            "maxAge": {
              "type": "string",
              "count": "string"
            },
            "maxCount": "string"
            // end of the list of possible fields
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
      "lvmSnapshottingEnabled": "boolean"
    },
    "folderId": "string"
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
|| metadata | **[UpdatePolicyMetadata](#yandex.cloud.backup.v1.UpdatePolicyMetadata)**

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
|| response | **[Policy](#yandex.cloud.backup.v1.Policy)**

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

## UpdatePolicyMetadata {#yandex.cloud.backup.v1.UpdatePolicyMetadata}

#|
||Field | Description ||
|| policyId | **string**

Required field. Policy ID. ||
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

Required field. Policy ID. ||
|| name | **string**

Required field. Policy name. ||
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
|| enabled | **boolean**

If this field is true, it means that the policy is enabled. ||
|| settings | **[PolicySettings](#yandex.cloud.backup.v1.PolicySettings2)**

Set of policy settings ||
|| folderId | **string**

ID of the folder that the policy belongs to. ||
|#

## PolicySettings {#yandex.cloud.backup.v1.PolicySettings2}

Set of policy settings

#|
||Field | Description ||
|| compression | **enum** (Compression)

Required field. Archive compression level.

- `COMPRESSION_UNSPECIFIED`
- `NORMAL`
- `HIGH`
- `MAX`
- `OFF` ||
|| format | **enum** (Format)

Required field. Format of the Acronis backup archive.

- `FORMAT_UNSPECIFIED`
- `VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.
- `VERSION_12`: A new format recommended in most cases for fast backup and recovery.
- `AUTO`: Automatic version selection. Will be used version 12 unless the protection
plan (policy) appends backups to the ones created by earlier product
versions. ||
|| multiVolumeSnapshottingEnabled | **boolean**

If true, snapshots of multiple volumes will be taken simultaneously. ||
|| preserveFileSecuritySettings | **boolean**

If true, the file security settings will be preserved.
Deprecated. ||
|| reattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration2)**

Required field. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. ||
|| silentModeEnabled | **boolean**

If true, a user interaction will be avoided when possible. Equals to false if value is not specified. ||
|| splitting | **[Splitting](#yandex.cloud.backup.v1.PolicySettings.Splitting2)**

Required field. Determines the size to split backups on. Splitting is not performed if value is not specified. ||
|| vmSnapshotReattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration2)**

Required field. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set. ||
|| vss | **[VolumeShadowCopyServiceSettings](#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings2)**

Required field. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used. ||
|| archive | **[ArchiveProperties](#yandex.cloud.backup.v1.PolicySettings.ArchiveProperties2)**

The archive properties. ||
|| performanceWindow | **[PerformanceWindow](#yandex.cloud.backup.v1.PolicySettings.PerformanceWindow2)**

Required field. Time windows for performance limitations of backup and storage maintenance operations. ||
|| retention | **[Retention](#yandex.cloud.backup.v1.PolicySettings.Retention2)**

Required field. Configuration of backup retention rules. ||
|| scheduling | **[Scheduling](#yandex.cloud.backup.v1.PolicySettings.Scheduling2)**

Required field. Configuration of the backup schedule. ||
|| cbt | **enum** (ChangedBlockTracking)

Required field. A configuration of Changed Block Tracking (CBT).

- `CHANGED_BLOCK_TRACKING_UNSPECIFIED`
- `USE_IF_ENABLED`
- `ENABLE_AND_USE`
- `DO_NOT_USE` ||
|| fastBackupEnabled | **boolean**

If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. ||
|| quiesceSnapshottingEnabled | **boolean**

If true, a quiesced snapshot of the virtual machine will be taken.
Deprecated. ||
|| fileFilters | **[FileFilters](#yandex.cloud.backup.v1.PolicySettings.FileFilters2)**

File filters to specify masks of files to backup or to exclude of backuping ||
|| sectorBySector | **boolean**

A sector-by-sector backup of a disk or volume creates a backup copy of all sectors of the disk or volume,
including those that do not contain data.
Therefore, the size of such a backup copy will be equal to the size of the original disk or volume.
This method can be used to back up a disk or volume with an unsupported file system. ||
|| validationEnabled | **boolean**

Validation is a time-consuming process, even with incremental or differential backups of small amounts of data.
This is because not only the data physically contained in the backup copy is verified,
but all data restored when it is selected.
This option requires access to previously created backup copies. ||
|| lvmSnapshottingEnabled | **boolean**

LVM will be used to create the volume snapshot.
If LVM fails to create a snapshot (for example, because there is not enough free space),
the software will create the snapshot itself. ||
|#

## RetriesConfiguration {#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration2}

#|
||Field | Description ||
|| enabled | **boolean**

If true, enables retry on errors. ||
|| interval | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval2)**

Required field. An interval between retry attempts. ||
|| maxAttempts | **string** (int64)

Max number of retry attempts. Operation will be considered as failed
when max number of retry attempts is reached. ||
|#

## Interval {#yandex.cloud.backup.v1.PolicySettings.Interval2}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. A type of the interval.

- `TYPE_UNSPECIFIED`
- `SECONDS`
- `MINUTES`
- `HOURS`
- `DAYS`
- `WEEKS`
- `MONTHS` ||
|| count | **string** (int64)

The amount of value specified in `Interval.Type`. ||
|#

## Splitting {#yandex.cloud.backup.v1.PolicySettings.Splitting2}

#|
||Field | Description ||
|| size | **string** (int64)

The size of split backup file in bytes. ||
|#

## VolumeShadowCopyServiceSettings {#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings2}

Settings for Volume Shadow Copy Services which allows to notify
VSS-aware applications that backup is about to start. This will
ensure the consistent state of all data used by the applications.

#|
||Field | Description ||
|| enabled | **boolean**

If true, the VSS will be enabled. ||
|| provider | **enum** (VSSProvider)

Required field. A type of VSS provider to use in backup.

- `VSS_PROVIDER_UNSPECIFIED`
- `NATIVE`
- `TARGET_SYSTEM_DEFINED` ||
|#

## ArchiveProperties {#yandex.cloud.backup.v1.PolicySettings.ArchiveProperties2}

#|
||Field | Description ||
|| name | **string**

The name of the generated archive. The name may use the following variables: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, `[Virtualization Server Type]`.
Default value: `[Machine Name]-[Plan ID]-[Unique ID]A`. ||
|#

## PerformanceWindow {#yandex.cloud.backup.v1.PolicySettings.PerformanceWindow2}

#|
||Field | Description ||
|| enabled | **boolean**

If true, the time windows will be enabled. ||
|#

## Retention {#yandex.cloud.backup.v1.PolicySettings.Retention2}

#|
||Field | Description ||
|| rules[] | **[RetentionRule](#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule2)**

A list of retention rules. ||
|| beforeBackup | **boolean**

If true, retention rules will be applied before backup is finished. ||
|#

## RetentionRule {#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule2}

#|
||Field | Description ||
|| backupSet[] | **enum** (RepeatePeriod)

A list of backup sets where rules are effective.

- `REPEATE_PERIOD_UNSPECIFIED`
- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|| maxAge | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval2)**

Includes only one of the fields `maxAge`, `maxCount`. ||
|| maxCount | **string** (int64)

Includes only one of the fields `maxAge`, `maxCount`. ||
|#

## Scheduling {#yandex.cloud.backup.v1.PolicySettings.Scheduling2}

#|
||Field | Description ||
|| backupSets[] | **[BackupSet](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet2)**

A list of schedules with backup sets that compose the whole scheme. ||
|| enabled | **boolean**

If true, the backup schedule will be enabled. ||
|| maxParallelBackups | **string** (int64)

Max number of backup processes allowed to run in parallel. Unlimited if not set. ||
|| randMaxDelay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval2)**

Required field. Configuration of the random delay between the execution of parallel tasks. ||
|| scheme | **enum** (Scheme)

Required field. A backup scheme. Available values: `simple`, `always_full`, `always_incremental`, `weekly_incremental`, `weekly_full_daily_incremental`, `custom`, `cdp`.

- `SCHEME_UNSPECIFIED`
- `SIMPLE`
- `ALWAYS_FULL`
- `ALWAYS_INCREMENTAL`
- `WEEKLY_INCREMENTAL`
- `WEEKLY_FULL_DAILY_INCREMENTAL`
- `CUSTOM`: Custom will require to specify schedules for full, differential
and incremental backups additionally.
- `CDP` ||
|| weeklyBackupDay | **enum** (Day)

Required field. A day of week to start weekly backups.

- `DAY_UNSPECIFIED`
- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| taskFailure | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration2)**

Task failure settings in case of failure of scheduled task, not applicable to  manually launched tasks ||
|#

## BackupSet {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet2}

#|
||Field | Description ||
|| time | **[Time](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time2)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| sinceLastExecTime | **[SinceLastExecTime](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime2)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| type | **enum** (Type)

BackupSet type -- one of incr, full, differential or auto.
if custom scheme is used the BackupSet type should be specified

- `TYPE_UNSPECIFIED`
- `TYPE_AUTO`
- `TYPE_FULL`
- `TYPE_INCREMENTAL`
- `TYPE_DIFFERENTIAL` ||
|#

## Time {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time2}

#|
||Field | Description ||
|| weekdays[] | **enum** (Day)

Days in a week to perform a backup.

- `DAY_UNSPECIFIED`
- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| repeatAt[] | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay2)**

Time to repeat the backup. ||
|| repeatEvery | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval2)**

Frequency of backup repetition. ||
|| timeFrom | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay2)**

The start time of the backup time interval. ||
|| timeTo | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay2)**

The end time of the backup time interval. ||
|| monthdays[] | **string** (int64)

Days in a month to perform a backup.
Allowed values are from 1 to 31. ||
|| includeLastDayOfMonth | **boolean**

If set to true, last day of month will activate
the policy. ||
|| months[] | **string** (int64)

Set of values. Allowed values form 1 to 12. ||
|| type | **enum** (RepeatePeriod)

Required field. Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`.

- `REPEATE_PERIOD_UNSPECIFIED`
- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|| runLater | **boolean**

If the machine is off, launch missed tasks on boot up. ||
|#

## TimeOfDay {#yandex.cloud.backup.v1.PolicySettings.TimeOfDay2}

#|
||Field | Description ||
|| hour | **string** (int64)

Hours. ||
|| minute | **string** (int64)

Minutes. ||
|#

## SinceLastExecTime {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime2}

#|
||Field | Description ||
|| delay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval2)**

Required field. The interval between backups. ||
|#

## FileFilters {#yandex.cloud.backup.v1.PolicySettings.FileFilters2}

#|
||Field | Description ||
|| exclusionMasks[] | **string**

Do not backup files that match the following criteria ||
|| inclusionMasks[] | **string**

Backup only files that match the following criteria ||
|#