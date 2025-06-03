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
| `compression` | Backup compression ratio. | <ul><li>`COMPRESSION_UNSPECIFIED`: Not specified.</li><li>`NORMAL`: Standard compression ratio.</li><li>`HIGH`: High compression ratio.</li><li>`MAX`: Maximum compression ratio.</li><li>`OFF`: Disabled.</li></ul> |
| `format` | Backup format. | <ul><li>`FORMAT_UNSPECIFIED`: Not specified.</li><li>`VERSION_11`: Deprecated format, not recommended.</li><li>`VERSION_12`: Recommended format for high-speed backup and recovery.</li><li>`AUTO`: Automatic format selection. Version 12 is used by default unless you are creating incremental backups for the images created in other versions.</li></ul> |
| `multiVolumeSnapshottingEnabled` | Backing up multiple volumes at the same time. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
| `preserveFileSecuritySettings` | Retaining file security settings. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
| `cbt` | Changed Block Tracking (configuration for tracking backup contents). | <ul><li>`CHANGED_BLOCK_TRACKING_UNSPECIFIED`: Not specified.</li><li>`USE_IF_ENABLED`: Use if enabled.</li><li>`ENABLE_AND_USE`: Enable and use.</li><li>`DO_NOT_USE`: Do not use.</li></ul> |
| `fastBackupEnabled` | Fast backup: setting for tracking changes to files. When enabled, file changes are detected by the file size and timestamp. When disabled, files are checked for changes by comparing their contents to backed up files. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
| `quiesceSnapshottingEnabled` | Using `quiescing` when creating backups. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |

Attribute sections with multiple nested values.

{% list tabs %}

- reattempts

  Setting up backup reattempts in the event of failures.

  | Attribute | Description | Possible values |
  |---|---|---|
  | `reattempts.enabled` | Retry creating a backup if a noncritical error occur (e.g., failure to connect to a target disk). | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
  | `reattempts.interval.type` | Unit of time used to set the reattempt interval. | <ul><li>`TYPE_UNSPECIFIED`: Not specified.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
  | `reattempts.interval.count` | Interval between reattempts. | Integer |
  | `reattempts.maxAttempts` | Maximum number of reattempts. If reached, the operation is considered failed. | Integer |
  | `silentModeEnabled` | Silent mode to reduce the number of user interactions wherever possible. Disabled by default. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
  | `splitting.size` | Splitting a backup into volumes of a preset size in bytes. If no value is specified, a backup is saved as a single file. | Integer |

- vmSnapshotReattempts

  Configuring backup reattempts in the event of failure.

  | Attribute | Description | Possible values |
  |---|---|---|
  | `vmSnapshotReattempts.enabled` | Retry creating a backup if errors occur. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
  | `vmSnapshotReattempts.interval.type` | Unit of time used to set the reattempt interval. | <ul><li>`TYPE_UNSPECIFIED`: Not specified.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
  | `vmSnapshotReattempts.interval.count` | Interval between reattempts. | Integer |
  | `vmSnapshotReattempts.maxAttempts` | Maximum number of reattempts. If reached, the operation is considered failed. | Integer |

- vss

  Volume Shadow Copy Service (VSS) setup. The service notifies applications with VSS support of the upcoming backup start. The applications save information from memory to disk, which ensures data integrity during backup.

  | Attribute | Description | Possible values |
  |---|---|---|
  | `vss.enabled` | Enable VSS. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
  | `vss.provider` | Choosing a VSS provider. | <ul><li>`VSS_PROVIDER_UNSPECIFIED`: Not specified.</li><li>`NATIVE`: Native VSS provider.</li><li>`TARGET_SYSTEM_DEFINED`: VSS provider defined in the target system.</li></ul>|
  | `archive.name` | Name of the archive being created. | String that may contain the following variables: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, and `[Virtualization Server Type]`. |
  | `performanceWindow` | Enable a performance window to limit the impact of backups and storage maintenance on performance. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |

- retention

  Setting up rules for storing backups. The `maxAge` and `maxCount` attributes are mutually exclusive, i.e., the use of one makes it impossible to use the other.

  | Attribute | Description | Possible values |
  |---|---|---|
  | `retention.rules.backupSet` | Set of backups for which the retention settings are specified. | String |
  | `retention.rules.maxAge.type` | Setting a backup retention rule to delete outdated backups depending on their age in specified time units. | <ul><li>`TYPE_UNSPECIFIED`: Not specified.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
  | `retention.rules.maxAge.count` | Maximum backup retention period in time units set by the `maxAge.type` attribute. | Integer |
  | `retention.rules.maxCount` | Setting a backup retention rule to delete outdated backups depending on the specified maximum number of stored backups. | Integer |
  | `retention.beforeBackup` | Applying backup retention rules before the end of the backup. When creating a policy by default or via the management console, the `beforeBackup=false` rule is set. The backup retention rule settings will take effect as soon as another backup is created. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |

