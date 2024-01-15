- {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}

- **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**

  Автоматические резервные копии будут храниться указанное количество дней.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../managed-mysql/concepts/maintenance.md):

  {% include [Maintenance window](console/maintenance-window-description.md) %}

- **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**
  
  Разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../datalens/concepts/index.md).
  
  Подробнее о настройке подключения см. в разделе [Подключение к {{ datalens-name }}](../../managed-mysql/operations/datalens-connect.md).


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**

  Разрешает [выполнять SQL-запросы](../../managed-mysql/operations/web-sql-query.md) к базам кластера из консоли управления {{ yandex-cloud }}.


- {% include [datatransfer access](console/datatransfer-access.md) %}

- **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** — включите эту опцию, чтобы воспользоваться инструментом [{#T}](../../managed-mysql/operations/performance-diagnostics.md) в кластере.

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [Ограничения защиты от удаления](deletion-protection-limits-db.md) %}
