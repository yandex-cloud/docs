# Yandex Data Streams

Yandex Data Streams — масштабируемый сервис для управления потоками данных в режиме реального времени.  Data Streams непрерывно выполняет сбор данных из различных источников, например, истории посещений веб‑сайтов, логов работы приложений и системных журналов.  API сервиса совместим с Amazon Kinesis Data Streams API и Kafka API до версии <a href="https://kafka.apache.org/34/apis/">3.4.0</a> включительно.

# Yandex Data Streams

## Начало работы

 - [Подготовка окружения](quickstart/index.md)

 - [Создание потока данных](quickstart/create-stream.md)

### Сбор и поставка данных

 - [Fluentd](quickstart/fluentd.md)

 - [Logstash](quickstart/logstash.md)

 - [AWS CLI](quickstart/aws-cli.md)

 - [Обработка потока изменений из Debezium](quickstart/debezium.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Управление потоками данных](operations/manage-streams.md)

### Работа с AWS CLI

 - [Создание потока данных](operations/aws-cli/create.md)

 - [Получение информации о потоке](operations/aws-cli/describe.md)

 - [Отправка данных в поток](operations/aws-cli/send.md)

 - [Чтение данных из потока](operations/aws-cli/get-records.md)

 - [Удаление потока данных](operations/aws-cli/delete.md)

### Работа с AWS SDK

 - [Подготовка окружения](operations/aws-sdk/prepare.md)

 - [Создание потока данных](operations/aws-sdk/create.md)

 - [Отправка данных в поток](operations/aws-sdk/send.md)

 - [Чтение данных из потока](operations/aws-sdk/get-records.md)

 - [Удаление потока данных](operations/aws-sdk/delete.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Термины и определения](concepts/glossary.md)

 - [Сегменты и ключи сегментов](concepts/partition-keys.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Сравнение с Yandex Message Queue](concepts/yds-ymq-comparison.md)

 - [Транзакции с участием потоков данных и таблиц YDB](concepts/topic-table-transactions.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Ввод данных в системы хранения](tutorials/data-ingestion.md)

 - [Умная обработка логов](tutorials/log-ingestion.md)

 - [Передача данных в микросервисных архитектурах](tutorials/message-broker.md)

 - [Сохранение данных в ClickHouse®](tutorials/send-to-clickhouse.md)

 - [Репликация логов в Object Storage с помощью Fluent Bit](tutorials/replicate-logs-to-storage.md)

 - [Репликация логов в {{ objstorage-name }} с помощью {{ yds-name }}](tutorials/replicate-logs-to-storage-via-data-streams.md)

 - [Миграция данных в {{ objstorage-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/yds-obj-migration.md)

 - [Поставка данных из {{ mkf-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/kafka-to-yds.md)

 - [Поставка данных из очереди {{ yds-name }} в {{ ydb-name }}](tutorials/yds-to-ydb.md)

 - [Поставка данных в {{ mkf-full-name }} с помощью {{ data-transfer-full-name }}](tutorials/yds-to-kafka.md)

 - [Захват изменений {{ ydb-short-name }} и поставка в {{ DS }}](tutorials/ydb-to-yds.md)

 - [Захват изменений {{ PG }} и поставка в {{ DS }}](tutorials/mpg-to-yds.md)

 - [Захват изменений {{ MY }} и поставка в {{ DS }}](tutorials/mmy-to-yds.md)

### Хранение статического ключа доступа в секрете {{ lockbox-name }}

 - [Обзор](tutorials/static-key-in-lockbox/index.md)

 - [CLI](tutorials/static-key-in-lockbox/console.md)

 - [{{ TF }}](tutorials/static-key-in-lockbox/terraform.md)

 - [Передача событий {{ postbox-full-name }} в {{ yds-full-name }} и их анализ с помощью {{ datalens-full-name }}](tutorials/events-from-postbox-to-yds.md)

 - [Создание интерактивного serverless-приложения с использованием WebSocket](tutorials/websocket-app.md)

 - [Обработка аудитных логов {{ at-name }}](tutorials/audit-trails.md)

### Поиск событий в аудитных логах

 - [Обзор](tutorials/search-events-audit-logs/index.md)

 - [Инструменты для работы с аудитными логами](tutorials/search-events-audit-logs/tools.md)

 - [Примеры запросов для поиска событий](tutorials/search-events-audit-logs/examples.md)

 - [Настройка работы с {{ yq-full-name }}](tutorials/search-events-audit-logs/query.md)

 - [Обработка потока изменений Debezium](tutorials/debezium.md)

### Загрузка аудитных логов в MaxPatrol SIEM

 - [Обзор](tutorials/maxpatrol/index.md)

 - [Консоль управления](tutorials/maxpatrol/console.md)

 - [{{ TF }}](tutorials/maxpatrol/terraform.md)

 - [Поиск событий {{ yandex-cloud }} в {{ yq-full-name }}](tutorials/search-events-query.md)

 - [Интеграция {{ postbox-full-name }} с внешними системами через вебхуки](tutorials/postbox-webhook.md)

 - [Диагностика медленной записи в {{ yds-full-name }}](tutorials/slow-writes-debug.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## HTTP API, совместимый с Amazon Kinesis Data Streams

 - [Обзор](kinesisapi/index.md)

 - [Все методы](kinesisapi/api-ref.md)

### Методы

 - [CreateStream](kinesisapi/methods/createstream.md)

 - [DecreaseStreamRetentionPeriod](kinesisapi/methods/decreasetreamretentionperiod.md)

 - [DeleteStream](kinesisapi/methods/deletestream.md)

 - [DescribeStream](kinesisapi/methods/describestream.md)

 - [IncreaseStreamRetentionPeriod](kinesisapi/methods/increasestreamretentionperiod.md)

 - [GetRecords](kinesisapi/methods/getrecords.md)

 - [GetShardIterator](kinesisapi/methods/getsharditerator.md)

 - [ListStreams](kinesisapi/methods/liststreams.md)

 - [PutRecord](kinesisapi/methods/putrecord.md)

 - [PutRecords](kinesisapi/methods/putrecords.md)

 - [UpdateShardCount](kinesisapi/methods/updateshardcount.md)

 - [Общие ошибки](kinesisapi/common-errors.md)

 - [Примеры](kinesisapi/examples.md)

## Kafka API

 - [Обзор](kafkaapi/index.md)

 - [Аутентификация и соединение с БД](kafkaapi/auth.md)

 - [Вопросы и ответы](qa/index.md)