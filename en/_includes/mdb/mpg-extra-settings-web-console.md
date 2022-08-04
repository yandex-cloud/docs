- **Backup start time (UTC)**: UTC time in 24-hour format when you would like to start creating a cluster backup. If the time is not set, the backup will start at 22:00 UTC.

- **Retention period for automatic backups, days**: The period to store the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mpg-backup-retention }} days. For more information, see [{#T}](../../managed-postgresql/concepts/backup.md).

   Changing the retention period affects both new automatic backups and existing backups. For example, the initial retention period was 7 days. The remaining lifetime for a backup with this period is 1 day. When the retention period increases to 9 days, the remaining lifetime for this backup is 3 days.

   Automatic cluster backups are stored for a specified number of days whereas manually created ones are stored indefinitely. After a cluster is deleted, all backups persist for 7 days.

- {% include [Maintenance window](console/maintenance-window.md) %}

{% if product == "yandex-cloud" %}
- **Access from {{ datalens-name }}** : Enable this option to be able to analyze data from the cluster in [{{ datalens-full-name }}](../../datalens/concepts/index.md). For more information about setting up a connection, see [Connecting to {{ datalens-name }}](../../managed-postgresql/operations/datalens-connect.md).
{% endif %}

- **Access from management console**: Enable this option to be able to [run SQL queries](../../managed-postgresql/operations/web-sql-query.md) against a cluster's databases from the {{ yandex-cloud }} management console.
{% if product == "yandex-cloud" %}
{% if audience != "internal" %}

- **Access from Serverless**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../functions/concepts/index.md). For more detail on setting up access, see the [{{ sf-name }}](../../functions/operations/database-connection.md).

{% else %}

- **Access from Serverless**: Enable this option to allow cluster access from {{ sf-full-name }.

{% endif %}
{% endif %}

- **Statistics sampling**: The option allows using the [{#T}](../../managed-postgresql/operations/performance-diagnostics.md) tool in a cluster. {% if audience != "internal" %}This feature is in the [Preview](../../overview/concepts/launch-stages.md) stage.{% else %}This feature is in the Preview stage.{% endif %}

- **Autofailover**: Enable this option so that when the master host changes, the replication source for every replica host is automatically switched over to the new master host. To learn more, see [Replication](../../managed-postgresql/concepts/replication.md).

{% if audience == "internal" %}

- **SOX**: Enable this option to use the [SOX data access mechanism](https://ru.wikipedia.org/wiki/Закон_Сарбейнза_—_Оксли). This option is required to assign persons responsible for a cluster and to provide cluster access in [Identity Management](https://idm.yandex-team.ru/) (IDM).

   {% note alert %}

   You can't disable this option.

   {% endnote %}

{% endif %}

- **Connection pooler mode**: Choose one of [connection pooler modes](../../managed-postgresql/concepts/pooling.md).

- {% include [Deletion protection](console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](deletion-protection-limits-db.md) %}
