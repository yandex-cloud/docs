```json
{
  "compression": "string",
  "format": "string",
  "multiVolumeSnapshottingEnabled": bool,
  "preserveFileSecuritySettings": bool,
  "reattempts": {
    "enabled": bool,
    "interval": {
      "type": "string",
      "count": "string"
    },
    "maxAttempts": "string"
  },
  "silentModeEnabled": bool,
  "splitting": {
    "size": "string"
  },
  "vmSnapshotReattempts": {
    "enabled": bool,
    "interval": {
      "type": "string",
      "count": "string"
    },
    "maxAttempts": "string"
  },
  "vss": {
    "enabled": bool,
    "provider": "string"
  },
  "archive": {
    "name": "string"
  },
  "performanceWindow": {
    "enabled": bool
  },
  "retention": {
    "rules": [
      {
        "backupSet": [
          "string"
        ],
        "maxAge": {
          "type": "string",
          "count": "string"
        },
        "maxCount": "string",
      }
    ],
    "beforeBackup": bool
  },
  "scheduling": {
    "backupSets": [
      {
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
          "includeLastDayOfMonth": bool,
          "months": [
            "string"
          ],
          "type": "string"
        },
        "sinceLastExecTime": {
          "delay": {
            "type": "string",
            "count": "string"
          }
        },
      }
    ],
    "enabled": bool,
    "maxParallelBackups": "string",
    "randMaxDelay": {
      "type": "string",
      "count": "string"
    },
    "scheme": "string",
    "weeklyBackupDay": "string"
  },
  "cbt": "string",
  "fastBackupEnabled": bool,
  "quiesceSnapshottingEnabled": bool
}
```

Specification description:

| Attribute | Description | Possible values |
|---|---|---|
| `compression` | Backup compression ratio. | <ul><li>`COMPRESSION_UNSPECIFIED`: Not set.</li><li>`NORMAL`: Standard compression.</li><li>`HIGH`: High compression ratio.</li><li>`MAX`: Maximum compression.</li><li>`OFF`: Disabled.</li></ul> |
| `format` | Backup format. | <ul><li>`FORMAT_UNSPECIFIED`: Not set.</li><li>`VERSION_11`: Outdated format, not recommended.</li><li>`VERSION_12`: Recommended format for fast backup and recovery.</li><li>`AUTO`: Automatic format selection. Defaults to version 12. The exception is creating incremental backups for images created in other versions.</li></ul> |
| `multiVolumeSnapshottingEnabled` | Making snapshots of multiple volumes at the same time. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
| `preserveFileSecuritySettings` | Preserving file security settings. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
| `cbt` | Changed Block Tracking (configuration for tracking backup contents). | <ul><li>`CHANGED_BLOCK_TRACKING_UNSPECIFIED`: Not set.</li><li>`USE_IF_ENABLED`: Use if enabled.</li><li>`ENABLE_AND_USE`: Enable and use.</li><li>`DO_NOT_USE`: Do not use.</li></ul> |
| `fastBackupEnabled` | Fast backup: Setting for tracking changes to files. When enabled, file changes are detected by the file's size and timestamp. When disabled, files are checked for changes by comparing their contents to backed up files. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
| `quiesceSnapshottingEnabled` | Using `quiescing` mode when creating snapshots. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |

Attribute sections with multiple nested values.

{% list tabs %}

- reattempts

   Setting up backup reattempts in the event of failures.

   | Attribute | Description | Possible values |
   |---|---|---|
   | `reattempts.enabled` | Retry creating a backup if noncritical errors occur (for example, when failing to connect to a target disk). | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
   | `reattempts.interval.type` | Unit of time used to set the reattempt interval. | <ul><li>`TYPE_UNSPECIFIED`: Not set.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
   | `reattempts.interval.count` | Duration of the interval between reattempts. | Integer. |
   | `reattempts.maxAttempts` | Maximum number of reattempts. If reached, the operation is considered failed. | Integer. |
   | `silentModeEnabled` | Silent mode. Reduces the amount of interactions with users whenever possible. Disabled by default. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
   | `splitting.size` | Splitting a backup into volumes of a preset size in bytes. If no value is specified, a backup is saved as a single file. | Integer. |

- vmSnapshotReattempts

   Setting up snapshot creation reattempts in the event of failures.

   | Attribute | Description | Possible values |
   |---|---|---|
   | `vmSnapshotReattempts.enabled` | Retry creating a VM snapshot if an error occurs. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
   | `vmSnapshotReattempts.interval.type` | Unit of time used to set the reattempt interval. | <ul><li>`TYPE_UNSPECIFIED`: Not set.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
   | `vmSnapshotReattempts.interval.count` | Duration of the interval between reattempts. | Integer. |
   | `vmSnapshotReattempts.maxAttempts` | Maximum number of reattempts. If reached, the operation is considered failed. | Integer. |

