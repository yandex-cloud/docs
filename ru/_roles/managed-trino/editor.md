Роль `managed-trino.editor` позволяет управлять кластерами Trino.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Trino](../../managed-trino/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* создавать, изменять, запускать, останавливать и удалять кластеры Trino;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-trino/concepts/maintenance.md) кластеров Trino и изменять такие задания;
* использовать веб-интерфейс Trino;
* отправлять запросы к API Trino;
* просматривать информацию о [квотах](../../managed-trino/concepts/limits.md#quotas) сервиса Managed Service for Trino.

Включает разрешения, предоставляемые ролями `managed-trino.user` и `managed-trino.maintenanceTask.editor`.

Для создания кластеров Trino дополнительно необходима роль `vpc.user`.