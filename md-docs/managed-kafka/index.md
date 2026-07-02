[Документация Yandex Cloud](../index.md) > Yandex Managed Service for Apache Kafka® > Managed Service for Apache Kafka®

# Yandex Managed Service for Apache Kafka®

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Кластеры

 - [Информация об имеющихся кластерах](operations/cluster-list.md)

 - [Создание кластера](operations/cluster-create.md)

 - [Изменение настроек кластера](operations/cluster-update.md)

 - [Обновление версии Apache Kafka®](operations/cluster-version-update.md)

 - [Управление дисковым пространством](operations/storage-space.md)

 - [Остановка и запуск кластера](operations/cluster-stop.md)

 - [Получение списка хостов кластера](operations/cluster-hosts.md)

 - [Получение патч-версии Apache Kafka®](operations/cluster-patch-version.md)

 - [Миграция хостов в другую зону доступности](operations/host-migration.md)

 - [Управление доступом к кластеру](operations/cluster-access.md)

 - [Техническое обслуживание](operations/cluster-maintenance.md)

 - [Удаление кластера](operations/cluster-delete.md)

### Подключение

 - [Предварительная настройка](operations/connect/index.md)

 - [Подключение из приложений](operations/connect/clients.md)

 - [Примеры кода](operations/connect/code-examples.md)

 - [Управление топиками](operations/cluster-topics.md)

 - [Управление пользователями](operations/cluster-accounts.md)

 - [Управление коннекторами](operations/cluster-connector.md)

 - [Веб-интерфейс Kafka UI для Apache Kafka®](operations/kafka-ui-enable.md)

### Логи и мониторинг

 - [Просмотр логов кластера](operations/cluster-logs.md)

 - [Мониторинг состояния кластера и хостов](operations/monitoring.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Самостоятельное развертывание веб-интерфейса Apache Kafka®](tutorials/deploy-kafka-ui.md)

 - [Обновление кластера Managed Service for Apache Kafka® с ZooKeeper на KRaft](tutorials/zk-kraft-kafka-migration.md)

### Перемещение данных из Apache Kafka®

 - [Настройка Kafka Connect для работы с Managed Service for Apache Kafka®](tutorials/kafka-connect.md)

 - [Миграция базы данных из стороннего кластера Apache Kafka®](tutorials/kafka-connectors.md)

 - [Перенос данных между кластерами Managed Service for Apache Kafka® с помощью Yandex Data Transfer](tutorials/mkf-to-mkf-transfer.md)

### Использование схем формата данных с Managed Service for Apache Kafka®

 - [Управление схемами данных в Managed Service for Apache Kafka®](tutorials/schema-registry-overview.md)

 - [Работа с управляемым реестром схем формата данных](tutorials/managed-schema-registry.md)

 - [Работа с управляемым реестром схем формата данных с помощью REST API](tutorials/managed-schema-registry-rest.md)

 - [Использование Confluent Schema Registry с Managed Service for Apache Kafka®](tutorials/confluent-schema-registry.md)

### Поставка данных с помощью Data Transfer

 - [Поставка из PostgreSQL в Apache Kafka®](tutorials/cdc/data-transfer-mpg.md)

 - [Поставка из Apache Kafka® в PostgreSQL](tutorials/mkf-to-mpg.md)

 - [Поставка из YDB в Apache Kafka®](tutorials/cdc/data-transfer-ydb.md)

 - [Поставка из Apache Kafka® в YDB](tutorials/mkf-ydb-stream.md)

 - [Поставка из Apache Kafka® в ClickHouse®](tutorials/mkf-to-mch-migration.md)

 - [Поставка из Apache Kafka® в Data Streams](tutorials/mkf-yds-stream.md)

 - [Поставка из Data Streams в Apache Kafka®](tutorials/yds-to-kafka.md)

 - [Поставка из Apache Kafka® в Greenplum®](tutorials/managed-kafka-to-greenplum.md)

 - [Поставка из Apache Kafka® в Yandex StoreDoc](tutorials/mkf-to-mmg-migration.md)

 - [Поставка из MySQL® в Apache Kafka®](tutorials/cdc/cdc-mmy.md)

 - [Поставка из Apache Kafka® в MySQL®](tutorials/mkf-to-mmy-migration.md)

 - [Поставка из Apache Kafka® в OpenSearch](tutorials/mkf-to-mos-migration.md)

### Поставка данных другими способами

 - [Поставка из PostgreSQL с помощью Debezium](tutorials/cdc/debezium-mpg.md)

 - [Поставка из MySQL® с помощью Debezium](tutorials/cdc/debezium-mmy.md)

 - [Поставка в ClickHouse®](tutorials/send-data-to-mch.md)

 - [Поставка в ksqlDB](tutorials/use-ksqldb-with-mkf.md)

 - [Синхронизация топиков Apache Kafka® в Object Storage без использования интернета](tutorials/kafka-topic-s3-sync-private.md)

 - [Работа с топиками Apache Kafka® с помощью Yandex Data Processing](tutorials/data-processing.md)

 - [Отслеживание потери сообщений в топике Apache Kafka®](tutorials/retention-policy.md)

