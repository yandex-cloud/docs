# Запуск заданий Apache Hive

[Hive](https://hive.apache.org/) — инструмент доступа к хранилищам данных в экосистеме Hadoop. Позволяет работать с данными в разных форматах и СУБД, используя SQL-подобный язык запросов. Преимущественно используется для работы с данными в HDFS, HBase, S3-совместимых хранилищах и [реляционных СУБД](../../glossary/relational-databases.md).

Вы можете запускать задания Hive как с помощью [CLI Yandex Cloud](#run-hive-job-cli), так и непосредственно на сервере с помощью [Hive CLI](#hive-shell).

{% note info %}

Вы можете просматривать логи выполнения заданий и искать в них информацию с помощью сервиса [Yandex Cloud Logging](../../logging/index.md). Подробнее в разделе [Работа с логами](../operations/logging.md).

{% endnote %}


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластеры Yandex Data Processing: использование вычислительных ресурсов с наценкой за сервис Yandex Data Processing, использование сетевых дисков, получение и хранение логов, объем исходящего трафика ([тарифы Yandex Data Processing](../../../data-proc/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).
* Бакеты Yandex Object Storage: использование хранилища и выполнение операций с данными ([тарифы Object Storage](../../../storage/pricing.md)).


## Работа с заданиями в CLI Yandex Cloud {#run-hive-job-cli}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

Запуск заданий с помощью Yandex Cloud CLI происходит посредством агента Yandex Data Processing, установленного на хосте-мастере кластера. Параметры заданий передаются агенту через [Yandex Data Processing API](../api-ref/Job/index.md).  

Исполняемый файл и его зависимости должны находиться в хранилище, к которому есть доступ у сервисного аккаунта кластера Yandex Data Processing. У самого запускаемого приложения должен быть доступ к хранилищам, в которых хранятся исходный набор данных и результаты запуска.

SQL-запрос для Hive можно передать двумя способами:

* [в команде на запуск задачи](#sql-in-cli);
* [в объекте Object Storage](#sql-from-objstorage), который доступен на чтение сервисному аккаунту кластера Yandex Data Processing.

Результат выполнения запроса сохраняется в привязанный к кластеру бакет Yandex Object Storage вместе с сервисным выводом.

### Подготовьте инфраструктуру {#infra-yc-cli}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. В Object Storage [создайте бакеты](../../storage/operations/buckets/create.md) и [настройте доступ](../../storage/operations/buckets/edit-acl.md) к ним:
   
   1. Создайте бакет для исходных данных и предоставьте сервисному аккаунту кластера разрешение `READ` для этого бакета.
   1. Создайте бакет для результатов обработки и предоставьте сервисному аккаунту кластера разрешение `READ и WRITE` для этого бакета.

1. [Создайте кластер Yandex Data Processing](../operations/cluster-create.md) со следующими настройками:

    * **Сервисы**:
        * `HDFS`;
        * `HIVE`;
        * `MAPREDUCE`;
        * `SPARK`;
        * `YARN`.
    * **Сервисный аккаунт** — выберите созданный ранее сервисный аккаунт.
    * **Имя бакета** — выберите бакет для результатов обработки.
    * **Публичный доступ** — включите опцию для доступа к хостам всех подкластеров.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

### Передача SQL-запроса в команде на запуск задачи {#sql-in-cli}

1. Создайте внешнюю таблицу (external table) для данных примера в формате Parquet. Таблица будет содержать список перелетов между городами США в 2018-м году. Выполните следующий запрос с помощью CLI Yandex Cloud:

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
    yc dataproc job create-hive \
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

### Передача SQL-запроса в объекте Object Storage {#sql-from-objstorage}

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

### Подготовьте инфраструктуру {#infra-hive-shell}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролями `dataproc.agent` и `dataproc.provisioner`.

1. [Создайте кластер Yandex Data Processing](../operations/cluster-create.md) со следующими настройками:

    * **Сервисы**:
        * `HDFS`;
        * `HIVE`;
        * `SPARK`;
        * `YARN`.
    * **Сервисный аккаунт** — выберите созданный ранее сервисный аккаунт.
    * **Публичный доступ** — включите опцию для доступа к хостам всех подкластеров.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

### Запуск задания с помощью Hive CLI {#run-job-hive-shell}

1. [Подключитесь к хосту-мастеру](../operations/connect-ssh.md) по [SSH](../../glossary/ssh-keygen.md) и выполните команду `hive`.

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


## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластеры Yandex Data Processing](../operations/cluster-delete.md).
1. [Удалите бакеты Object Storage](../../storage/operations/buckets/delete.md). Перед удалением бакетов [удалите из них все объекты](../../storage/operations/objects/delete.md).