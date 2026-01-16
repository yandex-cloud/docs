Роль `managed-greenplum.restorer` позволяет восстанавливать из резервных копий кластеры Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL, просматривать информацию о кластерах и хостах Greenplum®, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров Greenplum®](../../managed-greenplum/concepts/index.md) и восстанавливать кластеры из [резервных копий](../../managed-greenplum/concepts/backup.md);
* просматривать информацию о кластерах Greenplum®;
* просматривать информацию о [хостах](../../managed-greenplum/concepts/instance-types.md) кластеров Greenplum®;
* просматривать логи работы кластеров Greenplum®;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®;
* просматривать информацию о [квотах](../../managed-greenplum/concepts/limits.md#quotas) сервиса Yandex MPP Analytics for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.viewer`.