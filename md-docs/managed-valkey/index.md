# Yandex Managed Service for Valkey™

Сервис Yandex Managed Service for Valkey™ помогает разворачивать и поддерживать кластеры серверов <a href="https://valkey.io/">Valkey™</a> 7.2, 8.0, 8.1 и 9.0 в инфраструктуре Yandex Cloud. Valkey™ — это совместимая с Redis высокопроизводительная СУБД класса NoSQL с открытым исходным кодом, работающая с данными типа «ключ-значение».

Yandex Managed Service for Valkey™ часто используется, чтобы: <ul>
  <li>Создавать сервер очередей (механизм «публикация-подписка»).</li>
  <li>Кешировать результаты запросов к основной базе данных.</li>
  <li>Кешировать промежуточные результаты при обработке данных.</li>
  <li>Управлять сессиями пользователей и счетчиками: количество пользователей онлайн, просмотры и т.д.</li>
</ul>

Управлять сервисом можно с помощью консоли управления, интерфейса командной строки Yandex Cloud (CLI), API или Terraform.

Инфраструктура Yandex Cloud <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами:

<ul> <li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li> </ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>.

Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_mdb">Уровень обслуживания Yandex Managed Databases</a>.

# Yandex Managed Service for Valkey™

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение настроек кластера](operations/update.md)

 - [Обновление версии Valkey™](operations/cluster-version-update.md)

 - [Работа с модулями Valkey™](operations/modules.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление хостами кластера](operations/hosts.md)

 - [Миграция хостов в другую зону доступности](operations/host-migration.md)

 - [Управление резервными копиями](operations/cluster-backups.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключение

 - [Предварительная настройка](operations/connect/index.md)

 - [FQDN хостов](operations/connect/fqdn.md)

 - [Подключение из приложений](operations/connect/clients.md)

#### Примеры кода

 - [Обзор](operations/connect/code-examples.md)

 - [Примеры для подключения к нешардированному кластеру](operations/connect/non-sharded-code-examples.md)

 - [Примеры для подключения к шардированному кластеру](operations/connect/sharded-code-examples.md)

### Базы данных

 - [Запросы в Yandex WebSQL](operations/web-sql-query.md)

### Пользователи

 - [Получение информации о пользователях](operations/user-list.md)

 - [Создание пользователя](operations/user-create.md)

 - [Изменение настроек пользователя](operations/user-update.md)

 - [Удаление пользователя](operations/user-delete.md)

### Шардирование и отказоустойчивость

 - [Управление шардами](operations/shards.md)

 - [Переключение мастера](operations/failover.md)

### Логи и мониторинг

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Мониторинг состояния кластера, хостов и шардов](operations/monitoring.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Хранение сессий PHP в Yandex Managed Service for Valkey™](tutorials/valkey-as-php-sessions-storage.md)

 - [Миграция базы данных в Yandex Managed Service for Valkey™](tutorials/data-migration.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

### Классы хостов

 - [Действующие классы хостов](concepts/instance-types.md)

#### Архив

 - [До 20 июня 2023 года](concepts/instance-types-archive/instance-types-20062023.md)

 - [Сеть в Yandex Managed Service for Valkey™](concepts/network.md)

 - [Шардирование](concepts/sharding.md)

 - [Резервные копии](concepts/backup.md)

 - [Репликация и отказоустойчивость](concepts/replication.md)

 - [Поддерживаемые клиенты](concepts/supported-clients.md)

 - [Управление памятью](concepts/memory-management.md)

 - [Доступные команды](concepts/supported-features.md)

 - [Модули Valkey™](concepts/modules.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Хранилище](concepts/storage.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Настройки Valkey™](concepts/settings-list.md)

 - [Политика поддержки версий Valkey™](concepts/update-policy.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### backup

 - [Overview](cli-ref/backup/index.md)

 - [delete](cli-ref/backup/delete.md)

 - [get](cli-ref/backup/get.md)

 - [list](cli-ref/backup/list.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [add-labels](cli-ref/cluster/add-labels.md)

 - [backup](cli-ref/cluster/backup.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [enable-sharding](cli-ref/cluster/enable-sharding.md)

 - [get](cli-ref/cluster/get.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-backups](cli-ref/cluster/list-backups.md)

 - [list-logs](cli-ref/cluster/list-logs.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [move](cli-ref/cluster/move.md)

 - [rebalance](cli-ref/cluster/rebalance.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/cluster/restore.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [start-failover](cli-ref/cluster/start-failover.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

 - [update-config](cli-ref/cluster/update-config.md)

### hosts

 - [Overview](cli-ref/hosts/index.md)

 - [add](cli-ref/hosts/add.md)

 - [delete](cli-ref/hosts/delete.md)

 - [list](cli-ref/hosts/list.md)

 - [update](cli-ref/hosts/update.md)

### resource-preset

 - [Overview](cli-ref/resource-preset/index.md)

 - [get](cli-ref/resource-preset/get.md)

 - [list](cli-ref/resource-preset/list.md)

### shards

 - [Overview](cli-ref/shards/index.md)

 - [add](cli-ref/shards/add.md)

 - [delete](cli-ref/shards/delete.md)

 - [get](cli-ref/shards/get.md)

 - [list](cli-ref/shards/list.md)

### user

 - [Overview](cli-ref/user/index.md)

 - [create](cli-ref/user/create.md)

 - [delete](cli-ref/user/delete.md)

 - [get](cli-ref/user/get.md)

 - [list](cli-ref/user/list.md)

 - [update](cli-ref/user/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### backup

 - [Overview](cli-ref/v0/backup/index.md)

 - [delete](cli-ref/v0/backup/delete.md)

 - [get](cli-ref/v0/backup/get.md)

 - [list](cli-ref/v0/backup/list.md)

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [add-labels](cli-ref/v0/cluster/add-labels.md)

 - [backup](cli-ref/v0/cluster/backup.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [enable-sharding](cli-ref/v0/cluster/enable-sharding.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-backups](cli-ref/v0/cluster/list-backups.md)

 - [list-logs](cli-ref/v0/cluster/list-logs.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [move](cli-ref/v0/cluster/move.md)

 - [rebalance](cli-ref/v0/cluster/rebalance.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/v0/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/v0/cluster/restore.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [start-failover](cli-ref/v0/cluster/start-failover.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

 - [update-config](cli-ref/v0/cluster/update-config.md)

#### hosts

 - [Overview](cli-ref/v0/hosts/index.md)

 - [add](cli-ref/v0/hosts/add.md)

 - [delete](cli-ref/v0/hosts/delete.md)

 - [list](cli-ref/v0/hosts/list.md)

 - [update](cli-ref/v0/hosts/update.md)

#### resource-preset

 - [Overview](cli-ref/v0/resource-preset/index.md)

 - [get](cli-ref/v0/resource-preset/get.md)

 - [list](cli-ref/v0/resource-preset/list.md)

#### shards

 - [Overview](cli-ref/v0/shards/index.md)

 - [add](cli-ref/v0/shards/add.md)

 - [delete](cli-ref/v0/shards/delete.md)

 - [get](cli-ref/v0/shards/get.md)

 - [list](cli-ref/v0/shards/list.md)

#### user

 - [Overview](cli-ref/v0/user/index.md)

 - [create](cli-ref/v0/user/create.md)

 - [delete](cli-ref/v0/user/delete.md)

 - [get](cli-ref/v0/user/get.md)

 - [list](cli-ref/v0/user/list.md)

 - [update](cli-ref/v0/user/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Backup

 - [Overview](api-ref/grpc/Backup/index.md)

 - [Get](api-ref/grpc/Backup/get.md)

 - [List](api-ref/grpc/Backup/list.md)

 - [Delete](api-ref/grpc/Backup/delete.md)

#### Cluster

 - [Overview](api-ref/grpc/Cluster/index.md)

 - [Get](api-ref/grpc/Cluster/get.md)

 - [List](api-ref/grpc/Cluster/list.md)

 - [Create](api-ref/grpc/Cluster/create.md)

 - [Update](api-ref/grpc/Cluster/update.md)

 - [Delete](api-ref/grpc/Cluster/delete.md)

 - [Start](api-ref/grpc/Cluster/start.md)

 - [Stop](api-ref/grpc/Cluster/stop.md)

 - [Move](api-ref/grpc/Cluster/move.md)

 - [Backup](api-ref/grpc/Cluster/backup.md)

 - [Restore](api-ref/grpc/Cluster/restore.md)

 - [RescheduleMaintenance](api-ref/grpc/Cluster/rescheduleMaintenance.md)

 - [StartFailover](api-ref/grpc/Cluster/startFailover.md)

 - [ListLogs](api-ref/grpc/Cluster/listLogs.md)

 - [StreamLogs](api-ref/grpc/Cluster/streamLogs.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListBackups](api-ref/grpc/Cluster/listBackups.md)

 - [ListHosts](api-ref/grpc/Cluster/listHosts.md)

 - [AddHosts](api-ref/grpc/Cluster/addHosts.md)

 - [DeleteHosts](api-ref/grpc/Cluster/deleteHosts.md)

 - [UpdateHosts](api-ref/grpc/Cluster/updateHosts.md)

 - [GetShard](api-ref/grpc/Cluster/getShard.md)

 - [ListShards](api-ref/grpc/Cluster/listShards.md)

 - [AddShard](api-ref/grpc/Cluster/addShard.md)

 - [DeleteShard](api-ref/grpc/Cluster/deleteShard.md)

 - [Rebalance](api-ref/grpc/Cluster/rebalance.md)

 - [EnableSharding](api-ref/grpc/Cluster/enableSharding.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### ResourcePreset

 - [Overview](api-ref/grpc/ResourcePreset/index.md)

 - [Get](api-ref/grpc/ResourcePreset/get.md)

 - [List](api-ref/grpc/ResourcePreset/list.md)

#### User

 - [Overview](api-ref/grpc/User/index.md)

 - [Get](api-ref/grpc/User/get.md)

 - [List](api-ref/grpc/User/list.md)

 - [Create](api-ref/grpc/User/create.md)

 - [Update](api-ref/grpc/User/update.md)

 - [Delete](api-ref/grpc/User/delete.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Backup

 - [Overview](api-ref/Backup/index.md)

 - [Get](api-ref/Backup/get.md)

 - [List](api-ref/Backup/list.md)

 - [Delete](api-ref/Backup/delete.md)

#### Cluster

 - [Overview](api-ref/Cluster/index.md)

 - [Get](api-ref/Cluster/get.md)

 - [List](api-ref/Cluster/list.md)

 - [Create](api-ref/Cluster/create.md)

 - [Update](api-ref/Cluster/update.md)

 - [Delete](api-ref/Cluster/delete.md)

 - [Start](api-ref/Cluster/start.md)

 - [Stop](api-ref/Cluster/stop.md)

 - [Move](api-ref/Cluster/move.md)

 - [Backup](api-ref/Cluster/backup.md)

 - [Restore](api-ref/Cluster/restore.md)

 - [RescheduleMaintenance](api-ref/Cluster/rescheduleMaintenance.md)

 - [StartFailover](api-ref/Cluster/startFailover.md)

 - [ListLogs](api-ref/Cluster/listLogs.md)

 - [StreamLogs](api-ref/Cluster/streamLogs.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListBackups](api-ref/Cluster/listBackups.md)

 - [ListHosts](api-ref/Cluster/listHosts.md)

 - [AddHosts](api-ref/Cluster/addHosts.md)

 - [DeleteHosts](api-ref/Cluster/deleteHosts.md)

 - [UpdateHosts](api-ref/Cluster/updateHosts.md)

 - [GetShard](api-ref/Cluster/getShard.md)

 - [ListShards](api-ref/Cluster/listShards.md)

 - [AddShard](api-ref/Cluster/addShard.md)

 - [DeleteShard](api-ref/Cluster/deleteShard.md)

 - [Rebalance](api-ref/Cluster/rebalance.md)

 - [EnableSharding](api-ref/Cluster/enableSharding.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### ResourcePreset

 - [Overview](api-ref/ResourcePreset/index.md)

 - [Get](api-ref/ResourcePreset/get.md)

 - [List](api-ref/ResourcePreset/list.md)

#### User

 - [Overview](api-ref/User/index.md)

 - [Get](api-ref/User/get.md)

 - [List](api-ref/User/list.md)

 - [Create](api-ref/User/create.md)

 - [Update](api-ref/User/update.md)

 - [Delete](api-ref/User/delete.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/general.md)