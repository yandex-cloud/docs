- {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**

  Automatic backups are stored for the specified number of days.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../managed-mysql/concepts/maintenance.md) settings:

  {% include [Maintenance window](console/maintenance-window-description.md) %}

- **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: Enables you to analyze cluster data in [{{ datalens-full-name }}](../../datalens/concepts/index.md).
  
  For more information about setting up a connection, see [Connecting to {{ datalens-name }}](../../managed-mysql/operations/datalens-connect.md).


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**: Enables you to [run SQL queries](../../managed-mysql/operations/web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.



- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}**: Enable this option to use the [Performance diagnostics](../../managed-mysql/operations/performance-diagnostics.md) tool in the cluster.

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [deletion-protection-limits-db](deletion-protection-limits-db.md) %}

