# Обмен данными между {{ mch-full-name }} и {{ dataproc-full-name }}

Чтобы настроить загрузку и выгрузку данных между кластерами {{ mch-full-name }} и {{ dataproc-full-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Выгрузите данные из {{ mch-full-name }}](#export-from-mch).
1. [Загрузите данные в {{ mch-full-name }}](#import-to-mch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% note info %}

Создавайте кластеры и виртуальную машину в одной облачной сети.

{% endnote %}

1. [Создайте кластер {{ mch-full-name }}](../../managed-clickhouse/operations/cluster-create.md) любой [подходящей вам конфигурации](../../managed-clickhouse/concepts/instance-types.md) со следующими настройками:
    * с базой данных `db1`;
    * с пользователем `user1`.
1. [Создайте кластер {{ dataproc-full-name }}](../../data-proc/operations/cluster-create.md) любой [подходящей вам конфигурации](../../data-proc/concepts/instance-types.md) со следующими настройками:
    * с включенной опцией **UI Proxy**;
    * c компонентами:
        * **HBASE**
        * **HDFS**
        * **HIVE**
        * **MAPREDUCE**
        * **SPARK**
        * **TEZ**
        * **YARN**
        * **ZEPPELIN**
        * **ZOOKEEPER**
1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для подключения к кластерам {{ mch-full-name }} и {{ dataproc-full-name }}.
1. [Подключитесь к виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md) и настройте подключения к кластерам:
    * [{{ mch-full-name }}](../../managed-clickhouse/operations/connect.md);
    * [{{ dataproc-full-name }}](../../data-proc/operations/connect.md).
1. (Опционально) Чтобы экспортировать данные в [бакет {{ objstorage-full-name }}](../../storage/concepts/bucket.md):
    1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).
    1. [Выдайте права на запись в него](../../storage/operations/buckets/edit-acl.md) сервисному аккаунту кластера {{ dataproc-full-name }}.
	
{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки обмена данными между {{ mch-full-name }} и {{ dataproc-full-name }} входит:
* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

{% endif %}

## Выгрузите данные из {{ mch-full-name }} {#export-from-mch}

### Подготовьте кластер {{ mch-full-name }} {#prepare-mch}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect.md) `db1` кластера {{ mch-full-name }} от имени пользователя `user1`.
1. Наполните базу тестовыми данными. В качестве примера используется простая таблица с именами и возрастом людей.

    1. Создайте таблицу:

        ```sql
        CREATE TABLE persons (
            `name` String,
            `age` UInt8) ENGINE = MergeTree ()
        ORDER BY
            `name`;
        ```

    1. Наполните таблицу данными:

        ```sql
        INSERT INTO persons VALUES
           ('Anna', 19),
           ('Michael', 65),
           ('Alvar', 28),
           ('Lilith', 50),
           ('Max', 27),
           ('Jaimey', 34),
           ('Dmitry', 42),
           ('Qiang', 19),
           ('Augustyna', 20),
           ('Maria', 28);
        ```

### Запустите выгрузку из {{ mch-full-name }} {#start-mch-export}

1. Откройте [веб-интерфейс Zeppelin](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) кластера {{ dataproc-full-name }}.
1. Нажмите ссылку **Create new note** и укажите параметры ноутбука Zeppelin:
    * **Note name** — введите произвольное имя ноутбука;
    * **Default Interpreter** — выберите `spark`.
1. Нажмите кнопку **Create**.
1. Чтобы сформировать датафрейм, создайте и запустите параграф с кодом. Чтобы запустить параграф, нажмите на кнопку **Run this paragraph** или используйте сочетание клавиш **Shift** + **Enter**. Текст параграфа зависит от наличия публичного доступа к хостам кластера {{ mch-full-name }}.

    {% list tabs %}

    - Подключение без SSL

        ```python
        %spark.pyspark
        jdbcPort = 8123
        jdbcHostname = "c-<идентификатор кластера {{ mch-full-name }}>.rw.{{ dns-zone }}"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}"
        df = spark.read.format("jdbc") \
        .option("url", jdbcUrl) \
        .option("user","user1") \
        .option("password","<пароль к базе данных {{ mch-full-name }}>") \
        .option("dbtable","persons") \
        .load()
        df.show()
        ```

    - Подключение с SSL

        ```python
        %spark.pyspark
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор кластера {{ mch-full-name }}>.rw.{{ dns-zone }}"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
        df = spark.read.format("jdbc") \
        .option("url", jdbcUrl) \
        .option("user","user1") \
        .option("password","<пароль к базе данных {{ mch-full-name }}>") \
        .option("dbtable","persons") \
        .load()
        df.show()
        ```

    {% endlist %}

    Если датафрейм сформирован успешно, ответ на запрос будет содержать таблицу с исходными данными.

1. Чтобы выгрузить информацию из датафрейма в бакет {{ objstorage-full-name }} или таблицу Hive, создайте и запустите параграф с кодом.

    {% list tabs %}

    - {{ objstorage-name }}

        ```python
        %spark.pyspark
        df.write.parquet('s3a://<имя бакета>/<директория бакета>/')
        spark.read.parquet('s3a://<имя бакета>/<директория бакета/').show()
        ```

    - Hive

        ```python
        %spark.pyspark
        df.createOrReplaceTempView("mytempTable")
        spark.sql("CREATE TABLE IF NOT EXISTS persons AS SELECT * FROM mytempTable");
        spark.sql("SELECT * FROM persons").show()
        ```

    {% endlist %}

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с исходными данными.


## Загрузите данные в {{ mch-full-name }} {#import-to-mch}

### Подготовьте исходные данные {#prepare-source-data}

Источником данных может быть директория HDFS или бакет {{ objstorage-full-name }}. В качестве исходных данных будет использоваться CSV-файл с именами и возрастом людей:

```text
name,age
Anna,19
Michael,65
Fred,28
Alsou,50
Max,27
John,34
Dmitry,42
Oleg,19
Alina,20
Maria,28
```

{% list tabs %}

- {{ objstorage-name }}

    Создайте файл `example.csv` с тестовыми данными и загрузите его в бакет {{ objstorage-full-name }}.

- Директория HDFS

    1. [Подключитесь к хосту кластера {{ dataproc-full-name }}](../../data-proc/operations/connect.md) в подкластере для хранения данных.
    1. Определите адрес сервера HDFS. Этот адрес понадобится указать при выгрузке данных в директорию HDFS.

        ```bash
        hdfs getconf -confKey fs.defaultFS
        ```

    1. Создайте файл `example.csv` с тестовыми данными.
    1. Создайте директорию HDFS для записи тестовых данных:

        ```bash
        hdfs fs -mkdir /user/testdata
        ```

    1. Скопируйте файл с тестовыми данными из локальной файловой системы в директорию HDFS:

        ```bash
        hdfs dfs -copyFromLocal example.csv /user/testdata/example.csv
        ```

{% endlist %}

### Запустите выгрузку из {{ dataproc-full-name }} {#start-dp-export}

1. Откройте [веб-интерфейс Zeppelin](../../data-proc/operations/connect-interfaces.md#ui-proxy-list) кластера {{ dataproc-full-name }}.
1. Нажмите ссылку **Create new note** и укажите параметры ноутбука Zeppelin:
    * **Note name** — введите произвольное имя ноутбука;
    * **Default Interpreter** — выберите `spark`.
1. Нажмите кнопку **Create**.
1. Чтобы сформировать датафрейм, создайте и запустите параграф с кодом.

    {% list tabs %}

    - {{ objstorage-name }}

        ```python
        %spark.pyspark
        df = spark.read.option("header", True).csv("s3a://<имя бакета>/<директория бакета>/example.csv")
        df.show()
        ```

    - Директория HDFS

        ```python
        %spark.pyspark
        df = spark.read.option("header", True).csv("hdfs://<адрес сервера HDFS>/user/testdata/example.csv")
        df.show()
        ```

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с исходными данными.

    {% endlist %}

1. Чтобы выгрузить информацию из датафрейма в базу данных {{ mch-full-name }}, создайте и запустите параграф с кодом. Текст параграфа зависит от наличия публичного доступа к хостам кластера {{ mch-full-name }}.

    {% list tabs %}

    * Подключение без SSL

        ```python
        %spark.pyspark
        jdbcPort = 8123
        jdbcHostname = "c-<идентификатор кластера {{ mch-full-name }}>.rw.{{ dns-zone }}"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}"
        df.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "example") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
        .option("user","user1") \
        .option("password","<пароль к базе данных {{ mch-full-name }}>") \
        .save()
        ```

    * Подключение с SSL

        ```python
        %spark.pyspark
        jdbcPort = 8443
        jdbcHostname = "c-<идентификатор кластера {{ mch-full-name }}>.rw.{{ dns-zone }}"
        jdbcDatabase = "db1"
        jdbcUrl = f"jdbc:clickhouse://{jdbcHostname}:{jdbcPort}/{jdbcDatabase}?ssl=true"
        df.write.format("jdbc") \
        .mode("error") \
        .option("url", jdbcUrl) \
        .option("dbtable", "example") \
        .option("createTableOptions", "ENGINE = MergeTree() ORDER BY age") \
        .option("user","user1") \
        .option("password","<пароль к базе данных {{ mch-full-name }}>") \
        .save()
        ```

    {% endlist %}

### Проверьте загрузку данных в {{ mch-full-name }} {#check-mch-export}

1. [Подключитесь к базе данных](../../managed-clickhouse/operations/connect.md) `db1` кластера {{ mch-full-name }} от имени пользователя `user1`.
1. Выполните запрос:

    ```sql
    SELECT * FROM example;
    ```

    Если выгрузка прошла успешно, ответ на запрос будет содержать таблицу с данными.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
1. Удалите кластеры:
    * [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-delete.md);
    * [{{ dataproc-full-name }}](../../data-proc/operations/cluster-delete.md).
1. Если вы создавали бакет {{ objstorage-full-name }}, [удалите его](../../storage/operations/buckets/delete.md).
