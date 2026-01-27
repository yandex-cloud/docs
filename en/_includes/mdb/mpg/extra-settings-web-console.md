- {% include [Backup time](../../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**: Retention period for automatic backups. Backups are automatically deleted once their retention period expires. The default is {{ mpg-backup-retention }} days. For more information, see [Backups](../../../managed-postgresql/concepts/backup.md).

    Changing the retention period affects both new and existing automatic backups. For example, the initial retention period was 7 days. A specific automatic backup has 1 day of remaining lifetime. If you increase the retention period to 9 days, that backup’s remaining lifetime becomes 3 days.

    Automatic cluster backups are stored for a specified number of days, while manually created ones are stored indefinitely. After a cluster is deleted, all its backups are retained for 7 days.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-postgresql/concepts/maintenance.md) settings:

    {% include [Maintenance window](../console/maintenance-window-description.md) %}

- **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: This option enables you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**: This option enables you to [run SQL queries](../../../managed-postgresql/operations/web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.




- **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}**: Enables you to run YQL queries against cluster databases from [{{ yq-full-name }}](../../../query/concepts/index.md).

- **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../../functions/concepts/index.md). For more information about setting up access, see [{{ sf-name }}](../../../functions/operations/database-connection.md) this guide.



- **{{ ui-key.yacloud.postgresql.cluster.additional-field-pooling_mode }}**: Select one of the [connection pooler modes](../../../managed-postgresql/concepts/pooling.md).

- **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**: Deletion protection for the cluster, its databases, and users.

    By default, when users and databases are created, this setting’s value is inherited from the cluster. You can also specify this setting manually. See [User management](../../../managed-postgresql/operations/cluster-users.md) and [Database management](../../../managed-postgresql/operations/databases.md) for details.
    
    If the setting is changed on a running cluster, the new value will only be inherited by users and databases with the **Same as cluster** protection level.

    {% include [deletion-protection-limits](../../../_includes/mdb/deletion-protection-limits-data.md) %}
