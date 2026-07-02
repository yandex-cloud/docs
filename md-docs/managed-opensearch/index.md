[Документация Yandex Cloud](../index.md) > Yandex Managed Service for OpenSearch > Managed Service for OpenSearch

# Yandex Managed Service for OpenSearch

Сервис Managed Service for OpenSearch помогает разворачивать и поддерживать кластеры серверов OpenSearch в инфраструктуре Yandex Cloud.

Инфраструктура Yandex Cloud <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами:

<ul> <li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li> </ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>.

Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_mdb">Уровень обслуживания Yandex Managed Databases</a>.

# Yandex Managed Service for OpenSearch

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

#### Изменение параметров

 - [Изменение настроек кластера](operations/update.md)

 - [Обновление версии OpenSearch](operations/cluster-version-update.md)

 - [Управление плагинами](operations/plugins.md)

#### Управление хостами кластера

 - [Управление группами хостов](operations/host-groups.md)

 - [Миграция групп хостов в другую зону доступности](operations/host-migration.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Управление резервными копиями](operations/cluster-backups.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Настройка доступа к Object Storage](operations/s3-access.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключение

 - [Предварительная настройка](operations/connect/index.md)

 - [FQDN хостов](operations/connect/fqdn.md)

 - [Подключение из приложений](operations/connect/clients.md)

 - [Примеры кода](operations/connect/code-examples.md)

 - [Настройка SAML-аутентификации](operations/saml-authentication.md)

 - [Управление пользователями](operations/cluster-users.md)

### Логи и мониторинг

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Мониторинг состояния кластера и хостов](operations/monitoring.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Настройка политики индексов в Managed Service for OpenSearch](tutorials/opensearch-index-policy.md)

 - [Настройка политики холодного хранилища в Managed Service for OpenSearch](tutorials/opensearch-cold-storage-policy.md)

 - [Загрузка логов из Audit Trails](tutorials/trails-to-opensearch.md)

 - [Аутентификация в OpenSearch Dashboards с помощью Keycloak](tutorials/saml-keycloak.md)

 - [Подключение MCP-клиента к OpenSearch](tutorials/mcp.md)

 - [Использование плагина yandex-lemmer](tutorials/opensearch-yandex-lemmer.md)

