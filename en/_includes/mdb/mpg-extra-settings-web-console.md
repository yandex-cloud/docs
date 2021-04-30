- **Backup start (UTC)**: The time in UTC when you want to start creating a [backup](../../managed-postgresql/operations/cluster-backups.md) of a cluster (in 24-hour format). If the time is not set, the backup will start at 22:00 UTC.

- **Maintenance window**: Settings of the technical support window. You can use the settings to specify the preferred start time for cluster host maintenance (for example, you can select the time when the cluster is least loaded with requests):
  - To specify the preferred start time for the maintenance window, select **by schedule** and set the desired day of the week and hour of day in UTC (Coordinated Universal Time) using the drop-down lists.
  - To allow maintenance at any time, select **arbitrary**.

  Maintenance may include updating the DBMS version, applying patches, and so on.

- **Access from {{ datalens-name }}**: Enable this option to be able to analyze data from the cluster in [{{ datalens-full-name }}](../../datalens/concepts/index.md). For more information about setting up a connection, see [Connecting to {{ datalens-name }}](../../managed-postgresql/operations/datalens-connect.md).

- **Access from the management console**: Select this option to be able to [execute SQL queries](../../managed-postgresql/operations/web-sql-query.md) to cluster databases from the {{ yandex-cloud }} management console.

- **Collect statistics**: Enable this option to use the [{#T}](../../managed-postgresql/operations/performance-diagnostics.md) tool in the cluster. This feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

