---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Policy/list.md
---

# Cloud Backup API, gRPC: PolicyService.List

List [policies](/docs/backup/concepts/policy) of specified folder.

## gRPC request

**rpc List ([ListPoliciesRequest](#yandex.cloud.backup.v1.ListPoliciesRequest)) returns ([ListPoliciesResponse](#yandex.cloud.backup.v1.ListPoliciesResponse))**

## ListPoliciesRequest {#yandex.cloud.backup.v1.ListPoliciesRequest}

```json
{
  "folder_id": "string",
  "compute_instance_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Folder ID. Either Folder ID or Compute Cloud instance ID should be set. ||
|| compute_instance_id | **string**

Compute Cloud instance ID. Either Folder ID or Compute Cloud instance ID should be set. ||
|#

## ListPoliciesResponse {#yandex.cloud.backup.v1.ListPoliciesResponse}

```json
{
  "policies": [
    {
      "id": "string",
      "name": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "enabled": "bool",
      "settings": {
        "compression": "Compression",
        "format": "Format",
        "multi_volume_snapshotting_enabled": "bool",
        "preserve_file_security_settings": "bool",
        "reattempts": {
          "enabled": "bool",
          "interval": {
            "type": "Type",
            "count": "int64"
          },
          "max_attempts": "int64"
        },
        "silent_mode_enabled": "bool",
        "splitting": {
          "size": "int64"
        },
        "vm_snapshot_reattempts": {
          "enabled": "bool",
          "interval": {
            "type": "Type",
            "count": "int64"
          },
          "max_attempts": "int64"
        },
        "vss": {
          "enabled": "bool",
          "provider": "VSSProvider"
        },
        "archive": {
          "name": "string"
        },
        "performance_window": {
          "enabled": "bool"
        },
        "retention": {
          "rules": [
            {
              "backup_set": [
                "RepeatePeriod"
              ],
              // Includes only one of the fields `max_age`, `max_count`
              "max_age": {
                "type": "Type",
                "count": "int64"
              },
              "max_count": "int64"
              // end of the list of possible fields
            }
          ],
          "before_backup": "bool"
        },
        "scheduling": {
          "backup_sets": [
            {
              // Includes only one of the fields `time`, `since_last_exec_time`
              "time": {
                "weekdays": [
                  "Day"
                ],
                "repeat_at": [
                  {
                    "hour": "int64",
                    "minute": "int64"
                  }
                ],
                "repeat_every": {
                  "type": "Type",
                  "count": "int64"
                },
                "time_from": {
                  "hour": "int64",
                  "minute": "int64"
                },
                "time_to": {
                  "hour": "int64",
                  "minute": "int64"
                },
                "monthdays": [
                  "int64"
                ],
                "include_last_day_of_month": "bool",
                "months": [
                  "int64"
                ],
                "type": "RepeatePeriod",
                "run_later": "bool"
              },
              "since_last_exec_time": {
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
          "max_parallel_backups": "int64",
          "rand_max_delay": {
            "type": "Type",
            "count": "int64"
          },
          "scheme": "Scheme",
          "weekly_backup_day": "Day",
          "task_failure": {
            "enabled": "bool",
            "interval": {
              "type": "Type",
              "count": "int64"
            },
            "max_attempts": "int64"
          }
        },
        "cbt": "ChangedBlockTracking",
        "fast_backup_enabled": "bool",
        "quiesce_snapshotting_enabled": "bool",
        "file_filters": {
          "exclusion_masks": [
            "string"
          ],
          "inclusion_masks": [
            "string"
          ]
        },
        "sector_by_sector": "bool",
        "validation_enabled": "bool",
        "lvm_snapshotting_enabled": "bool"
      },
      "folder_id": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| policies[] | **[Policy](#yandex.cloud.backup.v1.Policy)** ||
|#

## Policy {#yandex.cloud.backup.v1.Policy}

#|
||Field | Description ||
|| id | **string**

Required field. Policy ID. ||
|| name | **string**

Required field. Policy name. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| enabled | **bool**

If this field is true, it means that the policy is enabled. ||
|| settings | **[PolicySettings](#yandex.cloud.backup.v1.PolicySettings)**

Set of policy settings ||
|| folder_id | **string**

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

Required field. Format of the Acronis backup archive.

- `FORMAT_UNSPECIFIED`
- `VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.
- `VERSION_12`: A new format recommended in most cases for fast backup and recovery.
- `AUTO`: Automatic version selection. Will be used version 12 unless the protection
plan (policy) appends backups to the ones created by earlier product
versions. ||
|| multi_volume_snapshotting_enabled | **bool**

If true, snapshots of multiple volumes will be taken simultaneously. ||
|| preserve_file_security_settings | **bool**

If true, the file security settings will be preserved.
Deprecated. ||
|| reattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)**

Required field. Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set. ||
|| silent_mode_enabled | **bool**

If true, a user interaction will be avoided when possible. Equals to false if value is not specified. ||
|| splitting | **[Splitting](#yandex.cloud.backup.v1.PolicySettings.Splitting)**

Required field. Determines the size to split backups on. Splitting is not performed if value is not specified. ||
|| vm_snapshot_reattempts | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)**

Required field. Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set. ||
|| vss | **[VolumeShadowCopyServiceSettings](#yandex.cloud.backup.v1.PolicySettings.VolumeShadowCopyServiceSettings)**

Required field. Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used. ||
|| archive | **[ArchiveProperties](#yandex.cloud.backup.v1.PolicySettings.ArchiveProperties)**

The archive properties. ||
|| performance_window | **[PerformanceWindow](#yandex.cloud.backup.v1.PolicySettings.PerformanceWindow)**

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
|| fast_backup_enabled | **bool**

If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup. ||
|| quiesce_snapshotting_enabled | **bool**

If true, a quiesced snapshot of the virtual machine will be taken.
Deprecated. ||
|| file_filters | **[FileFilters](#yandex.cloud.backup.v1.PolicySettings.FileFilters)**

File filters to specify masks of files to backup or to exclude of backuping ||
|| sector_by_sector | **bool**

A sector-by-sector backup of a disk or volume creates a backup copy of all sectors of the disk or volume,
including those that do not contain data.
Therefore, the size of such a backup copy will be equal to the size of the original disk or volume.
This method can be used to back up a disk or volume with an unsupported file system. ||
|| validation_enabled | **bool**

Validation is a time-consuming process, even with incremental or differential backups of small amounts of data.
This is because not only the data physically contained in the backup copy is verified,
but all data restored when it is selected.
This option requires access to previously created backup copies. ||
|| lvm_snapshotting_enabled | **bool**

LVM will be used to create the volume snapshot.
If LVM fails to create a snapshot (for example, because there is not enough free space),
the software will create the snapshot itself. ||
|#

## RetriesConfiguration {#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration}

#|
||Field | Description ||
|| enabled | **bool**

If true, enables retry on errors. ||
|| interval | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Required field. An interval between retry attempts. ||
|| max_attempts | **int64**

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
|| before_backup | **bool**

If true, retention rules will be applied before backup is finished. ||
|#

## RetentionRule {#yandex.cloud.backup.v1.PolicySettings.Retention.RetentionRule}

#|
||Field | Description ||
|| backup_set[] | enum **RepeatePeriod**

A list of backup sets where rules are effective.

- `REPEATE_PERIOD_UNSPECIFIED`
- `HOURLY`
- `DAILY`
- `WEEKLY`
- `MONTHLY` ||
|| max_age | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Includes only one of the fields `max_age`, `max_count`. ||
|| max_count | **int64**

Includes only one of the fields `max_age`, `max_count`. ||
|#

## Scheduling {#yandex.cloud.backup.v1.PolicySettings.Scheduling}

#|
||Field | Description ||
|| backup_sets[] | **[BackupSet](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet)**

A list of schedules with backup sets that compose the whole scheme. ||
|| enabled | **bool**

If true, the backup schedule will be enabled. ||
|| max_parallel_backups | **int64**

Max number of backup processes allowed to run in parallel. Unlimited if not set. ||
|| rand_max_delay | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

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
|| weekly_backup_day | enum **Day**

Required field. A day of week to start weekly backups.

- `DAY_UNSPECIFIED`
- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| task_failure | **[RetriesConfiguration](#yandex.cloud.backup.v1.PolicySettings.RetriesConfiguration)**

Task failure settings in case of failure of scheduled task, not applicable to  manually launched tasks ||
|#

## BackupSet {#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet}

#|
||Field | Description ||
|| time | **[Time](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.Time)**

Includes only one of the fields `time`, `since_last_exec_time`. ||
|| since_last_exec_time | **[SinceLastExecTime](#yandex.cloud.backup.v1.PolicySettings.Scheduling.BackupSet.SinceLastExecTime)**

Includes only one of the fields `time`, `since_last_exec_time`. ||
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
|| repeat_at[] | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)**

Time to repeat the backup. ||
|| repeat_every | **[Interval](#yandex.cloud.backup.v1.PolicySettings.Interval)**

Frequency of backup repetition. ||
|| time_from | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)**

The start time of the backup time interval. ||
|| time_to | **[TimeOfDay](#yandex.cloud.backup.v1.PolicySettings.TimeOfDay)**

The end time of the backup time interval. ||
|| monthdays[] | **int64**

Days in a month to perform a backup.
Allowed values are from 1 to 31. ||
|| include_last_day_of_month | **bool**

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
|| run_later | **bool**

If the machine is off, launch missed tasks on boot up. ||
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

## FileFilters {#yandex.cloud.backup.v1.PolicySettings.FileFilters}

#|
||Field | Description ||
|| exclusion_masks[] | **string**

Do not backup files that match the following criteria ||
|| inclusion_masks[] | **string**

Backup only files that match the following criteria ||
|#