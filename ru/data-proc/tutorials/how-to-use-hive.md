# Запуск заданий Apache Hive

[Hive](https://hive.apache.org/) — инструмент доступа к хранилищам данных в экосистеме Hadoop. Позволяет работать с данными в разных форматах и СУБД, используя SQL-подобный язык запросов. Преимущественно используется для работы с данными в HDFS, HBase, S3-совместимых хранилищах и [реляционных СУБД](../../glossary/relational-databases.md).

Вы можете запускать задания Hive как с помощью [CLI {{ yandex-cloud }}](#run-hive-job-cli), так и непосредственно на сервере с помощью [Hive CLI](#run-job-hive-shell).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `mdb.dataproc.agent`.

1. {% include [tutorials-basic-before-buckets](../../_includes/data-proc/tutorials/basic-before-buckets.md) %}

1. [Создайте кластер {{ dataproc-name }}](../operations/cluster-create.md) со следующими настройками:

    * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:
        * `HDFS`
        * `SPARK`
        * `HIVE`
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: выберите созданный ранее сервисный аккаунт с ролью `mdb.dataproc.agent`.
    * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: выберите бакет для результатов обработки.
    * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**: выберите опцию для доступа к хостам всех подкластеров.

## Запуск задания с помощью CLI {{ yandex-cloud }} {#run-hive-job-cli}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../_includes/data-proc/cli-job-intro.md) %}

Результат расчета сохраняется в бакет {{objstorage-full-name}} вместе с сервисным выводом.

SQL-запрос для Hive можно передать двумя способами:

* В команде на запуск задачи:

    ```bash
    {{ yc-dp }} job create-hive \
       --cluster-id=<идентификатор_кластера> \
       --name=<имя_задачи> \
       --query-list="SELECT Month, COUNT(*) FROM flights GROUP BY Month;"
    ```

* В объекте {{objstorage-name}}, который доступен на чтение сервисному аккаунту кластера {{dataproc-name}}:

    ```bash
    {{ yc-dp }} job create-hive \
       --cluster-id=<идентификатор_кластера> \
       --name=<имя_задачи> \
       --query-file-uri="s3a://<бакет>/hive-query.sql"
    ```

Результат исполнения запросов, а также дополнительную диагностическую информацию можно найти в бакете {{objstorage-name}}, который был указан при создании кластера: `s3://<бакет>/dataproc/clusters/<идентификатор_кластера>/jobs/<идентификатор_задачи>/`.

Идентификатор задачи есть в выводе команды запуска задания YC CLI и есть в ответе [API](../../glossary/rest-api.md) на запуск задания.

## Запуск задания с помощью Hive CLI {#run-job-hive-shell}

1. Подключитесь к хосту-мастеру по [SSH](../../glossary/ssh-keygen.md) и выполните команду `hive`.

1. Проверьте работоспособность Hive — выполните команду `select 1;`. Корректный результат выглядит так:

   ```text
   OK
   1
   Time taken: 0.077 seconds, Fetched: 1 row(s)
   ```

1. Создайте внешнюю таблицу (external table) для данных примера в формате Parquet. Таблица будет содержать список перелетов между городами США в 2018-м году. Выполните следующий запрос с помощью Hive CLI:

    ```sql
    CREATE EXTERNAL TABLE flights (Year bigint, Month bigint, FlightDate string, Flight_Number_Reporting_Airline bigint, OriginAirportID bigint, DestAirportID bigint) STORED AS PARQUET LOCATION 's3a://yc-mdb-examples/dataproc/example01/set01';
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

1. Пример результата такого запроса:

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
