- **Backup start time (UTC)**: UTC time when you want to start creating a cluster [backup](../../managed-postgresql/operations/cluster-backups.md) (in 24-hour format). If the time is not set, the backup will start at 22:00 UTC.

- **Retention period for automatic backups, days**: The period to store the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mmg-backup-retention }} days. This feature is in the [Preview stage](../../overview/concepts/launch-stages.md). For more information, see [{#T}](../../managed-postgresql/concepts/backup.md).

   Changing the retention period affects both new automatic backups and existing backups. For example, the initial retention period was 7 days. The remaining lifetime for a backup with this period is 1 day. When the retention period increases to 9 days, the remaining lifetime for this backup is 3 days.

- {% include [Maintenance window](console/maintenance-window.md) %}

- **Access from {{ datalens-name }}** : Enable this option to be able to analyze data from the cluster in [{{ datalens-full-name }}](../../datalens/concepts/index.md). For more information about setting up a connection, see [Connecting to {{ datalens-name }}](../../managed-postgresql/operations/datalens-connect.md).

- **Access from management console**: Enable this option to be able to [run SQL queries](../../managed-postgresql/operations/web-sql-query.md) against a cluster's databases from the {{ yandex-cloud }} management console.

- **Access from Serverless**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

- **Statistics sampling**: Enable this option to use the [{#T}](../../managed-postgresql/operations/performance-diagnostics.md) tool in the cluster. This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage.

- **Autofailover**: Enable this option so that when the master host changes, the replication source for every replica host is automatically switched over to the new master host. To learn more, see [Replication](../../managed-postgresql/concepts/replication.md).

- **Connection pooler mode**: Choose one of [connection pooler modes](../../managed-postgresql/concepts/pooling.md).

- {% include [Deletion protection](console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](deletion-protection-limits-db.md) %}
