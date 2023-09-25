* **{{ ui-key.yacloud.mdb.forms.backup-window-start }}**: UTC time in 24-hour format to start backing up the cluster. If the time is not set, the backup will start at 22:00 UTC.

* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-clickhouse/concepts/maintenance.md) settings:

   {% include [Maintenance window](../console/maintenance-window-description.md) %}

* **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: This option allows you to analyze cluster data in [{{ datalens-full-name }}](../../../datalens/concepts/index.md).

* {% include [datatransfer access](../console/datatransfer-access.md) %}



* **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**: Enables you to run SQL queries against cluster databases from the {{ yandex-cloud }} management console.

* **{{ ui-key.yacloud.mdb.forms.additional-field-metrika }}**: This option helps [import data from AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html) to a cluster.

* **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**: Enable this option to allow cluster access from [{{ sf-full-name }}](../../../functions/concepts/index.md). For more information on setting up access, see the [{{ sf-name }}](../../../functions/operations/database-connection.md) documentation.

* **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query }}**: Enable this option to allow cluster access from [{{ yq-full-name }}](../../../query/concepts/index.md).



* {% include [Deletion protection](../console/deletion-protection.md) %}

   {% include [deletion-protection-limits-db](../deletion-protection-limits-db.md) %}
