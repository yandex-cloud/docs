---
editable: false
noIndex: true
---

# yc beta backup policy create

Create a new policy.
For detailed information, please see [Creating a backup policy](/docs/backup/operations/policy-vm/create).

#### Command Usage

Syntax:

`yc beta backup policy create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--folder-id` | `string`

Folder ID. ||
|| `--name` | `string`

Policy name. ||
|| `--settings` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  archive = {
    name = string
  },
  cbt = USE_IF_ENABLED|ENABLE_AND_USE|DO_NOT_USE,
  compression = NORMAL|HIGH|MAX|OFF,
  fast-backup-enabled = boolean,
  file-filters = {
    exclusion-masks = string,...,
    inclusion-masks = string,...
  },
  format = VERSION_11|VERSION_12|AUTO,
  lvm-snapshotting-enabled = boolean,
  multi-volume-snapshotting-enabled = boolean,
  performance-window = {
    enabled = boolean
  },
  pre-post-commands = [
    {
      args = string,
      cmd = string,
      enabled = boolean,
      stop-on-error = boolean,
      type = PRE_COMMAND|POST_COMMAND|PRE_DATA_COMMAND|POST_DATA_COMMAND,
      wait = boolean,
      workdir = string
    }, ...
  ],
  preserve-file-security-settings = boolean,
  quiesce-snapshotting-enabled = boolean,
  reattempts = {
    enabled = boolean,
    interval = {
      count = integer,
      type = SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS
    },
    max-attempts = integer
  },
  retention = {
    before-backup = boolean,
    rules = [
      {
        backup-set = [
          HOURLY|DAILY|WEEKLY|MONTHLY, ...
        ],
        condition = max-age={
          count = integer,
          type = SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS
        } | max-count=integer
      }, ...
    ]
  },
  scheduling = {
    backup-sets = [
      {
        setting = since-last-exec-time={
          delay = {
            count = integer,
            type = SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS
          }
        } | time={
          include-last-day-of-month = boolean,
          monthdays = integer,...,
          months = integer,...,
          repeat-at = [
            {
              hour = integer,
              minute = integer
            }, ...
          ],
          repeat-every = {
            count = integer,
            type = SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS
          },
          run-later = boolean,
          time-from = {
            hour = integer,
            minute = integer
          },
          time-to = {
            hour = integer,
            minute = integer
          },
          type = HOURLY|DAILY|WEEKLY|MONTHLY,
          weekdays = [
            MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY, ...
          ]
        },
        type = TYPE_AUTO|TYPE_FULL|TYPE_INCREMENTAL|TYPE_DIFFERENTIAL
      }, ...
    ],
    enabled = boolean,
    max-parallel-backups = integer,
    rand-max-delay = {
      count = integer,
      type = SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS
    },
    scheme = SIMPLE|ALWAYS_FULL|ALWAYS_INCREMENTAL|WEEKLY_INCREMENTAL|WEEKLY_FULL_DAILY_INCREMENTAL|CUSTOM|CDP,
    task-failure = {
      enabled = boolean,
      interval = {
        count = integer,
        type = SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS
      },
      max-attempts = integer
    },
    weekly-backup-day = MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY
  },
  sector-by-sector = boolean,
  silent-mode-enabled = boolean,
  splitting = {
    size = integer
  },
  validation-enabled = boolean,
  vm-snapshot-reattempts = {
    enabled = boolean,
    interval = {
      count = integer,
      type = SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS
    },
    max-attempts = integer
  },
  vss = {
    enabled = boolean,
    provider = NATIVE|TARGET_SYSTEM_DEFINED
  }
}
```

JSON Syntax:

```json
{
  "archive": {
    "name": "string"
  },
  "cbt": "USE_IF_ENABLED|ENABLE_AND_USE|DO_NOT_USE",
  "compression": "NORMAL|HIGH|MAX|OFF",
  "fast-backup-enabled": "boolean",
  "file-filters": {
    "exclusion-masks": [
      "string", ...
    ],
    "inclusion-masks": [
      "string", ...
    ]
  },
  "format": "VERSION_11|VERSION_12|AUTO",
  "lvm-snapshotting-enabled": "boolean",
  "multi-volume-snapshotting-enabled": "boolean",
  "performance-window": {
    "enabled": "boolean"
  },
  "pre-post-commands": [
    {
      "args": "string",
      "cmd": "string",
      "enabled": "boolean",
      "stop-on-error": "boolean",
      "type": "PRE_COMMAND|POST_COMMAND|PRE_DATA_COMMAND|POST_DATA_COMMAND",
      "wait": "boolean",
      "workdir": "string"
    }, ...
  ],
  "preserve-file-security-settings": "boolean",
  "quiesce-snapshotting-enabled": "boolean",
  "reattempts": {
    "enabled": "boolean",
    "interval": {
      "count": "integer",
      "type": "SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS"
    },
    "max-attempts": "integer"
  },
  "retention": {
    "before-backup": "boolean",
    "rules": [
      {
        "backup-set": [
          "HOURLY|DAILY|WEEKLY|MONTHLY", ...
        ],
        "condition": {
          "max-age": {
            "count": "integer",
            "type": "SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS"
          },
          "max-count": "integer"
        }
      }, ...
    ]
  },
  "scheduling": {
    "backup-sets": [
      {
        "setting": {
          "since-last-exec-time": {
            "delay": {
              "count": "integer",
              "type": "SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS"
            }
          },
          "time": {
            "include-last-day-of-month": "boolean",
            "monthdays": [
              "integer", ...
            ],
            "months": [
              "integer", ...
            ],
            "repeat-at": [
              {
                "hour": "integer",
                "minute": "integer"
              }, ...
            ],
            "repeat-every": {
              "count": "integer",
              "type": "SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS"
            },
            "run-later": "boolean",
            "time-from": {
              "hour": "integer",
              "minute": "integer"
            },
            "time-to": {
              "hour": "integer",
              "minute": "integer"
            },
            "type": "HOURLY|DAILY|WEEKLY|MONTHLY",
            "weekdays": [
              "MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY", ...
            ]
          }
        },
        "type": "TYPE_AUTO|TYPE_FULL|TYPE_INCREMENTAL|TYPE_DIFFERENTIAL"
      }, ...
    ],
    "enabled": "boolean",
    "max-parallel-backups": "integer",
    "rand-max-delay": {
      "count": "integer",
      "type": "SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS"
    },
    "scheme": "SIMPLE|ALWAYS_FULL|ALWAYS_INCREMENTAL|WEEKLY_INCREMENTAL|WEEKLY_FULL_DAILY_INCREMENTAL|CUSTOM|CDP",
    "task-failure": {
      "enabled": "boolean",
      "interval": {
        "count": "integer",
        "type": "SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS"
      },
      "max-attempts": "integer"
    },
    "weekly-backup-day": "MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY"
  },
  "sector-by-sector": "boolean",
  "silent-mode-enabled": "boolean",
  "splitting": {
    "size": "integer"
  },
  "validation-enabled": "boolean",
  "vm-snapshot-reattempts": {
    "enabled": "boolean",
    "interval": {
      "count": "integer",
      "type": "SECONDS|MINUTES|HOURS|DAYS|WEEKS|MONTHS"
    },
    "max-attempts": "integer"
  },
  "vss": {
    "enabled": "boolean",
    "provider": "NATIVE|TARGET_SYSTEM_DEFINED"
  }
}
```

Fields:

```
archive -> (struct)
  The archive properties.
  name -> (string)
    The name of the generated archive. The name may use the following variables: '[Machine Name]', '[Plan ID]', '[Plan Name]', '[Unique ID]', '[Virtualization Server Type]'. Default value: '[Machine Name]-[Plan ID]-[Unique ID]A'.
