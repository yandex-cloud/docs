- **Backup start (UTC)**{#setting-backup-start}

  The time in UTC (in 24-hour format) to start creating a [backup](../../managed-mysql/operations/cluster-backups.md) of a cluster. If the time is not set, the backup will start at 22:00 UTC.

- **Maintenance window**{#setting-maintenance-window}

  Maintenance window settings:
  - To specify the preferred start time for the maintenance of cluster hosts, select **by schedule** and set the desired day of the week and hour of the day in UTC (Coordinated Universal Time) using the drop-down lists. You can choose the time when the cluster is least loaded.
  - To allow maintenance at any time, select **arbitrary**.

  Maintenance includes updating the DBMS version, applying patches, and so on.

- **Access from {{ datalens-name }}**{#setting-datalens-access}

  Allows you to analyze cluster data in [{{ datalens-full-name }}](../../datalens/concepts/index.md).

  For more information about setting up a connection, see [Connecting to {{ datalens-name }}](../../managed-mysql/operations/datalens-connect.md).

- **Access from the management console**{#setting-websql-access}

  Allows [executing SQL queries](../../managed-mysql/operations/web-sql-query.md) to cluster databases from the {{ yandex-cloud }} management console.

