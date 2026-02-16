* **{{ ui-key.yacloud.spqr.console_password }}**. It may be from 8 to 128 characters long.

* **{{ ui-key.yacloud.logging.label_minlevel }}**: Execution log will register logs of this or higher level. The available levels are `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`, and `PANIC`. The default level is `INFO`.

* {% include [Backup time](../../../../_includes/mdb/console/backup-time.md) %}

* **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**: Automatic backups will be stored for this many days. The default value is seven days.

* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: Maintenance window settings:

    {% include [Maintenance window](../../console/maintenance-window-description.md) %}

* **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: Enables you to analyze cluster data in [{{ datalens-full-name }}](../../../../datalens/concepts/index.md).

* **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**: Enables SQL queries against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}.

* {% include [datatransfer access](../../console/datatransfer-access.md) %}

* {% include [Deletion protection](../../console/deletion-protection.md) %}

    {% include [deletion-protection-limits-db](../../deletion-protection-limits-db.md) %}
