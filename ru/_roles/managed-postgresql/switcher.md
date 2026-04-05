Роль `managed-postgresql.switcher` позволяет переназначать хост-мастер в кластерах PostgreSQL, просматривать информацию о кластерах, хостах, базах данных и пользователях PostgreSQL, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах PostgreSQL](../../managed-postgresql/concepts/index.md);
* просматривать информацию о кластерах PostgreSQL и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-postgresql/concepts/maintenance.md) кластеров PostgreSQL;
* просматривать информацию о [хостах](../../managed-postgresql/concepts/instance-types.md) кластеров PostgreSQL;
* просматривать информацию о базах данных PostgreSQL;
* просматривать информацию о [пользователях](../../managed-postgresql/concepts/roles.md) PostgreSQL;
* просматривать информацию о [резервных копиях](../../managed-postgresql/concepts/backup.md) кластеров PostgreSQL;
* просматривать информацию об алертах PostgreSQL;
* просматривать логи работы кластеров PostgreSQL;
* просматривать информацию о результатах диагностики производительности кластеров PostgreSQL;
* просматривать информацию о [квотах](../../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса Managed Service for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-postgresql.viewer`.