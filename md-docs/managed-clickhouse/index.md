# Yandex Managed Service for ClickHouse®

Сервис Managed Service for ClickHouse® помогает разворачивать и поддерживать кластеры серверов <a href="https://clickhouse.com">ClickHouse®</a> в инфраструктуре Yandex Cloud. ClickHouse® — это высокопроизводительная колоночная СУБД с открытым исходным кодом.

Managed Service for ClickHouse® позволяет: <ul><li>Создавать системы, в которых требуется обработка и хранение большого объема данных.</li> <li>Обрабатывать транзакции в реальном времени <a href="../glossary/oltp.md">(OLTP)</a>.</li> <li>Обрабатывать аналитические запросы в режиме онлайн <a href="../glossary/olap.md">(OLAP)</a>.</li> <li>Поддерживать системы/работать с системами, которым нужна линейная масштабируемость по вертикали и горизонтали.</li> <li>Использовать параллельную обработку запросов на многих процессорных ядрах.</li></ul>

Взаимодействие с сервисом осуществляется с помощью консоли управления, интерфейса командной строки Yandex Cloud (CLI), API или <a href="https://clickhouse.com/docs/ru/interfaces/http">HTTP-интерфейса</a>. Managed Service for ClickHouse® позволяет визуализировать структуру данных на вашем ClickHouse®-кластере и отправлять SQL-запросы к базам из <a href="operations/web-sql-query.md">консоли управления</a> Yandex Cloud.

Инфраструктура Yandex Cloud <a href="../security/conform.md">защищена</a> в соответствии со следующими стандартами:

<ul><li>Федеральный закон Российской Федерации «О персональных данных» № 152-ФЗ.</li> <li>Стандарт безопасности индустрии платежных карт (PCI DSS).</li> <li>Стандарт ISO 27001.</li> <li>Стандарт ISO 27017.</li> <li>Стандарт ISO 27018.</li> <li>ГОСТ 57580.1-2017.</li></ul>

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>.

Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_mdb">Уровень обслуживания Yandex Managed Databases</a>.

<em>ClickHouse<sup>®</sup> является зарегистрированным товарным знаком <a href="https://clickhouse.com" target = "_blank">ClickHouse, Inc.</a></em>

# Yandex Managed Service for ClickHouse®

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение настроек кластера](operations/update.md)

