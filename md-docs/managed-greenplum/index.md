# {{ mgp-full-name }}

Сервис {{ mgp-full-name }} помогает разворачивать и поддерживать кластеры с СУБД Greenplum<sup>®</sup> версии 6 и выше и Apache Cloudberry<sup>™</sup> в инфраструктуре {{ yandex-cloud }}.

Greenplum<sup>®</sup> — аналитическая колоночная массово-параллельная (<a href="https://ru.wikipedia.org/wiki/Массово-параллельная_архитектура">MPP</a>) СУБД. MPP-архитектура позволяет хранить и обрабатывать данные на множестве узлов параллельно. Это отличает Greenplum<sup>®</sup> от систем, основанных на симметричной многопроцессорности (<a href="https://ru.wikipedia.org/wiki/Симметричная_многопроцессорность">SMP</a>), в которых масштабирование ограничено одним узлом.

В {{ mgp-full-name }} также доступна СУБД <a href="https://cloudberry.apache.org">Apache Cloudberry<sup>™</sup></a>. Она основана на Greenplum<sup>®</sup> версии 7 и будет базовым дистрибутивом для новых мажорных версий ядра сервиса.

Подробнее о Greenplum<sup>®</sup>, Apache Cloudberry<sup>™</sup> и {{ mgp-full-name }} см. в разделе <a href="concepts/overview.md">Обзор</a>.

Инфраструктура {{ yandex-cloud }} <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами:

<ul><li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li></ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla/ru">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_greenplum/ru">Уровень обслуживания Сервиса Управления MPP PostgreSQL / Yandex MPP Analytics for PostgreSQL</a>.

<em>Greenplum<sup>®</sup> и Greenplum Database<sup>®</sup> являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах.</em>

<em>Apache<sup>®</sup> и Apache Cloudberry<sup>™</sup> являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах.</em>

# Yandex MPP Analytics for PostgreSQL

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Расширение кластера](operations/cluster-expand.md)

 - [Изменение конфигурации кластера](operations/cluster-config.md)

 - [Изменение настроек кластера](operations/update.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление резервными копиями](operations/cluster-backups.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключение

 - [Предварительная настройка](operations/connect/index.md)

 - [FQDN хостов](operations/connect/fqdn.md)

 - [Подключение из приложений](operations/connect/clients.md)

 - [Примеры кода](operations/connect/code-examples.md)

### Базы данных

 - [Управление базами данных](operations/databases.md)

 - [Запросы в {{ websql-full-name }}](operations/web-sql-query.md)

### Пользователи и сессии

 - [Управление ролями и пользователями](operations/roles-and-users.md)

 - [Управление ресурсными группами](operations/resource-groups.md)

 - [Правила аутентификации пользователей](operations/user-auth-rules.md)

 - [Работа с командным центром](operations/command-center.md)

 - [Управление клиентскими процессами и сессиями пользователей](operations/cluster-process.md)

### Работа с PXF

 - [Обзор](operations/external-tables.md)

#### Создание внешних источников данных

 - [S3](operations/pxf/create-s3-source.md)

 - [JDBC](operations/pxf/create-jdbc-source.md)

 - [HDFS](operations/pxf/create-hdfs-source.md)

 - [Hive](operations/pxf/create-hive-source.md)

 - [Создание внешней таблицы](operations/pxf/create-table.md)

 - [Изменение настроек PXF](operations/pxf/settings.md)

 - [Подключение к внешнему файловому серверу (gpfdist)](operations/gpfdist/connect.md)

### Расширения

 - [Управление расширениями](operations/extensions/cluster-extensions.md)

 - [gp_relaccess_stats](operations/extensions/gp_relaccess_stats.md)

 - [gp_relsizes_stats](operations/extensions/gp-relsizes-stats.md)

 - [gp_url_tools](operations/extensions/gp-url-tools.md)

 - [pgcrypto](operations/extensions/pgcrypto.md)

 - [try_convert](operations/extensions/try_convert.md)

 - [uuid-cb](operations/extensions/uuid-cb.md)

 - [Yezzey](operations/extensions/yezzey.md)

### Встроенные функции

 - [Оценка количества уникальных элементов с помощью алгоритма HyperLogLog](operations/embedded-functions/hyperloglog.md)

### Логи и мониторинг

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Просмотр операций кластера](operations/cluster-operations.md)

 - [Мониторинг состояния кластера и хостов](operations/monitoring.md)

 - [Передача логов кластера в {{ cloud-logging-full-name }}](operations/mgp-to-cloud-logging.md)

 - [Чтение логов через SQL](operations/sql-log-access.md)

 - [Вспомогательные утилиты](operations/greenplum-db.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Миграция базы данных в {{ mgp-name }}](tutorials/data-migration.md)

 - [Создание внешней таблицы на базе таблицы из бакета {{ objstorage-name }} с помощью конфигурационного файла](tutorials/config-server-for-s3.md)

 - [Получение данных из внешних источников с помощью именованных запросов](tutorials/pxf-named-queries.md)

 - [Миграция базы данных из {{ GP }} в {{ PG }}](tutorials/greenplum-to-postgresql.md)

 - [Миграция базы данных из {{ GP }} в {{ CH }}](tutorials/greenplum-to-clickhouse.md)

 - [Миграция базы данных из {{ MY }} в {{ GP }}](tutorials/mmy-to-mgp.md)

 - [Выгрузка данных {{ GP }} в холодное хранилище {{ objstorage-name }}](tutorials/yezzey.md)

 - [Загрузка данных из {{ objstorage-name }} в {{ mgp-name }} с помощью {{ data-transfer-name }}](tutorials/object-storage-to-greenplum.md)

 - [Копирование данных из {{ mos-name }} в {{ mgp-name }} с помощью {{ data-transfer-full-name }}](tutorials/opensearch-to-greenplum.md)

