Роль `managed-spqr.restorer` позволяет восстанавливать кластеры Sharded PostgreSQL из резервных копий, а также просматривать информацию о кластерах, хостах, базах данных и пользователях в кластерах Sharded PostgreSQL, логи работы кластеров, данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров](../../managed-spqr/concepts/index.md) Sharded PostgreSQL, а также восстанавливать кластеры из резервных копий;
* просматривать информацию о кластерах Sharded PostgreSQL и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о [хостах](../../managed-spqr/concepts/instance-types.md) кластеров Sharded PostgreSQL;
* просматривать информацию о базах данных в кластерах Sharded PostgreSQL;
* просматривать информацию о пользователях в кластерах Sharded PostgreSQL;
* просматривать логи работы кластеров Sharded PostgreSQL;
* просматривать информацию о [квотах](../../managed-spqr/concepts/limits.md#mspqr-quotas) сервиса Managed Service for Sharded PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for Sharded PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-spqr.viewer`.
