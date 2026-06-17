---
title: Создание внешней таблицы по протоколу PXF
description: Следуя данной инструкции, вы создадите внешнюю таблицу по протоколу PXF с помощью SQL-запроса.
---


# Создание внешней таблицы по протоколу PXF

{{ mgp-name }} позволяет [создавать external-таблицы](#sql-statement) для доступа к данным во внешних СУБД. В кластерах с СУБД [Apache Cloudberry™](https://cloudberry.apache.org) кроме external-таблиц также можно [создавать foreign-таблицы](#sql-statement-fdw) с использованием механизма FDW. Такие таблицы предоставляют доступ к тем же внешним СУБД, что и external-таблицы. При этом foreign-таблицы поддерживают чтение и запись в рамках одной таблицы, тогда как external-таблицы — либо чтение, либо запись.

Механизм FDW поддерживает следующие типы внешних источников данных:

* `s3_pxf_fdw`
* `jdbc_pxf_fdw`
* `hdfs_pxf_fdw`
* `hive_pxf_fdw`

External-таблицы создаются с помощью SQL-запроса `CREATE EXTERNAL TABLE`, а foreign-таблицы — `CREATE FOREIGN TABLE`.


## Перед началом работы {#before-you-begin}


1. В подсети кластера {{ mgp-name }} [настройте NAT-шлюз и привяжите таблицу маршрутизации](../../../vpc/operations/create-nat-gateway.md).
1. В сети кластера {{ mgp-name }} [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.
1. Создайте внешний источник данных. Инструкции по созданию зависят от типа подключения источника:

    * [S3](create-s3-source.md)
    * [JDBC](create-jdbc-source.md)
    * [HDFS](create-hdfs-source.md)
    * [Hive](create-hive-source.md)



## Создать foreign-таблицу {#sql-statement-fdw}

Синтаксис SQL-запроса на создание foreign-таблицы:

```sql
CREATE FOREIGN TABLE <имя_таблицы>
  (<имя_столбца> <тип_данных> [, ...])
  SERVER "<локальное_имя_источника>"
  OPTIONS (
    resource '<путь_к_данным_или_имя_таблицы>'
  );
```

Где:

* `<имя_таблицы>` — имя внешней таблицы в кластере {{ mgp-name }}.
* `<имя_столбца>` — имя столбца.
* `<тип_данных>` — тип данных столбца. Должен совпадать с типом соответствующего столбца во внешней СУБД.
* `<локальное_имя_источника>` — локальное имя внешнего источника данных.
* `<путь_к_данным_или_имя_таблицы>` — путь к данным или имя таблицы на внешнем источнике.


### Примеры создания foreign-таблиц {#fdw-examples}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

  1. [Создайте кластер {{ mch-full-name }}](../../../managed-clickhouse/operations/cluster-create.md) с именем пользователя `chuser`.

  
  1. В группу безопасности кластера {{ mch-name }} [добавьте правила](../../../vpc/operations/security-group-add-rule.md), разрешающие весь входящий и исходящий трафик.
    
    
  1. Создайте таблицу в {{ CH }} и заполните ее данными:
      
      1. [Подключитесь к БД {{ CH }}](../../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью утилиты `clickhouse-client`.
  
      1. Создайте таблицу `test`:

          ```sql
          CREATE TABLE test (
            a INT,
            b INT
          ) ENGINE = Memory;
          ```

      1. Добавьте данные:

          ```sql
          INSERT INTO test (a, b)
          VALUES (1, 11), (2, 22);
          ```

  1. Получите доступ к внешним данным в {{ mgp-name }}:
  
      1. [Подключитесь к БД](../connect/index.md) в сервисе {{ mgp-name }}.

      1. Создайте внешний источник данных:
          
          
          ```sql
          CREATE SERVER "chserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              jdbc_driver 'com.clickhouse.jdbc.ClickHouseDriver',
              db_url 'jdbc:clickhouse:http://c-<идентификатор_кластера>.rw.{{ dns-zone }}:8123/<имя_БД>',
              user 'chuser',
              pass '<пароль>'
            );
          ```

          Где `db_url` — [особый FQDN](../../../managed-clickhouse/operations/connect/fqdn.md#auto), который всегда указывает на доступный хост кластера {{ mch-name }}.

          Идентификатор кластера можно [получить со списком кластеров](../../../managed-clickhouse/operations/cluster-list.md#list-clusters) в каталоге.

          Если для хостов {{ CH }} включен публичный доступ, при создании внешней таблицы необходимо использовать шифрованное соединение. Для этого укажите в запросе параметры SSL, используйте протокол `https` и порт `{{ port-mch-http }}`:

          ```sql
          CREATE SERVER "chserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              ssl 'true',
              sslmode 'strict',
              sslrootcert '/etc/greenplum/ssl/allCAs.pem',
              jdbc_driver 'com.clickhouse.jdbc.ClickHouseDriver',
              db_url 'jdbc:clickhouse:https://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mch-http }}/<имя_БД>',
              user 'chuser',
              pass '<пароль>'
            );
          ```

      1. Создайте сопоставление локального пользователя с пользователем на внешнем источнике:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "chserver";
          ```

      1. Создайте внешнюю таблицу `fdw_ch`, которая будет ссылаться на таблицу `test` в кластере {{ CH }}:

          ```sql
          CREATE FOREIGN TABLE fdw_ch (
            a INT,
            b INT
          )
          SERVER "chserver"
          OPTIONS (
            resource 'test'
          );
         ```

      1. Получите данные из внешней таблицы:

          ```sql
          SELECT * FROM fdw_ch;
          ```
      
      1. Добавьте данные во внешнюю таблицу:
          
          ```sql
          INSERT INTO fdw_ch (a, b)
          VALUES (3, 33);
          ```

- {{ MY }} {#mysql}

  
  1. [Создайте кластер {{ mmy-full-name }}](../../../managed-mysql/operations/cluster-create.md) с публичным доступом к хостам и именем пользователя `mysqluser`.

  1. В группу безопасности кластера {{ mmy-name }} [добавьте правила](../../../vpc/operations/security-group-add-rule.md), разрешающие весь входящий и исходящий трафик.

    
  1. Создайте таблицу в {{ MY }} и заполните ее данными:
      
      1. [Подключитесь к БД {{ MY }}](../../../managed-mysql/operations/connect/index.md#connection-string) с помощью утилиты `mysql`.
  
      1. Создайте таблицу `test`:

          ```sql
          CREATE TABLE test (
            a INT,
            b INT
          );
          ```

      1. Добавьте данные:

          ```sql
          INSERT INTO test (a, b)
          VALUES (1, 11), (2, 22);
          ```

  1. Получите доступ к внешним данным в {{ mgp-name }}:
  
      1. [Подключитесь к БД](../connect/index.md) в сервисе {{ mgp-name }}.

      1. Создайте внешний источник данных:
          
          ```sql
          CREATE SERVER "myserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              jdbc_driver 'com.mysql.jdbc.Driver',
              db_url 'jdbc:mysql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mmy }}/<имя_БД>',
              user 'mysqluser',
              pass '<пароль>'
            );
          ```

          Где `db_url` — [особый FQDN](../../../managed-mysql/operations/connect/fqdn.md#fqdn-master), который всегда указывает на текущий хост-мастер в кластере {{ mmy-name }}.

          Идентификатор кластера можно [получить со списком кластеров](../../../managed-mysql/operations/cluster-list.md#list-clusters) в каталоге.

      1. Создайте сопоставление локального пользователя с пользователем на внешнем источнике:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "myserver";
          ```

      1. Создайте внешнюю таблицу `fdw_mysql`, которая будет ссылаться на таблицу `test` в кластере {{ MY }}:

          ```sql
          CREATE FOREIGN TABLE fdw_mysql (
            a INT,
            b INT
          )
          SERVER "myserver"
          OPTIONS (
            resource 'test'
          );
         ```

      1. Получите данные из внешней таблицы:

          ```sql
          SELECT * FROM fdw_mysql;
          ```
      
      1. Добавьте данные во внешнюю таблицу:
          
          ```sql
          INSERT INTO fdw_mysql (a, b)
          VALUES (3, 33);
          ```

- {{ PG }} {#postgresql}

  
  1. [Создайте кластер {{ mpg-full-name }}](../../../managed-postgresql/operations/cluster-create.md) с публичным доступом к хостам и именем пользователя `pguser`.
  1. В группу безопасности кластера {{ mpg-name }} [добавьте правила](../../../vpc/operations/security-group-add-rule.md), разрешающие весь входящий и исходящий трафик.

    
  1. Создайте таблицу в {{ PG }} и заполните ее данными:
      
      1. [Подключитесь к БД {{ PG }}](../../../managed-postgresql/operations/connect/clients.md) с помощью утилиты `psql`.
  
      1. Создайте таблицу `test`:

          ```sql
          CREATE TABLE public.test (
            a INT,
            b INT
          );
          ```

      1. Добавьте данные:

          ```sql
          INSERT INTO public.test (a, b)
          VALUES (1, 11), (2, 22);
          ```

  1. Получите доступ к внешним данным в {{ mgp-name }}:
  
      1. [Подключитесь к БД](../connect/index.md) в сервисе {{ mgp-name }}.

      1. Создайте внешний источник данных:
          
          ```sql
          CREATE SERVER "pgserver"
            FOREIGN DATA WRAPPER jdbc_pxf_fdw
            OPTIONS (
              jdbc_driver 'org.postgresql.Driver',
              db_url 'jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/<имя_БД>',
              user 'pguser',
              pass '<пароль>'
            );
          ```

          Где `db_url` — [особый FQDN](../../../managed-postgresql/operations/connect/fqdn.md#fqdn-master), который всегда указывает на текущий хост-мастер в кластере {{ mpg-name }}.

          Идентификатор кластера можно [получить со списком кластеров](../../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.

      1. Создайте сопоставление локального пользователя с пользователем на внешнем источнике:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "pgserver";
          ```

      1. Создайте внешнюю таблицу `fdw_pg`, которая будет ссылаться на таблицу `public.test` в кластере {{ PG }}:

          ```sql
          CREATE FOREIGN TABLE fdw_pg (
            a INT,
            b INT
          )
          SERVER "pgserver"
          OPTIONS (
            resource 'public.test'
          );
         ```

      1. Получите данные из внешней таблицы:

          ```sql
          SELECT * FROM fdw_pg;
          ```

      1. Добавьте данные во внешнюю таблицу:
          
          ```sql
          INSERT INTO fdw_pg (a, b)
          VALUES (3, 33);
          ```

- {{ objstorage-name }} {#storage}

  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) `fdw-agent` и назначьте ему роль `storage.editor` для доступа к бакету {{ objstorage-name }}.
  1. [Создайте бакет {{ objstorage-name }}](../../../storage/operations/buckets/create.md) с ограниченным доступом.
  1. [Предоставьте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` для сервисного аккаунта `fdw-agent` на созданный бакет.
  1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key).
  1. Подготовьте тестовый файл и загрузите его в бакет:
      
      1. На локальной машине создайте тестовый файл `test.csv`:

          ```csv
          1,11
          2,22
          ```

      1. [Загрузите в бакет](../../../storage/operations/objects/upload.md) файл `test.csv`.
  
  1. Получите доступ к внешним данным в {{ mgp-name }}:
  
      1. [Подключитесь к БД](../connect/index.md) в сервисе {{ mgp-name }}.

      1. Создайте внешний источник данных:
          
          ```sql
          CREATE SERVER "objserver"
            FOREIGN DATA WRAPPER s3_pxf_fdw
            OPTIONS (
              accesskey '<идентификатор_статического_ключа_доступа>',
              secretkey '<секретный_ключ_доступа>',
              endpoint '{{ s3-storage-host }}'
            );
          ```

      1. Создайте сопоставление локального пользователя с пользователем на внешнем источнике:
  
          ```sql
          CREATE USER MAPPING FOR CURRENT_USER
            SERVER "objserver";
          ```

      1. Создайте внешнюю таблицу `fdw_s3`, которая будет ссылаться на таблицу `test.csv` в бакете:

          ```sql
          CREATE FOREIGN TABLE fdw_s3 (
            a INT,
            b INT
          )
          SERVER "objserver"
          OPTIONS (
            resource '<имя_бакета>/test.csv',
            format 'csv'
          );
         ```

      1. Получите данные из внешней таблицы:

          ```sql
          SELECT * FROM fdw_s3;
          ```

{% endlist %}

{% note tip %}

Параметры подключения можно передавать как при создании источника данных, так и при создании внешней таблицы.

{% cut "Передача параметров подключения при создании внешней таблицы" %}

```sql
CREATE SERVER "<локальное_имя_источника>"
  FOREIGN DATA WRAPPER jdbc_pxf_fdw;

CREATE USER MAPPING FOR CURRENT_USER
  SERVER "<локальное_имя_источника>";

CREATE FOREIGN TABLE <имя_таблицы>
  (<имя_столбца> <тип_данных> [, ...])
  SERVER "<локальное_имя_источника>"
  OPTIONS (
    resource '<путь_к_данным_или_имя_таблицы>',
    jdbc_driver '<имя_класса_JDBC_драйвера>',
    db_url 'jdbc:<тип_СУБД>://<FQDN_кластера>:<порт>/<имя_БД>',
    user '<имя_пользователя>',
    pass '<пароль>'
  );
```

{% endcut %}

{% endnote %}


## Создать external-таблицу {#sql-statement}

Синтаксис SQL-запроса на создание external-таблицы:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <имя_таблицы>
       (<имя_столбца> <тип_данных> [, ...])
       LOCATION('pxf://<путь_к_данным_или_имя_таблицы>?PROFILE=<имя_профиля>&SERVER=<имя_источника>')
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Где:

* `<имя_таблицы>` — имя внешней таблицы, которая будет создана в кластере {{ mgp-name }}.
* `<имя_столбца>` — имя столбца.
* `<тип_данных>` — тип данных столбца. Должен совпадать с типом данных столбца таблицы во внешней СУБД.
* `<путь_к_данным_или_имя_таблицы>` — имя внешнего объекта, рассмотрите [примеры внешних таблиц](#pxf-examples) ниже.
* `PROFILE` — стандарт взаимодействия с внешней СУБД (профиль). Например, `JDBC`. Список возможных значений зависит от типа подключения:

    * [S3]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/access_objstore.html#objstore_connectors);
    * [JDBC]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/jdbc_pxf.html#queryextdata);
    * [HDFS и Hive]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/access_hdfs.html#hadoop_connectors).

* `SERVER` — имя внешнего источника данных PXF.

    Вместо `SERVER` вы можете передать параметры, которые задают конфигурацию внешнего источника данных. Они зависят от типа подключения источника. Подробнее читайте в документации [{{ GP }} PXF]({{ gp.docs.broadcom }}-platform-extension-framework/6-9/gp-pxf/intro_pxf.html#create_external_table) и примерах создания внешних таблиц.

Опция `WRITABLE` позволяет записывать данные во внешний объект. Чтобы считать данные из внешнего объекта, создайте внешнюю таблицу с опцией `READABLE`.

### Примеры создания external-таблиц {#pxf-examples}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

    1. [Создайте кластер {{ mch-full-name }}](../../../managed-clickhouse/operations/cluster-create.md) с именем пользователя `chuser`.

    
    1. В подсети кластера [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) и [создайте группу безопасности](../../../vpc/operations/security-group-create.md), разрешающую весь входящий и исходящий трафик со всех адресов.


    1. (Опционально) [Создайте внешний источник данных JDBC](create-jdbc-source.md) с параметрами:

        * **Имя** — `chserver`;
        * **Driver** — `com.clickhouse.jdbc.ClickHouseDriver`;
        * **Url** — `jdbc:clickhouse:http://c-<идентификатор_кластера>.rw.{{ dns-zone }}:8123/db1`, где:

            * `c-<идентификатор_кластера>.rw.{{ dns-zone }}` — [особый FQDN](../../../managed-clickhouse/operations/connect/fqdn.md#auto), который всегда указывает на доступный хост кластера {{ mch-name }}.
            * `8123` — порт для [подключения](../../../managed-clickhouse/operations/connect/index.md) к кластеру {{ mch-name }}.
            * `db1` — имя БД в кластере {{ mch-name }}.

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

    1. [Подключитесь к БД](../connect/index.md).
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
            LOCATION ('pxf://test?PROFILE=JDBC&JDBC_DRIVER=com.clickhouse.jdbc.ClickHouseDriver&DB_URL=jdbc:clickhouse:https://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mch-http }}/db1&USER=chuser&ssl=true&sslmode=strict&sslrootcert=/etc/greenplum/ssl/allCAs.pem')
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
        * **Url** — `jdbc:mysql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mmy }}/db1`, где:

            * `c-<идентификатор_кластера>.rw.{{ dns-zone }}` — [особый FQDN](../../../managed-mysql/operations/connect/fqdn.md#fqdn-master), который всегда указывает на текущий хост-мастер в кластере {{ mmy-name }}.
            * `{{ port-mmy }}` — порт для [подключения](../../../managed-mysql/operations/connect/index.md) к кластеру {{ mmy-name }}.
            * `db1` — имя БД в кластере {{ mmy-name }}.

        * **User** — `mysqluser`.

        Идентификатор кластера можно [получить со списком кластеров](../../../managed-mysql/operations/cluster-list.md#list-clusters) в каталоге.

        Если не создать источник данных, параметры подключения к источнику нужно передать в SQL-запросе на создание внешней таблицы.

    1. [Подключитесь к БД {{ MY }}](../../../managed-mysql/operations/connect/index.md#connection-string) с помощью утилиты `mysql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE test (a INT, b INT);
        ```

        ```sql
        INSERT INTO test VALUES (1, 11), (2, 22);
        ```

    1. [Подключитесь к БД](../connect/index.md).
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
        * **Url** — `jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/db1`, где:

            * `c-<идентификатор_кластера>.rw.{{ dns-zone }}` — [особый FQDN](../../../managed-postgresql/operations/connect/fqdn.md#fqdn-master), который всегда указывает на текущий хост-мастер в кластере {{ mpg-name }}.
            * `{{ port-mpg }}` — порт для [подключения](../../../managed-postgresql/operations/connect/index.md) к кластеру {{ mpg-name }}.
            * `db1` — имя БД в кластере {{ mpg-name }}.

        * **User** — `pguser`.

        Идентификатор кластера можно [получить со списком кластеров](../../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.

        Если не создать источник данных, параметры подключения к источнику нужно передать в SQL-запросе на создание внешней таблицы.

    1. [Подключитесь к БД {{ PG }}](../../../managed-postgresql/operations/connect/clients.md) с помощью утилиты `psql`.
    1. Создайте тестовую таблицу и наполните ее данными:

        ```sql
        CREATE TABLE public.test ("a" INT,"b" INT);
        ```

        ```sql
        INSERT INTO public.test VALUES (1, 11), (2, 22);
        ```

    1. [Подключитесь к БД](../connect/index.md).
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
    1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key).
    1. (Опционально) [Создайте внешний источник данных S3](create-s3-source.md) с параметрами:

        * **Имя** — `objserver`;
        * **Access Key** — идентификатор статического ключа доступа, созданного ранее;
        * **Secret Key** — секретный ключ, созданный ранее вместе со статическим ключом доступа;
        * **Endpoint** — `{{ s3-storage-host }}`.

        Если не создать источник данных, параметры подключения к источнику нужно передать в SQL-запросе на создание внешней таблицы.

    1. На локальной машине создайте тестовый файл `test.csv`:

        ```csv
        1,111
        2,222
        ```

    1. [Загрузите тестовый файл в бакет](../../../storage/operations/objects/upload.md).

        Файлы, которые вы загружаете в бакет, не должны начинаться с символов `.` и `_`. Такие файлы считаются скрытыми, и PXF не считывает из них данные.

    1. [Подключитесь к БД](../connect/index.md).
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

    Для создания внешней таблицы из {{ objstorage-name }} можно использовать протокол S3, передавая параметры статического ключа в файле, расположенном на веб-сервере. Подробнее читайте в [руководстве](../../tutorials/config-server-for-s3.md).

    {% endnote %}

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
