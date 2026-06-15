# Yandex StoreDoc

Сервис помогает разворачивать и поддерживать кластеры серверов Yandex StoreDoc 6.0 и 7.0 в инфраструктуре Yandex Cloud. Yandex StoreDoc — это совместимая с MongoDB высокопроизводительная NoSQL СУБД с открытым исходным кодом.

Сервис Yandex StoreDoc позволяет: <ul> <li>Не указывая схему формата данных, создавать системы, в которых требуется обработка и хранение большого объема полуструктурированных и неструктурированных данных.</li> <li>Поддерживать системы/работать с системами, которым нужна масштабируемость по вертикали и горизонтали.</li> <li>Анализировать данные, в том числе большие (big data), в реальном времени.</li> <li>Обрабатывать транзакции в реальном времени <a href="../glossary/oltp.md">(OLTP)</a>.</li> <li>Обрабатывать аналитические запросы в режиме онлайн <a href="../glossary/olap.md">(OLAP)</a>.</li> <li>Использовать полнотекстовый поиск.</li> </ul>

Взаимодействие с сервисом осуществляется с помощью консоли управления, интерфейса командной строки Yandex Cloud (CLI), API или Terraform.

Инфраструктура Yandex Cloud <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами:

<ul> <li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li> </ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>.

Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_mdb">Уровень обслуживания Yandex Managed Databases</a>.

