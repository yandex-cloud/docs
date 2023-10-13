* Enter a name. The naming requirements are as follows:

   {% include [name-format](../../_includes/name-format.md) %}

* In the **{{ ui-key.yacloud.backup.field_repeat-period-type }}** field, select how often backups should be created:
   * `{{ ui-key.yacloud.backup.value_period-time-hourly }}`.
   * `{{ ui-key.yacloud.backup.value_period-time-daily }}`: Specify the time for creating backups.
   * `{{ ui-key.yacloud.backup.value_period-time-weekly }}`: Specify the days of the week and time for creating backups.
   * `{{ ui-key.yacloud.backup.value_period-time-monthly }}`: Specify the months, days of the month, and time for creating backups.
* Select the [type of backup](../../backup/concepts/backup.md#types):
   * `{{ ui-key.yacloud.backup.value_scheme-incremental }}`: Only data that differs from a previous backup is saved.
   * `{{ ui-key.yacloud.backup.value_scheme-full }}`: All VM's data is saved.
* Select the [policy for backup retention](../../backup/concepts/policy.md#retention):
   * `{{ ui-key.yacloud.backup.value_retention-save-all }}`: All backups created under this backup policy are retained.
   * `{{ ui-key.yacloud.backup.value_retention-save-last-f }}`: Set the number of the last backups to retain or the number of days, weeks, or months for which the backups to be retained are created. All other backups are deleted automatically.
