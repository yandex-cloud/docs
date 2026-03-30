Роль `managed-redis.switcher` позволяет переназначать хост-мастер в кластерах Valkey™, просматривать информацию о хостах и кластерах Valkey™, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах Valkey™](../../managed-valkey/concepts/index.md);
* просматривать информацию о кластерах Valkey™ и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-valkey/concepts/maintenance.md) кластеров Valkey™;
* просматривать информацию о [хостах](../../managed-valkey/concepts/instance-types.md) кластеров Valkey™;
* просматривать информацию о [шардах](../../managed-valkey/concepts/sharding.md) кластеров Valkey™;
* просматривать [информацию](../../managed-valkey/operations/user-list.md) о пользователях Valkey™;
* просматривать информацию о [резервных копиях](../../managed-valkey/concepts/backup.md) кластеров Valkey™;
* просматривать информацию об алертах Valkey™;
* просматривать логи работы кластеров Valkey™;
* просматривать информацию о [квотах](../../managed-valkey/concepts/limits.md#mrd-quotas) сервиса Yandex Managed Service for Valkey™;
* просматривать информацию об операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.