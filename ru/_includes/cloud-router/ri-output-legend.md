* `id` — идентификатор Routing Instance.
* `name` — имя Routing Instance.
* `description` — описание Routing Instance.
* `folder_id` — идентификатор [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан Routing Instance.
* `region_id` — регион [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), в котором был создан Routing Instance.
* `vpc_info` — список IP-префиксов, распределенный по [зонам доступности](../../overview/concepts/geo-scope.md). Для каждой зоны доступности префиксы указываются отдельно.
* `cic_private_connection_info` — список приватных соединений, подключенных к Routing Instance.
* `status` — состояние ресурса. Целевое состояние — `ACTIVE`. При изменении может находиться в состоянии `UPDATING`.
* `created_at` — дата и время создания ресурса.