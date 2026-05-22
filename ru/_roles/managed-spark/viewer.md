
Роль `managed-spark.viewer` позволяет просматривать информацию о кластерах {{ SPRK }}, заданиях и квотах сервиса {{ msp-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ SPRK }}](../../managed-spark/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-spark/concepts/maintenance.md) кластеров {{ SPRK }};
* просматривать информацию о [заданиях](../../managed-spark/operations/index.md#jobs);
* просматривать информацию о [квотах](../../managed-spark/concepts/limits.md#quotas) сервиса {{ msp-name }}.

Включает разрешения, предоставляемые ролями `managed-spark.auditor` и `managed-spark.maintenanceTask.viewer`.