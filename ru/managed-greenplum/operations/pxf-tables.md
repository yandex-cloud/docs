# Использование внешних таблиц

[{{ GP }} Platform Extension Framework (PXF)](https://docs.greenplum.org/6-4/pxf/overview_pxf.html) — программная платформа, которая позволяет получить доступ к данным в источниках, внешних по отношению к кластеру {{ mgp-name }}. Работа с внешними данными ведется с помощью _PXF-таблиц_ — специальных объектов в базе данных {{ GP }}, которые ссылаются на таблицы или бакеты внешних источников.

С помощью {{ GP }} PXF вы можете:

* выполнять запросы к внешним источникам данных;
* загружать наборы данных из внешних источников в БД {{ GP }};
* объединять локальные и внешние таблицы в запросах;
* записывать данные во внешние таблицы.

Доступно подключение таблиц следующих внешних источников:

* Apache Hive;
* {{ CH }};
* HBase;
* HDFS;
* {{ MY }};
* Oracle;
* {{ PG }};
* {{ MS }};
* Бакеты {{ objstorage-full-name }}.

## Создание БД с поддержкой внешних таблиц {#create-pxf-db}

Для работы с внешними таблицами нужно установить в базу данных плагин PXF. База данных `postgres`, доступная после создания кластера {{ GP }}, не содержит этого плагина. Чтобы получить поддержку внешних таблиц, создайте новую базу данных из шаблона `template1`, в котором плагин PXF уже установлен.

Чтобы создать базу данных {{ GP }} с поддержкой внешних таблиц:

1. [Создайте кластер {{ GP }}](../quickstart.md#cluster-create) нужной вам конфигурации. При создании кластера выберите опцию **Публичный доступ**.
1. [Подключитесь к кластеру](../quickstart.md#connect).
1. Создайте базу данных с поддержкой PXF:

    ```sql
    CREATE DATABASE test_pxf TEMPLATE template1;
    ```

1. Проверьте подключение к созданной базе данных:

    ```sql
    \c test_pxf
    ```

    ```text
    You are now connected to database "test_pxf" as user "<имя пользователя>".
    ```

## Создание внешних таблиц {#pxf-tables-creation}

{% note info %}

PXF-таблицы можно создавать только в [базе данных с поддержкой плагина PXF](#create-pxf-db).

{% endnote %}

Синтаксис SQL-запроса для создания PXF-таблицы:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <имя таблицы>
       ( <имя столбца> <тип данных> [, ...])
       LOCATION('pxf://<путь к данным или имя таблицы>?PROFILE=<имя профиля>&JDBC_DRIVER=<имя JDBC-драйвера>&DB_URL=<строка подключения>&USER=<имя пользователя>&PASS=<пароль пользователя>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Где:

* `имя таблицы` — имя PXF-таблицы, которая будет создана в кластере {{ GP }}.
* `имя столбца` — имя столбца PXF-таблицы.
* `тип данных` — тип данных столбца PXF-таблицы. Должен совпадать с типом данных во внешней таблице.
* `путь к данным или имя таблицы` — имя внешнего объекта, см. [примеры внешних таблиц](#examples).

При необходимости вы можете указать дополнительные параметры:

* `имя профиля` — стандарт взаимодействия с внешней СУБД, например `JDBC`.
* `имя JDBC-драйвера` — JDBC-драйвер, который будет использоваться для подключения к внешней СУБД.
* `строка подключения` — URL для подключения к внешней СУБД.
* `имя пользователя` — имя пользователя для подключения к внешней СУБД.
* `пароль пользователя`— пароль пользователя для подключения к внешней СУБД.

Опция `READABLE` позволяет считывать данные из внешнего объекта, но не записывать их. Чтобы записать данные во внешний объект, создайте PXF-таблицу с опцией `WRITABLE`.

В этом SQL-запросе приведены не все доступные параметры. Подробнее см. в [документации {{ GP }}](https://docs.greenplum.org/6-4/pxf/intro_pxf.html) и [примерах создания внешних таблиц](#examples).

## Примеры создания внешних таблиц {#examples}

{% list tabs %}

- {{ CH }}

    1. [Создайте кластер {{ mch-full-name }}](../../managed-clickhouse/operations/cluster-create.md) с настройками:

        * Имя пользователя — `chuser`;
        * Пароль — `chpassword`;
        * Убедитесь, что опция **Публичный доступ** в настройках хостов отключена.

    1. [Подключитесь к БД {{ CH }}](../../managed-clickhouse/operations/connect#connection-string) с помощью утилиты `clickhouse-client`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE test (id int) ENGINE = Memory;
        ```

        ```sql
        INSERT INTO test VALUES (1);
        ```

    1. [Подключитесь к БД {{ GP }}](#create-pxf-db), в которой настроена поддержка внешних таблиц.
    1. Создайте PXF-таблицу `pxf_ch`, которая будет ссылаться на внешнюю таблицу `test` в кластере {{ CH }}:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
        LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=ru.yandex.clickhouse.ClickHouseDriver&DB_URL=jdbc:clickhouse://c-<идентификатор кластера>.rw.mdb.yandexcloud.net:8123/db1&USER=chuser&PASS=chpassword') FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-clickhouse/operations/cluster-list.md#list-clusters).

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_ch;
        ```

        Результат выполнения команды:

        ```text
        test_pxf=> SELECT * FROM pxf_ch;
         id
        ----
          1
        (1 row)
        ```

- {{ MY }}

    1. [Создайте кластер {{ mmy-full-name }}](../../managed-mysql/operations/cluster-create.md) с настройками:

        * Имя пользователя — `mysqluser`;
        * Пароль — `mysqlpassword`;
        * В настройках хостов выберите опцию **Публичный доступ**.

    1. [Подключитесь к БД {{ MY }}](../../managed-mysql/operations/connect#connection-string) с помощью утилиты `mysql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE test (a  INT, b INT);
        ```

        ```sql
        INSERT INTO test VALUES (1, '11'), (2, '22');
        ```

    1. [Подключитесь к БД {{ GP }}](#create-pxf-db), в которой настроена поддержка внешних таблиц.
    1. Создайте PXF-таблицу `pxf_mysql`, которая будет ссылаться на внешнюю таблицу `test` в кластере {{ MY }}:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
        LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.mysql.jdbc.Driver&DB_URL=jdbc:mysql://c-<идентификатор кластера>.rw.mdb.yandexcloud.net:3306/db1&USER=mysqluser&PASS=mysqlpassword')
        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-mysql/operations/cluster-list.md#list-clusters).

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_mysql;
        ```

        Результат выполнения команды:

        ```text
        test_pxf=> SELECT * FROM pxf_mysql;
        a | b
        ---+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ PG }}

    1. [Создайте кластер {{ mpg-full-name }}](../../managed-postgresql/operations/cluster-create.md) с настройками:

        * Имя пользователя — `pguser`;
        * Пароль — `pgpassword`;
        * В настройках хостов выберите опцию **Публичный доступ**.

    1. [Подключитесь к БД {{ PG }}](../../managed-postgresql/operations/connect.md#bash) с помощью утилиты `psql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE public.test ("a" INT,"b" INT);
        ```

        ```sql
        INSERT INTO public.test VALUES (1, '11'), (2, '22');
        ```

    1. [Подключитесь к БД {{ GP }}](#create-pxf-db), в которой настроена поддержка внешних таблиц.
    1. Создайте PXF-таблицу `pxf_pg`, которая будет ссылаться на внешнюю таблицу `public.test` в кластере {{ PG }}:

        ```sql
        CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
        LOCATION ('pxf://public.test?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://c-<идентификатор кластера>.rw.mdb.yandexcloud.net:6432/db1&USER=pguser&PASS=pgpassword')
        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-postgresql/operations/cluster-list.md#list-clusters).

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_pg;
        ```

        Результат выполнения команды:

        ```text
        test_pxf=> SELECT * FROM pxf_pg;
        a | b
        ---+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ objstorage-name }}

    1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) с именем `test-bucket`.

    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md).

    1. На локальной машине создайте тестовый файл `test.csv`:

        ```csv
        1,111
        2,222
        ```

    1. [Загрузите тестовый файл в бакет](../../storage/operations/objects/upload.md).

    1. [Подключитесь к БД {{ GP }}](#create-pxf-db), в которой настроена поддержка внешних таблиц.

    1. Чтобы считать данные из бакета {{ objstorage-name }}:

        1. Создайте PXF-таблицу `pxf_s3_read`, которая будет ссылаться на бакет `test-bucket`:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
            LOCATION ('pxf://test-bucket/test.csv?PROFILE=s3:text&accesskey=<идентификатор ключа>&secretkey=<секретный ключ>&endpoint=storage.yandexcloud.net') FORMAT 'CSV';
            ```

        1. Получите данные из внешней таблицы:

            ```sql
            SELECT * FROM pxf_s3_read;
            ```

            Результат выполнения команды:

            ```text
            test_pxf=> SELECT * FROM pxf_s3_read;
            a | b
            ---+----
            1 | 111
            2 | 222
            (2 rows)
            ```

    1. Чтобы записать данные в бакет {{ objstorage-name }}:

        1. Создайте PXF-таблицу `pxf_s3_write` с опцией `WRITABLE`. Имя файла при создании таблицы указывать не нужно:

            ```sql
            CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
            LOCATION ('pxf://test-bucket/?PROFILE=s3:text&accesskey=<идентификатор ключа>&secretkey=<секретный ключ>&endpoint=storage.yandexcloud.net') FORMAT 'CSV';
            ```

        1. Добавьте данные в таблицу:

            ```sql
            INSERT INTO pxf_s3_write VALUES (3,333);
            ```

            ```text
            INSERT 0 1
            ```

        1. Убедитесь, что в бакете [создан новый объект](../../storage/operations/objects/info.md).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
