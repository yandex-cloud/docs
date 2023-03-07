- **Backup start time (UTC)**: UTC time in 24-hour format when you would like to start creating a cluster backup. If the time is not set, the backup will start at 22:00 UTC.

- **Retention period for automatic backups, days**: The period to store the automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mpg-backup-retention }} days. For more information, see [{#T}](../../../managed-postgresql/concepts/backup.md).

   Changing the retention period affects both new automatic backups and existing backups. For example, the initial retention period was 7 days. The remaining lifetime for a backup with this period is 1 day. When the retention period increases to 9 days, the remaining lifetime for this backup is 3 days.

   Automatic cluster backups are stored for a specified number of days whereas manually created ones are stored indefinitely. After a cluster is deleted, all backups persist for 7 days.

- **Maintenance window**: [Maintenance time](../../../managed-postgresql/concepts/maintenance.md) settings:

   {% include [Maintenance window](../console/maintenance-window-description.md) %}

- **{{ datalens-name }} access:** Allows you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).

{% if product == "yandex-cloud" %}

- **Access from management console**: Enables you to run SQL queries against cluster databases from the {{ yandex-cloud }} management console.

{% endif %}

- {% include [datatransfer access](../console/datatransfer-access.md) %}

{% if product == "yandex-cloud" %}

{% if audience != "internal" %}

- **Access from Serverless**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../../functions/concepts/index.md). For more detail on setting up access, see the [{{ sf-name }}](../../../functions/operations/database-connection.md).

{% endif %}

{% endif %}

- **Statistics sampling**: Option enables use of [{#T}](../../../managed-postgresql/operations/performance-diagnostics.md) in a cluster. If this option is enabled, also set the **Sessions sampling interval** and **Statements sampling interval** using the sliders. Both are measured in seconds.

   {% if audience != "internal" %}This feature is in the [Preview](../../../overview/concepts/launch-stages.md) stage.{% else %}This feature is in the Preview stage.{% endif %}

- **Autofailover**: Enable this option so that when the master host changes, the replication source for every replica host is automatically switched over to the new master host. For more information, see [{#T}](../../../managed-postgresql/concepts/replication.md).

   If the master host [is deleted](../../../managed-postgresql/operations/hosts.md#remove), a new master will be selected automatically regardless of the value of this option.

   {% note alert %}

   If the **Autofailover** option is disabled, run the selection of a new master or assign this role to one of the replicas [manually](../../../managed-postgresql/operations/update.md#start-manual-failover) if the master host fails.

   {% endnote %}

{% if audience == "internal" %}

- **IDM**: Enable this option to use the [SOX data access mechanism](https://en.wikipedia.org/wiki/Sarbanes–Oxley_Act). This option is required to assign persons responsible for a cluster and to provide cluster access in [Identity Management](https://idm.yandex-team.ru/) (IDM). It's mandatory for clusters created in the `PRODUCTION` environment.

   {% note alert %}

   You can't disable this option.

   {% endnote %}

   For more information, see [Identity Management (IDM)](../../../managed-postgresql/security/index.md#idm).

{% endif %}

- **Connection pooler mode**: Choose one of [connection pooler modes](../../../managed-postgresql/concepts/pooling.md).

- {% include [Deletion protection](../console/deletion-protection.md) %}

   {% include [deletion-protection-limits](../deletion-protection-limits-db.md) %}
