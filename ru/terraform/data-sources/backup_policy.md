---
subcategory: Cloud Backup
---

# yandex_backup_policy (DataSource)

Get information about a Yandex Backup Policy. For more information, see [the official documentation](https://yandex.cloud/docs/backup/concepts/policy).

{% note warning %}

One of `policy_id` or `name` should be specified.

{% endnote %}


{% note warning %}

In case you use `name`, an error will occur if two policies with the same name exist. In this case, rename the policy or use the `policy_id`.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Cloud Backup Policy
//
data "yandex_backup_policy" "my_policy" {
  name = "some_policy_name"
}

output "my_policy_name" {
  value = data.yandex_backup_policy.my_policy.name
}
```

## Arguments & Attributes Reference

- `archive_name` (*Read-Only*) (String). The name of generated archives. Default `[Machine Name]-[Plan ID]-[Unique ID]a`.
- `cbt` (*Read-Only*) (String). Configuration of Changed Block Tracking. Available values are: `USE_IF_ENABLED`, `ENABLED_AND_USE`, `DO_NOT_USE`. Default `DO_NOT_USE`.
- `compression` (*Read-Only*) (String). Archive compression level. Affects CPU. Available values: `NORMAL`, `HIGH`, `MAX`, `OFF`. Default: `NORMAL`.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `enabled` (*Read-Only*) (Bool). If this field is true, it means that the policy is enabled.
- `fast_backup_enabled` (*Read-Only*) (Bool). If true, determines whether a file has changed by the file size and timestamp. Otherwise, the entire file contents are compared to those stored in the backup.
- `file_filters` (*Read-Only*) (List Of Object). File filters to specify masks of files to backup or to exclude of backuping.
  - `exclusion_masks` . 
  - `inclusion_masks` . 
- `folder_id` (*Read-Only*) (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `format` (*Read-Only*) (String). Format of the backup. It's strongly recommend to leave this option empty or `AUTO`. Available values: `AUTO`, `VERSION_11`, `VERSION_12`.
- `id` (String). 
- `lvm_snapshotting_enabled` (*Read-Only*) (Bool). LVM will be used to create the volume snapshot. If LVM fails to create a snapshot (for example, because there is not enough free space), the software will create the snapshot itself. 
- `multi_volume_snapshotting_enabled` (*Read-Only*) (Bool). If true, snapshots of multiple volumes will be taken simultaneously. Default `true`.
- `name` (String). The resource name.
- `performance_window_enabled` (*Read-Only*) (Bool). Time windows for performance limitations of backup. Default `false`.
- `policy_id` (String). ID of the policy.
- `reattempts` (*Read-Only*) (Set Of Object). Amount of reattempts that should be performed while trying to make backup at the host.
  - `enabled` . 
  - `interval` . 
  - `max_attempts` . 
- `retention` (*Read-Only*) (Set Of Object). Retention policy for backups. Allows to setup backups lifecycle.
  - `after_backup` . 
  - `rules` . 
    - `max_age` . 
    - `max_count` . 
    - `repeat_period` . 
- `scheduling` (*Read-Only*) (Set Of Object). Schedule settings for creating backups on the host.
  - `backup_sets` . 
    - `execute_by_interval` . 
    - `execute_by_time` . 
      - `include_last_day_of_month` . 
      - `monthdays` . 
      - `months` . 
      - `repeat_at` . 
      - `repeat_every` . 
      - `run_later` . 
      - `type` . 
      - `weekdays` . 
    - `type` . 
  - `enabled` . 
  - `max_parallel_backups` . 
  - `random_max_delay` . 
  - `scheme` . 
  - `weekly_backup_day` . 
- `sector_by_sector` (*Read-Only*) (Bool). A sector-by-sector backup of a disk or volume creates a backup copy of all sectors of the disk or volume, including those that do not contain data. Therefore, the size of such a backup copy will be equal to the size of the original disk or volume. 
- `silent_mode_enabled` (*Read-Only*) (Bool). If true, a user interaction will be avoided when possible. Default `true`.
- `splitting_bytes` (*Read-Only*) (String). Determines the size to split backups. It's better to leave this option unchanged. Default `9223372036854775807`.
- `updated_at` (*Read-Only*) (String). The update timestamp of the resource.
- `validation_enabled` (*Read-Only*) (Bool). Validation is a time-consuming process, even with incremental or differential backups of small amounts of data. This is because not only the data physically contained in the backup copy is verified, but all data restored when it is selected. This option requires access to previously created backup copies. 
- `vm_snapshot_reattempts` (*Read-Only*) (Set Of Object). Amount of reattempts that should be performed while trying to make snapshot.
  - `enabled` . 
  - `interval` . 
  - `max_attempts` . 
- `vss_provider` (*Read-Only*) (String). Settings for the volume shadow copy service. Available values are: `NATIVE`, `TARGET_SYSTEM_DEFINED`. Default `NATIVE`.