### Поставка данных с помощью {{ data-transfer-name }}

 - [Поставка из {{ KF }} в {{ GP }}](tutorials/managed-kafka-to-greenplum.md)

## Концепции

 - [Обзор СУБД {{ GP }} и {{ CB }} в сервисе {{ mgp-full-name }}](concepts/overview.md)

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Классы хостов](concepts/instance-types.md)

 - [Высокая доступность кластера](concepts/high-availability.md)

 - [Расчет конфигурации кластера](concepts/calculate-specs.md)

 - [Сеть в {{ mgp-name }}](concepts/network.md)

### Хранилище в {{ mgp-name }}

 - [Типы дисков](concepts/storage.md)

 - [Типы хранения данных](concepts/tables.md)

 - [Гибридное хранилище](concepts/hybrid-storage.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Резервные копии](concepts/backup.md)

 - [Ресурсные группы](concepts/resource-groups.md)

 - [Шардирование](concepts/sharding.md)

 - [Пользователи и роли](concepts/cluster-users.md)

 - [Аутентификация пользователей](concepts/user-authentication.md)

 - [Командный центр](concepts/command-center.md)

 - [Параметры командного центра](concepts/command-center-parameters.md)

 - [Внешние таблицы](concepts/external-tables.md)

 - [Управление соединениями](concepts/pooling.md)

 - [Расширение кластера](concepts/expand.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Очистка таблиц и системного каталога](concepts/vacuum.md)

 - [Настройки СУБД](concepts/settings-list.md)

 - [Отличия {{ CB }} от {{ GP }}](concepts/cloudberry-vs-greenplum/breaking-changes.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing/index.md)

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

 - [expand](cli-ref/cluster/expand.md)

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

 - [connect](cli-ref/connect.md)

### hba-rules

 - [Overview](cli-ref/hba-rules/index.md)

 - [create](cli-ref/hba-rules/create.md)

 - [delete](cli-ref/hba-rules/delete.md)

 - [get](cli-ref/hba-rules/get.md)

 - [list](cli-ref/hba-rules/list.md)

 - [update](cli-ref/hba-rules/update.md)

### hosts

 - [Overview](cli-ref/hosts/index.md)

#### list

 - [Overview](cli-ref/hosts/list/index.md)

 - [master](cli-ref/hosts/list/master.md)

 - [segment](cli-ref/hosts/list/segment.md)

### pxf-datasource

 - [Overview](cli-ref/pxf-datasource/index.md)

#### create

 - [Overview](cli-ref/pxf-datasource/create/index.md)

 - [jdbc](cli-ref/pxf-datasource/create/jdbc.md)

 - [s3](cli-ref/pxf-datasource/create/s3.md)

 - [delete](cli-ref/pxf-datasource/delete.md)

 - [get](cli-ref/pxf-datasource/get.md)

 - [list](cli-ref/pxf-datasource/list.md)

#### update

 - [Overview](cli-ref/pxf-datasource/update/index.md)

 - [jdbc](cli-ref/pxf-datasource/update/jdbc.md)

 - [s3](cli-ref/pxf-datasource/update/s3.md)

### resource-groups

 - [Overview](cli-ref/resource-groups/index.md)

 - [create](cli-ref/resource-groups/create.md)

 - [delete](cli-ref/resource-groups/delete.md)

 - [get](cli-ref/resource-groups/get.md)

 - [list](cli-ref/resource-groups/list.md)

 - [update](cli-ref/resource-groups/update.md)

