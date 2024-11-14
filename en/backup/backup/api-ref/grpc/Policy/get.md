---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Policy/get.md
---

# Cloud Backup API, gRPC: PolicyService.Get {#Get}

Get specific policy.

## gRPC request

**rpc Get ([GetPolicyRequest](#yandex.cloud.backup.v1.GetPolicyRequest)) returns ([Policy](#yandex.cloud.backup.v1.Policy))**

## GetPolicyRequest {#yandex.cloud.backup.v1.GetPolicyRequest}

```json
{
  "policyId": "string"
}
```

#|
||Field | Description ||
|| policyId | **string**

Required field. Policy ID. ||
|#

## Policy {#yandex.cloud.backup.v1.Policy}

```json
{
  "id": "string",
  "name": "string",
  "createdAt": "google.protobuf.Timestamp",
  "updatedAt": "google.protobuf.Timestamp",
  "enabled": "bool",
  "settings": {
    "compression": "Compression",
    "format": "Format",
    "multiVolumeSnapshottingEnabled": "bool",
    "preserveFileSecuritySettings": "bool",
    "reattempts": {
      "enabled": "bool",
      "interval": {
        "type": "Type",
        "count": "int64"
      },
      "maxAttempts": "int64"
    },
    "silentModeEnabled": "bool",
    "splitting": {
      "size": "int64"
    },
    "vmSnapshotReattempts": {
      "enabled": "bool",
      "interval": {
        "type": "Type",
        "count": "int64"
      },
      "maxAttempts": "int64"
    },
    "vss": {
      "enabled": "bool",
      "provider": "VSSProvider"
    },
    "archive": {
      "name": "string"
    },
    "performanceWindow": {
      "enabled": "bool"
    },
    "retention": {
      "rules": [
        {
          "backupSet": [
            "RepeatePeriod"
          ],
          // Includes only one of the fields `maxAge`, `maxCount`
          "maxAge": {
            "type": "Type",
            "count": "int64"
          },
          "maxCount": "int64"
          // end of the list of possible fields
        }
      ],
      "beforeBackup": "bool"
    },
    "scheduling": {
      "backupSets": [
        {
          // Includes only one of the fields `time`, `sinceLastExecTime`
          "time": {
            "weekdays": [
              "Day"
            ],
            "repeatAt": [
              {
                "hour": "int64",
                "minute": "int64"
              }
            ],
            "repeatEvery": {
              "type": "Type",
              "count": "int64"
            },
            "timeFrom": {
              "hour": "int64",
              "minute": "int64"
            },
            "timeTo": {
              "hour": "int64",
              "minute": "int64"
            },
            "monthdays": [
              "int64"
            ],
            "includeLastDayOfMonth": "bool",
            "months": [
              "int64"
            ],
            "type": "RepeatePeriod"
          },
          "sinceLastExecTime": {
            "delay": {
              "type": "Type",
              "count": "int64"
            }
          },
          // end of the list of possible fields
          "type": "Type"
        }
      ],
      "enabled": "bool",
      "maxParallelBackups": "int64",
      "randMaxDelay": {
        "type": "Type",
        "count": "int64"
      },
      "scheme": "Scheme",
      "weeklyBackupDay": "Day"
    },
    "cbt": "ChangedBlockTracking",
    "fastBackupEnabled": "bool",
    "quiesceSnapshottingEnabled": "bool"
  },
  "folderId": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. Policy ID. ||
|| name | **string**

Required field. Policy name. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| enabled | **bool**

If this field is true, it means that the policy is enabled. ||
|| settings | **[PolicySettings](#yandex.cloud.backup.v1.PolicySettings)**

Set of policy settings ||
|| folderId | **string**

ID of the folder that the policy belongs to. ||
|#

## PolicySettings {#yandex.cloud.backup.v1.PolicySettings}

Set of policy settings

#|
||Field | Description ||
|| compression | enum **Compression**

Required field. Archive compression level.

- `COMPRESSION_UNSPECIFIED`
- `NORMAL`
- `HIGH`
- `MAX`
- `OFF` ||
|| format | enum **Format**

Required field. Format of the Cyberprotect backup archive.

- `FORMAT_UNSPECIFIED`
- `VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.
- `VERSION_12`: A new format recommended in most cases for fast backup and recovery.
- `AUTO`: Automatic version selection. Will be used version 12 unless the protection
plan (policy) appends backups to the ones created by earlier product
versions. ||
|| multiVolumeSnapshottingEnabled | **bool**

If true, snapshots of multiple volumes will be taken simultaneously. ||
|| preserveFileSecuritySettings | **bool**

If true, the file security settings will be preserved. ||
|| reattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)**

Required field. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. ||
|| silentModeEnabled | **bool**

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
|| cbt | enum **ChangedBlockTracking**

Required field. A configuration of Changed Block Tracking (CBT).

- `CHANGED_BLOCK_TRACKING_UNSPECIFIED`
- `USE_IF_ENABLED`
- `ENABLE_AND_USE`
- `DO_NOT_USE` ||
|| fastBackupEnabled | **bool**

If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. ||
|| quiesceSnapshottingEnabled | **bool**

If true, a quiesced snapshot of the virtual machine will be taken. ||
|#

## RetriesConfiguration {#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration}

#|
||Field | Description ||
|| enabled | **bool**

If true, enables retry on errors. ||
|| interval | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Required field. An interval between retry attempts. ||
|| maxAttempts | **int64**

Max number of retry attempts. Operation will be considered as failed
when max number of retry attempts is reached. ||
|#

## Interval {#yandex.cloud.backup.v1.PolicySettings.Interval}

#|
||Field | Description ||
|| type | enum **Type**

Required field. A type of the interval.

- `TYPE_UNSPECIFIED`
- `SECONDS`
- `MINUTES`
- `HOURS`
- `DAYS`
- `WEEKS`
- `MONTHS` ||
|| count | **int64**

The amount of value specified in `Interval.Type`. ||
|#

## Splitting {#yandex.cloud.backup.v1.PolicySettings.Splitting}

#|
||Field | Description ||
|| size | **int64**

The size of split backup file in bytes. ||
|#

## VolumeShadowCopyServiceSettings {#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings}

Settings for Volume Shadow Copy Services which allows to notify
VSS-aware applications that backup is about to start. This will
ensure the consistent state of all data used by the applications.

#|
||Field | Description ||
|| enabled | **bool**

If true, the VSS will be enabled. ||
|| provider | enum **VSSProvider**

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
|| enabled | **bool**

If true, the time windows will be enabled. ||
|#

## Retention {#yandex.cloud.backup.v1.PolicySettings.Retention}

#|
||Field | Description ||
|| rules[] | **[RetentionRule](#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule)**

A list of retention rules. ||
|| beforeBackup | **bool**

If true, retention rules will be applied before backup is finished. ||
|#

## RetentionRule {#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule}

#|
||Field | Description ||
|| backupSet[] | enum **RepeatePeriod**

A list of backup sets where rules are effective.

- `REPEATE_PERIOD_UNSPECIFIED`
- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|| maxAge | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Includes only one of the fields `maxAge`, `maxCount`. ||
|| maxCount | **int64**

Includes only one of the fields `maxAge`, `maxCount`. ||
|#

## Scheduling {#yandex.cloud.backup.v1.PolicySettings.Scheduling}

#|
||Field | Description ||
|| backupSets[] | **[BackupSet](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet)**

A list of schedules with backup sets that compose the whole scheme. ||
|| enabled | **bool**

If true, the backup schedule will be enabled. ||
|| maxParallelBackups | **int64**

Max number of backup processes allowed to run in parallel. Unlimited if not set. ||
|| randMaxDelay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Required field. Configuration of the random delay between the execution of parallel tasks. ||
|| scheme | enum **Scheme**

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
|| weeklyBackupDay | enum **Day**

Required field. A day of week to start weekly backups.

- `DAY_UNSPECIFIED`
- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|#

## BackupSet {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet}

#|
||Field | Description ||
|| time | **[Time](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| sinceLastExecTime | **[SinceLastExecTime](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime)**

Includes only one of the fields `time`, `sinceLastExecTime`. ||
|| type | enum **Type**

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
|| weekdays[] | enum **Day**

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
|| monthdays[] | **int64**

Days in a month to perform a backup.
Allowed values are from 1 to 31. ||
|| includeLastDayOfMonth | **bool**

If set to true, last day of month will activate
the policy. ||
|| months[] | **int64**

Set of values. Allowed values form 1 to 12. ||
|| type | enum **RepeatePeriod**

Required field. Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`.

- `REPEATE_PERIOD_UNSPECIFIED`
- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|#

## TimeOfDay {#yandex.cloud.backup.v1.PolicySettings.TimeOfDay}

#|
||Field | Description ||
|| hour | **int64**

Hours. ||
|| minute | **int64**

Minutes. ||
|#

## SinceLastExecTime {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime}

#|
||Field | Description ||
|| delay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Required field. The interval between backups. ||
|#