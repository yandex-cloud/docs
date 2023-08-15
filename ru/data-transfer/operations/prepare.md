# Подготовка к трансферу

## Подготовка источника {#source}

### Источники Airbyte® {#source-airbyte}

#### Источник AWS CloudTrail {#source-aws}

Получите идентификатор ключа и секретный ключ доступа AWS, следуя [инструкции AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).

Подробнее см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/aws-cloudtrail/).

#### Источник BigQuery {#source-bigquery}

1. [Создайте учетную запись](https://cloud.google.com/iam/docs/creating-managing-service-accounts) Google Cloud.
1. [Добавьте учетную запись](https://cloud.google.com/iam/docs/granting-changing-revoking-access#granting-console) в качестве участника в проект Google Cloud с ролью `BigQuery User`.
1. [Создайте ключ учетной записи](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) Google Cloud.

Подробнее см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/bigquery).

#### Источник Microsoft SQL Server {#source-mssql}

1. Убедитесь, что ваша база данных доступна с компьютера, на котором работает Airbyte®.
1. Создайте выделенного пользователя Airbyte® с правами только на чтение и с доступом ко всем таблицам, для которых необходима репликация.

Подробнее см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/mssql).

#### Источник S3 {#source-s3}

Если вы используете частный бакет в качестве источника, предоставьте разрешения `read` и `list` учетной записи, которую будете использовать для подключения.

Подробнее см. в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/s3/).

### Источник {{ KF }} {#source-kf}

{% list tabs %}

