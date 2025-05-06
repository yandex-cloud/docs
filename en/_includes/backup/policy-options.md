* Enter a name. The naming requirements are as follows:

  {% include [name-format](../../_includes/name-format.md) %}

* In the **{{ ui-key.yacloud.backup.policy-form.field_backup-periodicity }}** field, select how often backups should be created:
  * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-daily }}`: Specify the time for creating backups.
  * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-weekly }}`: Specify the days of the week and time for creating backups.
  * `{{ ui-key.yacloud.backup.policy-form.value_periodicity-monthly }}`: Specify the months, days of the month, and time for creating backups.
* Select the [type of backup](../../backup/concepts/backup.md#types):
  * `{{ ui-key.yacloud.backup.field_type-incremental }}`: Saves only data that is different from the previous backup.
  * `{{ ui-key.yacloud.backup.field_type-full }}`: Saves all the VM / {{ baremetal-name }} server data.
* Select the [policy for backup retention](../../backup/concepts/policy.md#retention):
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-all }}`: All backups created under this backup policy will be retained.
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-last-f }}`: Specify the number of recent backups you want to retain or the number of days, weeks, or months for which to retain the backups. All other backups are deleted automatically.

  If you create the policy via the management console, subsequent changes of backup retention rules will take effect as soon as you create another backup.