### resource-preset

 - [Overview](cli-ref/resource-preset/index.md)

#### get

 - [Overview](cli-ref/resource-preset/get/index.md)

 - [master](cli-ref/resource-preset/get/master.md)

 - [segment](cli-ref/resource-preset/get/segment.md)

#### list

 - [Overview](cli-ref/resource-preset/list/index.md)

 - [master](cli-ref/resource-preset/list/master.md)

 - [segment](cli-ref/resource-preset/list/segment.md)

### users

 - [Overview](cli-ref/users/index.md)

 - [create](cli-ref/users/create.md)

 - [delete](cli-ref/users/delete.md)

 - [get](cli-ref/users/get.md)

 - [list](cli-ref/users/list.md)

 - [update](cli-ref/users/update.md)

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

 - [expand](cli-ref/v0/cluster/expand.md)

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

 - [connect](cli-ref/v0/connect.md)

#### hba-rules

 - [Overview](cli-ref/v0/hba-rules/index.md)

 - [create](cli-ref/v0/hba-rules/create.md)

 - [delete](cli-ref/v0/hba-rules/delete.md)

 - [get](cli-ref/v0/hba-rules/get.md)

 - [list](cli-ref/v0/hba-rules/list.md)

 - [update](cli-ref/v0/hba-rules/update.md)

#### hosts

 - [Overview](cli-ref/v0/hosts/index.md)

##### list

 - [Overview](cli-ref/v0/hosts/list/index.md)

 - [master](cli-ref/v0/hosts/list/master.md)

 - [segment](cli-ref/v0/hosts/list/segment.md)

#### pxf-datasource

 - [Overview](cli-ref/v0/pxf-datasource/index.md)

##### create

 - [Overview](cli-ref/v0/pxf-datasource/create/index.md)

 - [jdbc](cli-ref/v0/pxf-datasource/create/jdbc.md)

 - [s3](cli-ref/v0/pxf-datasource/create/s3.md)

 - [delete](cli-ref/v0/pxf-datasource/delete.md)

 - [get](cli-ref/v0/pxf-datasource/get.md)

 - [list](cli-ref/v0/pxf-datasource/list.md)

##### update

 - [Overview](cli-ref/v0/pxf-datasource/update/index.md)

 - [jdbc](cli-ref/v0/pxf-datasource/update/jdbc.md)

 - [s3](cli-ref/v0/pxf-datasource/update/s3.md)

#### resource-groups

 - [Overview](cli-ref/v0/resource-groups/index.md)

 - [create](cli-ref/v0/resource-groups/create.md)

 - [delete](cli-ref/v0/resource-groups/delete.md)

 - [get](cli-ref/v0/resource-groups/get.md)

 - [list](cli-ref/v0/resource-groups/list.md)

 - [update](cli-ref/v0/resource-groups/update.md)

#### resource-preset

 - [Overview](cli-ref/v0/resource-preset/index.md)

##### get

 - [Overview](cli-ref/v0/resource-preset/get/index.md)

 - [master](cli-ref/v0/resource-preset/get/master.md)

 - [segment](cli-ref/v0/resource-preset/get/segment.md)

##### list

 - [Overview](cli-ref/v0/resource-preset/list/index.md)

 - [master](cli-ref/v0/resource-preset/list/master.md)

 - [segment](cli-ref/v0/resource-preset/list/segment.md)

