# Yandex Managed Service for YDB

Yandex Managed Service for YDB помогает разворачивать и поддерживать базы данных YDB в инфраструктуре Yandex Cloud.

<a href="https://ydb.tech/ru">YDB</a> — это распределенная отказоустойчивая Distributed SQL СУБД. YDB обеспечивает высокую доступность, горизонтальную масштабируемость, а также строгую консистентность и поддержку ACID-транзакций. Для запросов используется диалект SQL (<a href="https://ydb.tech/docs/ru/yql/reference/">YQL</a>).

Данная документация описывает особенности работы YDB в инфраструктуре Yandex Cloud. Основная документация YDB находится по адресу <a href="https://ydb.tech/docs/">https://ydb.tech/docs/</a>.

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ.

# Yandex Managed Service for YDB

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Обзор](operations/index.md)

 - [Подключение к БД с помощью YDB CLI](operations/connection.md)

 - [Управление базами данных](operations/manage-databases.md)

 - [Миграция базы данных в другую зону доступности](operations/migration-to-an-availability-zone.md)

 - [Управление таблицами и директориями](operations/schema.md)

 - [Чтение и запись данных](operations/crud.md)

 - [Мониторинг состояния базы данных](operations/monitoring.md)

 - [Работа с YDB через ydb-mcp сервер на примере IDE Cursor](operations/ydb-mcp-cursor.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Развертывание веб-приложения](tutorials/java-servlet-todo-list.md)

 - [Подключение к YDB из функции Yandex Cloud Functions на Python](tutorials/connect-from-cf.md)

 - [Подключение к базе данных YDB из функции Yandex Cloud Functions на Node.js](tutorials/connect-from-cf-nodejs.md)

### Конвертация видео в GIF на Python

 - [Обзор](tutorials/video-converting-queue/index.md)

 - [Консоль управления](tutorials/video-converting-queue/console.md)

 - [Terraform](tutorials/video-converting-queue/terraform.md)

 - [Разработка навыка Алисы и сайта с авторизацией](tutorials/alice-shareable-todolist.md)

 - [Миграция базы данных из Yandex Managed Service for MySQL® с помощью Yandex Data Transfer](tutorials/mmy-ydb-migration.md)

 - [Поставка данных из YDB в Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](tutorials/ydb-mkf-replication.md)

 - [Поставка данных из YDB в Yandex Data Streams с помощью Yandex Data Transfer](tutorials/ydb-to-yds.md)

 - [Загрузка данных из Yandex Object Storage в YDB с помощью Yandex Data Transfer](tutorials/object-storage-to-ydb.md)

 - [Загрузка данных из YDB в Yandex Object Storage с помощью Yandex Data Transfer](tutorials/ydb-to-object-storage.md)

 - [Загрузка данных из YDB в Yandex Managed Service for ClickHouse® с помощью Yandex Data Transfer](tutorials/ydb-to-clickhouse.md)

 - [Загрузка данных из YDB в Yandex Managed Service for PostgreSQL с помощью Yandex Data Transfer](tutorials/ydb-to-postgresql.md)

 - [Миграция данных из Yandex Managed Service for OpenSearch в YDB с помощью Yandex Data Transfer](tutorials/opensearch-to-ydb.md)

 - [Построение пайплайна CI/CD в GitLab с использованием serverless-продуктов](tutorials/ci-cd-serverless.md)

 - [Поставка данных из Yandex Managed Service for PostgreSQL в Yandex Managed Service for YDB с помощью Yandex Data Transfer](tutorials/mpg-ydb-replication.md)

 - [Передача событий Yandex Cloud Postbox в Yandex Data Streams и их анализ с помощью Yandex DataLens](tutorials/events-from-postbox-to-yds.md)

 - [Поставка данных из Yandex Managed Service for Apache Kafka® в Data Streams с помощью Yandex Data Transfer](tutorials/mkf-yds-stream.md)

 - [Поставка данных из Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](tutorials/mkf-ydb-stream.md)

 - [Сохранение потока данных Data Streams в Managed Service for ClickHouse®](tutorials/yds-to-clickhouse.md)

 - [Поставка данных из очереди Data Streams в Managed Service for Apache Kafka® с помощью Data Transfer](tutorials/yds-to-kafka.md)

 - [Поставка данных из очереди Data Streams в Managed Service for YDB с помощью Data Transfer](tutorials/yds-to-ydb.md)

 - [Захват изменений MySQL® и поставка в YDS](tutorials/mmy-to-yds.md)

 - [Захват изменений PostgreSQL и поставка в YDS](tutorials/mpg-to-yds.md)

 - [Интерактивная отладка функций Cloud Functions](tutorials/serverless-live-debug.md)

 - [Блокировка состояний Terraform с помощью Managed Service for YDB](tutorials/terraform-state-lock.md)

 - [Разработка пользовательской интеграции в API Gateway](tutorials/api-gw-integration.md)

 - [Разработка CRUD API для сервиса фильмов](tutorials/movies-database.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/websocket-app.md)

