* Enter a name. Naming requirements:

   {% include [name-format](../../_includes/name-format.md) %}

* In the **Create backups** field, select how often backups should be created:
   * **Every hour**.
   * **Every day**: Specify the time for creating backups.
   * **Every week**: Specify the days of the week and time for creating backups.
   * **By month**: Specify the months, days of the month, and time for creating backups.
* Select the [type of backup](../../backup/concepts/backup.md#types):
   * **Incremental**: Only data that differs from a previous backup is saved.
   * **Full**: All VM's data is saved.
* Select the [policy for backup retention](../../backup/concepts/policy.md#retention):
   * **Retain all backups**: All backups created under this backup policy are retained.
   * **Only the last**: Set the number of the last backups to retain or the number of days, weeks, or months for which the backups to be retained are created. All other backups are deleted automatically.