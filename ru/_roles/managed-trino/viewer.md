
Роль `managed-trino.viewer` позволяет просматривать информацию о кластерах {{ TR }} и квотах сервиса {{ mtr-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ TR }}](../../managed-trino/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-trino/concepts/maintenance.md) кластеров {{ TR }};
* просматривать информацию о [квотах](../../managed-trino/concepts/limits.md#quotas) сервиса {{ mtr-name }}.

Включает разрешения, предоставляемые ролями `managed-trino.auditor` и `managed-trino.maintenanceTask.viewer`.