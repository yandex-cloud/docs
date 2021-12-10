- **Backup start (UTC)**: The time in UTC when you want to start creating a [backup](../../managed-redis/operations/cluster-backups.md) of a cluster (in 24-hour format). If the time is not set, the backup will start at 22:00 UTC.

- **Maintenance window**: Settings of the technical support window. You can use the settings to specify the preferred start time for cluster host maintenance (for example, you can select the time when the cluster is least loaded with requests):
  - To specify the preferred start time for the maintenance window, select **by schedule** and set the desired day of the week and hour of day in UTC (Coordinated Universal Time) using the drop-down lists.
  - To allow maintenance at any time, select **arbitrary**.

  Maintenance may include updating the DBMS version, applying patches, and so on.

- **Deletion protection**: Enable this option to protect a cluster from accidental deletion by your cloud's users.

    {% include [Deletion protection limits](../../_includes/mdb/deletion-protection-limits-db.md) %}

