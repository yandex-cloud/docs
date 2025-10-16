Роль `managed-postgresql.restorer` позволяет восстанавливать кластеры PostgreSQL из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях PostgreSQL, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров PostgreSQL](../../managed-postgresql/concepts/index.md) и восстанавливать кластеры из [резервных копий](../../managed-postgresql/concepts/backup.md);
* просматривать информацию о кластерах PostgreSQL;
* просматривать информацию о [хостах](../../managed-postgresql/concepts/instance-types.md) кластеров PostgreSQL;
* просматривать информацию о базах данных PostgreSQL;
* просматривать информацию о [пользователях](../../managed-postgresql/concepts/roles.md) PostgreSQL;
* просматривать информацию об алертах PostgreSQL;
* просматривать логи работы кластеров PostgreSQL;
* просматривать информацию о результатах диагностики производительности кластеров PostgreSQL;
* просматривать информацию о [квотах](../../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса Managed Service for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-postgresql.viewer`.