#### Изменение настроек ClickHouse®

 - [На уровне сервера](operations/change-server-level-settings.md)

 - [На уровне запроса](operations/change-query-level-settings.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Получение патч-версии ClickHouse®](operations/cluster-patch-version.md)

 - [Обновление версии ClickHouse®](operations/cluster-version-update.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

#### Управление хостами

 - [Управление хостами ClickHouse®](operations/hosts.md)

 - [Управление хостами ZooKeeper](operations/zk-hosts.md)

 - [Управление хостами ClickHouse® Keeper](operations/ck-hosts.md)

 - [Миграция хостов в другую зону доступности](operations/host-migration.md)

 - [Управление резервными копиями](operations/cluster-backups.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключение

 - [Предварительная настройка](operations/connect/index.md)

 - [FQDN хостов](operations/connect/fqdn.md)

 - [Подключение из приложений](operations/connect/clients.md)

 - [Примеры кода](operations/connect/code-examples.md)

### Базы данных

 - [SQL-запросы в Yandex WebSQL](operations/web-sql-query.md)

 - [Управление базами данных](operations/databases.md)

 - [Управление пользователями БД](operations/cluster-users.md)

### Хранение и обработка данных

 - [Управление расширениями](operations/cluster-extensions.md)

 - [Управление собственной геобазой](operations/geobase.md)

 - [Подключение внешних словарей](operations/dictionaries.md)

 - [Управление схемами формата данных](operations/format-schemas.md)

 - [Управление моделями машинного обучения](operations/ml-models.md)

 - [Настройка доступа к Object Storage](operations/s3-access.md)

### Шардирование

 - [Управление шардами](operations/shards.md)

 - [Управление группами шардов](operations/shard-groups.md)

### Логи и мониторинг

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Диагностика производительности](operations/performance-diagnostics.md)

 - [Мониторинг состояния кластера и хостов](operations/monitoring.md)

 - [Подключение из DataLens](operations/datalens-connect.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Добавление данных в БД](tutorials/insert.md)

 - [Миграция данных в Managed Service for ClickHouse® средствами ClickHouse®](tutorials/data-migration.md)

 - [Миграция данных в Managed Service for ClickHouse® при помощи Data Transfer](tutorials/ch-to-mch-migration.md)

 - [Шардирование таблиц](tutorials/sharding.md)

 - [Использование гибридного хранилища](tutorials/hybrid-storage.md)

 - [Получение данных из Managed Service for Apache Kafka®](tutorials/fetch-data-from-mkf.md)

 - [Получение данных из RabbitMQ](tutorials/fetch-data-from-rabbitmq.md)

 - [Обмен данными с Yandex Data Processing](tutorials/exchange-data-with-dp.md)

 - [Настройка Yandex Cloud DNS для доступа к кластеру из других облачных сетей](tutorials/dns-peering.md)

 - [Анализ логов Yandex Object Storage при помощи Yandex DataLens](tutorials/storage-logs-analysis.md)

 - [Настройка Managed Service for ClickHouse® для Graphite](tutorials/clickhouse-for-graphite.md)

 - [Сохранение потока данных Yandex Data Streams в Managed Service for ClickHouse®](tutorials/yds-to-clickhouse.md)

 - [Миграция базы данных из Google BigQuery](tutorials/bigquery-to-clickhouse.md)

 - [Поставка данных из Managed Service for Apache Kafka® с помощью Yandex Data Transfer](tutorials/mkf-to-mch-migration.md)

 - [Миграция данных из Яндекс Директ с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](tutorials/transfer-from-direct.md)

 - [Загрузка данных из Yandex Object Storage в Managed Service for ClickHouse® с помощью Yandex Data Transfer](tutorials/object-storage-to-clickhouse.md)

 - [Миграция базы данных из Greenplum® в ClickHouse®](tutorials/greenplum-to-clickhouse.md)

 - [Миграция базы данных из MySQL® в ClickHouse® с помощью Yandex Data Transfer](tutorials/mysql-to-clickhouse.md)

 - [Асинхронная репликация данных из PostgreSQL в ClickHouse®](tutorials/rdbms-to-clickhouse.md)

 - [Загрузка данных из Yandex Managed Service for YDB в Managed Service for ClickHouse® с помощью Yandex Data Transfer](tutorials/ydb-to-clickhouse.md)

 - [Копирование данных из Managed Service for OpenSearch в Managed Service for ClickHouse® с помощью Yandex Data Transfer](tutorials/opensearch-to-clickhouse.md)

 - [Ввод данных в системы хранения](tutorials/data-ingestion.md)

 - [Использование параметров](tutorials/data-from-ch-with-parameters.md)

 - [Примеры создания QL-чартов](tutorials/data-from-ch-to-sql-chart.md)

 - [Веб-аналитика с расчетом воронок и когорт на данных Яндекс Метрики](tutorials/data-from-metrica-yc-visualization.md)

 - [AppMetrica: прямое подключение](tutorials/data-from-appmetrica-visualization.md)

 - [AppMetrica: экспорт, постобработка и визуализация данных](tutorials/data-from-appmetrica-yc-visualization.md)

 - [Загрузка данных из Яндекс Метрика в витрину ClickHouse®](tutorials/metrika-to-clickhouse.md)

 - [Яндекс Трекер: экспорт и визуализация данных](tutorials/data-from-tracker.md)

 - [Дашборд сети магазинов из БД ClickHouse®](tutorials/data-from-ch-visualization.md)

 - [Анализ продаж и локаций пиццерий на данных из БД ClickHouse® и Marketplace](tutorials/data-from-ch-to-geolayers-visualization.md)

 - [Геокодинг с помощью API Яндекс Карт для визуализации в DataLens](tutorials/data-from-ch-geocoder.md)

 - [Импорт данных из Object Storage, обработка и экспорт в Managed Service for ClickHouse®](tutorials/s3-data-processing-ch.md)

 - [Работа с данными с помощью Query](tutorials/yq-clickhouse.md)

 - [Федеративные запросы к данным с помощью Query](tutorials/yq-federative-queries.md)

 - [Интеграция с внешней базой данных Microsoft SQL Server через ClickHouse® JDBC Bridge](tutorials/jdbc-ch-to-sql-server-integration.md)

 - [Интеграция с внешней базой данных Oracle через ClickHouse® JDBC Bridge](tutorials/jdbc-ch-to-oracle-integration.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Высокая доступность кластера](concepts/high-availability.md)

### [Классы хостов](concepts/instance-types.md)

 - [Действующие классы хостов](concepts/instance-types.md)

#### Архив

 - [До 1 июня 2020 года](concepts/instance-types-archive/instance-types-01062020.md)

 - [До 20 июня 2023 года](concepts/instance-types-archive/instance-types-20062023.md)

 - [Использование устаревших классов хостов](concepts/using-deprecated-instances.md)

 - [Сеть в Managed Service for ClickHouse®](concepts/network.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Хранилище](concepts/storage.md)

 - [Резервные копии](concepts/backup.md)

 - [Репликация](concepts/replication.md)

 - [Сервисы координации](concepts/coordination-system.md)

 - [Словари](concepts/dictionaries.md)

 - [Шардирование](concepts/sharding.md)

 - [Служебные пользователи](concepts/service-users.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Поддерживаемые клиенты](concepts/supported-clients.md)

 - [Управление памятью](concepts/memory-management.md)

 - [Политика работы с версиями ClickHouse®](concepts/update-policy.md)

 - [Настройки ClickHouse®](concepts/settings-list.md)

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

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [add-extension](cli-ref/cluster/add-extension.md)

 - [add-external-dictionary](cli-ref/cluster/add-external-dictionary.md)

 - [add-graphite-rollup](cli-ref/cluster/add-graphite-rollup.md)

 - [add-labels](cli-ref/cluster/add-labels.md)

 - [add-zookeeper](cli-ref/cluster/add-zookeeper.md)

 - [backup](cli-ref/cluster/backup.md)

 - [clear-compression](cli-ref/cluster/clear-compression.md)

 - [clear-query-masking-rules](cli-ref/cluster/clear-query-masking-rules.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [get-extension](cli-ref/cluster/get-extension.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-backups](cli-ref/cluster/list-backups.md)

 - [list-extensions](cli-ref/cluster/list-extensions.md)

 - [list-external-dictionaries](cli-ref/cluster/list-external-dictionaries.md)

 - [list-logs](cli-ref/cluster/list-logs.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [move](cli-ref/cluster/move.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [remove-extension](cli-ref/cluster/remove-extension.md)

 - [remove-external-dictionary](cli-ref/cluster/remove-external-dictionary.md)

 - [remove-graphite-rollup](cli-ref/cluster/remove-graphite-rollup.md)

 - [remove-labels](cli-ref/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/cluster/restore.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [set-compression](cli-ref/cluster/set-compression.md)

 - [set-query-masking-rules](cli-ref/cluster/set-query-masking-rules.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

 - [update-config](cli-ref/cluster/update-config.md)

 - [update-extension](cli-ref/cluster/update-extension.md)

 - [update-external-dictionary](cli-ref/cluster/update-external-dictionary.md)

### database

 - [Overview](cli-ref/database/index.md)

 - [create](cli-ref/database/create.md)

 - [delete](cli-ref/database/delete.md)

 - [get](cli-ref/database/get.md)

 - [list](cli-ref/database/list.md)

### extension

 - [Overview](cli-ref/extension/index.md)

 - [get](cli-ref/extension/get.md)

 - [list](cli-ref/extension/list.md)

### format-schema

 - [Overview](cli-ref/format-schema/index.md)

 - [create](cli-ref/format-schema/create.md)

 - [delete](cli-ref/format-schema/delete.md)

 - [get](cli-ref/format-schema/get.md)

 - [list](cli-ref/format-schema/list.md)

 - [update](cli-ref/format-schema/update.md)

### hosts

 - [Overview](cli-ref/hosts/index.md)

 - [add](cli-ref/hosts/add.md)

 - [delete](cli-ref/hosts/delete.md)

 - [list](cli-ref/hosts/list.md)

 - [restart](cli-ref/hosts/restart.md)

 - [update](cli-ref/hosts/update.md)

### ml-model

 - [Overview](cli-ref/ml-model/index.md)

 - [create](cli-ref/ml-model/create.md)

 - [delete](cli-ref/ml-model/delete.md)

 - [get](cli-ref/ml-model/get.md)

 - [list](cli-ref/ml-model/list.md)

 - [update](cli-ref/ml-model/update.md)

### resource-preset

 - [Overview](cli-ref/resource-preset/index.md)

 - [get](cli-ref/resource-preset/get.md)

 - [list](cli-ref/resource-preset/list.md)

### shard-groups

 - [Overview](cli-ref/shard-groups/index.md)

 - [create](cli-ref/shard-groups/create.md)

 - [delete](cli-ref/shard-groups/delete.md)

 - [get](cli-ref/shard-groups/get.md)

 - [list](cli-ref/shard-groups/list.md)

 - [update](cli-ref/shard-groups/update.md)

### shards

 - [Overview](cli-ref/shards/index.md)

 - [add](cli-ref/shards/add.md)

 - [delete](cli-ref/shards/delete.md)

 - [get](cli-ref/shards/get.md)

 - [list](cli-ref/shards/list.md)

 - [update](cli-ref/shards/update.md)

 - [update-config](cli-ref/shards/update-config.md)

### user

 - [Overview](cli-ref/user/index.md)

 - [add-quota](cli-ref/user/add-quota.md)

 - [create](cli-ref/user/create.md)

 - [delete](cli-ref/user/delete.md)

 - [get](cli-ref/user/get.md)

 - [grant-permission](cli-ref/user/grant-permission.md)

 - [list](cli-ref/user/list.md)

 - [remove-quota](cli-ref/user/remove-quota.md)

 - [revoke-permission](cli-ref/user/revoke-permission.md)

 - [update](cli-ref/user/update.md)

 - [update-quota](cli-ref/user/update-quota.md)

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

 - [add-extension](cli-ref/v0/cluster/add-extension.md)

 - [add-external-dictionary](cli-ref/v0/cluster/add-external-dictionary.md)

 - [add-graphite-rollup](cli-ref/v0/cluster/add-graphite-rollup.md)

 - [add-labels](cli-ref/v0/cluster/add-labels.md)

 - [add-zookeeper](cli-ref/v0/cluster/add-zookeeper.md)

 - [backup](cli-ref/v0/cluster/backup.md)

 - [clear-compression](cli-ref/v0/cluster/clear-compression.md)

 - [clear-query-masking-rules](cli-ref/v0/cluster/clear-query-masking-rules.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [get-extension](cli-ref/v0/cluster/get-extension.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-backups](cli-ref/v0/cluster/list-backups.md)

 - [list-extensions](cli-ref/v0/cluster/list-extensions.md)

 - [list-external-dictionaries](cli-ref/v0/cluster/list-external-dictionaries.md)

 - [list-logs](cli-ref/v0/cluster/list-logs.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [move](cli-ref/v0/cluster/move.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [remove-extension](cli-ref/v0/cluster/remove-extension.md)

 - [remove-external-dictionary](cli-ref/v0/cluster/remove-external-dictionary.md)

 - [remove-graphite-rollup](cli-ref/v0/cluster/remove-graphite-rollup.md)

 - [remove-labels](cli-ref/v0/cluster/remove-labels.md)

 - [reschedule-maintenance](cli-ref/v0/cluster/reschedule-maintenance.md)

 - [restore](cli-ref/v0/cluster/restore.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [set-compression](cli-ref/v0/cluster/set-compression.md)

 - [set-query-masking-rules](cli-ref/v0/cluster/set-query-masking-rules.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

 - [update-config](cli-ref/v0/cluster/update-config.md)

 - [update-extension](cli-ref/v0/cluster/update-extension.md)

 - [update-external-dictionary](cli-ref/v0/cluster/update-external-dictionary.md)

#### database

 - [Overview](cli-ref/v0/database/index.md)

 - [create](cli-ref/v0/database/create.md)

 - [delete](cli-ref/v0/database/delete.md)

 - [get](cli-ref/v0/database/get.md)

 - [list](cli-ref/v0/database/list.md)

#### extension

 - [Overview](cli-ref/v0/extension/index.md)

 - [get](cli-ref/v0/extension/get.md)

 - [list](cli-ref/v0/extension/list.md)

#### format-schema

 - [Overview](cli-ref/v0/format-schema/index.md)

 - [create](cli-ref/v0/format-schema/create.md)

 - [delete](cli-ref/v0/format-schema/delete.md)

 - [get](cli-ref/v0/format-schema/get.md)

 - [list](cli-ref/v0/format-schema/list.md)

 - [update](cli-ref/v0/format-schema/update.md)

#### hosts

 - [Overview](cli-ref/v0/hosts/index.md)

 - [add](cli-ref/v0/hosts/add.md)

 - [delete](cli-ref/v0/hosts/delete.md)

 - [list](cli-ref/v0/hosts/list.md)

 - [restart](cli-ref/v0/hosts/restart.md)

 - [update](cli-ref/v0/hosts/update.md)

#### ml-model

 - [Overview](cli-ref/v0/ml-model/index.md)

 - [create](cli-ref/v0/ml-model/create.md)

 - [delete](cli-ref/v0/ml-model/delete.md)

 - [get](cli-ref/v0/ml-model/get.md)

 - [list](cli-ref/v0/ml-model/list.md)

 - [update](cli-ref/v0/ml-model/update.md)

#### resource-preset

 - [Overview](cli-ref/v0/resource-preset/index.md)

 - [get](cli-ref/v0/resource-preset/get.md)

 - [list](cli-ref/v0/resource-preset/list.md)

#### shard-groups

 - [Overview](cli-ref/v0/shard-groups/index.md)

 - [create](cli-ref/v0/shard-groups/create.md)

 - [delete](cli-ref/v0/shard-groups/delete.md)

 - [get](cli-ref/v0/shard-groups/get.md)

 - [list](cli-ref/v0/shard-groups/list.md)

 - [update](cli-ref/v0/shard-groups/update.md)

#### shards

 - [Overview](cli-ref/v0/shards/index.md)

 - [add](cli-ref/v0/shards/add.md)

 - [delete](cli-ref/v0/shards/delete.md)

 - [get](cli-ref/v0/shards/get.md)

 - [list](cli-ref/v0/shards/list.md)

 - [update](cli-ref/v0/shards/update.md)

 - [update-config](cli-ref/v0/shards/update-config.md)

#### user

 - [Overview](cli-ref/v0/user/index.md)

 - [add-quota](cli-ref/v0/user/add-quota.md)

 - [create](cli-ref/v0/user/create.md)

 - [delete](cli-ref/v0/user/delete.md)

 - [get](cli-ref/v0/user/get.md)

 - [grant-permission](cli-ref/v0/user/grant-permission.md)

 - [list](cli-ref/v0/user/list.md)

 - [remove-quota](cli-ref/v0/user/remove-quota.md)

 - [revoke-permission](cli-ref/v0/user/revoke-permission.md)

 - [update](cli-ref/v0/user/update.md)

 - [update-quota](cli-ref/v0/user/update-quota.md)

#### version

 - [Overview](cli-ref/v0/version/index.md)

 - [list](cli-ref/v0/version/list.md)

### version

 - [Overview](cli-ref/version/index.md)

 - [list](cli-ref/version/list.md)

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

#### ClusterExtension

 - [Overview](api-ref/grpc/ClusterExtension/index.md)

 - [Get](api-ref/grpc/ClusterExtension/get.md)

 - [List](api-ref/grpc/ClusterExtension/list.md)

 - [Create](api-ref/grpc/ClusterExtension/create.md)

 - [Delete](api-ref/grpc/ClusterExtension/delete.md)

 - [Update](api-ref/grpc/ClusterExtension/update.md)

 - [SetExtensions](api-ref/grpc/ClusterExtension/setExtensions.md)

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

 - [AddZookeeper](api-ref/grpc/Cluster/addZookeeper.md)

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

 - [RestartHosts](api-ref/grpc/Cluster/restartHosts.md)

 - [GetShard](api-ref/grpc/Cluster/getShard.md)

 - [ListShards](api-ref/grpc/Cluster/listShards.md)

 - [AddShard](api-ref/grpc/Cluster/addShard.md)

 - [AddShards](api-ref/grpc/Cluster/addShards.md)

 - [UpdateShard](api-ref/grpc/Cluster/updateShard.md)

 - [DeleteShard](api-ref/grpc/Cluster/deleteShard.md)

 - [DeleteShards](api-ref/grpc/Cluster/deleteShards.md)

 - [GetShardGroup](api-ref/grpc/Cluster/getShardGroup.md)

 - [ListShardGroups](api-ref/grpc/Cluster/listShardGroups.md)

 - [CreateShardGroup](api-ref/grpc/Cluster/createShardGroup.md)

 - [UpdateShardGroup](api-ref/grpc/Cluster/updateShardGroup.md)

 - [DeleteShardGroup](api-ref/grpc/Cluster/deleteShardGroup.md)

 - [ListExternalDictionaries](api-ref/grpc/Cluster/listExternalDictionaries.md)

 - [CreateExternalDictionary](api-ref/grpc/Cluster/createExternalDictionary.md)

 - [UpdateExternalDictionary](api-ref/grpc/Cluster/updateExternalDictionary.md)

 - [DeleteExternalDictionary](api-ref/grpc/Cluster/deleteExternalDictionary.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Database

 - [Overview](api-ref/grpc/Database/index.md)

 - [Get](api-ref/grpc/Database/get.md)

 - [List](api-ref/grpc/Database/list.md)

 - [Create](api-ref/grpc/Database/create.md)

 - [Delete](api-ref/grpc/Database/delete.md)

#### Extension

 - [Overview](api-ref/grpc/Extension/index.md)

 - [Get](api-ref/grpc/Extension/get.md)

 - [List](api-ref/grpc/Extension/list.md)

#### FormatSchema

 - [Overview](api-ref/grpc/FormatSchema/index.md)

 - [Get](api-ref/grpc/FormatSchema/get.md)

 - [List](api-ref/grpc/FormatSchema/list.md)

 - [Create](api-ref/grpc/FormatSchema/create.md)

 - [Update](api-ref/grpc/FormatSchema/update.md)

 - [Delete](api-ref/grpc/FormatSchema/delete.md)

#### MlModel

 - [Overview](api-ref/grpc/MlModel/index.md)

 - [Get](api-ref/grpc/MlModel/get.md)

 - [List](api-ref/grpc/MlModel/list.md)

 - [Create](api-ref/grpc/MlModel/create.md)

 - [Update](api-ref/grpc/MlModel/update.md)

 - [Delete](api-ref/grpc/MlModel/delete.md)

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

#### Backup

 - [Overview](api-ref/Backup/index.md)

 - [Get](api-ref/Backup/get.md)

 - [List](api-ref/Backup/list.md)

 - [Delete](api-ref/Backup/delete.md)

#### ClusterExtension

 - [Overview](api-ref/ClusterExtension/index.md)

 - [Get](api-ref/ClusterExtension/get.md)

 - [List](api-ref/ClusterExtension/list.md)

 - [Create](api-ref/ClusterExtension/create.md)

 - [Delete](api-ref/ClusterExtension/delete.md)

 - [Update](api-ref/ClusterExtension/update.md)

 - [SetExtensions](api-ref/ClusterExtension/setExtensions.md)

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

 - [AddZookeeper](api-ref/Cluster/addZookeeper.md)

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

 - [RestartHosts](api-ref/Cluster/restartHosts.md)

 - [GetShard](api-ref/Cluster/getShard.md)

 - [ListShards](api-ref/Cluster/listShards.md)

 - [AddShard](api-ref/Cluster/addShard.md)

 - [AddShards](api-ref/Cluster/addShards.md)

 - [UpdateShard](api-ref/Cluster/updateShard.md)

 - [DeleteShard](api-ref/Cluster/deleteShard.md)

 - [DeleteShards](api-ref/Cluster/deleteShards.md)

 - [GetShardGroup](api-ref/Cluster/getShardGroup.md)

 - [ListShardGroups](api-ref/Cluster/listShardGroups.md)

 - [CreateShardGroup](api-ref/Cluster/createShardGroup.md)

 - [UpdateShardGroup](api-ref/Cluster/updateShardGroup.md)

 - [DeleteShardGroup](api-ref/Cluster/deleteShardGroup.md)

 - [ListExternalDictionaries](api-ref/Cluster/listExternalDictionaries.md)

 - [CreateExternalDictionary](api-ref/Cluster/createExternalDictionary.md)

 - [UpdateExternalDictionary](api-ref/Cluster/updateExternalDictionary.md)

 - [DeleteExternalDictionary](api-ref/Cluster/deleteExternalDictionary.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Database

 - [Overview](api-ref/Database/index.md)

 - [Get](api-ref/Database/get.md)

 - [List](api-ref/Database/list.md)

 - [Create](api-ref/Database/create.md)

 - [Delete](api-ref/Database/delete.md)

#### Extension

 - [Overview](api-ref/Extension/index.md)

 - [Get](api-ref/Extension/get.md)

 - [List](api-ref/Extension/list.md)

#### FormatSchema

 - [Overview](api-ref/FormatSchema/index.md)

 - [Get](api-ref/FormatSchema/get.md)

 - [List](api-ref/FormatSchema/list.md)

 - [Create](api-ref/FormatSchema/create.md)

 - [Update](api-ref/FormatSchema/update.md)

 - [Delete](api-ref/FormatSchema/delete.md)

#### MlModel

 - [Overview](api-ref/MlModel/index.md)

 - [Get](api-ref/MlModel/get.md)

 - [List](api-ref/MlModel/list.md)

 - [Create](api-ref/MlModel/create.md)

 - [Update](api-ref/MlModel/update.md)

 - [Delete](api-ref/MlModel/delete.md)

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

 - [Метрики Yandex Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [Публичные материалы](public-talks.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Вопросы о ClickHouse®](qa/clickhouse.md)

 - [Подключение](qa/connection.md)

 - [Изменение кластера](qa/cluster-update.md)

 - [Настройки параметров кластера](qa/cluster-settings.md)

 - [Перемещение и восстановление кластера](qa/cluster-backups.md)

 - [Мониторинг и логи](qa/monitoring.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Обучающие курсы](training.md)