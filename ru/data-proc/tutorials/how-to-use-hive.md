# Запуск заданий Apache Hive 

[Hive](https://hive.apache.org/) — инструмент доступа к хранилищам данных в экосистеме Hadoop. Позволяет работать с данными в разных форматах и СУБД, используя SQL-подобный язык запросов. Преимущественно используется для работы с данными в HDFS, HBase, S3-совместимых хранилищах и реляционных СУБД.

Вы можете запускать задания Hive как с помощью [CLI {{ yandex-cloud }}](#run-hive-job-cli), так и непосредственно на сервере с помощью [Hive CLI](#run-job-hive-shell).

## Запуск задания с помощью CLI {{ yandex-cloud }} {#run-hive-job-cli}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [cli-job-intro](../../_includes/data-proc/cli-job-intro.md) %}

Результат расчета сохраняется в бакет {{objstorage-full-name}} вместе с сервисным выводом.

SQL-запрос для Hive можно передать двумя способами:

*  В команде на запуск задачи:

    ```bash
    {{ yc-dp }} job create-hive --cluster-id <ID кластера> --name <имя задачи> --query-list "SELECT Month, COUNT(*) FROM flights GROUP BY Month;"
    ```

* В объекте {{objstorage-name}}, который доступен на чтение сервисному аккаунту кластера {{dataproc-name}}:

    ```bash
    {{ yc-dp }} job create-hive --cluster-id <ID кластера> --name <имя задачи> --query-file-uri "s3a://<ваш бакет>/hive-query.sql"
    ```

Результат исполнения запросов, а также дополнительную диагностическую информацию можно найти в бакете {{objstorage-name}}, который был указан при создании кластера: `s3://<ваш бакет>/dataproc/clusters/<ID кластера>/jobs/<ID задачи>/`.

ID задачи есть в выводе команды запуска задания YC CLI и есть в ответе API на запуск задания.


## Запуск задания с помощью Hive CLI {#run-job-hive-shell}

Чтобы запустить командную оболочку (CLI) для Apache Hive, подключитесь к хосту-мастеру по SSH и выполните команду `hive`.

После этого проверьте работоспособность Hive — выполните команду `select 1;`. Корректный результат выглядит так:

```bash
hive> select 1;
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

    ```txt
    OK
    flights
    Time taken: 0.043 seconds, Fetched: 1 row(s)
    ```

1. Запросите количество перелетов по месяцам:

    ```sql
    SELECT Month, COUNT(*) FROM flights GROUP BY Month;
    ```

1. Пример результата такого запроса:

    ```txt
    Query ID = root_20200119195338_28049b67-4de9-4568-a4c4-3bbe500b78a1
    Total jobs = 1
    Launching Job 1 out of 1
    Status: Running (Executing on YARN cluster with App id application_1579251575762_0013)

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