# Yandex StoreDoc

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение настроек кластера](operations/update.md)

 - [Обновление версии Yandex StoreDoc](operations/cluster-version-update.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление хостами кластера](operations/hosts.md)

 - [Миграция хостов в другую зону доступности](operations/host-migration.md)

 - [Управление резервными копиями](operations/cluster-backups.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключение

 - [Предварительная настройка](operations/connect/index.md)

 - [Подключение из приложений](operations/connect/clients.md)

#### Примеры кода

 - [Обзор](operations/connect/code-examples.md)

 - [Примеры для подключения к нешардированному кластеру](operations/connect/non-sharded.md)

 - [Примеры для подключения к шардированному кластеру](operations/connect/sharded.md)

### Базы данных

 - [SQL-запросы в Yandex WebSQL](operations/websql.md)

 - [Управление базами данных](operations/databases.md)

 - [Управление пользователями БД](operations/cluster-users.md)

### Шардирование и репликация

 - [Управление шардами](operations/shards.md)

 - [Переключение первичной реплики](operations/stepdown.md)

### Логи и мониторинг

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Диагностика производительности](operations/performance-diagnostics.md)

 - [Инструменты для анализа производительности](operations/tools.md)

 - [Мониторинг состояния кластера, хостов и шардов](operations/monitoring.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Шардирование коллекций](tutorials/sharding.md)

 - [Миграция данных в Yandex StoreDoc](tutorials/data-migration.md)

 - [Миграция кластера Yandex StoreDoc с версии 4.4 на 6.0](tutorials/storedoc-versions.md)

 - [Миграция коллекций из стороннего кластера Yandex StoreDoc](tutorials/storedoc-migration-with-data-transfer.md)

 - [Анализ производительности и оптимизация Yandex StoreDoc](tutorials/profiling.md)

 - [Поставка данных из Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](tutorials/migration-from-kafka.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

### Классы хостов

 - [Действующие классы хостов](concepts/instance-types.md)

#### Архив

 - [До 1 июня 2020 года](concepts/instance-types-archive/instance-types-01062020.md)

 - [До 20 июня 2023 года](concepts/instance-types-archive/instance-types-20062023.md)

 - [Использование устаревших классов хостов](concepts/using-deprecated-instances.md)

 - [Сеть в Yandex StoreDoc](concepts/network.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Хранилище в Yandex StoreDoc](concepts/storage.md)

 - [Резервные копии](concepts/backup.md)

 - [Репликация](concepts/replication.md)

 - [Высокая доступность кластера](concepts/high-availability.md)

 - [Шардирование](concepts/sharding.md)

 - [Типы хостов](concepts/host-roles.md)

 - [Пользователи и роли](concepts/users-and-roles.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Поддерживаемые клиенты](concepts/supported-clients.md)

 - [Настройки Yandex StoreDoc](concepts/settings-list.md)

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

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/cluster/restore.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

 - [update-config](cli-ref/cluster/update-config.md)

### database

 - [Overview](cli-ref/database/index.md)

 - [create](cli-ref/database/create.md)

 - [delete](cli-ref/database/delete.md)

 - [get](cli-ref/database/get.md)

 - [list](cli-ref/database/list.md)

### hosts

 - [Overview](cli-ref/hosts/index.md)

 - [add](cli-ref/hosts/add.md)

 - [delete](cli-ref/hosts/delete.md)

 - [list](cli-ref/hosts/list.md)

 - [resetup](cli-ref/hosts/resetup.md)

 - [restart](cli-ref/hosts/restart.md)

 - [stepdown](cli-ref/hosts/stepdown.md)

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

 - [grant-permission](cli-ref/user/grant-permission.md)

 - [list](cli-ref/user/list.md)

 - [revoke-permission](cli-ref/user/revoke-permission.md)

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

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/v0/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/v0/cluster/restore.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

 - [update-config](cli-ref/v0/cluster/update-config.md)

#### database

 - [Overview](cli-ref/v0/database/index.md)

 - [create](cli-ref/v0/database/create.md)

 - [delete](cli-ref/v0/database/delete.md)

 - [get](cli-ref/v0/database/get.md)

 - [list](cli-ref/v0/database/list.md)

#### hosts

 - [Overview](cli-ref/v0/hosts/index.md)

 - [add](cli-ref/v0/hosts/add.md)

 - [delete](cli-ref/v0/hosts/delete.md)

 - [list](cli-ref/v0/hosts/list.md)

 - [resetup](cli-ref/v0/hosts/resetup.md)

 - [restart](cli-ref/v0/hosts/restart.md)

 - [stepdown](cli-ref/v0/hosts/stepdown.md)

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

 - [grant-permission](cli-ref/v0/user/grant-permission.md)

 - [list](cli-ref/v0/user/list.md)

 - [revoke-permission](cli-ref/v0/user/revoke-permission.md)

 - [update](cli-ref/v0/user/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### BackupRetentionPolicy

 - [Overview](api-ref/grpc/BackupRetentionPolicy/index.md)

 - [List](api-ref/grpc/BackupRetentionPolicy/list.md)

 - [ListByFolder](api-ref/grpc/BackupRetentionPolicy/listByFolder.md)

 - [Create](api-ref/grpc/BackupRetentionPolicy/create.md)

 - [Delete](api-ref/grpc/BackupRetentionPolicy/delete.md)

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

 - [ListLogs](api-ref/grpc/Cluster/listLogs.md)

 - [StreamLogs](api-ref/grpc/Cluster/streamLogs.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListBackups](api-ref/grpc/Cluster/listBackups.md)

 - [ListHosts](api-ref/grpc/Cluster/listHosts.md)

 - [AddHosts](api-ref/grpc/Cluster/addHosts.md)

 - [DeleteHosts](api-ref/grpc/Cluster/deleteHosts.md)

 - [UpdateHosts](api-ref/grpc/Cluster/updateHosts.md)

 - [EnableSharding](api-ref/grpc/Cluster/enableSharding.md)

 - [GetShard](api-ref/grpc/Cluster/getShard.md)

 - [ListShards](api-ref/grpc/Cluster/listShards.md)

 - [AddShard](api-ref/grpc/Cluster/addShard.md)

 - [DeleteShard](api-ref/grpc/Cluster/deleteShard.md)

 - [ResetupHosts](api-ref/grpc/Cluster/resetupHosts.md)

 - [RestartHosts](api-ref/grpc/Cluster/restartHosts.md)

 - [StepdownHosts](api-ref/grpc/Cluster/stepdownHosts.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Database

 - [Overview](api-ref/grpc/Database/index.md)

 - [Get](api-ref/grpc/Database/get.md)

 - [List](api-ref/grpc/Database/list.md)

 - [Create](api-ref/grpc/Database/create.md)

 - [Delete](api-ref/grpc/Database/delete.md)

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

 - [GrantPermission](api-ref/grpc/User/grantPermission.md)

 - [RevokePermission](api-ref/grpc/User/revokePermission.md)

#### Versions

 - [Overview](api-ref/grpc/Versions/index.md)

 - [List](api-ref/grpc/Versions/list.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### BackupRetentionPolicy

 - [Overview](api-ref/BackupRetentionPolicy/index.md)

 - [List](api-ref/BackupRetentionPolicy/list.md)

 - [ListByFolder](api-ref/BackupRetentionPolicy/listByFolder.md)

 - [Create](api-ref/BackupRetentionPolicy/create.md)

 - [Delete](api-ref/BackupRetentionPolicy/delete.md)

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

 - [ListLogs](api-ref/Cluster/listLogs.md)

 - [StreamLogs](api-ref/Cluster/streamLogs.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListBackups](api-ref/Cluster/listBackups.md)

 - [ListHosts](api-ref/Cluster/listHosts.md)

 - [AddHosts](api-ref/Cluster/addHosts.md)

 - [DeleteHosts](api-ref/Cluster/deleteHosts.md)

 - [UpdateHosts](api-ref/Cluster/updateHosts.md)

 - [EnableSharding](api-ref/Cluster/enableSharding.md)

 - [GetShard](api-ref/Cluster/getShard.md)

 - [ListShards](api-ref/Cluster/listShards.md)

 - [AddShard](api-ref/Cluster/addShard.md)

 - [DeleteShard](api-ref/Cluster/deleteShard.md)

 - [ResetupHosts](api-ref/Cluster/resetupHosts.md)

 - [RestartHosts](api-ref/Cluster/restartHosts.md)

 - [StepdownHosts](api-ref/Cluster/stepdownHosts.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Database

 - [Overview](api-ref/Database/index.md)

 - [Get](api-ref/Database/get.md)

 - [List](api-ref/Database/list.md)

 - [Create](api-ref/Database/create.md)

 - [Delete](api-ref/Database/delete.md)

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

 - [GrantPermission](api-ref/User/grantPermission.md)

 - [RevokePermission](api-ref/User/revokePermission.md)

#### Versions

 - [Overview](api-ref/Versions/index.md)

 - [List](api-ref/Versions/list.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Вопросы о Yandex StoreDoc](qa/storedoc.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Обучающие курсы](training.md)