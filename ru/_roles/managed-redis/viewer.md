Роль `managed-redis.viewer` позволяет просматривать информацию о хостах и кластерах Redis, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../managed-redis/concepts/index.md) Redis;
* просматривать информацию о [хостах](../../managed-redis/concepts/instance-types.md) кластеров Redis;
* просматривать информацию о [шардах](../../managed-redis/concepts/sharding.md) кластеров Redis;
* просматривать информацию о [резервных копиях](../../managed-redis/concepts/backup.md) БД Redis;
* просматривать информацию об алертах Redis;
* просматривать логи работы кластеров Redis;
* просматривать информацию о [квотах](../../managed-redis/concepts/limits.md#mrd-quotas) сервиса Managed Service for Redis;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for Redis.

Включает разрешения, предоставляемые ролью `managed-redis.auditor`.