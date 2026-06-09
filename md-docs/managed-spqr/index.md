# Yandex Managed Service for Sharded PostgreSQL

Сервис Managed Service for Sharded PostgreSQL помогает разворачивать кластеры шардированного PostgreSQL (<a href="https://pg-sharding.tech/">SPQR</a>) в инфраструктуре Yandex Cloud.

SPQR (Stateless Postgres Query Router) — это система горизонтального масштабирования PostgreSQL через шардирование, основанная на технологиях <a href="https://opensource.yandex/projects/">Yandex Open Source</a>.

Сервис находится на стадии <a href="../overview/concepts/launch-stages.md">Preview</a>. Запросить доступ можно на <a href="https://yandex.cloud/ru/services/managed-spqr">странице сервиса</a>.

Инфраструктура Yandex Cloud <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами:

<ul> <li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li> </ul>

# Yandex Managed Service for Sharded PostgreSQL

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Получение информации об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Подключение к базе данных](operations/connect.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Изменение кластера](operations/cluster-update.md)

 - [Управление хостами кластера](operations/cluster-hosts.md)

 - [Управление шардами](operations/shards.md)

 - [Управление резервными копиями](operations/cluster-backups.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Мониторинг состояния кластера и хостов](operations/monitoring.md)

 - [Удаление кластера](operations/cluster-delete.md)

 - [Управление пользователями](operations/cluster-users.md)

 - [Управление базами данных](operations/databases.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Шардирование](concepts/sharding.md)

 - [Ключи шардирования](concepts/sharding-keys.md)

 - [Выбор стратегии шардирования](concepts/sharding-method.md)

 - [Классы хостов](concepts/instance-types.md)

 - [Хранилище в Sharded PostgreSQL](concepts/storage.md)

 - [Резервные копии](concepts/backup.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Настройки Sharded PostgreSQL](concepts/settings-list.md)

 - [Политика поддержки версий Sharded PostgreSQL](concepts/update-policy.md)

 - [Управление доступом](security.md)

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

 - [add-labels](cli-ref/cluster/add-labels.md)

 - [add-subcluster](cli-ref/cluster/add-subcluster.md)

 - [backup](cli-ref/cluster/backup.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [list](cli-ref/cluster/list.md)

 - [list-backups](cli-ref/cluster/list-backups.md)

 - [list-logs](cli-ref/cluster/list-logs.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [remove-labels](cli-ref/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/cluster/restore.md)

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

 - [update](cli-ref/hosts/update.md)

 - [resource-preset](cli-ref/resource-preset.md)

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

 - [add-labels](cli-ref/v0/cluster/add-labels.md)

 - [add-subcluster](cli-ref/v0/cluster/add-subcluster.md)

 - [backup](cli-ref/v0/cluster/backup.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-backups](cli-ref/v0/cluster/list-backups.md)

 - [list-logs](cli-ref/v0/cluster/list-logs.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [remove-labels](cli-ref/v0/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/v0/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/v0/cluster/restore.md)

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

 - [update](cli-ref/v0/hosts/update.md)

 - [resource-preset](cli-ref/v0/resource-preset.md)

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

 - [AddSubcluster](api-ref/grpc/Cluster/addSubcluster.md)

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

 - [UpdateHosts](api-ref/grpc/Cluster/updateHosts.md)

 - [DeleteHosts](api-ref/grpc/Cluster/deleteHosts.md)

 - [ResetupHosts](api-ref/grpc/Cluster/resetupHosts.md)

 - [GetShard](api-ref/grpc/Cluster/getShard.md)

 - [ListShards](api-ref/grpc/Cluster/listShards.md)

 - [AddShard](api-ref/grpc/Cluster/addShard.md)

 - [DeleteShard](api-ref/grpc/Cluster/deleteShard.md)

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

 - [AddSubcluster](api-ref/Cluster/addSubcluster.md)

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

 - [UpdateHosts](api-ref/Cluster/updateHosts.md)

 - [DeleteHosts](api-ref/Cluster/deleteHosts.md)

 - [ResetupHosts](api-ref/Cluster/resetupHosts.md)

 - [GetShard](api-ref/Cluster/getShard.md)

 - [ListShards](api-ref/Cluster/listShards.md)

 - [AddShard](api-ref/Cluster/addShard.md)

 - [DeleteShard](api-ref/Cluster/deleteShard.md)

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

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Распределенные запросы](qa/distributed-queries.md)

 - [Подключение](qa/connection.md)

 - [Безопасность](qa/security.md)

 - [Производительность](qa/performance.md)

 - [Миграция](qa/migration.md)

 - [Ограничения](qa/limitations.md)

 - [Устранение неполадок](qa/troubleshooting.md)

 - [Все вопросы на одной странице](qa/all.md)