- {{ mkf-name }}

  [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с ролью `ACCESS_ROLE_CONSUMER` на топике-источнике.

- {{ KF }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../concepts/network.md#source-external).

    1. [Настройте права доступа](https://kafka.apache.org/documentation/#multitenancy-security) пользователя к нужному топику.

    1. (Опционально) Чтобы использовать авторизацию по логину и паролю, [настройте SASL-аутентификацию](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}

### Источник {{ CH }} {#source-ch}

{% list tabs %}

* {{ mch-name }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView).
    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md) с доступом к базе источника.

* {{ CH }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView).
    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../concepts/network.md#source-external).

    1. Создайте пользователя с доступом к базе источника.

{% endlist %}

### Источник {{ GP }} {#source-gp}

{% list tabs %}


- {{ mgp-name }}

    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:

        ```pgsql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-мастерам](../../managed-greenplum/concepts/index.md) кластера.

    1. Если предполагается использовать [параллельное копирование](../concepts/sharded.md), настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-сегментам](../../managed-greenplum/concepts/index.md) кластера в режиме прямого доступа (utility mode). Для этого убедитесь, что для кластера включена настройка "Доступ из {{ data-transfer-name }}".

    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над таблицами, которые переносит трансфер, и привилегию `USAGE` на схемы, в которых находятся эти таблицы.

        Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.

        Таблицы, для которых не выданы необходимые привилегии, недоступны для {{ data-transfer-name }}. Эти таблицы обрабатываются так же, как если бы они отсутствовали.

        В этом примере привилегии выдаются на все таблицы в выбранной схеме:

        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название схемы> TO <имя пользователя>;
        GRANT USAGE ON SCHEMA <название схемы> TO <имя пользователя>;
        ```


- {{ GP }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:

        ```pgsql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-мастерам](../../managed-greenplum/concepts/index.md) кластера.

    1. Если предполагается использовать [параллельное копирование](../concepts/sharded.md), настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-сегментам](../../managed-greenplum/concepts/index.md) кластера в режиме прямого доступа (utility mode).

    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над таблицами, которые переносит трансфер, и привилегию `USAGE` на схемы, в которых находятся эти таблицы.

        Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.

        Таблицы, для которых не выданы необходимые привилегии, недоступны для {{ data-transfer-name }}. Эти таблицы обрабатываются так же, как если бы они отсутствовали.

        В этом примере привилегии выдаются на все таблицы базы данных:

        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название схемы> TO <имя пользователя>;
        GRANT USAGE ON SCHEMA <название схемы> TO <имя пользователя>;
        ```

{% endlist %}

{{ data-transfer-name }} взаимодействует с {{ GP }} по-разному в зависимости от настроек трансфера и содержимого кластера-источника. Подробная информация доступна в разделе [настройка эндпоинта-источника {{ GP }}](../operations/endpoint/source/greenplum.md).


### Источник {{ MG }} {#source-mg}

{% list tabs %}


- {{ mmg-name }}

    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ mmg-name }}. Если нагрузка на базы выше 10 000 транзакций на запись в секунду, создайте несколько эндпоинтов и трансферов. Подробнее см. в разделе [{#T}](../../data-transfer/operations/endpoint/source/mongodb.md).
    1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) с ролью `readWrite` на каждую базу в источнике, которая будет реплицироваться. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__dt_cluster_time`.


- {{ MG }}

    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ MG }}. Если нагрузка на базы выше 10 000 транзакций на запись в секунду, создайте несколько эндпоинтов и трансферов. Подробнее см. в разделе [{#T}](../../data-transfer/operations/endpoint/source/mongodb.md).

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Убедитесь, что версия {{ MG }} на приемнике не ниже `4.0`.

    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../concepts/network.md#source-external). Чтобы настроить [кластер-источник](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) для подключения из интернета:

        1. Измените в конфигурационном файле значение настройки `net.bindIp` со `127.0.0.1` на `0.0.0.0`:

            ```yaml
            # network interfaces
            net:
              port: 27017
              bindIp: 0.0.0.0
            ```

        1. Перезапустите сервис `mongod`:

            ```bash
            sudo systemctl restart mongod.service
            ```

    1. Если кластер-источник не использует репликацию, включите ее:

        1. Добавьте в конфигурационный файл `/etc/mongod.conf` настройки репликации:

            ```yaml
            replication:
              replSetName: <имя набора реплик>
            ```

        1. Перезапустите сервис `mongod`:

            ```bash
            sudo systemctl restart mongod.service
            ```

        1. Подключитесь к {{ MG }} и инициализируйте набор реплик командой:

            ```javascript
            rs.initiate({
                _id: "<имя набора реплик>",
                members: [{
                    _id: 0,
                    host: "<IP-адрес, который слушает mongod>:<порт>"
                }]
            });
            ```

    1. Создайте пользователя с ролью [`readWrite`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-readWrite) на все базы в источнике, которые будут реплицироваться:

        ```javascript
        use admin
        db.createUser({
            user: "<имя пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя базы-источника 1>",
                    role: "readWrite"
                },
                {
                    db: "<имя базы-источника 2>",
                    role: "readWrite"
                },
                ...
            ]
        });
        ```

        После старта трансфер подключится к источнику от имени этого пользователя. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__dt_cluster_time`.

        {% note info %}

        Для {{ MG }} версий 3.6 и более старых достаточно выдать созданному пользователю роль [`read`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-read) на реплицируемые базы.

        {% endnote %}

    1. При использовании {{ MG }} версий 3.4 и 3.6 для работы трансфера необходимо, чтобы пользователь обладал правами на чтение коллекции `local.oplog.rs`, а также на запись с чтением коллекции `__data_transfer.__dt_cluster_time`. Чтобы назначить пользователю роль [`clusterAdmin`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterAdmin), предоставляющую такие права, подключитесь к {{ MG }} и выполните команды:

        ```js
        use admin;
        db.grantRolesToUser("<имя пользователя>", ["clusterAdmin"]);
        ```
       
        Для выдачи более гранулярных прав можно назначить роль [`clusterMonitor`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterMonitor), необходимую для чтения коллекции `local.oplog.rs`, а также дать доступ на чтение и запись системной коллекции `__data_transfer.__dt_cluster_time`.

{% endlist %}

### Источник {{ MY }} {#source-my}

{% list tabs %}

