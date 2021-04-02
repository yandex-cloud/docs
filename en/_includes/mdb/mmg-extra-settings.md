- **Backup start (UTC)**: The time in UTC when you want to start creating a [backup](../../managed-mongodb/operations/cluster-backups.md) of a cluster (in 24-hour format). If the time is not set, the backup will start at 22:00 UTC.

- **Retention period for automatic backups, days**: The time to retain the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mmg-backup-retention }} days. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../../managed-mongodb/concepts/backup.md).

  Changing the retention period affects both new automatic backups and existing backups: when you increase/decrease the retention period, the lifetime for existing backups increases/decreases.

  For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

- **Maintenance window**: Settings of the technical support window. You can use the settings to specify the preferred start time for cluster host maintenance (for example, you can select the time when the cluster is least loaded with requests):
  - To specify the preferred start time for the maintenance window, select **by schedule** and set the desired day of the week and hour of day in UTC (Coordinated Universal Time) using the drop-down lists.
  - To allow maintenance at any time, select **arbitrary**.

  Maintenance may include updating the DBMS version, applying patches, and so on.

