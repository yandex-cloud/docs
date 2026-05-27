
Роль `managed-redis.viewer` позволяет просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../managed-valkey/concepts/index.md) {{ VLK }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-valkey/concepts/maintenance.md) кластеров {{ VLK }};
* просматривать информацию о [хостах](../../managed-valkey/concepts/instance-types.md) кластеров {{ VLK }};
* просматривать информацию о [шардах](../../managed-valkey/concepts/sharding.md) кластеров {{ VLK }};
* просматривать [информацию](../../managed-valkey/operations/user-list.md) о пользователях {{ VLK }};
* просматривать информацию о [резервных копиях](../../managed-valkey/concepts/backup.md) кластеров {{ VLK }};
* просматривать информацию об алертах {{ VLK }};
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../../managed-valkey/concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролями `managed-redis.auditor` и `managed-redis.maintenanceTask.viewer`.