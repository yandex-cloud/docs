* Enter a name. The naming requirements are as follows:

  {% include [name-format](../../_includes/name-format.md) %}

* Select the [type of backup](../../backup/concepts/backup.md#types):
  * `{{ ui-key.yacloud.backup.field_type-incremental }}`: Saves only data that is different from the previous backup. On the first run, a full backup of the resource will be made.
  * `{{ ui-key.yacloud.backup.field_type-full }}`: Saves all VM or {{ baremetal-name }} server data.

* Under **{{ ui-key.yacloud.backup.policy-form.title_schedule-section }}**, specify:
  * **{{ ui-key.yacloud.backup.policy-form.field_backup-periodicity }}**: Select the backup frequency:
      * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-daily }}`. Either once a day at a specified time or several times a day at a particular interval within the specified time period.
      * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-weekly }}`. Select days of the week and time for backups on those days.
      * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-monthly }}`. Specify months, day of the month, and time for backups.

  Backups are created based on the VM's or {{ baremetal-name }} server's local time. There may be a slight delay in the schedule depending on the current service load.

* For incremental backups, you can enable **{{ ui-key.yacloud.backup.policy-form.value_weekly-full-copy }}** and select the day of the week for a full backup. On the selected day, a full backup will be created instead of an incremental one.

* Under **{{ ui-key.yacloud.backup.policy-form.title_retention-section }}**, set the [backup retention](../../backup/concepts/policy.md#retention) policy:
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-all }}`: All backups created under this backup policy will be retained.
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-last-f }}`: Specify the number of recent backups you want to retain or the number of days, weeks, or months for which to retain the backups. All other backups will be deleted automatically.

      {% note info %}

      If you created the policy via the management console, subsequent updates of backup retention settings will take effect only after a next backup is created. If the changes have not taken effect, [disassociate](../../backup/operations/policy-vm/detach-vm.md) the policy from the VM or {{ baremetal-name }} server and then [reassociate](../../backup/operations/policy-vm/attach-and-detach-vm.md) it.

      {% endnote %}

* Under **{{ ui-key.yacloud.backup.policy-form.title_additional-section }}**:

  * Optionally, enable **{{ ui-key.yacloud.backup.policy-form.field_run-later }}** to run all skipped backup jobs after the VM starts if the VM was `Stopped` during the scheduled backup.
  * Optionally, enable **{{ ui-key.yacloud.backup.policy-overview.field_fast-copy }}** to speed up creating incremental backups. Changes in the file will be determined by size, date, and last update time. If the option is disabled, {{ backup-name }} will compare the contents of all files with the backup contents. This option does not work for volumes with JFS, ReiserFS3, ReiserFS4, ReFS, or XFS file systems.
  * Optionally, enable **{{ ui-key.yacloud.backup.policy-form.field_sector-by-sector }}** to create an exact copy of a disk or volume at the physical level. Backs up all disk or volume sectors, including empty areas and unallocated space. If no compression level is selected, the backup size will be equal to the disk size. For disks with unsupported file systems, this mode applies automatically. You cannot recover app data from a backup like that.
  * Optionally, enable **{{ ui-key.yacloud.backup.policy-form.field_validation-enabled }}** to make sure you will be able to restore data from the created backup. During the check, a checksum is calculated for each section available for recovery. The check may take a long time because it scans all recoverable data.
  * Optionally, enable **{{ ui-key.yacloud.backup.policy-overview.field_multivolume-snapshot }}** to create time-synchronized data backups spanning several volumes. This parameter decides whether snapshots of several volumes will be created simultaneously or one after another. Select your preferred method for creating snapshots:

      * `{{ ui-key.yacloud.backup.policy-form.field_lvm-snapshotting-disabled }}`: Snapshot volumes using the {{ backup-name }} agent managed by LVM.
      * `{{ ui-key.yacloud.backup.policy-form.field_lvm-snapshotting-enabled }}`: Snapshot volumes using the built-in LVM tools. If the snapshot cannot be created using LVM, it will be created using the {{ backup-name }} agent.