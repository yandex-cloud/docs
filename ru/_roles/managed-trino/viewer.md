Роль `managed-trino.viewer` позволяет просматривать информацию о кластерах Trino и квотах сервиса Managed Service for Trino.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Trino](../../managed-trino/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-trino/concepts/maintenance.md) кластеров Trino;
* просматривать информацию о [квотах](../../managed-trino/concepts/limits.md#quotas) сервиса Managed Service for Trino.

Включает разрешения, предоставляемые ролями `managed-trino.auditor` и `managed-trino.maintenanceTask.viewer`.