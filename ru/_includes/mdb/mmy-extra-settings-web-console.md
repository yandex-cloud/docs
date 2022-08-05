- **Начало резервного копирования (UTC)**{#setting-backup-start}

  Время по UTC (в 24-часовом формате), когда начинается [резервное копирование](../../managed-mysql/operations/cluster-backups.md) кластера. Если время не задано, резервное копирование начинается в 22:00 UTC.

- **Окно обслуживания** — настройки времени [технического обслуживания](../../managed-mysql/concepts/maintenance.md):

  {% include [Maintenance window](console/maintenance-window-description.md) %}

- **Доступ из {{ datalens-name }}**{#setting-datalens-access}
  
  Разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../datalens/concepts/index.md).
  
  Подробнее о настройке подключения см. в разделе [Подключение к {{ datalens-name }}](../../managed-mysql/operations/datalens-connect.md).

- **Доступ из консоли управления**{#setting-websql-access}

  Разрешает [выполнять SQL-запросы](../../managed-mysql/operations/web-sql-query.md) к базам кластера из консоли управления {{ yandex-cloud }}.

- {% include [datatransfer access](console/datatransfer-access.md) %}

- **Сбор статистики** — включите эту опцию, чтобы воспользоваться инструментом [{#T}](../../managed-mysql/operations/performance-diagnostics.md) в кластере.

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [Ограничения защиты от удаления](deletion-protection-limits-db.md) %}
