---
subcategory: Cloud Backup
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/backup_policy.md
---

# yandex_backup_policy (Resource)

Allows management of [Yandex Cloud Backup Policy](https://yandex.cloud/docs/backup/concepts/policy).

{% note warning %}

Cloud Backup Provider must be activated in order to manipulate with policies. Active it either by UI Console or by `yc` command.

{% endnote %}


## Defined types

### interval_type

 A string type, that accepts values in the format of: `number` + `time type`, where `time type` might be:
* `s` — seconds
* `m` — minutes
* `h` — hours
* `d` — days
* `w` — weekdays
* `M` — months

Example of interval value: `5m`, `10d`, `2M`, `5w`

### day_type

A string type, that accepts the following values: `ALWAYS_INCREMENTAL`, `ALWAYS_FULL`, `WEEKLY_FULL_DAILY_INCREMENTAL`, `WEEKLY_INCREMENTAL`.

### backup_set_type

`TYPE_AUTO`, `TYPE_FULL`, `TYPE_INCREMENTAL`, `TYPE_DIFFERENTIAL`.

## Example usage

```terraform
//
// Create a new basic Cloud Backup Policy
//
resource "yandex_backup_policy" "basic_policy" {
  name = "basic policy"

  scheduling {
    enabled = false
    backup_sets {
      execute_by_interval = 86400
    }
  }

  retention {
    after_backup = false
  }

  reattempts {}

  vm_snapshot_reattempts {}
}
```
```terraform
//
// Create a new full Cloud Backup Policy
//
resource "yandex_backup_policy" "my_policy" {
  archive_name                      = "[Machine Name]-[Plan ID]-[Unique ID]a"
  cbt                               = "USE_IF_ENABLED"
  compression                       = "NORMAL"
  fast_backup_enabled               = true
  format                            = "AUTO"
  multi_volume_snapshotting_enabled = true
  name                              = "example_name"
  performance_window_enabled        = true
  preserve_file_security_settings   = true
  quiesce_snapshotting_enabled      = true
  silent_mode_enabled               = true
  splitting_bytes                   = "9223372036854775807"
  vss_provider                      = "NATIVE"

  reattempts {
    enabled      = true
    interval     = "1m"
    max_attempts = 10
  }

  retention {
    after_backup = false

    rules {
      max_age       = "365d"
      repeat_period = []
    }
  }

  scheduling {
    enabled              = false
    max_parallel_backups = 0
    random_max_delay     = "30m"
    scheme               = "ALWAYS_INCREMENTAL"
    weekly_backup_day    = "MONDAY"


    backup_sets {
      execute_by_time {
        include_last_day_of_month = true
        monthdays                 = []
        months                    = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        repeat_at                 = ["04:10"]
        repeat_every              = "30m"
        type                      = "MONTHLY"
        weekdays                  = []
      }
    }
  }

  vm_snapshot_reattempts {
    enabled      = true
    interval     = "1m"
    max_attempts = 10
  }
}
```

## Arguments & Attributes Reference

- `archive_name` (String). The name of generated archives. Default `[Machine Name]-[Plan ID]-[Unique ID]a`.
- `cbt` (String). Configuration of Changed Block Tracking. Available values are: `USE_IF_ENABLED`, `ENABLED_AND_USE`, `DO_NOT_USE`. Default `DO_NOT_USE`.
- `compression` (String). Archive compression level. Affects CPU. Available values: `NORMAL`, `HIGH`, `MAX`, `OFF`. Default: `NORMAL`.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `enabled` (*Read-Only*) (Bool). If this field is true, it means that the policy is enabled.
- `fast_backup_enabled` (Bool). If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `format` (String). Format of the backup. It's strongly recommend to leave this option empty or `AUTO`. Available values: `AUTO`, `VERSION_11`, `VERSION_12`.
- `id` (String). 
- `lvm_snapshotting_enabled` (Bool). LVM will be used to create the volume snapshot. If LVM fails to create a snapshot (for example, because there is not enough free space), the software will create the snapshot itself. 
- `multi_volume_snapshotting_enabled` (Bool). If true, snapshots of multiple volumes will be taken simultaneously. Default `true`.
- `name` (**Required**)(String). The resource name.
- `performance_window_enabled` (Bool). Time windows for performance limitations of backup. Default `false`.
- `preserve_file_security_settings` (Bool). If true, a quiesced snapshot of the virtual machine will be taken. Default `true`.
- `quiesce_snapshotting_enabled` (Bool). If true, a quiesced snapshot of the virtual machine will be taken. Default `true`.
- `sector_by_sector` (Bool). A sector-by-sector backup of a disk or volume creates a backup copy of all sectors of the disk or volume, including those that do not contain data. Therefore, the size of such a backup copy will be equal to the size of the original disk or volume. 
- `silent_mode_enabled` (Bool). If true, a user interaction will be avoided when possible. Default `true`.
- `splitting_bytes` (String). Determines the size to split backups. It's better to leave this option unchanged. Default `9223372036854775807`.
- `updated_at` (*Read-Only*) (String). The update timestamp of the resource.
- `validation_enabled` (Bool). Validation is a time-consuming process, even with incremental or differential backups of small amounts of data. This is because not only the data physically contained in the backup copy is verified, but all data restored when it is selected. This option requires access to previously created backup copies. 
- `vss_provider` (String). Settings for the volume shadow copy service. Available values are: `NATIVE`, `TARGET_SYSTEM_DEFINED`. Default `NATIVE`.
- `file_filters` [Block]. File filters to specify masks of files to backup or to exclude of backuping.
  - `exclusion_masks` (List Of String). Do not backup files that match the following criteria.
  - `inclusion_masks` (List Of String). Backup only files that match the following criteria.
- `reattempts` [Block]. Amount of reattempts that should be performed while trying to make backup at the host.
  - `enabled` (Bool). Enable flag. Default `true`.
  - `interval` (String). Retry interval. See `interval_type` for available values. Default: `5m`.
  - `max_attempts` (Number). Maximum number of attempts before throwing an error. Default `5`.
- `retention` [Block]. Retention policy for backups. Allows to setup backups lifecycle.
  - `after_backup` (Bool). Defines whether retention rule applies after creating backup or before.
  - `rules` [Block]. A list of retention rules.
    - `max_age` (String). Deletes backups that older than `max_age`. Exactly one of `max_count` or `max_age` should be set.
    - `max_count` (Number). Deletes backups if it's count exceeds `max_count`. Exactly one of `max_count` or `max_age` should be set.
    - `repeat_period` (List Of String). Possible types: `REPEATE_PERIOD_UNSPECIFIED`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`. Specifies repeat period of the backupset.
- `scheduling` [Block]. Schedule settings for creating backups on the host.
  - `enabled` (Bool). Enables or disables scheduling. Default `true`.
  - `execute_by_interval` (Number).  Perform backup by interval, since last backup of the host. Maximum value is: 9999 days. See `interval_type` for available values. Exactly on of options should be set: `execute_by_interval` or `execute_by_time`.
  - `max_parallel_backups` (Number). Maximum number of backup processes allowed to run in parallel. 0 for unlimited. Default `0`.
  - `random_max_delay` (String). Configuration of the random delay between the execution of parallel tasks. See `interval_type` for available values. Default `30m`.
  - `scheme` (String). Scheme of the backups. Available values are: `ALWAYS_INCREMENTAL`, `ALWAYS_FULL`, `WEEKLY_FULL_DAILY_INCREMENTAL`, `WEEKLY_INCREMENTAL`. Default `ALWAYS_INCREMENTAL`.
  - `weekly_backup_day` (String). A day of week to start weekly backups. See `day_type` for available values. Default `MONDAY`.
  - `backup_sets` [Block]. A list of schedules with backup sets that compose the whole scheme.
    - `execute_by_interval` (Number). Perform backup by interval, since last backup of the host. Maximum value is: 9999 days. See `interval_type` for available values. Exactly on of options should be set: `execute_by_interval` or `execute_by_time`.
    - `type` (String). BackupSet type. See `backup_set_type` for available values. Default `TYPE_AUTO`.
    - `execute_by_time` [Block]. Perform backup periodically at specific time. Exactly on of options should be set: `execute_by_interval` or `execute_by_time`.
      - `include_last_day_of_month` (Bool). If true, schedule will be applied on the last day of month. See `day_type` for available values. Default `false`.
      - `monthdays` (List Of Number). List of days when schedule applies. Used in `MONTHLY` type.
      - `months` (List Of Number). Set of values. Allowed values form 1 to 12.
      - `repeat_at` (List Of String). List of time in format `HH:MM` (24-hours format), when the schedule applies.
      - `repeat_every` (String). Frequency of backup repetition. See `interval_type` for available values.
      - `run_later` (Bool). If true and if the machine is off, launch missed tasks on boot up. Default `false`.
      - `type` (**Required**)(String). Type of the scheduling. Available values are: `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`.
      - `weekdays` (List Of String). List of weekdays when the backup will be applied. Used in `WEEKLY` type.
  - `execute_by_time` [Block]. Perform backup periodically at specific time. Exactly on of options should be set: `execute_by_interval` or `execute_by_time`.
    - `include_last_day_of_month` (Bool). If true, schedule will be applied on the last day of month. See `day_type` for available values. Default `false`.
    - `monthdays` (List Of Number). List of days when schedule applies. Used in `MONTHLY` type.
    - `months` (List Of Number). Set of values. Allowed values form 1 to 12.
    - `repeat_at` (List Of String). List of time in format `HH:MM` (24-hours format), when the schedule applies.
    - `repeat_every` (String). Frequency of backup repetition. See `interval_type` for available values.
    - `run_later` (Bool). If true and if the machine is off, launch missed tasks on boot up. Default `false`.
    - `type` (**Required**)(String). Type of the scheduling. Available values are: `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`.
    - `weekdays` (List Of String). List of weekdays when the backup will be applied. Used in `WEEKLY` type.
- `vm_snapshot_reattempts` [Block]. Amount of reattempts that should be performed while trying to make snapshot.
  - `enabled` (Bool). Enable flag. Default `true`.
  - `interval` (String). Retry interval. See `interval_type` for available values. Default: `5m`.
  - `max_attempts` (Number). Maximum number of attempts before throwing an error. Default `5`.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_backup_policy.<resource Name> <Resource Id>
terraform import yandex_backup_policy.my_backup_policy ...
```
