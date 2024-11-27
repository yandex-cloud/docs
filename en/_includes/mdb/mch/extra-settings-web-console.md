* {% include [Backup time](../../../_includes/mdb/console/backup-time.md) %}

* **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**: Retention period for automatic backups, in days. If an automatic backup expires, it is deleted. The default is {{ mch-backup-retention }} days. For more information, see [Backups](../../../managed-clickhouse/concepts/backup.md#storage).

    Changing the retention period affects both new automatic backups and existing backups. For example, the initial retention period was 7 days, and the remaining lifetime of a single automatic backup is 1 day. If the retention period increases to 9 days, the remaining lifetime for this backup will now be 3 days.

* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance](../../../managed-clickhouse/concepts/maintenance.md) window settings:

   {% include [Maintenance window](../console/maintenance-window-description.md) %}

* **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: This option allows you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).


* **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**: Enables you to [run SQL queries](../../../managed-clickhouse/operations/web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.




* **{{ ui-key.yacloud.mdb.forms.additional-field-metrika }}**: This option helps [import data from AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html) to a cluster.

* **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../../functions/concepts/index.md). For more information about setting up access, see the [{{ sf-name }}](../../../functions/operations/database-connection.md) documentation.


* **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}**: Enable this option to allow cluster access from [{{ yq-full-name }}](../../../query/concepts/index.md). This feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

* {% include [Deletion protection](../console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](../deletion-protection-limits-db.md) %}

