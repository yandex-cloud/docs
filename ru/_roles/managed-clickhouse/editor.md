Роль `managed-clickhouse.editor` позволяет управлять кластерами ClickHouse®.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах ClickHouse®](../../managed-clickhouse/concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам ClickHouse®;
* просматривать информацию о заданиях на [техническое обслуживание](../../managed-clickhouse/concepts/maintenance.md) кластеров ClickHouse® и изменять такие задания;
* восстанавливать кластеры ClickHouse® из резервных копий;
* просматривать логи работы кластеров ClickHouse®;
* просматривать информацию о результатах диагностики производительности кластеров ClickHouse®;
* просматривать информацию о [квотах](../../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса Managed Service for ClickHouse®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for ClickHouse®.

Включает разрешения, предоставляемые ролями `managed-clickhouse.viewer`, `managed-clickhouse.user`, `managed-clickhouse.restorer` и `managed-clickhouse.maintenanceTask.editor`.

Для создания кластеров ClickHouse® дополнительно необходима роль `vpc.user`.