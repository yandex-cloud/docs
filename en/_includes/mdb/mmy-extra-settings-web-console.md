- **Backup start (UTC)**{#setting-backup-start}

   The time in UTC (in 24-hour format) to start [backing up](../../managed-mysql/operations/cluster-backups.md) the cluster. If the time is not set, the backup will start at 22:00 UTC.

- {% include [Maintenance window](console/maintenance-window.md) %}

{% if product == "yandex-cloud" %}
- **Access from {{ datalens-name }}**{#setting-datalens-access}

   Allows you to analyze cluster data in [{{ datalens-full-name }}](../../datalens/concepts/index.md).

   For more information about setting up a connection, see [Connecting to {{ datalens-name }}](../../managed-mysql/operations/datalens-connect.md).
{% endif %}

- **Access from management console**{#setting-websql-access}

   It allows you to [execute SQL queries](../../managed-mysql/operations/web-sql-query.md) against the databases in the cluster from the dashboard {{ yandex-cloud }}.

- {% include [datatransfer access](console/datatransfer-access.md) %}

- **Statistics sampling**: Enable this option to use the [{#T}](../../managed-mysql/operations/performance-diagnostics.md) tool in the cluster.

- {% include [Deletion protection](console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](deletion-protection-limits-db.md) %}