### Сокращатель ссылок

 - [Обзор](tutorials/serverless-url-shortener/index.md)

 - [Консоль управления](tutorials/serverless-url-shortener/console.md)

 - [Terraform](tutorials/serverless-url-shortener/terraform.md)

### Загрузка аудитных логов в MaxPatrol SIEM

 - [Обзор](tutorials/maxpatrol/index.md)

 - [Консоль управления](tutorials/maxpatrol/console.md)

 - [Terraform](tutorials/maxpatrol/terraform.md)

 - [Интеграция Yandex Cloud Postbox с внешними системами через вебхуки](tutorials/postbox-webhook.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Термины и определения](concepts/resources.md)

 - [Режимы работы Serverless и Dedicated](concepts/serverless-and-dedicated.md)

 - [Автоматическое масштабирование](concepts/autoscaling.md)

 - [Режимы работы OLTP или OLAP](concepts/oltp-and-olap.md)

 - [Трансфер](concepts/transfer.md)

 - [Таблицы DynamoDB](concepts/dynamodb-tables.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

## Правила тарификации

 - [Обзор](pricing/index.md)

### Режим Serverless

 - [Правила тарификации для режима Serverless](pricing/serverless.md)

 - [Стоимость запроса для YQL](pricing/ru-yql.md)

 - [Стоимость запроса для Document API](pricing/ru-docapi.md)

 - [Стоимость запроса для специальных API](pricing/ru-special.md)

 - [Стоимость операций с топиками](pricing/ru-topics.md)

### Режим Dedicated

 - [Правила тарификации для режима Dedicated](pricing/dedicated.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### backup

 - [Overview](cli-ref/backup/index.md)

 - [add-access-binding](cli-ref/backup/add-access-binding.md)

 - [delete](cli-ref/backup/delete.md)

 - [get](cli-ref/backup/get.md)

 - [list](cli-ref/backup/list.md)

 - [list-access-bindings](cli-ref/backup/list-access-bindings.md)

 - [remove-access-binding](cli-ref/backup/remove-access-binding.md)

 - [set-access-bindings](cli-ref/backup/set-access-bindings.md)

### database

 - [Overview](cli-ref/database/index.md)

 - [add-access-binding](cli-ref/database/add-access-binding.md)

 - [add-labels](cli-ref/database/add-labels.md)

 - [backup](cli-ref/database/backup.md)

 - [create](cli-ref/database/create.md)

 - [delete](cli-ref/database/delete.md)

 - [get](cli-ref/database/get.md)

 - [list](cli-ref/database/list.md)

 - [list-access-bindings](cli-ref/database/list-access-bindings.md)

 - [move](cli-ref/database/move.md)

 - [remove-access-binding](cli-ref/database/remove-access-binding.md)

 - [remove-labels](cli-ref/database/remove-labels.md)

 - [restore](cli-ref/database/restore.md)

 - [set-access-bindings](cli-ref/database/set-access-bindings.md)

 - [start](cli-ref/database/start.md)

 - [stop](cli-ref/database/stop.md)

 - [update](cli-ref/database/update.md)

### resource-preset

 - [Overview](cli-ref/resource-preset/index.md)

 - [get](cli-ref/resource-preset/get.md)

 - [list](cli-ref/resource-preset/list.md)

### storage-type

 - [Overview](cli-ref/storage-type/index.md)

 - [get](cli-ref/storage-type/get.md)

 - [list](cli-ref/storage-type/list.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### backup

 - [Overview](cli-ref/v0/backup/index.md)

 - [add-access-binding](cli-ref/v0/backup/add-access-binding.md)

 - [delete](cli-ref/v0/backup/delete.md)

 - [get](cli-ref/v0/backup/get.md)

 - [list](cli-ref/v0/backup/list.md)

 - [list-access-bindings](cli-ref/v0/backup/list-access-bindings.md)

 - [remove-access-binding](cli-ref/v0/backup/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/backup/set-access-bindings.md)

#### database

 - [Overview](cli-ref/v0/database/index.md)

 - [add-access-binding](cli-ref/v0/database/add-access-binding.md)

 - [add-labels](cli-ref/v0/database/add-labels.md)

 - [backup](cli-ref/v0/database/backup.md)

 - [create](cli-ref/v0/database/create.md)

 - [delete](cli-ref/v0/database/delete.md)

 - [get](cli-ref/v0/database/get.md)

 - [list](cli-ref/v0/database/list.md)

 - [list-access-bindings](cli-ref/v0/database/list-access-bindings.md)

 - [move](cli-ref/v0/database/move.md)

 - [remove-access-binding](cli-ref/v0/database/remove-access-binding.md)

 - [remove-labels](cli-ref/v0/database/remove-labels.md)

 - [restore](cli-ref/v0/database/restore.md)

 - [set-access-bindings](cli-ref/v0/database/set-access-bindings.md)

 - [start](cli-ref/v0/database/start.md)

 - [stop](cli-ref/v0/database/stop.md)

 - [update](cli-ref/v0/database/update.md)

#### resource-preset

 - [Overview](cli-ref/v0/resource-preset/index.md)

 - [get](cli-ref/v0/resource-preset/get.md)

 - [list](cli-ref/v0/resource-preset/list.md)

#### storage-type

 - [Overview](cli-ref/v0/storage-type/index.md)

 - [get](cli-ref/v0/storage-type/get.md)

 - [list](cli-ref/v0/storage-type/list.md)

## Document API, совместимый с Amazon DynamoDB

### Инструменты

 - [Настройка инструментов AWS](docapi/tools/aws-setup.md)

 - [Работа с данными через HTTP-интерфейс](docapi/tools/aws-http.md)

#### Работа с AWS CLI

 - [Обзор](docapi/tools/aws-cli/index.md)

 - [Создание таблицы](docapi/tools/aws-cli/create-table.md)

 - [Добавление данных в таблицу](docapi/tools/aws-cli/put-item.md)

 - [Чтение данных из таблицы](docapi/tools/aws-cli/get-item.md)

 - [Обновление данных](docapi/tools/aws-cli/update-item.md)

 - [Выборка данных](docapi/tools/aws-cli/query.md)

 - [Удаление созданных ресурсов](docapi/tools/aws-cli/cleanup.md)

#### Работа с AWS SDK

 - [Обзор](docapi/tools/aws-sdk/index.md)

 - [Создание таблицы](docapi/tools/aws-sdk/create-table.md)

 - [Загрузка данных в таблицу](docapi/tools/aws-sdk/load-data.md)

##### Управление записями в таблице

 - [Создание записи](docapi/tools/aws-sdk/create-item.md)

 - [Чтение записи](docapi/tools/aws-sdk/read-item.md)

 - [Обновление записи](docapi/tools/aws-sdk/update-item.md)

 - [Удаление записи](docapi/tools/aws-sdk/delete-item.md)

 - [Поиск и извлечение данных](docapi/tools/aws-sdk/query-and-scan.md)

 - [Удаление таблицы](docapi/tools/aws-sdk/delete-table.md)

### Справочник Document API

 - [Все методы](docapi/api-ref/index.md)

#### Actions

 - [BatchGetItem](docapi/api-ref/actions/batchGetItem.md)

 - [BatchWriteItem](docapi/api-ref/actions/batchWriteItem.md)

 - [CreateTable](docapi/api-ref/actions/createTable.md)

 - [DeleteItem](docapi/api-ref/actions/deleteItem.md)

 - [DeleteTable](docapi/api-ref/actions/deleteTable.md)

 - [DescribeTable](docapi/api-ref/actions/describeTable.md)

 - [DescribeTimeToLive](docapi/api-ref/actions/describeTimeToLive.md)

 - [GetItem](docapi/api-ref/actions/getItem.md)

 - [ListTables](docapi/api-ref/actions/listTables.md)

 - [PutItem](docapi/api-ref/actions/putItem.md)

 - [Query](docapi/api-ref/actions/query.md)

 - [Scan](docapi/api-ref/actions/scan.md)

 - [TransactGetItems](docapi/api-ref/actions/transactGetItems.md)

 - [TransactWriteItems](docapi/api-ref/actions/transactWriteItems.md)

 - [UpdateItem](docapi/api-ref/actions/updateItem.md)

 - [UpdateTimeToLive](docapi/api-ref/actions/updateTimeToLive.md)

 - [UpdateTable](docapi/api-ref/actions/updateTable.md)

 - [Общие ошибки при работе с Document API](docapi/common-errors.md)

## Справочник API Yandex Cloud для Managed Service for YDB

 - [Обзор](api-ref/overview.md)

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Backup

 - [Overview](api-ref/grpc/Backup/index.md)

 - [Get](api-ref/grpc/Backup/get.md)

 - [ListPaths](api-ref/grpc/Backup/listPaths.md)

 - [List](api-ref/grpc/Backup/list.md)

 - [ListAccessBindings](api-ref/grpc/Backup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Backup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Backup/updateAccessBindings.md)

 - [Delete](api-ref/grpc/Backup/delete.md)

#### Database

 - [Overview](api-ref/grpc/Database/index.md)

 - [Get](api-ref/grpc/Database/get.md)

 - [List](api-ref/grpc/Database/list.md)

 - [Create](api-ref/grpc/Database/create.md)

 - [Update](api-ref/grpc/Database/update.md)

 - [Start](api-ref/grpc/Database/start.md)

 - [Stop](api-ref/grpc/Database/stop.md)

 - [Move](api-ref/grpc/Database/move.md)

 - [ListAccessBindings](api-ref/grpc/Database/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Database/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Database/updateAccessBindings.md)

 - [Delete](api-ref/grpc/Database/delete.md)

 - [Restore](api-ref/grpc/Database/restore.md)

 - [Backup](api-ref/grpc/Database/backup.md)

#### Location

 - [Overview](api-ref/grpc/Location/index.md)

 - [Get](api-ref/grpc/Location/get.md)

 - [List](api-ref/grpc/Location/list.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### ResourcePreset

 - [Overview](api-ref/grpc/ResourcePreset/index.md)

 - [Get](api-ref/grpc/ResourcePreset/get.md)

 - [List](api-ref/grpc/ResourcePreset/list.md)

#### StorageType

 - [Overview](api-ref/grpc/StorageType/index.md)

 - [Get](api-ref/grpc/StorageType/get.md)

 - [List](api-ref/grpc/StorageType/list.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Backup

 - [Overview](api-ref/Backup/index.md)

 - [Get](api-ref/Backup/get.md)

 - [ListPaths](api-ref/Backup/listPaths.md)

 - [List](api-ref/Backup/list.md)

 - [Delete](api-ref/Backup/delete.md)

#### Database

 - [Overview](api-ref/Database/index.md)

 - [Get](api-ref/Database/get.md)

 - [List](api-ref/Database/list.md)

 - [Create](api-ref/Database/create.md)

 - [Update](api-ref/Database/update.md)

 - [Start](api-ref/Database/start.md)

 - [Stop](api-ref/Database/stop.md)

 - [Move](api-ref/Database/move.md)

 - [Delete](api-ref/Database/delete.md)

 - [Restore](api-ref/Database/restore.md)

 - [Backup](api-ref/Database/backup.md)

#### Location

 - [Overview](api-ref/Location/index.md)

 - [Get](api-ref/Location/get.md)

 - [List](api-ref/Location/list.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### ResourcePreset

 - [Overview](api-ref/ResourcePreset/index.md)

 - [Get](api-ref/ResourcePreset/get.md)

 - [List](api-ref/ResourcePreset/list.md)

#### StorageType

 - [Overview](api-ref/StorageType/index.md)

 - [Get](api-ref/StorageType/get.md)

 - [List](api-ref/StorageType/list.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

## Работа с YDB через Terraform

 - [Введение в работу с YDB через Terraform](terraform/intro.md)

 - [Получение данных для аутентификации](terraform/credentials.md)

 - [Установка и настройка Terraform и провайдера для подключения к YDB](terraform/install.md)

 - [Создание конфигурационных файлов и подключение к YDB](terraform/configure.md)

 - [Создание и изменение параметров бессерверной базы данных](terraform/serverless-database.md)

 - [Создание и изменение параметров выделенной базы данных](terraform/dedicated-database.md)

 - [Создание строковых и колоночных таблиц в базе данных](terraform/tables.md)

 - [Создание документных таблиц в базе данных](terraform/dynamodb-tables.md)

 - [Создание потока изменений таблицы](terraform/cdc.md)

 - [Создание вторичных индексов строковых таблиц](terraform/row-tables-secondary-index.md)

 - [Управление конфигурацией топиков YDB](terraform/topic.md)

 - [Вопросы и ответы](faq.md)

 - [Публичные материалы](https://ydb.tech/docs/ru/public-talks)

 - [Обучающие курсы](training.md)