- {{ mmy-name }}

    1. [Включите режим полного бинарного лога](../../managed-mysql/operations/update.md#change-mysql-config) на источнике, установив значение `FULL` или `NOBLOB` для [параметра **Binlog row image**](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image).

    1. (Опционально) [Настройте лимит](../../managed-mysql/operations/update.md#change-mysql-config) на размер отправляемых кусков данных (chunk) с помощью параметра **Max allowed packet**.

    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к источнику.

        1. [Выдайте пользователю привилегию](../../managed-mysql/operations/grant.md#grant-privilege) `ALL_PRIVILEGES` для базы-источника.

        1. [Выдайте пользователю административные привилегии](../../managed-mysql/concepts/settings-list#setting-administrative-privileges) `REPLICATION CLIENT` и `REPLICATION SLAVE`.

    1. {% include [primary-keys-mysql](../../_includes/data-transfer/primary-keys-mysql.md) %}

        {% note info %}

        Если создание первичного ключа завершается ошибкой <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, [увеличьте в настройках СУБД](../../managed-mysql/operations/update.md#change-mysql-config) значение [параметра `Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

        {% endnote %}

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ MY }}](./endpoint/source/mysql.md#additional-settings).

- {{ MY }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Убедитесь, что источник использует подсистему хранения данных низкого уровня MyISAM или InnoDB. При использовании других подсистем трансфер может завершиться с ошибкой.

    1. [Включите режим полного бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) на источнике, установив значение `FULL` или `NOBLOB` для параметра `binlog_row_image`.

    1. [Задайте строковый формат бинарного лога](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_format) на источнике, установив значение `ROW` для параметра `binlog_format`.

    1. Если источник репликации — кластер, который находится за балансером, включите для него GTID-режим (`GTID-MODE = ON`).

        Если по какой-то причине включить GTID-режим невозможно, убедитесь, что шаблон имен бинарных логов содержит имя хоста.

        В обоих случаях это позволит продолжить репликацию в случае смены хоста-мастера.

    1. (Опционально) [Настройте лимит](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) на размер отправляемых кусков данных (chunk) с помощью параметра `max_allowed_packet`.

    1. Создайте пользователя для подключения к источнику и выдайте ему необходимые привилегии:

        ```sql
        CREATE USER '<имя пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя базы>.* TO '<имя пользователя>'@'%';
        GRANT REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO '<имя пользователя>'@'%';
        ```

    1. {% include [Таблицы без первичных ключей](../../_includes/data-transfer/primary-keys-mysql.md) %}

        {% note info %}

        Если создание первичного ключа завершается ошибкой <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, увеличьте в настройках СУБД значение параметра [`inno_db_log_file_size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

        {% endnote %}

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }})_. Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ MY }}](./endpoint/source/mysql.md#additional-settings).

{% endlist %}

### Источник Oracle {#source-oracle}

{% note info %}

В некоторых версиях Oracle для системных объектов вместо префикса `V$` используются `V_$`. Например, `V_$DATABASE` вместо `V$DATABASE`.

Измените префиксы, если вы столкнулись с ошибкой вида `can only select from fixed tables/views` при выдаче прав на системные объекты.

{% endnote %}

{% list tabs %}

- Oracle

    * Чтобы подготовить источник к трансферу типа _{{ dt-type-copy }}_:

        1. Создайте пользователя, от имени которого трансфер подключится к источнику:

            ```sql
            CREATE USER <имя пользователя> IDENTIFIED BY <пароль>;
            GRANT CREATE SESSION TO <имя пользователя>;
            ```

        1. Выдайте права созданному пользователю:

           ```sql
           GRANT SELECT ON V$DATABASE TO <имя пользователя>;
           GRANT SELECT ON DBA_EXTENTS TO <имя пользователя>;
           GRANT SELECT ON DBA_OBJECTS TO <имя пользователя>;
           GRANT FLASHBACK ANY TABLE TO <имя пользователя>;
           ```

           При необходимости, право `FLASHBACK` можно выдать не на все таблицы (`ANY TABLE`), а только на те, которые нужно скопировать.

        1. Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно скопировать.

    * Чтобы подготовить источник к трансферу типа _{{ dt-type-repl }}_:
    
        1. Создайте пользователя, от имени которого трансфер подключится к источнику:
    
           ```sql
           CREATE USER <имя пользователя> IDENTIFIED BY <пароль>;
           ALTER USER <имя пользователя> DEFAULT tablespace USERS TEMPORARY tablespace TEMP;
           ALTER USER <имя пользователя> quote unlimited on USERS;

           GRANT 
               CREATE SESSION,
               execute_catalog_role,
               SELECT ANY TRANSACTION,
               SELECT ANY DISCTIONARY,
               CREATE PROCEDURE,
               LOGMINING 
           TO <имя пользователя>;
           ```

        1. Выдайте права созданному пользователю:

            ```sql
            GRANT SELECT ON V$DATABASE TO <имя пользователя>;
            GRANT SELECT ON V$LOG TO <имя пользователя>;
            GRANT SELECT ON V$LOGFILE TO <имя пользователя>;
            GRANT SELECT ON V$ARCHIVED_LOG TO <имя пользователя>;

            GRANT SELECT ON dba_objects TO <имя пользователя>;
            GRANT SELECT ON dba_extents TO <имя пользователя>;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO <имя пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO <имя пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO <имя пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO <имя пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO <имя пользователя>;
            ```

        1. Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно реплицировать.
        1. Включите [Minimal Supplemental Logging](https://docs.oracle.com/database/121/SUTIL/GUID-D2DDD67C-E1CC-45A6-A2A7-198E4C142FA3.htm#SUTIL1583) с первичными ключами, для этого выполните:

            ```sql
            ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
            ```

    * Если вы работаете в [CDB-среде](https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89234), выполните следующие настройки:

        1. Создайте [пользователя](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/overview-of-managing-a-multitenant-environment.html#GUID-7D303718-2D59-495F-90FB-E51A377B1AD2) `Common User`:

            ```sql
            CREATE USER C##<имя пользователя> IDENTIFIED BY <пароль> CONTAINER=all;
            ALTER USER C##<имя пользователя> DEFAULT TABLESPACE USERS temporary tablespace TEMP CONTAINER=all;
            ALTER USER C##<имя пользователя> quota unlimited on USERS CONTAINER=all;
            ALTER USER C##<имя пользователя> SET container_data = (cdb$root, <имя вашей PCB>) CONTAINER=current;

            GRANT 
                CREATE SESSION,
                execute_catalog_role,
                SELECT ANY TRANSACTION,
                SELECT ANY DICTIONALY,
                CREATE PROCEDURE,
                LOGMINING,
                SET CONTAINER
            TO C##<имя пользователя> CONTAINER=ALL;
            ```

            При необходимости, можно указать только контейнер `cdb$root` и контейнер с таблицами, которые нужно перенести.

        1. Чтобы пользователь мог переключаться на контейнер `cdb$root`, выдайте ему права `ALTER SESSION`:

            ```sql
            GRANT ALTER SESSION TO C##<имя пользователя>;
            ```

        1. Выдайте права созданному пользователю:

            ```sql
            GRANT SELECT ON V$DATABASE TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$LOG TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$LOGFILE TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$ARCHIVED_LOG TO C##<имя пользователя> CONTAINER=ALL;

            GRANT SELECT ON dba_objects TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON dba_extents TO C##<имя пользователя> CONTAINER=ALL;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO C##<имя пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO C##<имя пользователя> CONTAINER=ALL;
            ```

{% endlist %}

### Источник {{ PG }} {#source-pg}

{% note info %}

При трансфере из {{ PG }} в любой тип приемника объекты типа [large objects](https://www.postgresql.org/docs/current/largeobjects.html) не переносятся.

Большие объекты в [системе хранения TOAST](https://www.postgresql.org/docs/12/storage-toast.html) и данные с [типом bytea](https://www.postgresql.org/docs/12/datatype-binary.html) переносятся без ограничений.

{% endnote %}

{% list tabs %}

- {{ mpg-name }}

    1. Настройте пользователя, от имени которого трансфер подключится к источнику:

        1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser).

        1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ [назначьте роль](../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` этому пользователю.

        1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect.md), которую нужно мигрировать, от имени владельца базы и [настройте привилегии](../../managed-postgresql/operations/grant.md#grant-privilege):

            * `SELECT` над всеми таблицами базы данных, которые переносит трансфер;
            * `SELECT` над всеми последовательностями базы данных, которые переносит трансфер;
            * `USAGE` на схемы этих таблиц и последовательностей.
            * `ALL PRIVILEGES` (`CREATE` и `USAGE`) на задаваемую [параметром эндпоинта](./endpoint/source/postgresql.md#additional-settings) схему служебных таблиц `__consumer_keeper` и `__data_transfer_mole_finder`, если эндпоинт будет использоваться для типов трансфера _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_.

    1. Если источник репликации — кластер, [включите](../../managed-postgresql/operations/extensions/cluster-extensions.md) для него расширение `pg_tm_aux`. Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее см. в разделе [Решение проблем](../troubleshooting/index.md#master-change).

    1. {% include [Таблицы без первичных ключей](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.

    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы {{ PG }} `pg_stat_activity`:

        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```

        Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ PG }}](./endpoint/source/postgresql.md#additional-settings).

    1. Для параллельного чтения из таблицы установите ее первичный ключ в [режим serial](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

        После этого укажите количество воркеров и потоков в блоке **Среда выполнения** в [параметрах трансфера](transfer.md#create).

- {{ PG }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Создайте пользователя, от имени которого трансфер подключится к источнику:

        * Для типа трансфера _{{ dt-type-copy }}_ создайте пользователя командой:

            ```sql
            CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
            ```

        * Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ создайте пользователя с привилегией `REPLICATION` командой:

            ```sql
            CREATE ROLE <имя пользователя> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<пароль>';
            ```

    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер, и привилегию `USAGE` на схемы этих таблиц:

        ```sql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название схемы> TO <имя пользователя>;
        GRANT USAGE ON SCHEMA <название схемы> TO <имя пользователя>;
        ```

    1. Выдайте созданному пользователю привилегии на задаваемую [параметром эндпоинта](./endpoint/source/postgresql.md#additional-settings) схему служебных таблиц `__consumer_keeper` и `__data_transfer_mole_finder`, если эндпоинт будет использоваться для типов трансфера _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_:

        ```sql
        GRANT ALL PRIVILEGES ON SCHEMA <имя схемы> TO <имя пользователя>;
        ```

    1. Установите и включите расширение [wal2json](https://github.com/eulerto/wal2json).

        **Установка**

        * Linux

            1. Подключите [официальный репозиторий {{ PG }}](https://www.postgresql.org/download/) для вашего дистрибутива.
            1. Обновите список доступных пакетов и установите пакет `wal2json` для используемой версии {{ PG }}.

        * Windows 10, 11

            1. Если у вас не установлена Microsoft Visual Studio, загрузите и установите ее. Для сборки расширения wal2json достаточно редакции [Community Edition](https://visualstudio.microsoft.com/ru/vs/community/). При установке выберите компоненты:

                * MSBuild,
                * MSVC v141 x86/x64 build tools,
                * C++\CLI support for v141 build tools,
                * MSVC v141 — VS 2017 C++ x64\x86 build tools,
                * MSVC v141 — VS 2017 C++ x64\x86 Spectre-mitigated libs,
                * самая свежая версия Windows SDK для используемой версии ОС,
                * прочие зависимости, которые устанавливаются автоматически для выбранных компонентов.

                Запомните номер устанавливаемой версии Windows SDK — он понадобится при указании параметров сборки wal2json.

            1. Загрузите исходный код wal2json со [страницы проекта](https://github.com/eulerto/wal2json/releases).
            1. Распакуйте архив с исходным кодом в каталог `C:\wal2json\`.
            1. Перейдите в каталог `C:\wal2json`.
            1. В рамках одной сессии PowerShell внесите изменения в файл `wal2json.vcxproj`:

                * замените строки `C:\postgres\pg103` на путь к каталогу с установленной версией {{ PG }}, например:

                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('C:\postgres\pg103', 'C:\PostgreSQL\14') | `
                     Set-Content .\wal2json.vcxproj
                    ```

                * замените параметр сборки `/MP` на `/MT`, например:

                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('/MP', '/MT') | Set-Content .\wal2json.vcxproj
                    ```

                * укажите в параметре `<WindowsTargetPlatformVersion>` номер версии установленного компонента Windows SDK:

                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('<WindowsTargetPlatformVersion>8.1', '<WindowsTargetPlatformVersion><установленная версия Windows SDK>') | `
                     Set-Content .\wal2json.vcxproj
                    ```

                1. Укажите значение переменной окружения, необходимой для сборки wal2json, например, для Visual Studio Community Edition 2022:

                    ```powershell
                    $VCTargetsPath='C:\Program Files\Microsoft Visual Studio\2022\Comminuty\MSBuild\Microsoft\VC\v150'
                    ```

                1. Запустите сборку:

                    ```powershell
                    & 'C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe' /p:Configuration=Release /p:Platform=x64
                    ```

                1. Скопируйте файл `wal2json.dll` из каталога `build/release` в каталог `lib` установленной версии {{ PG }}.

       {% endlist %}

        **Настройка**

        1. В файле `postgresql.conf` измените значение параметра `wal_level` на `logical`:

            ```conf
            wal_level = logical
            ```

        1. Перезапустите PostgreSQL.

    1. Если источник репликации — кластер, установите и включите на его хостах расширение [pg_tm_aux](https://github.com/x4m/pg_tm_aux). Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее см. в разделе [Решение проблем](../troubleshooting/index.md#master-change).

    1. {% include [Таблицы без первичных ключей](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.

    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы {{ PG }} `pg_stat_activity`:

        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```

        Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ PG }}](./endpoint/source/postgresql.md#additional-settings).

    1. Для параллельного чтения из таблицы установите ее первичный ключ в [режим serial](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

        После этого укажите количество воркеров и потоков в блоке **Среда выполнения** в [параметрах трансфера](transfer.md#create).

    1. Если на источнике настроена репликация через [Patroni](https://github.com/zalando/patroni), добавьте в его конфигурацию [блок ignore_slots](https://patroni.readthedocs.io/en/latest/SETTINGS.html?highlight=ignore_slots#dynamic-configuration-settings):

       ```yaml
       ignore_slots:
         - database: <имя базы данных, для которой настроен трансфер>
           name: <имя слота репликации>
           plugin: wal2json
           type: logical
       ```
       
       Имя базы данных и имя слота репликации должны совпадать со значениями, указанными в [настройках эндпоинта для источника](../../data-transfer/operations/endpoint/source/postgresql.md). По умолчанию `имя слота репликации` совпадает с `ID трансфера`.

       В противном случае начало этапа репликации завершится ошибкой:
      
       ```
       Warn(Termination): unable to create new pg source: Replication slotID <имя слота репликации> does not exist.
       ```

{% endlist %}

{% note info %}

Об особенностях переноса данных из {{ PG }} в {{ CH }} трансферами типа _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ см. в разделе [Асинхронная репликация данных из {{ PG }} в {{ CH }}](../tutorials/rdbms-to-clickhouse.md).

{% endnote %}


### Источник {{ yds-full-name }} {#source-yds}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `yds.editor`.
1. [Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream).
1. (Опционально) [Создайте функцию обработки](../../functions/operations/function/function-create.md).

    {% cut "Пример функции обработки" %}

    ```javascript
    const yc = require("yandex-cloud");
    const { Parser } = require("@robojones/nginx-log-parser");
    module.exports.handler = async function (event, context) {
        const schema =
            '$remote_addr - $remote_user [$time_local] "$request" $status $bytes_sent "$http_referer" "$http_user_agent"';
        const parser = new Parser(schema);
        return {
            Records: event.Records.map((record) => {
                const decodedData = new Buffer(record.kinesis.data, "base64")
                    .toString("ascii")
                    .trim();
                try {
                    const result = parser.parseLine(decodedData);
                    if (result.request == "") {
                        // empty request - drop message
                        return {
                            eventID: record.eventID,
                            invokeIdentityArn: record.invokeIdentityArn,
                            eventVersion: record.eventVersion,
                            eventName: record.eventName,
                            eventSourceARN: record.eventSourceARN,
                            result: "Dropped"
                        };
                    }
                    return {
                        // successfully parsed message
                        eventID: record.eventID,
                        invokeIdentityArn: record.invokeIdentityArn,
                        eventVersion: record.eventVersion,
                        eventName: record.eventName,
                        eventSourceARN: record.eventSourceARN,
                        kinesis: {
                            data: new Buffer(JSON.stringify(result)).toString(
                                "base64"
                            ),
                        },
                        result: "Ok"
                    };
                } catch (err) {
                    // error - fail message
                    return {
                        eventID: record.eventID,
                        invokeIdentityArn: record.invokeIdentityArn,
                        eventVersion: record.eventVersion,
                        eventName: record.eventName,
                        eventSourceARN: record.eventSourceARN,
                        result: "ProcessingFailed",
                    };
                }
            })
        };
    };
    ```

    {% endcut %}

1. (Опционально) Подготовьте файл схемы данных в формате JSON.

    Пример файла со схемой данных:

    ```json
    [
        {
            "name": "<имя поля>",
            "type": "<тип>"
        },
        ...
        {
            "name": "<имя поля>",
            "type": "<тип>"
        }
    ]
    ```

    Список допустимых типов:
	
    * `any`
    * `boolean`
    * `datetime`
    * `double`
    * `int8`
    * `int16`
    * `int32`
    * `int64`
    * `string`
    * `uint8`
    * `uint16`
    * `uint32`
    * `uint64`
    * `utf8`


## Подготовка приемника {#target}

### Приемник {{ CH }} {#target-ch}

{% list tabs %}

- {{ mch-name }}

    1. [Создайте базу-приемник](../../managed-clickhouse/operations/databases.md#add-db).

        Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md#adduser) с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

- {{ CH }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Создайте базу-приемник. Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. Создайте пользователя с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

{% endlist %}

### Приемник {{ ES }} {#target-es}

{% list tabs %}


- {{ mes-name }}

    {% include [prepare-es](../../_includes/data-transfer/prepare-es.md) %}


- {{ ES }}

    * {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    {% include [prepare-es](../../_includes/data-transfer/prepare-es.md) %}

{% endlist %}

### Приемник {{ GP }} {#target-gp}

{% list tabs %}


- {{ mgp-name }}

    1. Отключите на приемнике следующие настройки:

        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

       {% note warning %}

       Не включайте эти настройки до окончания трансфера. Это обеспечит целостность данных по внешним ключам.

       {% endnote %}

    1. Создайте пользователя:

        ```sql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя базы> TO <имя пользователя>;
        ```

       Если база не пустая, то пользователь должен быть ее владельцем (owner):

        ```sql
        ALTER DATABASE <имя базы> OWNER TO <имя пользователя>;
        ```

       После старта трансфер подключится к приемнику от имени этого пользователя.


- {{ GP }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Отключите на приемнике следующие настройки:

        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

        {% note warning %}

        Не включайте эти настройки до окончания трансфера. Это обеспечит целостность данных по внешним ключам.

        {% endnote %}

    1. Создайте пользователя:

        ```sql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя базы> TO <имя пользователя>;
        ```

        Если база не пустая, то пользователь должен быть ее владельцем (owner):

        ```sql
        ALTER DATABASE <имя базы> OWNER TO <имя пользователя>;
        ```

        После старта трансфер подключится к приемнику от имени этого пользователя.

{% endlist %}


### Приемник {{ MG }} {#target-mg}

{% list tabs %}


- {{ mmg-name }}

    1. [Создайте базу данных](../../managed-mongodb/operations/databases.md#add-db) с тем же именем, что и на источнике.
    1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) с ролью [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) на созданную базу.
    1. Чтобы шардировать переносимые коллекции в кластере-приемнике {{ mmg-full-name }}:
        1. Следуя [инструкции](../../managed-mongodb/tutorials/sharding.md), создайте и настройте в базе-приемнике пустые шардированные коллекции с теми же именами, что и на источнике.

            Сервис {{ data-transfer-name }} не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.

        1. Если шардирование происходит по ключу, отличному от `_id` (используется по умолчанию), [назначьте пользователю роль](../../managed-mongodb/operations/cluster-users.md#updateuser) `mdbShardingManager`.

        1. При [создании эндпоинта для приемника](./endpoint/target/mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.

            {% include [MongoDB endpoint DROP clean policy warning](../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

        Подробнее о шардировании см. в [документации {{ MG }}](https://docs.mongodb.com/manual/sharding/).


- {{ MG }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Убедитесь, версия {{ MG }} на приемнике не ниже чем на источнике.

    1. [Настройте кластер-приемник](https://docs.mongodb.com/manual/core/security-mongodb-configuration/), чтобы к нему можно было подключиться из интернета:

        1. Измените в конфигурационном файле значение настройки `net.bindIp` со `127.0.0.1` на `0.0.0.0`:

            ```yaml
            # network interfaces
            net:
              port: 27017
              bindIp: 0.0.0.0
            ```

        1. Перезапустите сервис `mongod`:

            ```bash
            sudo systemctl restart mongod.service
            ```

    1. Если кластер-приемник не использует репликацию, включите ее:

        1. Добавьте в конфигурационный файл `/etc/mongod.conf` настройки репликации:

            ```yaml
            replication:
              replSetName: <имя набора реплик>
            ```

        1. Перезапустите сервис `mongod`:

            ```bash
            sudo systemctl restart mongod.service
            ```

        1. Подключитесь к {{ MG }} и инициализируйте набор реплик командой:

            ```javascript
            rs.initiate({
                _id: "<имя набора реплик>",
                members: [{
                    _id: 0,
                    host: "<IP-адрес, который слушает mongod>:<порт>"
                }]
            });
            ```

    1. Подключитесь к кластеру и создайте базу-приемник с тем же именем, что и на источнике:

        ```javascript
        use <имя базы>
        ```

    1. Создайте пользователя с правами `readWrite` на базу-приемник:

        ```javascript
        use admin;
        db.createUser({
            user: "<имя пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя базы-приемника>",
                    role: "readWrite"
                }
            ]
        });
        ```

        После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Чтобы шардировать переносимые коллекции в кластере-приемнике:

        1. Подготовьте базу данных и создайте в ней пустые коллекции с теми же именами, что и на источнике.

            Сервис {{ data-transfer-name }} не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.

        1. Включите шардирование для базы-приемника:

            ```javascript
            sh.enableSharding("<имя базы-приемника>")
            ```

        1. Задайте шардирование для каждой коллекции с учетом ее пространства имен:

            ```javascript
            sh.shardCollection("<имя базы-приемника>.<имя коллекции>", { <имя поля>: <1|"hashed">, ... });
            ```

            Описание функции `shardCollection()` см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#mongodb-method-sh.shardCollection).

        1. Чтобы убедиться в том, что шардирование настроено и включено, получите список доступных шардов:

            ```javascript
            sh.status()
            ```

        1. Если для шардирования используется ключ, отличный от `_id` (значение по умолчанию), назначьте системную роль `clusterManager` пользователю, от имени которого сервис {{ data-transfer-name }} будет подключаться к кластеру-приемнику:

            ```javascript
            use admin;
            db.grantRolesToUser("<имя пользователя>", ["clusterManager"]);
            ```

        1. При [создании эндпоинта для приемника](./endpoint/target/mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.

            {% include [MongoDB endpoint DROP clean policy warning](../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

        Подробнее о шардировании см. в [документации {{ MG }}](https://docs.mongodb.com/basics/sharding/).

{% endlist %}

### Приемник {{ MY }} {#target-my}

{% list tabs %}

- {{ mmy-name }}

    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.

    1. [Установите SQL Mode](../../managed-mysql/operations/update.md#change-mysql-config), который совпадает с источником.

    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к приемнику.

        1. [Назначьте пользователю роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-приемника.

- {{ MY }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.

    1. Убедитесь, что приемник использует подсистему хранения данных низкого уровня MyISAM или InnoDB.

    1. [Установите SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting), который совпадает с источником.

    1. Создайте пользователя для подключения к приемнику и выдайте ему необходимые привилегии:

        ```sql
        CREATE USER '<имя пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя базы>.* TO '<имя пользователя>'@'%';
        ```

{% endlist %}

### Приемник {{ objstorage-full-name }} {#target-storage}


   1. [Создайте бакет](../../storage/operations/buckets/create.md) нужной вам конфигурации.
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `storage.uploader`.


### Приемник {{ OS }} {#target-os}

{% list tabs %}


- {{ mos-name }}

    {% include [prepare-os](../../_includes/data-transfer/prepare-os.md) %}


- {{ OS }}

    * {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    {% include [prepare-os](../../_includes/data-transfer/prepare-os.md) %}

{% endlist %}

### Приемник {{ PG }} {#target-pg}

{% list tabs %}

- {{ mpg-name }}

    1. Убедитесь, что мажорная версия {{ PG }} на приемнике не ниже версии на источнике.

    1. Отключите на приемнике следующие настройки:

        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

        {% note warning %}

        Не включайте эти настройки до окончания трансфера. Это обеспечит целостность данных по внешним ключам.

        Если вы используете тип трансфера _{{ dt-type-copy-repl }}_, настройки можно включить обратно после завершения [стадии копирования](../concepts/transfer-lifecycle.md#copy-and-replication).

        {% endnote %}

    1. [Включите те же расширения](../../managed-postgresql/operations/extensions/cluster-extensions.md) в базе приемника, что и в базе источника.

    1. Убедитесь, что на приемнике выбрана политика очистки `DROP таблиц трансфера`.

    1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) с доступом к базе приемника.

    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя базы> TO <имя пользователя>;
        ```

       Если база не пустая, то пользователь должен быть ее владельцем (owner):

        ```sql
        ALTER DATABASE <имя базы> OWNER TO <имя пользователя>;
        ```

       После старта трансфер подключится к приемнику от имени этого пользователя.
    1. Если в приемнике включена опция [сохранение границ транзакций](endpoint/target/postgresql.md#additional-settings), выдайте созданному пользователю все привилегии на создание служебной таблицы `__data_transfer_lsn` в [текущей схеме](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (обычно `public`) на приемнике:

       ```sql
       GRANT ALL PRIVILEGES ON SCHEMA <имя схемы> TO <имя пользователя>;
       ```

- {{ PG }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Убедитесь, что мажорная версия {{ PG }} на приемнике не ниже версии на источнике.

    1. Отключите на приемнике следующие настройки:

        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

        {% note warning %}

        Не включайте эти настройки до окончания трансфера. Это обеспечит целостность данных по внешним ключам.

        Если вы используете тип трансфера _{{ dt-type-copy-repl }}_, настройки можно включить обратно после завершения [стадии копирования](../concepts/transfer-lifecycle.md#copy-and-replication).

        {% endnote %}
    
    1. Включите те же расширения в базе приемника, что и в базе источника. 

    1. Убедитесь, что на приемнике выбрана политика очистки `DROP таблиц трансфера`.

    1. Создайте пользователя:

        ```sql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя базы> TO <имя пользователя>;
        ```

        Если база не пустая, то пользователь должен быть ее владельцем (owner):

        ```sql
        ALTER DATABASE <имя базы> OWNER TO <имя пользователя>;
        ```

        После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Если в приемнике включена опция [сохранение границ транзакций](endpoint/target/postgresql.md#additional-settings), выдайте созданному пользователю все привилегии на создание служебной таблицы `__data_transfer_lsn` в [текущей схеме](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (обычно `public`) на приемнике:

        ```sql
        GRANT ALL PRIVILEGES ON SCHEMA <имя схемы> TO <имя пользователя>;
        ```

{% endlist %}

Сервис не переносит материализованные представления (`MATERIALIZED VIEW`). Подробнее см. в разделе [Особенности работы сервиса с источниками и приемниками](../concepts/index.md#postgresql).


### Приемник {{ ydb-full-name }} {#target-ydb}


[Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `ydb.editor`.


{% include [airbyte-trademark](../../_includes/data-transfer/airbyte-trademark.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

