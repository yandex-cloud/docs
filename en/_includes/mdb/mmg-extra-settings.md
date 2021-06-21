- **Backup start (UTC)**{#setting-backup-start}

  The time in UTC (in 24-hour format) to start creating a [backup](../../managed-mongodb/operations/cluster-backups.md) of a cluster. If the time is not set, the backup will start at 22:00 UTC.

- **Retention period for automatic backups, days**{#setting-backup-saving}

  The time to retain the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mmg-backup-retention }} days. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../../managed-mongodb/concepts/backup.md).

  Changing the retention period affects both new automatic backups and existing backups. For example, if the original retention period was 7 days and the remaining lifetime of a separate automatic backup is 1 day, then when the retention period increases to 9 days, the remaining lifetime of this backup becomes 3 days.

- **Maintenance window**{#setting-maintenance-window}

  Maintenance time settings:
  - To specify the preferred start time for the maintenance of cluster hosts, select **by schedule** and set the desired day of the week and hour of the day in UTC (Coordinated Universal Time).
  - To allow maintenance at any time, select **arbitrary**.

  Maintenance includes updating the DBMS version, applying patches, and so on.