#### users

 - [Overview](cli-ref/v0/users/index.md)

 - [create](cli-ref/v0/users/create.md)

 - [delete](cli-ref/v0/users/delete.md)

 - [get](cli-ref/v0/users/get.md)

 - [list](cli-ref/v0/users/list.md)

 - [update](cli-ref/v0/users/update.md)

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

 - [Expand](api-ref/grpc/Cluster/expand.md)

 - [Delete](api-ref/grpc/Cluster/delete.md)

 - [Start](api-ref/grpc/Cluster/start.md)

 - [Stop](api-ref/grpc/Cluster/stop.md)

 - [Move](api-ref/grpc/Cluster/move.md)

 - [RescheduleMaintenance](api-ref/grpc/Cluster/rescheduleMaintenance.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListMasterHosts](api-ref/grpc/Cluster/listMasterHosts.md)

 - [ListSegmentHosts](api-ref/grpc/Cluster/listSegmentHosts.md)

 - [ListLogs](api-ref/grpc/Cluster/listLogs.md)

 - [StreamLogs](api-ref/grpc/Cluster/streamLogs.md)

 - [ListBackups](api-ref/grpc/Cluster/listBackups.md)

 - [Backup](api-ref/grpc/Cluster/backup.md)

 - [Restore](api-ref/grpc/Cluster/restore.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### HBARule

 - [Overview](api-ref/grpc/HBARule/index.md)

 - [List](api-ref/grpc/HBARule/list.md)

 - [ListAtRevision](api-ref/grpc/HBARule/listAtRevision.md)

 - [Create](api-ref/grpc/HBARule/create.md)

 - [Update](api-ref/grpc/HBARule/update.md)

 - [Delete](api-ref/grpc/HBARule/delete.md)

 - [BatchUpdate](api-ref/grpc/HBARule/batchUpdate.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### PXFDatasource

 - [Overview](api-ref/grpc/PXFDatasource/index.md)

 - [List](api-ref/grpc/PXFDatasource/list.md)

 - [Create](api-ref/grpc/PXFDatasource/create.md)

 - [Update](api-ref/grpc/PXFDatasource/update.md)

 - [Delete](api-ref/grpc/PXFDatasource/delete.md)

#### ResourceGroup

 - [Overview](api-ref/grpc/ResourceGroup/index.md)

 - [List](api-ref/grpc/ResourceGroup/list.md)

 - [GetAtRevision](api-ref/grpc/ResourceGroup/getAtRevision.md)

 - [Create](api-ref/grpc/ResourceGroup/create.md)

 - [Update](api-ref/grpc/ResourceGroup/update.md)

 - [Delete](api-ref/grpc/ResourceGroup/delete.md)

#### ResourcePreset

 - [Overview](api-ref/grpc/ResourcePreset/index.md)

 - [Get](api-ref/grpc/ResourcePreset/get.md)

 - [List](api-ref/grpc/ResourcePreset/list.md)

#### User

 - [Overview](api-ref/grpc/User/index.md)

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

 - [Expand](api-ref/Cluster/expand.md)

 - [Delete](api-ref/Cluster/delete.md)

 - [Start](api-ref/Cluster/start.md)

 - [Stop](api-ref/Cluster/stop.md)

 - [Move](api-ref/Cluster/move.md)

 - [RescheduleMaintenance](api-ref/Cluster/rescheduleMaintenance.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListMasterHosts](api-ref/Cluster/listMasterHosts.md)

 - [ListSegmentHosts](api-ref/Cluster/listSegmentHosts.md)

 - [ListLogs](api-ref/Cluster/listLogs.md)

 - [StreamLogs](api-ref/Cluster/streamLogs.md)

 - [ListBackups](api-ref/Cluster/listBackups.md)

 - [Backup](api-ref/Cluster/backup.md)

 - [Restore](api-ref/Cluster/restore.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### HBARule

 - [Overview](api-ref/HBARule/index.md)

 - [List](api-ref/HBARule/list.md)

 - [ListAtRevision](api-ref/HBARule/listAtRevision.md)

 - [Create](api-ref/HBARule/create.md)

 - [Update](api-ref/HBARule/update.md)

 - [Delete](api-ref/HBARule/delete.md)

 - [BatchUpdate](api-ref/HBARule/batchUpdate.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### PXFDatasource

 - [Overview](api-ref/PXFDatasource/index.md)

 - [List](api-ref/PXFDatasource/list.md)

 - [Create](api-ref/PXFDatasource/create.md)

 - [Update](api-ref/PXFDatasource/update.md)

 - [Delete](api-ref/PXFDatasource/delete.md)

#### ResourceGroup

 - [Overview](api-ref/ResourceGroup/index.md)

 - [List](api-ref/ResourceGroup/list.md)

 - [GetAtRevision](api-ref/ResourceGroup/getAtRevision.md)

 - [Create](api-ref/ResourceGroup/create.md)

 - [Update](api-ref/ResourceGroup/update.md)

 - [Delete](api-ref/ResourceGroup/delete.md)

#### ResourcePreset

 - [Overview](api-ref/ResourcePreset/index.md)

 - [Get](api-ref/ResourcePreset/get.md)

 - [List](api-ref/ResourcePreset/list.md)

#### User

 - [Overview](api-ref/User/index.md)

 - [List](api-ref/User/list.md)

 - [Create](api-ref/User/create.md)

 - [Update](api-ref/User/update.md)

 - [Delete](api-ref/User/delete.md)

 - [Метрики {{ monitoring-name }}](metrics.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Подключение](qa/connection.md)

 - [Резервное копирование](qa/backup.md)

 - [Изменение кластера](qa/update.md)

 - [Кластер и хосты](qa/cluster-hosts.md)

 - [Работа с внешними таблицами](qa/pxf.md)

 - [Мониторинг и логи](qa/monitoring.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Обучающие курсы](training.md)