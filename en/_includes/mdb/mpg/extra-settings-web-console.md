- {% include [Backup time](../../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**: Retention period for automatic backups. Backups are automatically deleted once their retention period expires. The default is {{ mpg-backup-retention }} days. For more information, see [Backups](../../../managed-postgresql/concepts/backup.md).

    Changing the retention period affects both new and existing automatic backups. For example, the initial retention period was 7 days. A specific automatic backup has 1 day of remaining lifetime. If you increase the retention period to 9 days, that backup’s remaining lifetime becomes 3 days.

    Automatic cluster backups are stored for a specified number of days, while manually created ones are stored indefinitely. After a cluster is deleted, all its backups are retained for 7 days.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-postgresql/concepts/maintenance.md) settings:

    {% include [Maintenance window](../console/maintenance-window-description.md) %}

- **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: Enables you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**: Enables you to [run SQL queries](../../../managed-postgresql/operations/web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.




- **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}**: Enables you to run YQL queries against cluster databases from [{{ yq-full-name }}](../../../query/concepts/index.md).

- **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**: Enables cluster access from [{{ sf-full-name }}](../../../functions/concepts/index.md). For more details on configuring access, see this [{{ sf-name }} article](../../../functions/operations/database-connection.md).



- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}**: Enables you to use the [Performance diagnostics](../../../managed-postgresql/operations/performance-diagnostics.md) tool in a cluster. When enabling this option, also configure **{{ ui-key.yacloud.mdb.forms.field_diagnostics-sessions-interval }}** and **{{ ui-key.yacloud.mdb.forms.field_diagnostics-statements-interval }}** using the sliders. Both settings are measured in seconds.


- **Autofailover**: If this option is enabled, the system will automatically update the replication source for all replica hosts to point to the new master host when the master changes. To learn more, see [Replication](../../../managed-postgresql/concepts/replication.md).

    If the master host [is deleted](../../../managed-postgresql/operations/hosts.md#remove), a new master will be elected automatically, regardless of this setting.

    {% note alert %}

    If the **Autofailover** option is disabled, you must [manually](../../../managed-postgresql/operations/update.md#start-manual-failover) initiate an election for a new master or assign this role to a replica if the master host fails.

    {% endnote %}


- **{{ ui-key.yacloud.postgresql.cluster.additional-field-pooling_mode }}**: Select one of the [connection pooler modes](../../../managed-postgresql/concepts/pooling.md).

- **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**: Deletion protection for the cluster, its databases, and users.

    By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](../../../managed-postgresql/operations/cluster-users.md) and [Database management](../../../managed-postgresql/operations/databases.md) for details.
    
    If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

    {% include [deletion-protection-limits](../../../_includes/mdb/deletion-protection-limits-data.md) %}
