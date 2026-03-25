Роль `managed-redis.editor` позволяет управлять кластерами Valkey™.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../managed-valkey/concepts/index.md) Valkey™, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам Valkey™;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-valkey/concepts/maintenance.md) кластеров Valkey™ и изменять такие задания;
* просматривать информацию о [хостах](../../managed-valkey/concepts/instance-types.md) кластеров Valkey™, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах Valkey™;
* просматривать информацию о [шардах](../../managed-valkey/concepts/sharding.md) кластеров Valkey™, а также создавать и удалять их;
* просматривать [информацию](../../managed-valkey/operations/user-list.md) о пользователях Valkey™, а также создавать, изменять и удалять таких пользователей;
* просматривать информацию о [резервных копиях](../../managed-valkey/concepts/backup.md) кластеров Valkey™, создавать резервные копии и восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах Valkey™, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров Valkey™;
* просматривать информацию о [квотах](../../managed-valkey/concepts/limits.md#mrd-quotas) сервиса Yandex Managed Service for Valkey™;
* просматривать информацию об операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролями `managed-redis.viewer`, `managed-redis.restorer`, `managed-redis.user`, `managed-redis.switcher` и `managed-redis.maintenanceTask.editor`.

Для создания кластеров Valkey™ дополнительно необходима роль `vpc.user`.