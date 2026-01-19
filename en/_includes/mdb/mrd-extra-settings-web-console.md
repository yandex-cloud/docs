- **{{ ui-key.yacloud.mdb.forms.backup-window-start }}**: UTC time when you want to start creating a cluster [backup](../../managed-valkey/operations/cluster-backups.md) (in 24-hour format). If the time is not set, the backup will start at 22:00 UTC.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../managed-valkey/concepts/maintenance.md) settings:

    {% include [Maintenance window](console/maintenance-window-description.md) %}

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [deletion-protection-limits-db](deletion-protection-limits-data.md) %}


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**: Enables you to run [SQL queries](../../managed-valkey/operations/web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.