- vss

   Volume Shadow Copy Service (VSS) setup. The service notifies applications with VSS support of the upcoming backup start. The applications save information from memory to disk, which ensures data integrity during backup.

   | Attribute | Description | Possible values |
   |---|---|---|
   | `vss.enabled` | Enable VSS. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
   | `vss.provider` | Choosing a VSS provider. | <ul><li>`VSS_PROVIDER_UNSPECIFIED`: Not set.</li><li>`NATIVE`: Native VSS provider.</li><li>`TARGET_SYSTEM_DEFINED`: VSS provider defined in the target system.</li></ul> |
   | `archive.name` | Name of the archive being created. | Line. May contain variables such as `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, and `[Virtualization Server Type]`. |
   | `performanceWindow` | Enable a performance window to limit the impact of backups and storage maintenance on performance. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |

- retention

   Setting up rules for storing backups. The `maxAge` and `maxCount` attributes are mutually exclusive. Using one of them disables the use of the other.

   | Attribute | Description | Possible values |
   |---|---|---|
   | `retention.rules.backupSet` | A set of backups for which the retention settings are specified. | Line. |
   | `retention.rules.maxAge.type` | Set a backup retention rule to delete outdated backups depending on their age in specified time units. | <ul><li>`TYPE_UNSPECIFIED`: Not set.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
   | `retention.rules.maxAge.count` | Maximum backup retention period in time units set by the `maxAge.type` attribute. | Integer |
   | `retention.rules.maxCount` | Set a backup retention rule to delete outdated backups depending on the specified maximum number of stored backups. | Integer |
   | `retention.beforeBackup` | Apply backup retention rules before the end of backup. When creating a policy by default or via the management console, the `beforeBackup=false` rule is set. The backup retention rule settings will take effect as soon as another backup is created. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |

- scheduling

   Setting up a backup schedule. The `time` (using the preset time) and `sinceLastExecTime` (with the preset interval between backups) attributes are mutually exclusive. Using one of them disables the use of the other.

   | Attribute | Description | Possible values |
   |---|---|---|
   | `scheduling.backupSets.time.weekdays` | Days of the week to make backups on. You can specify multiple values separated by commas. | <ul><li>`DAY_UNSPECIFIED`: Not set.</li><li>`MONDAY`</li><li>`TUESDAY`</li><li>`WEDNESDAY`</li><li>`THURSDAY`</li><li>`FRIDAY`</li><li>`SATURDAY`</li><li>`SUNDAY`</li></ul> |
   | `scheduling.backupSets.time.repeatAt.hour` | Time to repeat backups at: hours. | Integer from 0 to 23. |
   | `scheduling.backupSets.time.repeatAt.minute` | Time to repeat backups at: minutes. | Integer from 0 to 59. |
   | `scheduling.backupSets.time.repeatEvery.type` | Units of time used to set the repeat backup interval. | <ul><li>`TYPE_UNSPECIFIED`: Not set.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
   | `scheduling.backupSets.time.repeatEvery.count` | Repeat backup interval in time units set by the `repeatEvery.type` attribute. | Integer. |
   | `scheduling.backupSets.time.timeFrom.hour` | Start time for the backup interval (from): hours. | Integer from 0 to 23. |
   | `scheduling.backupSets.time.timeFrom.minute` | Start time for the backup interval (from): minutes. | Integer from 0 to 59. |
   | `scheduling.backupSets.time.timeTo.hour` | End time for the backup interval (to): hours. | Integer from 0 to 23. |
   | `scheduling.backupSets.time.timeTo.minute` | End time for the backup interval (to): minutes. | Integer from 0 to 59. |
   | `scheduling.backupSets.time.monthdays` | Day of the month to make backups on. You can specify multiple values separated by commas. | Integer from 1 to 31. |
   | `scheduling.backupSets.time.includeLastDayOfMonth` | Making backups on the last day of each month. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
   | `scheduling.backupSets.time.months` | Months to make backups in. You can specify multiple values separated by commas. | Integer from 1 to 12. |
   | `scheduling.backupSets.time.type` | Backup frequency. | <ul><li>`REPEATE_PERIOD_UNSPECIFIED`: Not set.</li><li>`HOURLY`: Every hour.</li><li>`DAILY`: Every day.</li><li>`WEEKLY`: Every week.</li><li>`MONTHLY`: Every month.</li></ul> |
   | `scheduling.backupSets.sinceLastExecTime.delay.type` | Units of time used to set the interval between backups. | <ul><li>`TYPE_UNSPECIFIED`: Not set.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
   | `scheduling.backupSets.sinceLastExecTime.delay.count` | Duration of the interval between backups in time units set by the `delay.type` attribute. | Integer. |
   | `scheduling.enabled` | Making scheduled backups. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
   | `scheduling.maxParallelBackups` | Maximum number of parallel backups allowed. Unlimited if no value is specified. | Integer. |
   | `scheduling.randMaxDelay.type` | Units of time used to set the maximum delay before running parallel jobs. | <ul><li>`TYPE_UNSPECIFIED`: Not set.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
   | `scheduling.randMaxDelay.count` | Value of the maximum delay before running parallel jobs in time units set by the `randMaxDelay.type` attribute. The delay is determined randomly but it may not exceed the value set here. | Integer. |
   | `scheduling.scheme` | Backup schedule scheme. | <ul><li>`SCHEME_UNSPECIFIED`: Not set.</li><li>`SIMPLE`: Simple.</li><li>`ALWAYS_FULL`: Always full.</li><li>`ALWAYS_INCREMENTAL`: Always incremental.</li><li>`WEEKLY_INCREMENTAL`: Weekly: incremental.</li><li>`WEEKLY_FULL_DAILY_INCREMENTAL`: Weekly: full; daily: incremental.</li><li>`CUSTOM`: User-defined.</li><li>`CDP`: Continuous Data Protection.</li></ul> |
   | `scheduling.weeklyBackupDay` | Day of the week to make weekly backups on. | Integer from 1 to 7. |

{% endlist %}