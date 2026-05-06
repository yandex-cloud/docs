
Роль `managed-opensearch.viewer` позволяет просматривать информацию о кластерах {{ OS }} и логи их работы, а также информацию о квотах и операциях с ресурсами сервиса {{ mos-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ OS }}](../../managed-opensearch/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-opensearch/concepts/maintenance.md) кластеров {{ OS }};
* просматривать логи работы кластеров {{ OS }};
* просматривать информацию о [квотах](../../managed-opensearch/concepts/limits.md#quotas) сервиса {{ mos-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mos-name }}.

Включает разрешения, предоставляемые ролями `managed-opensearch.auditor` и `managed-opensearch.maintenanceTask.viewer`.