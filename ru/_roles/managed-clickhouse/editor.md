Роль `managed-clickhouse.editor` позволяет управлять кластерами ClickHouse® и просматривать их логи, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах ClickHouse®](../../managed-clickhouse/concepts/index.md), а также создавать, изменять, удалять, запускать и останавливать их;
* просматривать логи работы кластеров ClickHouse®;
* просматривать информацию о [квотах](../../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса Managed Service for ClickHouse®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for ClickHouse®.

Включает разрешения, предоставляемые ролью `managed-clickhouse.viewer`.

Для создания кластеров ClickHouse® дополнительно необходима роль `vpc.user`.