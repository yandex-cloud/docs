# Yandex Query

Yandex Query — интерактивный, полностью управляемый сервис для инженеров данных и аналитиков. Сервис позволяет выполнять аналитические и потоковые запросы реального времени к структурированным или частично структурированным данным с помощью единого диалекта SQL.

# Yandex Query

## Начало работы

 - [Обзор](quickstart/index.md)

 - [Аналитическая обработка](quickstart/batch-example.md)

 - [Потоковая обработка](quickstart/streaming-example.md)

 - [Единый анализ потоковых и аналитических данных](quickstart/unified-example.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Термины и определения](concepts/glossary.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Обработка запроса](concepts/request-processing.md)

### Аналитическая обработка данных

 - [Описание](concepts/batch-processing.md)

 - [Федеративные запросы](concepts/federated-processing.md)

 - [Партицирование данных](concepts/partitioning.md)

 - [Расширенное партицирование](concepts/partition-projection.md)

### Потоковая обработка данных

 - [Описание](concepts/stream-processing.md)

 - [Окна потоковой обработки](concepts/stream-processing-windows.md)

 - [Обработка паттернов в данных](concepts/match-recognize.md)

 - [Единый анализ потоковых и аналитических данных](concepts/unified-processing.md)

 - [Резервное копирование](concepts/backup.md)

## Пошаговые инструкции

 - [Управление соединениями](operations/connection.md)

 - [Управление привязками](operations/binding.md)

 - [Загрузка схемы данных](operations/schema-uploading.md)

 - [Управление запросами](operations/query.md)

 - [Подключение с помощью IDE](operations/ide.md)

## Источники и приемники данных

 - [Форматы данных и алгоритмы сжатия](sources-and-sinks/formats.md)

### Работа с {{ objstorage-full-name }}

 - [Чтение данных с помощью соединений](sources-and-sinks/object-storage.md)

 - [Чтение данных с помощью привязок к данным](sources-and-sinks/object-storage-binding.md)

 - [Запись данных](sources-and-sinks/object-storage-write.md)

### Работа с Data Streams

 - [Чтение данных с помощью соединений](sources-and-sinks/data-streams.md)

 - [Чтение данных с помощью привязок к данным](sources-and-sinks/data-streams-binding.md)

 - [Запись данных](sources-and-sinks/data-streams-write.md)

### Работа с {{ monitoring-full-name }}

 - [Чтение данных с помощью соединений](sources-and-sinks/monitoring.md)

 - [Запись данных](sources-and-sinks/monitoring-write.md)

 - [Работа с базами данных {{ mch-name }}](sources-and-sinks/clickhouse.md)

 - [Работа с базами данных {{ mgp-name }}](sources-and-sinks/greenplum.md)

 - [Работа с базами данных {{ mmy-name }}](sources-and-sinks/mysql.md)

 - [Работа с базами данных {{ mpg-name }}](sources-and-sinks/postgresql.md)

 - [Работа с базами данных {{ ydb-name }}](sources-and-sinks/ydb.md)

 - [Чтение данных из таблиц {{ yq-iceberg-name }}](sources-and-sinks/iceberg.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Обработка логов {{ cloud-logging-name }}](tutorials/cloud-logging.md)

 - [Обработка потока изменений Debezium](tutorials/debezium.md)

 - [Визуализация данных из {{ objstorage-name }} в {{ datalens-name }}](tutorials/datalens.md)

 - [Обработка аудитных логов {{ at-name }}](tutorials/audit-trails.md)

 - [Обработка файлов детализации в сервисе {{ billing-name }}](tutorials/billing.md)

 - [Анализ данных с помощью {{ jlab }}](tutorials/jupyter.md)

 - [Автоматизация задач с помощью {{ maf-short-name }}](tutorials/airflow-auto-tasks.md)

 - [Анализ данных с помощью {{ yq-name }}](tutorials/yq.md)

 - [Работа с данными в {{ objstorage-name }}](tutorials/yq-storage.md)

 - [Работа с данными в {{ mch-name }}](tutorials/yq-clickhouse.md)

 - [Работа с данными в {{ mpg-name }}](tutorials/yq-postgre.md)

 - [Федеративные запросы к данным](tutorials/yq-federative-queries.md)

 - [Поиск событий {{ yandex-cloud }} в {{ yq-name }}](tutorials/search-events-query.md)

### Поставка данных из {{ forms-full-name }} в {{ datalens-full-name }} с использованием {{ sf-full-name }} и {{ yq-full-name }}

 - [Обзор](tutorials/forms-and-datalens-integration/index.md)

 - [Консоль управления](tutorials/forms-and-datalens-integration/console.md)

 - [Terraform](tutorials/forms-and-datalens-integration/terraform.md)

## Работа с YQL

 - [Обзор](yql-tutorials/index.md)

 - [Выборка данных из всех колонок](yql-tutorials/select-all-columns.md)

 - [Выборка данных из определенных колонок](yql-tutorials/select-specific-columns.md)

 - [Сортировка и фильтрация](yql-tutorials/sort-filter.md)

 - [Агрегирование данных](yql-tutorials/basic-aggregation.md)

 - [Дополнительные условия выборки](yql-tutorials/conditional-values.md)

 - [Работа с JSON](yql-tutorials/json.md)

 - [Выполнение запроса к потоковым данным](yql-tutorials/streaming-query.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник

 - [{{ TF }}](tf-ref.md)

 - [SDK](SDK/SDK.md)

### HTTP API

 - [Обзор](api/index.md)

 - [Аутентификация](api/auth.md)

#### Методы

 - [Все методы](api/methods/index.md)

 - [create-query](api/methods/create-query.md)

 - [get-query](api/methods/get-query.md)

 - [get-query-status](api/methods/get-query-status.md)

 - [stop-query](api/methods/stop-query.md)

 - [get-query-results](api/methods/get-query-results.md)

 - [Соответствие YQL и Json-типов](api/yql-json-conversion-rules.md)

 - [{{ AF }}](airflow/operator.md)

 - [Интеграции](integrations.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

 - [Вопросы и ответы](qa/index.md)

 - [Публичные материалы](public_talks.md)

 - [Обучающие курсы](training.md)