### Миграция и копирование данных

 - [Миграция данных из стороннего кластера OpenSearch](tutorials/migration-from-standalone.md)

 - [Миграция данных из Elasticsearch](tutorials/migration-to-opensearch.md)

 - [Миграция данных из Yandex Managed Service for PostgreSQL](tutorials/postgresql-to-opensearch.md)

 - [Поставка данных из Yandex Managed Service for Apache Kafka®](tutorials/migration-from-mkf.md)

 - [Загрузка данных в Object Storage](tutorials/opensearch-to-object-storage.md)

 - [Миграция данных в Yandex Managed Service for YDB](tutorials/opensearch-to-ydb.md)

 - [Копирование данных в Yandex Managed Service for ClickHouse®](tutorials/opensearch-to-clickhouse.md)

 - [Копирование данных в Yandex MPP Analytics for PostgreSQL](tutorials/opensearch-to-greenplum.md)

 - [Мониторинг кластера Managed Service for Kubernetes с помощью Filebeat OSS](tutorials/filebeat-oss-monitoring.md)

 - [Отправка оповещений по электронной почте](tutorials/opensearch-email-notifications.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Роли хостов](concepts/host-roles.md)

 - [Индексы](concepts/indexing.md)

 - [Политики индексов](concepts/index-policy.md)

 - [Поиск с помощью OpenSearch](concepts/searching.md)

 - [Классы хостов](concepts/instance-types.md)

 - [Сеть в Managed Service for OpenSearch](concepts/network.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Хранилище](concepts/storage.md)

 - [Резервные копии](concepts/backup.md)

 - [Шардирование и репликация](concepts/scalability-and-resilience.md)

 - [Высокая доступность кластера](concepts/high-availability.md)

 - [Плагины OpenSearch](concepts/plugins.md)

 - [Политика работы с версиями OpenSearch](concepts/update-policy.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### auth-settings

 - [Overview](cli-ref/auth-settings/index.md)

 - [get](cli-ref/auth-settings/get.md)

 - [update](cli-ref/auth-settings/update.md)

### backup

 - [Overview](cli-ref/backup/index.md)

 - [get](cli-ref/backup/get.md)

 - [list](cli-ref/backup/list.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [backup](cli-ref/cluster/backup.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-backups](cli-ref/cluster/list-backups.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [restart-opensearch](cli-ref/cluster/restart-opensearch.md)

 - [restore](cli-ref/cluster/restore.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [switch-master](cli-ref/cluster/switch-master.md)

 - [update](cli-ref/cluster/update.md)

### extension

 - [Overview](cli-ref/extension/index.md)

 - [create](cli-ref/extension/create.md)

 - [delete](cli-ref/extension/delete.md)

 - [get](cli-ref/extension/get.md)

 - [list](cli-ref/extension/list.md)

 - [update](cli-ref/extension/update.md)

### node-group

 - [Overview](cli-ref/node-group/index.md)

 - [add](cli-ref/node-group/add.md)

 - [delete](cli-ref/node-group/delete.md)

 - [update](cli-ref/node-group/update.md)

### plugin

 - [Overview](cli-ref/plugin/index.md)

 - [add](cli-ref/plugin/add.md)

 - [delete](cli-ref/plugin/delete.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### auth-settings

 - [Overview](cli-ref/v0/auth-settings/index.md)

 - [get](cli-ref/v0/auth-settings/get.md)

 - [update](cli-ref/v0/auth-settings/update.md)

#### backup

 - [Overview](cli-ref/v0/backup/index.md)

 - [get](cli-ref/v0/backup/get.md)

 - [list](cli-ref/v0/backup/list.md)

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [backup](cli-ref/v0/cluster/backup.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-backups](cli-ref/v0/cluster/list-backups.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [restart-opensearch](cli-ref/v0/cluster/restart-opensearch.md)

 - [restore](cli-ref/v0/cluster/restore.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [switch-master](cli-ref/v0/cluster/switch-master.md)

 - [update](cli-ref/v0/cluster/update.md)

#### extension

 - [Overview](cli-ref/v0/extension/index.md)

 - [create](cli-ref/v0/extension/create.md)

 - [delete](cli-ref/v0/extension/delete.md)

 - [get](cli-ref/v0/extension/get.md)

 - [list](cli-ref/v0/extension/list.md)

 - [update](cli-ref/v0/extension/update.md)

#### node-group

 - [Overview](cli-ref/v0/node-group/index.md)

 - [add](cli-ref/v0/node-group/add.md)

 - [delete](cli-ref/v0/node-group/delete.md)

 - [update](cli-ref/v0/node-group/update.md)

#### plugin

 - [Overview](cli-ref/v0/plugin/index.md)

 - [add](cli-ref/v0/plugin/add.md)

 - [delete](cli-ref/v0/plugin/delete.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Backup

 - [Overview](api-ref/grpc/Backup/index.md)

 - [Get](api-ref/grpc/Backup/get.md)

 - [List](api-ref/grpc/Backup/list.md)

#### Cluster

 - [Overview](api-ref/grpc/Cluster/index.md)

 - [Get](api-ref/grpc/Cluster/get.md)

 - [List](api-ref/grpc/Cluster/list.md)

 - [Create](api-ref/grpc/Cluster/create.md)

 - [Update](api-ref/grpc/Cluster/update.md)

 - [Delete](api-ref/grpc/Cluster/delete.md)

 - [Backup](api-ref/grpc/Cluster/backup.md)

 - [DeleteBackup](api-ref/grpc/Cluster/deleteBackup.md)

 - [Restore](api-ref/grpc/Cluster/restore.md)

 - [RescheduleMaintenance](api-ref/grpc/Cluster/rescheduleMaintenance.md)

 - [ListBackups](api-ref/grpc/Cluster/listBackups.md)

 - [Move](api-ref/grpc/Cluster/move.md)

 - [Start](api-ref/grpc/Cluster/start.md)

 - [Stop](api-ref/grpc/Cluster/stop.md)

 - [ListLogs](api-ref/grpc/Cluster/listLogs.md)

 - [StreamLogs](api-ref/grpc/Cluster/streamLogs.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListHosts](api-ref/grpc/Cluster/listHosts.md)

 - [AddOpenSearchNodeGroup](api-ref/grpc/Cluster/addOpenSearchNodeGroup.md)

 - [DeleteOpenSearchNodeGroup](api-ref/grpc/Cluster/deleteOpenSearchNodeGroup.md)

 - [UpdateOpenSearchNodeGroup](api-ref/grpc/Cluster/updateOpenSearchNodeGroup.md)

 - [AddDashboardsNodeGroup](api-ref/grpc/Cluster/addDashboardsNodeGroup.md)

 - [DeleteDashboardsNodeGroup](api-ref/grpc/Cluster/deleteDashboardsNodeGroup.md)

 - [UpdateDashboardsNodeGroup](api-ref/grpc/Cluster/updateDashboardsNodeGroup.md)

 - [GetAuthSettings](api-ref/grpc/Cluster/getAuthSettings.md)

 - [UpdateAuthSettings](api-ref/grpc/Cluster/updateAuthSettings.md)

 - [RestartOpenSearch](api-ref/grpc/Cluster/restartOpenSearch.md)

 - [SwitchMaster](api-ref/grpc/Cluster/switchMaster.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Extension

 - [Overview](api-ref/grpc/Extension/index.md)

 - [Get](api-ref/grpc/Extension/get.md)

 - [List](api-ref/grpc/Extension/list.md)

 - [Create](api-ref/grpc/Extension/create.md)

 - [Update](api-ref/grpc/Extension/update.md)

 - [Delete](api-ref/grpc/Extension/delete.md)

#### Maintenance

 - [Overview](api-ref/grpc/Maintenance/index.md)

 - [List](api-ref/grpc/Maintenance/list.md)

 - [Get](api-ref/grpc/Maintenance/get.md)

 - [Reschedule](api-ref/grpc/Maintenance/reschedule.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### ResourcePreset

 - [Overview](api-ref/grpc/ResourcePreset/index.md)

 - [Get](api-ref/grpc/ResourcePreset/get.md)

 - [List](api-ref/grpc/ResourcePreset/list.md)

#### Versions

 - [Overview](api-ref/grpc/Versions/index.md)

 - [List](api-ref/grpc/Versions/list.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Backup

 - [Overview](api-ref/Backup/index.md)

 - [Get](api-ref/Backup/get.md)

 - [List](api-ref/Backup/list.md)

#### Cluster

 - [Overview](api-ref/Cluster/index.md)

 - [Get](api-ref/Cluster/get.md)

 - [List](api-ref/Cluster/list.md)

 - [Create](api-ref/Cluster/create.md)

 - [Update](api-ref/Cluster/update.md)

 - [Delete](api-ref/Cluster/delete.md)

 - [Backup](api-ref/Cluster/backup.md)

 - [DeleteBackup](api-ref/Cluster/deleteBackup.md)

 - [Restore](api-ref/Cluster/restore.md)

 - [RescheduleMaintenance](api-ref/Cluster/rescheduleMaintenance.md)

 - [ListBackups](api-ref/Cluster/listBackups.md)

 - [Move](api-ref/Cluster/move.md)

 - [Start](api-ref/Cluster/start.md)

 - [Stop](api-ref/Cluster/stop.md)

 - [ListLogs](api-ref/Cluster/listLogs.md)

 - [StreamLogs](api-ref/Cluster/streamLogs.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListHosts](api-ref/Cluster/listHosts.md)

 - [AddOpenSearchNodeGroup](api-ref/Cluster/addOpenSearchNodeGroup.md)

 - [DeleteOpenSearchNodeGroup](api-ref/Cluster/deleteOpenSearchNodeGroup.md)

 - [UpdateOpenSearchNodeGroup](api-ref/Cluster/updateOpenSearchNodeGroup.md)

 - [AddDashboardsNodeGroup](api-ref/Cluster/addDashboardsNodeGroup.md)

 - [DeleteDashboardsNodeGroup](api-ref/Cluster/deleteDashboardsNodeGroup.md)

 - [UpdateDashboardsNodeGroup](api-ref/Cluster/updateDashboardsNodeGroup.md)

 - [GetAuthSettings](api-ref/Cluster/getAuthSettings.md)

 - [UpdateAuthSettings](api-ref/Cluster/updateAuthSettings.md)

 - [RestartOpenSearch](api-ref/Cluster/restartOpenSearch.md)

 - [SwitchMaster](api-ref/Cluster/switchMaster.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Extension

 - [Overview](api-ref/Extension/index.md)

 - [Get](api-ref/Extension/get.md)

 - [List](api-ref/Extension/list.md)

 - [Create](api-ref/Extension/create.md)

 - [Update](api-ref/Extension/update.md)

 - [Delete](api-ref/Extension/delete.md)

#### Maintenance

 - [Overview](api-ref/Maintenance/index.md)

 - [List](api-ref/Maintenance/list.md)

 - [Get](api-ref/Maintenance/get.md)

 - [Reschedule](api-ref/Maintenance/reschedule.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### ResourcePreset

 - [Overview](api-ref/ResourcePreset/index.md)

 - [Get](api-ref/ResourcePreset/get.md)

 - [List](api-ref/ResourcePreset/list.md)

#### Versions

 - [Overview](api-ref/Versions/index.md)

 - [List](api-ref/Versions/list.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

 - [Вопросы и ответы](qa/index.md)