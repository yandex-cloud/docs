Роль `managed-clickhouse.viewer` позволяет просматривать информацию о кластерах ClickHouse® и логи их работы, а также данные о квотах и операциях с ресурсами сервиса Managed Service for ClickHouse®.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах ClickHouse®](../../managed-clickhouse/concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-clickhouse/concepts/maintenance.md) кластеров ClickHouse®;
* просматривать логи работы кластеров ClickHouse®;
* просматривать информацию о результатах диагностики производительности кластеров ClickHouse®;
* просматривать информацию о [квотах](../../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса Managed Service for ClickHouse®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for ClickHouse®.

Включает разрешения, предоставляемые ролями `managed-clickhouse.auditor` и `managed-clickhouse.maintenanceTask.viewer`.
