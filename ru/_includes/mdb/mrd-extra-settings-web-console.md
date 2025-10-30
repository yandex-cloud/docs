- **{{ ui-key.yacloud.mdb.forms.backup-window-start }}** — время по UTC, когда требуется начать [резервное копирование](../../managed-redis/operations/cluster-backups.md) кластера (в 24-часовом формате). Если время не задано, резервное копирование начнется в 22:00 UTC.

- **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../../managed-redis/concepts/maintenance.md):

    {% include [Maintenance window](console/maintenance-window-description.md) %}

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [Ограничения защиты от удаления кластера](deletion-protection-limits-data.md) %}


- **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** — опция разрешает [выполнять SQL-запросы](../../managed-redis/operations/web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}.

