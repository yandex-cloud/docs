
Роль `managed-greenplum.viewer` позволяет просматривать информацию о кластерах и хостах {{ mgp-name }} в сервисе {{ mgp-full-name }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах {{ mgp-name }}](../../managed-greenplum/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-greenplum/concepts/maintenance.md) кластеров {{ mgp-name }};
* просматривать информацию о [хостах](../../managed-greenplum/concepts/instance-types.md) кластеров {{ mgp-name }};
* просматривать информацию о [резервных копиях](../../managed-greenplum/concepts/backup.md) кластеров {{ mgp-name }};
* просматривать логи работы кластеров {{ mgp-name }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }};
* просматривать информацию о [квотах](../../managed-greenplum/concepts/limits.md#quotas) сервиса {{ mgp-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mgp-full-name }}.

Включает разрешения, предоставляемые ролями `managed-greenplum.auditor` и `managed-greenplum.maintenanceTask.viewer`.