cbt -> (struct)
  A configuration of Changed Block Tracking (CBT).
compression -> (struct)
  Archive compression level.
fast-backup-enabled -> (boolean)
  If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup.
file-filters -> (struct)
  File filters to specify masks of files to backup or to exclude of backuping
  exclusion-masks -> ([]string)
    Do not backup files that match the following criteria
  inclusion-masks -> ([]string)
    Backup only files that match the following criteria
format -> (struct)
  Format of the Acronis backup archive.
lvm-snapshotting-enabled -> (boolean)
  LVM will be used to create the volume snapshot. If LVM fails to create a snapshot (for example, because there is not enough free space), the software will create the snapshot itself.
multi-volume-snapshotting-enabled -> (boolean)
  If true, snapshots of multiple volumes will be taken simultaneously.
performance-window -> (struct)
  Time windows for performance limitations of backup and storage maintenance operations.
  enabled -> (boolean)
    If true, the time windows will be enabled.
pre-post-commands -> ([]struct)
  Commands to launch before or after backup execution
  args -> (string)
    Command args
  cmd -> (string)
    Command to execute
  enabled -> (boolean)
    Is command enabled
  stop-on-error -> (boolean)
    Stop backup execution on error
  type -> (struct)
    Type of command: pre or post
  wait -> (boolean)
    Wait command finish before launching backup
  workdir -> (string)
    Workdir for command execution
preserve-file-security-settings -> (boolean)
  If true, the file security settings will be preserved. Deprecated.
quiesce-snapshotting-enabled -> (boolean)
  If true, a quiesced snapshot of the virtual machine will be taken. Deprecated.
reattempts -> (struct)
  Configuration of retries on recoverable errors during the backup operations like reconnection to destination. No attempts to fix recoverable errors will be made if retry configuration is not set.
  enabled -> (boolean)
    If true, enables retry on errors.
  interval -> (struct)
    An interval between retry attempts.
    count -> (integer)
      The amount of value specified in 'Interval.Type'.
    type -> (struct)
      A type of the interval.
  max-attempts -> (integer)
    Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached.
