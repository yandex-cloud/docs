# Создание внешней таблицы по протоколу PXF

## Перед началом работы {#before-you-begin}


1. В подсети кластера {{ mgp-name }} [настройте NAT-шлюз и привяжите таблицу маршрутизации](../../../vpc/operations/create-nat-gateway.md).
1. В той же подсети [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.
1. Создайте внешний источник данных. Инструкции по созданию зависят от типа подключения источника:

    * [S3](create-s3-source.md)
    * [JDBC](create-jdbc-source.md)
    * [HDFS](create-hdfs-source.md)
    * [Hive](create-hive-source.md)


## Создание внешней таблицы с помощью SQL-запроса {#sql-statement}

Синтаксис SQL-запроса на создание внешней таблицы:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <имя_таблицы>
       (<имя_столбца> <тип_данных> [, ...])
       LOCATION('pxf://<путь_к_данным_или_имя_таблицы>?PROFILE=<имя_профиля>&SERVER=<имя_источника>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Где:

* `<имя_таблицы>` — имя внешней таблицы, которая будет создана в кластере {{ GP }}.
* `<имя_столбца>` — имя столбца.
* `<тип_данных>` — тип данных столбца. Должен совпадать с типом данных столбца таблицы во внешней СУБД.
* `<путь_к_данным_или_имя_таблицы>` — имя внешнего объекта, см. [примеры внешних таблиц](#pxf-examples).
* `PROFILE` — стандарт взаимодействия с внешней СУБД (профиль). Например, `JDBC`. Список возможных значений зависит от типа подключения:

    * [S3]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/access_objstore.html#connectors-data-formats-and-profiles-1);
    * [JDBC]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/jdbc_pxf.html#accessing-an-external-sql-database-3);
    * [HDFS и Hive]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/access_hdfs.html#connectors-data-formats-and-profiles-3).

* `SERVER` — имя внешнего источника данных PXF.

    Вместо `SERVER` вы можете передать параметры, которые задают конфигурацию внешнего источника данных. Они зависят от типа подключения источника. Подробнее см. в документации [{{ GP }} PXF]({{ gp.docs.vmware }}-Platform-Extension-Framework/6.9/greenplum-platform-extension-framework/intro_pxf.html#creating-an-external-table-6) и примерах создания внешних таблиц.

Опция `WRITABLE` позволяет записывать данные во внешний объект. Чтобы считать данные из внешнего объекта, создайте внешнюю таблицу с опцией `READABLE`.

## Примеры создания внешних таблиц {#pxf-examples}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

    1. [Создайте кластер {{ mch-full-name }}](../../../managed-clickhouse/operations/cluster-create.md) с именем пользователя `chuser`.

    
    1. В подсети кластера [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.


    1. (Опционально) [Создайте внешний источник данных JDBC](create-jdbc-source.md) с параметрами:

        * **Имя** — `chserver`;
        * **Driver** — `com.clickhouse.jdbc.ClickHouseDriver`;
        * **Url** — `jdbc:clickhouse:http://c-<идентификатор_кластера>.rw.{{ dns-zone }}:8123/db1`;
        * **User** — `chuser`.

        Идентификатор кластера можно [получить со списком кластеров](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) в каталоге.

        Если не создать источник данных, параметры подключения к источнику нужно передать в SQL-запросе на создание внешней таблицы.

    1. [Подключитесь к БД {{ CH }}](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью утилиты `clickhouse-client`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE test (id int) ENGINE = Memory;
        ```

        ```sql
        INSERT INTO test VALUES (1);
        ```

    1. [Подключитесь к БД {{ GP }}](../connect.md).
    1. Создайте внешнюю таблицу `pxf_ch`, которая будет ссылаться на таблицу `test` в кластере {{ CH }}. SQL-запрос зависит от того, был ли создан ранее внешний источник данных:

        * С источником данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&SERVER=chserver')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * Без источника данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:http://c-<идентификатор_кластера>.rw.{{ dns-zone }}:8123/db1&USER=chuser')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        Если для хостов {{ CH }} включен публичный доступ, при создании внешней таблицы необходимо использовать шифрованное соединение. Для этого укажите в запросе параметры SSL:

        * С источником данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&SERVER=chserver&ssl=true&sslmode=strict&sslrootcert=/etc/greenplum/ssl/allCAs.pem')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * Без источника данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_ch(id int)
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:https://c-<идентификатор_кластера>.rw.mdb.yandexcloud.net:{{ port-mch-http }}/db1&USER=chuser&ssl=true&sslmode=strict&sslrootcert=/etc/greenplum/ssl/allCAs.pem')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_ch;
        ```

        Результат:

        ```text
        test_pxf=> SELECT * FROM pxf_ch;
         id
        ----
          1
        (1 row)
        ```

- {{ MY }} {#mysql}

    1. [Создайте кластер {{ mmy-full-name }}](../../../managed-mysql/operations/cluster-create.md) с настройками:

        * Имя пользователя — `mysqluser`.
        * В настройках хостов выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

    
    1. В подсети кластера [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.


    1. (Опционально) [Создайте внешний источник данных JDBC](create-jdbc-source.md) с параметрами:

        * **Имя** — `mysqlserver`;
        * **Driver** — `com.mysql.jdbc.Driver`;
        * **Url** — `jdbc:mysql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mmy }}/db1`;
        * **User** — `mysqluser`.

        Идентификатор кластера можно [получить со списком кластеров](../../../managed-mysql/operations/cluster-list.md#list-clusters) в каталоге.

        Если не создать источник данных, параметры подключения к источнику нужно передать в SQL-запросе на создание внешней таблицы.

    1. [Подключитесь к БД {{ MY }}](../../../managed-mysql/operations/connect.md#connection-string) с помощью утилиты `mysql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE test (a INT, b INT);
        ```

        ```sql
        INSERT INTO test VALUES (1, '11'), (2, '22');
        ```

    1. [Подключитесь к БД {{ GP }}](../connect.md).
    1. Создайте внешнюю таблицу `pxf_mysql`, которая будет ссылаться на таблицу `test` в кластере {{ MY }}. SQL-запрос зависит от того, был ли создан ранее внешний источник данных:

        * С источником данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
            LOCATION ('pxf://test?PROFILE=JDBC&SERVER=mysqlserver')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * Без источника данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_mysql(a int, b int)
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.mysql.jdbc.Driver&DB_URL=jdbc:mysql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mmy }}/db1&USER=mysqluser')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_mysql;
        ```

        Результат:

        ```text
        test_pxf=> SELECT * FROM pxf_mysql;
        a | b
        --+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ PG }} {#postgresql}

    1. [Создайте кластер {{ mpg-full-name }}](../../../managed-postgresql/operations/cluster-create.md) с настройками:

        * Имя пользователя — `pguser`;
        * В настройках хостов выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

    
    1. В подсети кластера [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.


    1. (Опционально) [Создайте внешний источник данных JDBC](create-jdbc-source.md) с параметрами:

        * **Имя** — `pgserver`;
        * **Driver** — `org.postgresql.Driver`;
        * **Url** — `jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/db1`;
        * **User** — `pguser`.

        Идентификатор кластера можно [получить со списком кластеров](../../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.

        Если не создать источник данных, параметры подключения к источнику нужно передать в SQL-запросе на создание внешней таблицы.

    1. [Подключитесь к БД {{ PG }}](../../../managed-postgresql/operations/connect.md#bash) с помощью утилиты `psql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE public.test ("a" INT,"b" INT);
        ```

        ```sql
        INSERT INTO public.test VALUES (1, '11'), (2, '22');
        ```

    1. [Подключитесь к БД {{ GP }}](../connect.md).
    1. Создайте внешнюю таблицу `pxf_pg`, которая будет ссылаться на таблицу `public.test` в кластере {{ PG }}. SQL-запрос зависит от того, был ли создан ранее внешний источник данных:

        * С источником данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
            LOCATION ('pxf://public.test?PROFILE=JDBC&SERVER=pgserver')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

        * Без источника данных:

            ```sql
            CREATE READABLE EXTERNAL TABLE pxf_pg(a int, b int)
            LOCATION ('pxf://public.test?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/db1&USER=pguser')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
            ```

    1. Получите данные из внешней таблицы:

        ```sql
        SELECT * FROM pxf_pg;
        ```

        Результат:

        ```text
        test_pxf=> SELECT * FROM pxf_pg;
        a | b
        --+----
        1 | 11
        2 | 22
        (2 rows)
        ```

- {{ objstorage-name }} {#storage}

    
    1. В подсети кластера [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.


    1. [Создайте бакет {{ objstorage-name }}](../../../storage/operations/buckets/create.md) с ограниченным доступом.
    1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md).
    1. (Опционально) [Создайте внешний источник данных S3](create-s3-source.md) с параметрами:

        * **Имя** — `objserver`;
        * **Access Key** — идентификатор статического ключа доступа, созданного ранее;
        * **Secret Key** — секретыный ключ, созданный ранее вместе со статическим ключом доступа;
        * **Endpoint** — `{{ s3-storage-host }}`.

        Если не создать источник данных, параметры подключения к источнику нужно передать в SQL-запросе на создание внешней таблицы.

    1. На локальной машине создайте тестовый файл `test.csv`:

        ```csv
        1,111
        2,222
        ```

    1. [Загрузите тестовый файл в бакет](../../../storage/operations/objects/upload.md).
    1. [Подключитесь к БД {{ GP }}](../connect.md).
    1. Чтобы считать данные из бакета {{ objstorage-name }}:

        1. Создайте внешнюю таблицу `pxf_s3_read`, которая будет ссылаться на бакет. SQL-запрос зависит от того, был ли создан ранее внешний источник данных:

            * С источником данных:

                ```sql
                CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
                LOCATION ('pxf://<имя_бакета>/test.csv?PROFILE=s3:text&SERVER=objserver')
                FORMAT 'CSV';
                ```

            * Без источника данных:

                ```sql
                CREATE READABLE EXTERNAL TABLE pxf_s3_read(a int, b int)
                LOCATION ('pxf://<имя_бакета>/test.csv?PROFILE=s3:text&accesskey=<идентификатор_ключа>&secretkey=<секретный_ключ>&endpoint={{ s3-storage-host }}')
                FORMAT 'CSV';
                ```

        1. Получите данные из внешней таблицы:

            ```sql
            SELECT * FROM pxf_s3_read;
            ```

            Результат:

            ```text
            test_pxf=> SELECT * FROM pxf_s3_read;
            a | b
            ---+----
            1 | 111
            2 | 222
            (2 rows)
            ```

    1. Чтобы записать данные в бакет {{ objstorage-name }}:

        1. Создайте внешнюю таблицу `pxf_s3_write` с опцией `WRITABLE`. Имя файла при создании таблицы указывать не нужно:

            * С источником данных:

                ```sql
                CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
                LOCATION ('pxf://<имя_бакета>/?PROFILE=s3:text&SERVER=objserver')
                FORMAT 'CSV';
                ```

            * Без источника данных:

                ```sql
                CREATE WRITABLE EXTERNAL TABLE pxf_s3_write(a int, b int)
                LOCATION ('pxf://<имя_бакета>/?PROFILE=s3:text&accesskey=<идентификатор_ключа>&secretkey=<секретный_ключ>&endpoint={{ s3-storage-host }}')
                FORMAT 'CSV';
                ```

        1. Добавьте данные в таблицу:

            ```sql
            INSERT INTO pxf_s3_write VALUES (3,333);
            ```

            ```text
            INSERT 0 1
            ```

        1. Убедитесь, что в бакете [создан новый объект](../../../storage/operations/objects/info.md).

    {% note info %}

    Для создания внешней таблицы из {{ objstorage-name }} можно использовать протокол S3, передавая параметры статического ключа в файле, расположенном на веб-сервере. Подробнее см. в [руководстве](../../tutorials/config-server-for-s3.md).

    {% endnote %}

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
