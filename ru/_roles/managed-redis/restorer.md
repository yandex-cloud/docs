Роль `managed-redis.restorer` позволяет восстанавливать кластеры Valkey™ из резервных копий, а также просматривать информацию о хостах и кластерах Valkey™, логи их работы, данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [резервных копиях](../../managed-redis/concepts/backup.md) кластеров Valkey™, а также восстанавливать [кластеры](../../managed-redis/concepts/index.md) из резервных копий;
* просматривать информацию о кластерах Valkey™;
* просматривать информацию о [хостах](../../managed-redis/concepts/instance-types.md) кластеров Valkey™;
* просматривать информацию о [шардах](../../managed-redis/concepts/sharding.md) кластеров Valkey™;
* просматривать информацию об алертах Valkey™;
* просматривать логи работы кластеров Valkey™;
* просматривать информацию о [квотах](../../managed-redis/concepts/limits.md#mrd-quotas) сервиса Yandex Managed Service for Valkey™;
* просматривать информацию об операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.