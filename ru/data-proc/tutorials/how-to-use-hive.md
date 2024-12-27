# Запуск заданий Apache Hive

[Hive](https://hive.apache.org/) — инструмент доступа к хранилищам данных в экосистеме Hadoop. Позволяет работать с данными в разных форматах и СУБД, используя SQL-подобный язык запросов. Преимущественно используется для работы с данными в HDFS, HBase, S3-совместимых хранилищах и [реляционных СУБД](../../glossary/relational-databases.md).

Вы можете запускать задания Hive как с помощью [CLI {{ yandex-cloud }}](#run-hive-job-cli), так и непосредственно на сервере с помощью [Hive CLI](#hive-shell).

{% include [get-logs-info](../../_includes/data-processing/note-info-get-logs.md) %}

## Работа с заданиями в CLI {{ yandex-cloud }} {#run-hive-job-cli}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../_includes/data-processing/cli-job-intro.md) %}

SQL-запрос для Hive можно передать двумя способами:

* [в команде на запуск задачи](#sql-in-cli);
* [в объекте {{objstorage-name}}](#sql-from-objstorage), который доступен на чтение сервисному аккаунту кластера {{dataproc-name}}.

Результат выполнения запроса сохраняется в привязанный к кластеру бакет {{objstorage-full-name}} вместе с сервисным выводом.

### Перед началом работы {#before-you-begin-yc-cli}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. {% include [tutorials-basic-before-buckets](../../_includes/data-processing/tutorials/basic-before-buckets.md) %}

1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`;
        * `HIVE`;
        * `MAPREDUCE`;
        * `SPARK`;
        * `YARN`.
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — выберите созданный ранее сервисный аккаунт.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — выберите бакет для результатов обработки.
    * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** — включите опцию для доступа к хостам всех подкластеров.

### Передача SQL-запроса в команде на запуск задачи {#sql-in-cli}

1. Создайте внешнюю таблицу (external table) для данных примера в формате Parquet. Таблица будет содержать список перелетов между городами США в 2018-м году. Выполните следующий запрос с помощью CLI {{ yandex-cloud }}:

    ```bash
    yc dataproc job create-hive \
       --cluster-id=<идентификатор_кластера> \
       --name=task-one \
       --query-list="CREATE EXTERNAL TABLE flights (
         Year bigint,
         Month bigint,
         FlightDate string,
         Flight_Number_Reporting_Airline bigint,
         OriginAirportID bigint,
         DestAirportID bigint)
         STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';"
    ```

    {% cut "Пример ответа на запрос" %}

    ```bash
    done (14s)
    id: c9qloj5crovu********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T03:51:03.285819Z"
    started_at: "2024-12-04T03:51:15.884426Z"
    finished_at: "2024-12-04T03:51:15.884426Z"
    name: task-one
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_list:
        queries:
          - CREATE EXTERNAL TABLE flights (Year bigint, Month bigint, FlightDate string, Flight_Number_Reporting_Airline bigint, OriginAirportID bigint, DestAirportID bigint) STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
    application_info: {}
    ```

    {% endcut %}

1. Проверьте, что таблица успешно создалась. Для этого запросите количество перелетов по месяцам:

    ```bash
    {{ yc-dp }} job create-hive \
       --cluster-id=<идентификатор_кластера> \
       --name=task-two \
       --query-list="SELECT Month, COUNT(*) FROM flights GROUP BY Month;"
    ```

    {% cut "Пример ответа на запрос" %}

    ```bash
    done (34s)
    id: c9quejacclo3********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T05:15:38.436203Z"
    started_at: "2024-12-04T05:16:11.608422Z"
    finished_at: "2024-12-04T05:16:11.608422Z"
    name: task-two
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_list:
        queries:
          - SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    application_info: {}
    ```

    {% endcut %}

1. В бакете для результатов обработки перейдите в папку:

    ```
    dataproc/clusters/<идентификатор_кластера>/jobs/<идентификатор_задания_Hive>
    ```

    Идентификатор задания указан в выводе команды запуска задания YC CLI и в ответе [API](../../glossary/rest-api.md) на запуск задания.

1. Скачайте файл `driveroutput.000000000`, который содержит ответ на запрос.

    {% cut "Пример ответа на запрос" %}

    ```bash
    Init job c9quejacclo3******** at Wed Dec  4 05:15:40 UTC 2024
    ...
    Connecting to jdbc:hive2://localhost:10000
    Connected to: Apache Hive (version 3.1.2)
    Driver: Hive JDBC (version 3.1.2)
    Transaction isolation: TRANSACTION_REPEATABLE_READ
    0: jdbc:hive2://localhost:10000> SELECT Month, COUNT(*) FROM flights GROUP BY Month;;
    +--------+---------+
    | month  |   _c1   |
    +--------+---------+
    | 1      | 570118  |
    | 2      | 520731  |
    | 3      | 611987  |
    | 4      | 596046  |
    | 5      | 616529  |
    | 6      | 626193  |
    | 7      | 645299  |
    | 8      | 644673  |
    | 9      | 585749  |
    | 10     | 616101  |
    | 11     | 586178  |
    | 12     | 593842  |
    +--------+---------+
    12 rows selected (27.532 seconds)
    0: jdbc:hive2://localhost:10000>
    0: jdbc:hive2://localhost:10000> Closing: 0: jdbc:hive2://localhost:10000
    ```

    {% endcut %}

    Если при выполнении запроса возникнут ошибки, информация о них также сохранится в файле `driveroutput.000000000`.

### Передача SQL-запроса в объекте {{objstorage-name}} {#sql-from-objstorage}

1. Создайте файл `create-table.sql` и поместите в него SQL-запрос для создания внешней таблицы (external table) для данных примера в формате Parquet. Таблица будет содержать список перелетов между городами США в 2018-м году. SQL-запрос будет выглядеть так:

    ```sql
    CREATE EXTERNAL TABLE flights (
        Year bigint,
        Month bigint,
        FlightDate string,
        Flight_Number_Reporting_Airline bigint,
        OriginAirportID bigint,
        DestAirportID bigint)
        STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
    ```

1. [Загрузите файл](../../storage/operations/objects/upload.md) `create-table.sql` в бакет для исходных данных.

1. Выполните команду:

    ```bash
    yc dataproc job create-hive \
      --cluster-id=<идентификатор_кластера> \
      --name=task-one \
      --query-file-uri="s3a://<имя_бакета_для_исходных_данных>/create-table.sql"
    ```

    {% cut "Пример ответа на запрос" %}

    ```bash
    done (8s)
    id: c9qhpt6334qs********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T04:21:20.062704Z"
    started_at: "2024-12-04T04:21:27.702644Z"
    finished_at: "2024-12-04T04:21:27.702644Z"
    name: task-one
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_file_uri: s3a://<имя_бакета_для_исходных_данных>/create-table.sql
    application_info: {}
    ```

    {% endcut %}

1. Создайте файл `get-data.sql` и поместите в него SQL-запрос на количество перелетов по месяцам:

    ```sql
    SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    ```

1. Загрузите файл `get-data.sql` в бакет для исходных данных.
1. Выполните команду:

    ```bash
    yc dataproc job create-hive \
      --cluster-id=<идентификатор_кластера> \
      --name=task-two \
      --query-file-uri="s3a://<имя_бакета_для_исходных_данных>/get-data.sql"
    ```

    {% cut "Пример ответа на запрос" %}

    ```bash
    done (37s)
    id: c9q2srq817cu********
    cluster_id: c9qkjos5sa3d********
    created_at: "2024-12-04T04:24:58.480468Z"
    started_at: "2024-12-04T04:25:34.613549Z"
    finished_at: "2024-12-04T04:25:34.613549Z"
    name: task-two
    created_by: ajefhe0o8uas********
    status: DONE
    hive_job:
      query_file_uri: s3a://<имя_бакета_для_исходных_данных>/get-data.sql
    application_info: {}
    ```

    {% endcut %}

1. В бакете для результатов обработки перейдите в папку:

    ```
    dataproc/clusters/<идентификатор_кластера>/jobs/<идентификатор_задания_Hive>
    ```

    Идентификатор задания указан в выводе команды запуска задания YC CLI и в ответе [API](../../glossary/rest-api.md) на запуск задания.

1. Скачайте файл `driveroutput.000000000`, который содержит ответ на запрос.

    {% cut "Пример ответа на запрос" %}

    ```bash
    Init job c9q2gha5hocg******** at Wed Dec  4 06:56:45 UTC 2024
    ...
    Connecting to jdbc:hive2://localhost:10000
    Connected to: Apache Hive (version 3.1.2)
    Driver: Hive JDBC (version 3.1.2)
    Transaction isolation: TRANSACTION_REPEATABLE_READ
    0: jdbc:hive2://localhost:10000> SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    +--------+---------+
    | month  |   _c1   |
    +--------+---------+
    | 1      | 570118  |
    | 2      | 520731  |
    | 3      | 611987  |
    | 4      | 596046  |
    | 5      | 616529  |
    | 6      | 626193  |
    | 7      | 645299  |
    | 8      | 644673  |
    | 9      | 585749  |
    | 10     | 616101  |
    | 11     | 586178  |
    | 12     | 593842  |
    +--------+---------+
    12 rows selected (28.801 seconds)
    0: jdbc:hive2://localhost:10000> Closing: 0: jdbc:hive2://localhost:10000
    ```

    {% endcut %}

    Если при выполнении запроса возникнут ошибки, информация о них также сохранится в файле `driveroutput.000000000`.

## Работа с заданиями в Hive CLI {#hive-shell}

### Перед началом работы {#before-you-begin-hive-shell}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`;
        * `HIVE`;
        * `SPARK`;
        * `YARN`.
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — выберите созданный ранее сервисный аккаунт.
    * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** — включите опцию для доступа к хостам всех подкластеров.

### Запуск задания с помощью Hive CLI {#run-job-hive-shell}

1. [Подключитесь к хосту-мастеру](../operations/connect.md#data-proc-ssh) по [SSH](../../glossary/ssh-keygen.md) и выполните команду `hive`.

1. Проверьте работоспособность Hive — выполните команду `select 1;`. Корректный результат выглядит так:

   ```text
   OK
   1
   Time taken: 0.077 seconds, Fetched: 1 row(s)
   ```

1. Создайте внешнюю таблицу (external table) для данных примера в формате Parquet. Таблица будет содержать список перелетов между городами США в 2018-м году. Выполните следующий запрос с помощью Hive CLI:

    ```sql
    CREATE EXTERNAL TABLE flights (
        Year bigint,
        Month bigint,
        FlightDate string,
        Flight_Number_Reporting_Airline bigint,
        OriginAirportID bigint,
        DestAirportID bigint)
        STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
    ```

1. Проверьте список таблиц:

    ```sql
    show tables;
    ```

1. Список таблиц должен выглядеть так:

    ```text
    OK
    flights
    Time taken: 0.043 seconds, Fetched: 1 row(s)
    ```

1. Запросите количество перелетов по месяцам:

    ```sql
    SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    ```

    {% cut "Пример ответа на запрос" %}

    ```text
    Query ID = root_20200119195338_28049b67-4de9-4568-a4c4-3bbe********
    Total jobs = 1
    Launching Job 1 out of 1
    Status: Running (Executing on YARN cluster with App id application_157925157****_****)

    ----------------------------------------------------------------------------------------------
            VERTICES      MODE        STATUS  TOTAL  COMPLETED  RUNNING  PENDING  FAILED  KILLED
    ----------------------------------------------------------------------------------------------
    Map 1 .......... container     SUCCEEDED      6          6        0        0       0       0
    Reducer 2 ...... container     SUCCEEDED      1          1        0        0       0       0
    ----------------------------------------------------------------------------------------------
    VERTICES: 02/02  [==========================>>] 100%  ELAPSED TIME: 11.52 s
    ----------------------------------------------------------------------------------------------
    OK
    1       570118
    2       520731
    3       611987
    4       596046
    5       616529
    6       626193
    7       645299
    8       644673
    9       585749
    10      616101
    11      586178
    12      593842
    Time taken: 12.137 seconds, Fetched: 12 row(s)
    ```

    {% endcut %}
