Роль `managed-postgresql.editor` позволяет управлять кластерами PostgreSQL.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../managed-postgresql/concepts/index.md) PostgreSQL, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам PostgreSQL;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-postgresql/concepts/maintenance.md) кластеров PostgreSQL и изменять такие задания;
* просматривать информацию о [хостах](../../managed-postgresql/concepts/instance-types.md) кластеров PostgreSQL, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах PostgreSQL;
* просматривать информацию о базах данных PostgreSQL, а также создавать, изменять и удалять их;
* просматривать информацию о [пользователях](../../managed-postgresql/concepts/roles.md) PostgreSQL, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../../managed-postgresql/concepts/backup.md) кластеров PostgreSQL, создавать и удалять резервные копии, а также восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах PostgreSQL, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров PostgreSQL;
* просматривать информацию о результатах диагностики производительности кластеров PostgreSQL;
* просматривать информацию о [квотах](../../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса Managed Service for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for PostgreSQL.

Включает разрешения, предоставляемые ролями `managed-postgresql.viewer`, `managed-postgresql.restorer`, `managed-postgresql.user`, `managed-postgresql.switcher` и `managed-postgresql.maintenanceTask.editor`.

Для создания кластеров PostgreSQL дополнительно необходима роль `vpc.user`.