- scheduling

  Setting up a backup schedule. The `time` (based on preset time) and `sinceLastExecTime` (with preset interval between backups) attributes are mutually exclusive, i.e., the use of one makes it impossible to use the other.

  | Attribute | Description | Possible values |
  |---|---|---|
  | `scheduling.backupSets.time.weekdays` | Days of the week to create backups on. You can specify multiple values separated by commas. | <ul><li>`DAY_UNSPECIFIED`: Not specified.</li><li>`MONDAY`</li><li>`TUESDAY`</li><li>`WEDNESDAY`</li><li>`THURSDAY`</li><li>`FRIDAY`</li><li>`SATURDAY`</li><li>`SUNDAY`</li></ul> |
  | `scheduling.backupSets.time.repeatAt.hour` | Time to repeat backups at: hours. | Integer from 0 to 23 |
  | `scheduling.backupSets.time.repeatAt.minute` | Time to repeat backups at: minutes. | Integer from 0 to 59 |
  | `scheduling.backupSets.time.repeatEvery.type` | Units of time used to set the repeat backup interval. | <ul><li>`TYPE_UNSPECIFIED`: Not specified.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
  | `scheduling.backupSets.time.repeatEvery.count` | Backup reattempt interval in units set by the `repeatEvery.type` attribute. | Integer |
  | `scheduling.backupSets.time.timeFrom.hour` | Start time for the backup interval (from): hours. | Integer from 0 to 23 |
  | `scheduling.backupSets.time.timeFrom.minute` | Start time for the backup interval (from): minutes. | Integer from 0 to 59 |
  | `scheduling.backupSets.time.timeTo.hour` | End time for the backup interval (to): hours. | Integer from 0 to 23 |
  | `scheduling.backupSets.time.timeTo.minute` | End time for the backup interval (to): minutes. | Integer from 0 to 59 |
  | `scheduling.backupSets.time.monthdays` | Day of the month to create backups on. You can specify multiple values separated by commas. | Integer from 1 to 31 |
  | `scheduling.backupSets.time.includeLastDayOfMonth` | Making backups on the last day of each month. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
  | `scheduling.backupSets.time.months` | Months to create backups in. You can specify multiple values separated by commas. | Integer from 1 to 12 |
  | `scheduling.backupSets.time.type` | Backup frequency. | <ul><li>`REPEATE_PERIOD_UNSPECIFIED`: Not specified.</li><li>`HOURLY`</li><li>`DAILY`</li><li>`WEEKLY`</li><li>`MONTHLY`</li></ul> |
  | `scheduling.backupSets.sinceLastExecTime.delay.type` | Units of time used to set the interval between backups. | <ul><li>`TYPE_UNSPECIFIED`: Not specified.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
  | `scheduling.backupSets.sinceLastExecTime.delay.count` | Interval between backups in time units set by the `delay.type` attribute. | Integer |
  | `scheduling.enabled` | Scheduled backup. | <ul><li>`true`: Enabled.</li><li>`false`: Disabled.</li></ul> |
  | `scheduling.maxParallelBackups` | Maximum number of parallel backups; unlimited if no value is specified. | Integer |
  | `scheduling.randMaxDelay.type` | Units of time used to set the maximum delay before running parallel jobs. | <ul><li>`TYPE_UNSPECIFIED`: Not specified.</li><li>`SECONDS`</li><li>`MINUTES`</li><li>`HOURS`</li><li>`DAYS`</li><li>`WEEKS`</li><li>`MONTHS`</li></ul> |
  | `scheduling.randMaxDelay.count` | Maximum delay before running parallel jobs in time units set by the `randMaxDelay.type` attribute. The delay is determined randomly but it may not exceed the value set here. | Integer |
  | `scheduling.scheme` | Backup schedule scheme. | <ul><li>`SCHEME_UNSPECIFIED`: Not specified.</li><li>`SIMPLE`: Simple.</li><li>`ALWAYS_FULL`: Always full.</li><li>`ALWAYS_INCREMENTAL`: Always incremental.</li><li>`WEEKLY_INCREMENTAL`: Create an incremental backup every week.</li><li>`WEEKLY_FULL_DAILY_INCREMENTAL`: Create an incremental backup every day and a full one weekly.</li><li>`CUSTOM`: Custom.</li><li>`CDP`: Continuous Data Protection.</li></ul> |
  | `scheduling.weeklyBackupDay` | Day of the week for the weekly backup. | Integer from 1 to 7 |

{% endlist %}