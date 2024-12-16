Роль `managed-redis.viewer` позволяет просматривать информацию о хостах и кластерах Valkey™, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../managed-redis/concepts/index.md) Valkey™;
* просматривать информацию о [хостах](../../managed-redis/concepts/instance-types.md) кластеров Valkey™;
* просматривать информацию о [шардах](../../managed-redis/concepts/sharding.md) кластеров Valkey™;
* просматривать информацию о [резервных копиях](../../managed-redis/concepts/backup.md) БД Valkey™;
* просматривать информацию об алертах Valkey™;
* просматривать логи работы кластеров Valkey™;
* просматривать информацию о [квотах](../../managed-redis/concepts/limits.md#mrd-quotas) сервиса Yandex Managed Service for Valkey™;
* просматривать информацию об операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролью `managed-redis.auditor`.