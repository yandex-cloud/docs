Роль `managed-greenplum.viewer` позволяет просматривать информацию о кластерах и хостах Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Greenplum®](../../managed-greenplum/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-greenplum/concepts/maintenance.md) кластеров Greenplum®;
* просматривать информацию о [хостах](../../managed-greenplum/concepts/instance-types.md) кластеров Greenplum®;
* просматривать информацию о [резервных копиях](../../managed-greenplum/concepts/backup.md) кластеров Greenplum®;
* просматривать логи работы кластеров Greenplum®;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®;
* просматривать информацию о [квотах](../../managed-greenplum/concepts/limits.md#quotas) сервиса Yandex MPP Analytics for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролями `managed-greenplum.auditor` и `managed-greenplum.maintenanceTask.viewer`.