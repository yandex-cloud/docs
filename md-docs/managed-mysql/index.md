# Yandex Managed Service for MySQL<sup>®</sup>

Managed Service for MySQL<sup>®</sup> помогает разворачивать и поддерживать кластеры серверов MySQL<sup>®</sup> в инфраструктуре {{ yandex-cloud }}. Сервис поддерживает MySQL<sup>®</sup> 5.7 и MySQL<sup>®</sup> 8.0.

Инфраструктура {{ yandex-cloud }} <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами:

<ul> <li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li> </ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>.

Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_mdb">Уровень обслуживания Yandex Managed Databases</a>.

# Yandex Managed Service for MySQL®

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение кластера](operations/update.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление хостами кластера](operations/hosts.md)

 - [Миграция хостов в другую зону доступности](operations/host-migration.md)

 - [Управление резервными копиями](operations/cluster-backups.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Обновление версии {{ MY }}](operations/cluster-version-update.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключение

 - [Предварительная настройка](operations/connect/index.md)

 - [FQDN хостов](operations/connect/fqdn.md)

 - [Подключение из приложений](operations/connect/clients.md)

 - [Примеры кода](operations/connect/code-examples.md)

### Базы данных

 - [SQL-запросы в {{ websql-full-name }}](operations/web-sql-query.md)

 - [Управление базами данных](operations/databases.md)

### Пользователи {{ MY }}

 - [Управление пользователями](operations/cluster-users.md)

 - [Управление правами пользователей](operations/grant.md)

### Логи и мониторинг

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Диагностика производительности](operations/performance-diagnostics.md)

 - [Мониторинг состояния кластера и хостов](operations/monitoring.md)

 - [Подключение из {{ datalens-name }}](operations/datalens-connect.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

### Классы хостов

 - [Действующие классы хостов](concepts/instance-types.md)

#### Архив

 - [До 1 июня 2020 года](concepts/instance-types-archive/instance-types-01062020.md)

 - [До 20 июня 2023 года](concepts/instance-types-archive/instance-types-20062023.md)

 - [Использование устаревших классов хостов](concepts/using-deprecated-instances.md)

 - [Высокая доступность кластера](concepts/high-availability.md)

 - [Сеть в Managed Service for MySQL](concepts/network.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Хранилище в {{ mmy-name }}](concepts/storage.md)

 - [Резервные копии](concepts/backup.md)

 - [Репликация](concepts/replication.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Права пользователей](concepts/user-rights.md)

 - [Настройки MySQL](concepts/settings-list.md)

 - [Ограничения для команд SQL](concepts/sql-limits.md)

 - [Сравнение {{ MY }} версий 5.7 и 8.0](concepts/mysql-57-80-comparison.md)

 - [Политика поддержки версий {{ MY }}](concepts/update-policy.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Анализ производительности и оптимизация {{ mmy-name }}](tutorials/profiling-mmy.md)

 - [Выгрузка базы данных в {{ dataproc-full-name }}](tutorials/sqoop.md)

### Миграция базы данных из стороннего кластера {{ MY }}

 - [Обзор](tutorials/data-migration/index.md)

 - [Перенос данных с использованием сервиса {{ data-transfer-name }}](tutorials/data-migration/data-transfer.md)

 - [Перенос данных с помощью логического дампа](tutorials/data-migration/logical-dump-migration.md)

 - [Миграция базы данных из {{ mmy-name }} в {{ MY }}](tutorials/mmy-to-mysql-migration.md)

 - [Поставка данных из {{ mkf-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/mkf-mmy-data-transfer.md)

 - [Поставка данных в {{ mkf-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/cdc-data-transfer.md)

 - [Поставка данных в {{ mkf-full-name }} с помощью Debezium](tutorials/cdc-debezium.md)

### Сайт на WordPress с БД {{ MY }}

 - [Обзор](tutorials/wordpress-mysql/index.md)

 - [Консоль управления](tutorials/wordpress-mysql/console.md)

 - [{{ TF }}](tutorials/wordpress-mysql/terraform.md)

### Создание сайта на базе «1С-Битрикс»

 - [Обзор](tutorials/bitrix-website/index.md)

 - [Консоль управления](tutorials/bitrix-website/console.md)

 - [{{ TF }}](tutorials/bitrix-website/terraform.md)

### Интернет-магазин на «1С-Битрикс»

 - [Обзор](tutorials/bitrix-shop/index.md)

 - [Консоль управления](tutorials/bitrix-shop/console.md)

 - [{{ TF }}](tutorials/bitrix-shop/terraform.md)

### Интернет-магазин на платформе OpenCart

 - [Обзор](tutorials/opencart/index.md)

 - [Консоль управления](tutorials/opencart/console.md)

 - [{{ TF }}](tutorials/opencart/terraform.md)

 - [Миграция базы данных в {{ ydb-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/mmy-ydb-migration.md)

 - [Миграция базы данных из {{ mmy-name }} в {{ objstorage-full-name }}](tutorials/mmy-objs-migration.md)

 - [Перенос данных из {{ objstorage-full-name }} в {{ mmy-name }}](tutorials/objs-mmy-migration.md)

 - [Захват изменений {{ MY }} и поставка в {{ DS }}](tutorials/mmy-to-yds.md)

 - [Миграция данных из {{ mpg-full-name }} в {{ mmy-name }} с помощью {{ data-transfer-full-name }}](tutorials/mpg-to-mmy.md)

 - [Миграция данных из {{ mmy-name }} в {{ mpg-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/mmy-to-mpg.md)

 - [Миграция данных из {{ mmy-name }} в {{ mgp-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/mmy-to-mgp.md)

 - [Синхронизация данных из стороннего кластера {{ MY }} в {{ mmy-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/sync-mysql.md)

 - [Миграция базы данных из {{ MY }} в {{ CH }} с помощью {{ data-transfer-full-name }}](tutorials/mysql-to-clickhouse.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### backup

 - [Overview](cli-ref/backup/index.md)

 - [get](cli-ref/backup/get.md)

 - [list](cli-ref/backup/list.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [add-labels](cli-ref/cluster/add-labels.md)

 - [backup](cli-ref/cluster/backup.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

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

 - [start-failover](cli-ref/cluster/start-failover.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

 - [update-config](cli-ref/cluster/update-config.md)

 - [connect](cli-ref/connect.md)

### database

 - [Overview](cli-ref/database/index.md)

 - [create](cli-ref/database/create.md)

 - [delete](cli-ref/database/delete.md)

 - [get](cli-ref/database/get.md)

 - [list](cli-ref/database/list.md)

 - [update](cli-ref/database/update.md)

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

 - [get](cli-ref/v0/backup/get.md)

 - [list](cli-ref/v0/backup/list.md)

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [add-labels](cli-ref/v0/cluster/add-labels.md)

 - [backup](cli-ref/v0/cluster/backup.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

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

 - [start-failover](cli-ref/v0/cluster/start-failover.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

 - [update-config](cli-ref/v0/cluster/update-config.md)

 - [connect](cli-ref/v0/connect.md)

#### database

 - [Overview](cli-ref/v0/database/index.md)

 - [create](cli-ref/v0/database/create.md)

 - [delete](cli-ref/v0/database/delete.md)

 - [get](cli-ref/v0/database/get.md)

 - [list](cli-ref/v0/database/list.md)

 - [update](cli-ref/v0/database/update.md)

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

#### user

 - [Overview](cli-ref/v0/user/index.md)

 - [create](cli-ref/v0/user/create.md)

 - [delete](cli-ref/v0/user/delete.md)

 - [get](cli-ref/v0/user/get.md)

 - [grant-permission](cli-ref/v0/user/grant-permission.md)

 - [list](cli-ref/v0/user/list.md)

 - [revoke-permission](cli-ref/v0/user/revoke-permission.md)

 - [update](cli-ref/v0/user/update.md)

 - [Справочник {{ TF }}](tf-ref.md)

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

 - [UpdateHosts](api-ref/grpc/Cluster/updateHosts.md)

 - [DeleteHosts](api-ref/grpc/Cluster/deleteHosts.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Database

 - [Overview](api-ref/grpc/Database/index.md)

 - [Get](api-ref/grpc/Database/get.md)

 - [List](api-ref/grpc/Database/list.md)

 - [Create](api-ref/grpc/Database/create.md)

 - [Update](api-ref/grpc/Database/update.md)

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

 - [UpdateHosts](api-ref/Cluster/updateHosts.md)

 - [DeleteHosts](api-ref/Cluster/deleteHosts.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Database

 - [Overview](api-ref/Database/index.md)

 - [Get](api-ref/Database/get.md)

 - [List](api-ref/Database/list.md)

 - [Create](api-ref/Database/create.md)

 - [Update](api-ref/Database/update.md)

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

 - [Метрики {{ monitoring-name }}](metrics.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Вопросы о MySQL](qa/mysql.md)

 - [Подключение](qa/connection.md)

 - [Проблемы с чтением/записью в кластер](qa/read-write.md)

 - [Проблемы с производительностью](qa/performance.md)

 - [Изменение кластера](qa/updating.md)

 - [Мониторинг и логи](qa/monitoring.md)

 - [Миграция/перенос](qa/migration.md)

 - [Настройки параметров MySQL](qa/configuring.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Обучающие курсы](training.md)