retention -> (struct)
  Configuration of backup retention rules.
  before-backup -> (boolean)
    If true, retention rules will be applied before backup is finished.
  rules -> ([]struct)
    A list of retention rules.
    backup-set -> ([]struct)
      A list of backup sets where rules are effective.
    condition -> (oneof<max-age|max-count>)
      Oneof condition field
      max-age -> (struct)
        count -> (integer)
          The amount of value specified in 'Interval.Type'.
        type -> (struct)
          A type of the interval.
      max-count -> (integer)
scheduling -> (struct)
  Configuration of the backup schedule.
  backup-sets -> ([]struct)
    A list of schedules with backup sets that compose the whole scheme.
    type -> (struct)
      BackupSet type -- one of incr, full, differential or auto. if custom scheme is used the BackupSet type should be specified
    setting -> (oneof<since-last-exec-time|time>)
      Oneof setting field
      time -> (struct)
        include-last-day-of-month -> (boolean)
          If set to true, last day of month will activate the policy.
        monthdays -> ([]integer)
          Days in a month to perform a backup. Allowed values are from 1 to 31.
        months -> ([]integer)
          Set of values. Allowed values form 1 to 12.
        repeat-at -> ([]struct)
          Time to repeat the backup.
          hour -> (integer)
            Hours.
          minute -> (integer)
            Minutes.
        repeat-every -> (struct)
          Frequency of backup repetition.
          count -> (integer)
            The amount of value specified in 'Interval.Type'.
          type -> (struct)
            A type of the interval.
        run-later -> (boolean)
          If the machine is off, launch missed tasks on boot up.
        time-from -> (struct)
          The start time of the backup time interval.
          hour -> (integer)
            Hours.
          minute -> (integer)
            Minutes.
        time-to -> (struct)
          The end time of the backup time interval.
          hour -> (integer)
            Hours.
          minute -> (integer)
            Minutes.
        type -> (struct)
          Possible types: 'REPEATE_PERIOD_UNSPECIFIED', 'HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY'.
        weekdays -> ([]struct)
          Days in a week to perform a backup.
      since-last-exec-time -> (struct)
        delay -> (struct)
          The interval between backups.
          count -> (integer)
            The amount of value specified in 'Interval.Type'.
          type -> (struct)
            A type of the interval.
  enabled -> (boolean)
    If true, the backup schedule will be enabled.
  max-parallel-backups -> (integer)
    Max number of backup processes allowed to run in parallel. Unlimited if not set.
  rand-max-delay -> (struct)
    Configuration of the random delay between the execution of parallel tasks.
    count -> (integer)
      The amount of value specified in 'Interval.Type'.
    type -> (struct)
      A type of the interval.
  scheme -> (struct)
    A backup scheme. Available values: 'simple', 'always_full', 'always_incremental', 'weekly_incremental', 'weekly_full_daily_incremental', 'custom', 'cdp'.
  task-failure -> (struct)
    Task failure settings in case of failure of scheduled task, not applicable to manually launched tasks
    enabled -> (boolean)
      If true, enables retry on errors.
    interval -> (struct)
      An interval between retry attempts.
      count -> (integer)
        The amount of value specified in 'Interval.Type'.
      type -> (struct)
        A type of the interval.
    max-attempts -> (integer)
      Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached.
  weekly-backup-day -> (struct)
    A day of week to start weekly backups.
sector-by-sector -> (boolean)
  A sector-by-sector backup of a disk or volume creates a backup copy of all sectors of the disk or volume, including those that do not contain data. Therefore, the size of such a backup copy will be equal to the size of the original disk or volume. This method can be used to back up a disk or volume with an unsupported file system.
silent-mode-enabled -> (boolean)
  If true, a user interaction will be avoided when possible. Equals to false if value is not specified.
splitting -> (struct)
  Determines the size to split backups on. Splitting is not performed if value is not specified.
  size -> (integer)
    The size of split backup file in bytes.
validation-enabled -> (boolean)
  Validation is a time-consuming process, even with incremental or differential backups of small amounts of data. This is because not only the data physically contained in the backup copy is verified, but all data restored when it is selected. This option requires access to previously created backup copies.
vm-snapshot-reattempts -> (struct)
  Configuration of retries on errors during the creation of the virtual machine snapshot. No attempts to fix recoverable errors will be made if retry configuration is not set.
  enabled -> (boolean)
    If true, enables retry on errors.
  interval -> (struct)
    An interval between retry attempts.
    count -> (integer)
      The amount of value specified in 'Interval.Type'.
    type -> (struct)
      A type of the interval.
  max-attempts -> (integer)
    Max number of retry attempts. Operation will be considered as failed when max number of retry attempts is reached.
vss -> (struct)
  Settings for the Volume Shadow Copy Service (VSS) provider. If not set, no VSS provider is used.
  enabled -> (boolean)
    If true, the VSS will be enabled.
  provider -> (struct)
    A type of VSS provider to use in backup.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#