## Концепции

 - [Взаимосвязь ресурсов сервиса](concepts/index.md)

 - [Топики и разделы](concepts/topics.md)

 - [Брокеры](concepts/brokers.md)

 - [Протокол KRaft](concepts/kraft.md)

 - [Производители и потребители](concepts/producers-consumers.md)

 - [Роли пользователей](concepts/account-roles.md)

 - [Управление схемами данных](concepts/managed-schema-registry.md)

 - [Веб-интерфейс для Apache Kafka®](concepts/kafka-ui.md)

 - [API в Managed Service for Apache Kafka®](concepts/available-apis.md)

 - [Классы хостов](concepts/instance-types.md)

 - [Высокая доступность кластера](concepts/ha-cluster.md)

 - [Сеть в Managed Service for Apache Kafka®](concepts/network.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Хранилище в Managed Service for Apache Kafka®](concepts/storage.md)

 - [Коннекторы](concepts/connectors.md)

 - [Техническое обслуживание](concepts/maintenance.md)

 - [Настройки Apache Kafka®](concepts/settings-list.md)

 - [Политика работы с версиями Apache Kafka®](concepts/update-policy.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### cluster

 - [Overview](cli-ref/cluster/index.md)

 - [add-access-binding](cli-ref/cluster/add-access-binding.md)

 - [create](cli-ref/cluster/create.md)

 - [delete](cli-ref/cluster/delete.md)

 - [get](cli-ref/cluster/get.md)

 - [list](cli-ref/cluster/list.md)

 - [list-access-bindings](cli-ref/cluster/list-access-bindings.md)

 - [list-hosts](cli-ref/cluster/list-hosts.md)

 - [list-logs](cli-ref/cluster/list-logs.md)

 - [list-operations](cli-ref/cluster/list-operations.md)

 - [move](cli-ref/cluster/move.md)

 - [remove-access-binding](cli-ref/cluster/remove-access-binding.md)

 - [reschedule-maintenance](cli-ref/cluster/reschedule-maintenance.md)

 - [set-access-bindings](cli-ref/cluster/set-access-bindings.md)

 - [start](cli-ref/cluster/start.md)

 - [stop](cli-ref/cluster/stop.md)

 - [update](cli-ref/cluster/update.md)

### connector

 - [Overview](cli-ref/connector/index.md)

 - [delete](cli-ref/connector/delete.md)

 - [get](cli-ref/connector/get.md)

 - [list](cli-ref/connector/list.md)

 - [pause](cli-ref/connector/pause.md)

 - [resume](cli-ref/connector/resume.md)

### connector-iceberg-sink

 - [Overview](cli-ref/connector-iceberg-sink/index.md)

 - [create](cli-ref/connector-iceberg-sink/create.md)

 - [update](cli-ref/connector-iceberg-sink/update.md)

### connector-mirrormaker

 - [Overview](cli-ref/connector-mirrormaker/index.md)

 - [create](cli-ref/connector-mirrormaker/create.md)

 - [update](cli-ref/connector-mirrormaker/update.md)

### connector-s3-sink

 - [Overview](cli-ref/connector-s3-sink/index.md)

 - [create](cli-ref/connector-s3-sink/create.md)

 - [update](cli-ref/connector-s3-sink/update.md)

### topic

 - [Overview](cli-ref/topic/index.md)

 - [create](cli-ref/topic/create.md)

 - [delete](cli-ref/topic/delete.md)

 - [get](cli-ref/topic/get.md)

 - [list](cli-ref/topic/list.md)

 - [update](cli-ref/topic/update.md)

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

#### cluster

 - [Overview](cli-ref/v0/cluster/index.md)

 - [add-access-binding](cli-ref/v0/cluster/add-access-binding.md)

 - [create](cli-ref/v0/cluster/create.md)

 - [delete](cli-ref/v0/cluster/delete.md)

 - [get](cli-ref/v0/cluster/get.md)

 - [list](cli-ref/v0/cluster/list.md)

 - [list-access-bindings](cli-ref/v0/cluster/list-access-bindings.md)

 - [list-hosts](cli-ref/v0/cluster/list-hosts.md)

 - [list-logs](cli-ref/v0/cluster/list-logs.md)

 - [list-operations](cli-ref/v0/cluster/list-operations.md)

 - [move](cli-ref/v0/cluster/move.md)

 - [remove-access-binding](cli-ref/v0/cluster/remove-access-binding.md)

 - [reschedule-maintenance](cli-ref/v0/cluster/reschedule-maintenance.md)

 - [set-access-bindings](cli-ref/v0/cluster/set-access-bindings.md)

 - [start](cli-ref/v0/cluster/start.md)

 - [stop](cli-ref/v0/cluster/stop.md)

 - [update](cli-ref/v0/cluster/update.md)

#### connector

 - [Overview](cli-ref/v0/connector/index.md)

 - [delete](cli-ref/v0/connector/delete.md)

 - [get](cli-ref/v0/connector/get.md)

 - [list](cli-ref/v0/connector/list.md)

 - [pause](cli-ref/v0/connector/pause.md)

 - [resume](cli-ref/v0/connector/resume.md)

#### connector-iceberg-sink

 - [Overview](cli-ref/v0/connector-iceberg-sink/index.md)

 - [create](cli-ref/v0/connector-iceberg-sink/create.md)

 - [update](cli-ref/v0/connector-iceberg-sink/update.md)

#### connector-mirrormaker

 - [Overview](cli-ref/v0/connector-mirrormaker/index.md)

 - [create](cli-ref/v0/connector-mirrormaker/create.md)

 - [update](cli-ref/v0/connector-mirrormaker/update.md)

#### connector-s3-sink

 - [Overview](cli-ref/v0/connector-s3-sink/index.md)

 - [create](cli-ref/v0/connector-s3-sink/create.md)

 - [update](cli-ref/v0/connector-s3-sink/update.md)

#### topic

 - [Overview](cli-ref/v0/topic/index.md)

 - [create](cli-ref/v0/topic/create.md)

 - [delete](cli-ref/v0/topic/delete.md)

 - [get](cli-ref/v0/topic/get.md)

 - [list](cli-ref/v0/topic/list.md)

 - [update](cli-ref/v0/topic/update.md)

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

#### Cluster

 - [Overview](api-ref/grpc/Cluster/index.md)

 - [Get](api-ref/grpc/Cluster/get.md)

 - [List](api-ref/grpc/Cluster/list.md)

 - [Create](api-ref/grpc/Cluster/create.md)

 - [Update](api-ref/grpc/Cluster/update.md)

 - [Delete](api-ref/grpc/Cluster/delete.md)

 - [Move](api-ref/grpc/Cluster/move.md)

 - [Start](api-ref/grpc/Cluster/start.md)

 - [Stop](api-ref/grpc/Cluster/stop.md)

 - [RescheduleMaintenance](api-ref/grpc/Cluster/rescheduleMaintenance.md)

 - [ListLogs](api-ref/grpc/Cluster/listLogs.md)

 - [StreamLogs](api-ref/grpc/Cluster/streamLogs.md)

 - [ListOperations](api-ref/grpc/Cluster/listOperations.md)

 - [ListHosts](api-ref/grpc/Cluster/listHosts.md)

 - [ListAccessBindings](api-ref/grpc/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Cluster/updateAccessBindings.md)

#### Connector

 - [Overview](api-ref/grpc/Connector/index.md)

 - [Get](api-ref/grpc/Connector/get.md)

 - [List](api-ref/grpc/Connector/list.md)

 - [Create](api-ref/grpc/Connector/create.md)

 - [Update](api-ref/grpc/Connector/update.md)

 - [Delete](api-ref/grpc/Connector/delete.md)

 - [Resume](api-ref/grpc/Connector/resume.md)

 - [Pause](api-ref/grpc/Connector/pause.md)

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

#### Topic

 - [Overview](api-ref/grpc/Topic/index.md)

 - [Get](api-ref/grpc/Topic/get.md)

 - [List](api-ref/grpc/Topic/list.md)

 - [Create](api-ref/grpc/Topic/create.md)

 - [Update](api-ref/grpc/Topic/update.md)

 - [Delete](api-ref/grpc/Topic/delete.md)

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

#### Cluster

 - [Overview](api-ref/Cluster/index.md)

 - [Get](api-ref/Cluster/get.md)

 - [List](api-ref/Cluster/list.md)

 - [Create](api-ref/Cluster/create.md)

 - [Update](api-ref/Cluster/update.md)

 - [Delete](api-ref/Cluster/delete.md)

 - [Move](api-ref/Cluster/move.md)

 - [Start](api-ref/Cluster/start.md)

 - [Stop](api-ref/Cluster/stop.md)

 - [RescheduleMaintenance](api-ref/Cluster/rescheduleMaintenance.md)

 - [ListLogs](api-ref/Cluster/listLogs.md)

 - [StreamLogs](api-ref/Cluster/streamLogs.md)

 - [ListOperations](api-ref/Cluster/listOperations.md)

 - [ListHosts](api-ref/Cluster/listHosts.md)

 - [ListAccessBindings](api-ref/Cluster/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Cluster/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Cluster/updateAccessBindings.md)

#### Connector

 - [Overview](api-ref/Connector/index.md)

 - [Get](api-ref/Connector/get.md)

 - [List](api-ref/Connector/list.md)

 - [Create](api-ref/Connector/create.md)

 - [Update](api-ref/Connector/update.md)

 - [Delete](api-ref/Connector/delete.md)

 - [Resume](api-ref/Connector/resume.md)

 - [Pause](api-ref/Connector/pause.md)

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

#### Topic

 - [Overview](api-ref/Topic/index.md)

 - [Get](api-ref/Topic/get.md)

 - [List](api-ref/Topic/list.md)

 - [Create](api-ref/Topic/create.md)

 - [Update](api-ref/Topic/update.md)

 - [Delete](api-ref/Topic/delete.md)

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

 - [Вопросы и ответы](qa/index.md)

 - [Обучающие курсы](training.md)