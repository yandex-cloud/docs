- **Начало резервного копирования (UTC)** — время по UTC, когда требуется начать [резервное копирование](../../managed-redis/operations/cluster-backups.md) кластера (в 24-часовом формате). Если время не задано, резервное копирование начнется в 22:00 UTC.

- **Окно обслуживания** — настройки времени [технического обслуживания](../../managed-redis/concepts/maintenance.md):

    {% include [Maintenance window](console/maintenance-window-description.md) %}

- {% include [Deletion protection](console/deletion-protection.md) %}

    {% include [Ограничения защиты от удаления](deletion-protection-limits-db.md) %}
