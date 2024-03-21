- {% include [Backup time](../../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**: Period to store automatically created backups. If an automatic backup expires, it is deleted. The default is {{ mpg-backup-retention }} days. For more information, see [Backups](../../../managed-postgresql/concepts/backup.md).

   Changing the retention period affects both new automatic backups and existing backups. For example, the initial retention period was 7 days. The remaining lifetime for a backup with this period is 1 day. When the retention period increases to 9 days, the remaining lifetime for this backup is 3 days.

   Automatic cluster backups are stored for a specified number of days whereas manually created ones are stored indefinitely. After a cluster is deleted, all backups persist for 7 days.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-postgresql/concepts/maintenance.md) settings:

   {% include [Maintenance window](../console/maintenance-window-description.md) %}

- **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: This option allows you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**: This option allows you to run SQL queries against cluster databases from the {{ yandex-cloud }} management console.


- {% include [datatransfer access](../console/datatransfer-access.md) %}



- **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../../functions/concepts/index.md). For more information about setting up access, see the [{{ sf-name }}](../../../functions/operations/database-connection.md) documentation.



- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}**: Allows you to use the [Performance diagnostics](../../../managed-postgresql/operations/performance-diagnostics.md) tool in a cluster. If this option is enabled, also set the **{{ ui-key.yacloud.mdb.forms.field_diagnostics-sessions-interval }}** and **{{ ui-key.yacloud.mdb.forms.field_diagnostics-statements-interval }}** using the sliders. Both are measured in seconds.

   This feature is at the [Preview stage](../../../overview/concepts/launch-stages.md).

- **Autofailover**: Enable this option so that when the master host changes, the replication source for every replica host is automatically switched over to the new master host. To learn more, see [Replication](../../../managed-postgresql/concepts/replication.md).

   If the master host [is deleted](../../../managed-postgresql/operations/hosts.md#remove), a new master will be selected automatically regardless of the value of this option.

   {% note alert %}

   If the **Autofailover** option is disabled, run the selection of a new master or assign this role to one of the replicas [manually](../../../managed-postgresql/operations/update.md#start-manual-failover) if the master host fails.

   {% endnote %}


- **{{ ui-key.yacloud.postgresql.cluster.additional-field-pooling_mode }}**: Select one of the [connection pooler modes](../../../managed-postgresql/concepts/pooling.md).

- {% include [Deletion protection](../console/deletion-protection.md) %}

   {% include [deletion-protection-limits](../deletion-protection-limits-db.md) %}
