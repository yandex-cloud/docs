* Enter a name. The naming requirements are as follows:

  {% include [name-format](../../_includes/name-format.md) %}

* Select the [type of backup](../../backup/concepts/backup.md#types):
  * `{{ ui-key.yacloud.backup.field_type-incremental }}`: Saves only data that is different from the previous backup. On the first run, a full backup of the resource will be made.
  * `{{ ui-key.yacloud.backup.field_type-full }}`: Saves all VM or {{ baremetal-name }} server data.

* Under **{{ ui-key.yacloud.backup.policy-form.title_schedule-section }}**, specify:
  * **{{ ui-key.yacloud.backup.policy-form.field_backup-periodicity }}**: Select the backup frequency:
      *  `{{ ui-key.yacloud.backup.policy-form.value_periodicity-daily }}`. Either once a day at a specified time or several times a day at a particular interval within the specified time period.
      * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-weekly }}`. Select days of the week and time for backups on those days.
      * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-monthly }}`. Specify the months, day of the month, and time for backups.

  Backups are created based on the VM's or {{ baremetal-name }} server's local time. There may be a slight delay in the schedule depending on the current service load.

* For incremental backups, you can enable **{{ ui-key.yacloud.backup.policy-form.value_weekly-full-copy }}** and select the day of the week for the full backup. On the selected day, a full backup will be created instead of an incremental one.

* Under **{{ ui-key.yacloud.backup.policy-form.title_retention-section }}**, set the [backup retention](../../backup/concepts/policy.md#retention) policy:
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-all }}`: All backups created under this backup policy will be retained.
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-last-f }}`: Specify the number of recent backups you want to retain or the number of days, weeks, or months for which to retain the backups. All other backups are deleted automatically.

      {% note info %}

      If your policy is created via the management console, subsequent updates of backup retention settings will take effect only after you create another backup. If the changes have not taken effect, [detach](../../backup/operations/policy-vm/detach-vm.md) the policy from the VM or {{ baremetal-name }} server and then [reattach](../../backup/operations/policy-vm/attach-and-detach-vm.md) it.

      {% endnote %}

* Under **{{ ui-key.yacloud.backup.policy-form.title_additional-section }}**:

  * Optionally, enable **{{ ui-key.yacloud.backup.policy-overview.field_fast-copy }}** to accelerate creating incremental backups. The presence of changes in the file will be determined by size, date, and last update time. If the option is disabled, {{ backup-name }} will compare the contents of all files with the backup contents. This option does not work for volumes with JFS, ReiserFS3, ReiserFS4, ReFS, or XFS file systems.

  * Optionally, enable **{{ ui-key.yacloud.backup.policy-overview.field_multivolume-snapshot }}** to create time-synchronized data backups spanning several volumes. This parameter decides whether snapshots of several volumes will be created simultaneously or one after another.
