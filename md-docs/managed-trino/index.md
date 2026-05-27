# Yandex Managed Service for Trino

Сервис Managed Service for Trino позволяет управлять распределенным аналитическим SQL-движком Trino в инфраструктуре Yandex Cloud.

Инфраструктура Yandex Cloud <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами: <ul> <li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li> </ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla/ru/">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_trino/ru/">Уровень обслуживания Yandex Managed Service for Trino</a>.

# Yandex Managed Service for Trino

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Получение информации об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение кластера](operations/cluster-update.md)

 - [Обновление версии Trino](operations/cluster-version-update.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Подключение к кластеру](operations/connect.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Каталоги

 - [Получение информации об имеющихся каталогах](operations/catalog-list.md)

 - [Создание каталога](operations/catalog-create.md)

 - [Изменение каталога](operations/catalog-update.md)

 - [Удаление каталога](operations/catalog-delete.md)

### Логи и мониторинг

 - [Мониторинг состояния кластера](operations/monitoring.md)

 - [Просмотр логов кластера](operations/cluster-logs.md)

### Правила доступа к объектам

 - [Управление доступом](operations/access-control.md)

 - [Получение правил доступа](operations/access-control-get.md)

 - [Назначение правил для объектов каталогов](operations/access-control-catalogs.md)

 - [Назначение правил для схем](operations/access-control-schemas.md)

 - [Назначение правил для таблиц](operations/access-control-tables.md)

 - [Назначение правил для функций](operations/access-control-functions.md)

 - [Назначение правил для процедур](operations/access-control-procedures.md)

 - [Назначение правил для запросов](operations/access-control-queries.md)

 - [Назначение правил для системных свойств сессии](operations/access-control-session-properties.md)

 - [Назначение правил для свойств сессии каталога](operations/access-control-catalog-properties.md)

 - [Удаление правил доступа](operations/access-control-delete.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Сеть в Managed Service for Trino](concepts/network.md)

 - [Имперсонация](concepts/impersonation.md)

 - [Отказоустойчивое выполнение запросов](concepts/retry-policy.md)

 - [Классы хостов](concepts/instance-types.md)

 - [Управление доступом](concepts/access-control.md)

 - [Техническое обслуживание](concepts/maintenance.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### catalog

 - [Overview](cli-ref/catalog/index.md)

#### create

 - [Overview](cli-ref/catalog/create/index.md)

 - [clickhouse](cli-ref/catalog/create/clickhouse.md)

 - [delta-lake](cli-ref/catalog/create/delta-lake.md)

 - [greenplum](cli-ref/catalog/create/greenplum.md)

 - [hive](cli-ref/catalog/create/hive.md)

 - [hudi](cli-ref/catalog/create/hudi.md)

 - [iceberg](cli-ref/catalog/create/iceberg.md)

 - [mysql](cli-ref/catalog/create/mysql.md)

 - [oracle](cli-ref/catalog/create/oracle.md)

 - [postgresql](cli-ref/catalog/create/postgresql.md)

 - [sqlserver](cli-ref/catalog/create/sqlserver.md)

 - [tpcds](cli-ref/catalog/create/tpcds.md)

 - [tpch](cli-ref/catalog/create/tpch.md)

 - [delete](cli-ref/catalog/delete.md)

 - [get](cli-ref/catalog/get.md)

 - [list](cli-ref/catalog/list.md)

#### update

 - [Overview](cli-ref/catalog/update/index.md)

 - [clickhouse](cli-ref/catalog/update/clickhouse.md)

 - [delta-lake](cli-ref/catalog/update/delta-lake.md)

 - [greenplum](cli-ref/catalog/update/greenplum.md)

 - [hive](cli-ref/catalog/update/hive.md)

 - [hudi](cli-ref/catalog/update/hudi.md)

 - [iceberg](cli-ref/catalog/update/iceberg.md)

 - [mysql](cli-ref/catalog/update/mysql.md)

 - [oracle](cli-ref/catalog/update/oracle.md)

 - [postgresql](cli-ref/catalog/update/postgresql.md)

 - [sqlserver](cli-ref/catalog/update/sqlserver.md)

 - [tpcds](cli-ref/catalog/update/tpcds.md)

 - [tpch](cli-ref/catalog/update/tpch.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [get-access-control](cli-ref/cluster/get-access-control.md)

 - [get-resource-groups](cli-ref/cluster/get-resource-groups.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [remove-access-control](cli-ref/cluster/remove-access-control.md)

 - [remove-resource-groups](cli-ref/cluster/remove-resource-groups.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [set-access-control](cli-ref/cluster/set-access-control.md)

 - [set-resource-groups](cli-ref/cluster/set-resource-groups.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### catalog

 - [Overview](cli-ref/v0/catalog/index.md)

##### create

 - [Overview](cli-ref/v0/catalog/create/index.md)

 - [clickhouse](cli-ref/v0/catalog/create/clickhouse.md)

 - [delta-lake](cli-ref/v0/catalog/create/delta-lake.md)

 - [greenplum](cli-ref/v0/catalog/create/greenplum.md)

 - [hive](cli-ref/v0/catalog/create/hive.md)

 - [hudi](cli-ref/v0/catalog/create/hudi.md)

 - [iceberg](cli-ref/v0/catalog/create/iceberg.md)

 - [mysql](cli-ref/v0/catalog/create/mysql.md)

 - [oracle](cli-ref/v0/catalog/create/oracle.md)

 - [postgresql](cli-ref/v0/catalog/create/postgresql.md)

 - [sqlserver](cli-ref/v0/catalog/create/sqlserver.md)

 - [tpcds](cli-ref/v0/catalog/create/tpcds.md)

 - [tpch](cli-ref/v0/catalog/create/tpch.md)

 - [delete](cli-ref/v0/catalog/delete.md)

 - [get](cli-ref/v0/catalog/get.md)

 - [list](cli-ref/v0/catalog/list.md)

##### update

 - [Overview](cli-ref/v0/catalog/update/index.md)

 - [clickhouse](cli-ref/v0/catalog/update/clickhouse.md)

 - [delta-lake](cli-ref/v0/catalog/update/delta-lake.md)

 - [greenplum](cli-ref/v0/catalog/update/greenplum.md)

 - [hive](cli-ref/v0/catalog/update/hive.md)

 - [hudi](cli-ref/v0/catalog/update/hudi.md)

 - [iceberg](cli-ref/v0/catalog/update/iceberg.md)

 - [mysql](cli-ref/v0/catalog/update/mysql.md)

 - [oracle](cli-ref/v0/catalog/update/oracle.md)

 - [postgresql](cli-ref/v0/catalog/update/postgresql.md)

 - [sqlserver](cli-ref/v0/catalog/update/sqlserver.md)

 - [tpcds](cli-ref/v0/catalog/update/tpcds.md)

 - [tpch](cli-ref/v0/catalog/update/tpch.md)

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [get-access-control](cli-ref/v0/cluster/get-access-control.md)

 - [get-resource-groups](cli-ref/v0/cluster/get-resource-groups.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [remove-access-control](cli-ref/v0/cluster/remove-access-control.md)

 - [remove-resource-groups](cli-ref/v0/cluster/remove-resource-groups.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [set-access-control](cli-ref/v0/cluster/set-access-control.md)

 - [set-resource-groups](cli-ref/v0/cluster/set-resource-groups.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Catalog

 - [Overview](api-ref/grpc/Catalog/index.md)

 - [Get](api-ref/grpc/Catalog/get.md)

 - [List](api-ref/grpc/Catalog/list.md)

 - [Create](api-ref/grpc/Catalog/create.md)

 - [Update](api-ref/grpc/Catalog/update.md)

 - [Delete](api-ref/grpc/Catalog/delete.md)

#### Cluster

 - [Overview](api-ref/grpc/Cluster/index.md)

 - [Get](api-ref/grpc/Cluster/get.md)

 - [List](api-ref/grpc/Cluster/list.md)

 - [Create](api-ref/grpc/Cluster/create.md)

 - [Update](api-ref/grpc/Cluster/update.md)

 - [Delete](api-ref/grpc/Cluster/delete.md)

 - [Start](api-ref/grpc/Cluster/start.md)

 - [Stop](api-ref/grpc/Cluster/stop.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Catalog

 - [Overview](api-ref/Catalog/index.md)

 - [Get](api-ref/Catalog/get.md)

 - [List](api-ref/Catalog/list.md)

 - [Create](api-ref/Catalog/create.md)

 - [Update](api-ref/Catalog/update.md)

 - [Delete](api-ref/Catalog/delete.md)

#### Cluster

 - [Overview](api-ref/Cluster/index.md)

 - [Get](api-ref/Cluster/get.md)

 - [List](api-ref/Cluster/list.md)

 - [Create](api-ref/Cluster/create.md)

 - [Update](api-ref/Cluster/update.md)

 - [Delete](api-ref/Cluster/delete.md)

 - [Start](api-ref/Cluster/start.md)

 - [Stop](api-ref/Cluster/stop.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security.md)

 - [Правила тарификации](pricing.md)

 - [Метрики Yandex Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)