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

    1. (опционально) Чтобы использовать авторизацию по логину и паролю, [настройте SASL-аутентификацию](https://kafka.apache.org/documentation/#security_sasl).

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

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView).

    1. Создайте пользователя с доступом к базе источника.

{% endlist %}

### Источник {{ GP }} {#source-gp}

{% list tabs %}


- {{ mgp-name }}

    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:

        ```pgsql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем хостам-мастерам и хостам-сегментам кластера.

        Доступ к хостам-сегментам осуществляется в режиме прямого доступа (utility mode) без необходимости взаимодействия с хостами-мастерами.

    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер, и привилегию `USAGE` на схемы этих таблиц.

        Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.

        Вы можете выдать нужные привилегии только ограниченному набору таблиц. В этом случае перечислите все таблицы для переноса в [дополнительных настройках](./endpoint/source/greenplum.md#additional-settings) эндпоинта-источника {{ GP }}.

        В этом примере команды привилегии выдаются на все таблицы базы данных:

        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название схемы> TO <имя пользователя>;
        GRANT USAGE ON SCHEMA <название схемы> TO <имя пользователя>;
        ```

    1. Выдайте созданному пользователю привилегии для доступа к схеме, в которой будут размещаться [служебные объекты трансфера](./endpoint/source/greenplum.md#additional-settings). В частности, необходима привилегия на создание и использование функций в этой схеме.

        Для этого выполните команду:

        ```pgsql
        GRANT USAGE ON SCHEMA <название служебной схемы> TO <имя пользователя>;
        GRANT CREATE ON SCHEMA <название служебной схемы> TO <имя пользователя>;
        GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA <название служебной схемы> TO <имя пользователя>;
        GRANT SELECT ON ALL TABLES IN SCHEMA <название служебной схемы> TO <имя пользователя>;
        ```


- {{ GP }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:

        ```pgsql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем хостам-мастерам и хостам-сегментам кластера.

       Доступ к хостам-сегментам осуществляется в режиме прямого доступа (utility mode) без необходимости взаимодействия с хостами-мастерами.

    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер, и привилегию `USAGE` на схемы этих таблиц.

       Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.

       Вы можете выдать нужные привилегии только ограниченному набору таблиц. В этом случае перечислите все таблицы для переноса в [дополнительных настройках](./endpoint/source/greenplum.md#additional-settings) эндпоинта-источника {{ GP }}.

       В этом примере команды привилегии выдаются на все таблицы базы данных:

        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название схемы> TO <имя пользователя>;
        GRANT USAGE ON SCHEMA <название схемы> TO <имя пользователя>;
        ```

    1. Выдайте созданному пользователю привилегии для доступа к схеме, в которой будут размещаться [служебные объекты трансфера](./endpoint/source/greenplum.md#additional-settings). В частности, необходима привилегия на создание и использование функций в этой схеме.

       Для этого выполните команду:

        ```pgsql
        GRANT USAGE ON SCHEMA <название служебной схемы> TO <имя пользователя>;
        GRANT CREATE ON SCHEMA <название служебной схемы> TO <имя пользователя>;
        GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA <название служебной схемы> TO <имя пользователя>;
        GRANT SELECT ON ALL TABLES IN SCHEMA <название служебной схемы> TO <имя пользователя>;
        ```

{% endlist %}

### Источник {{ MG }} {#source-mg}

{% list tabs %}


- {{ mmg-name }}

    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ mmg-name }}. Если нагрузка на базы выше 10 000 транзакций на запись в секунду, создайте несколько эндпоинтов и трансферов. Подробнее см. в разделе [{#T}](../../data-transfer/operations/endpoint/source/mongodb.md).
    1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) с ролью `readWrite` на базу источник.


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

    1. Создайте пользователя с ролью `readWrite` на базу-источник:

        ```javascript
        use admin
        db.createUser({
            user: "<имя пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя базы-источника>",
                    role: "readWrite"
                }
            ]
        });
        ```

        После старта трансфер подключится к источнику от имени этого пользователя.

    1. При использовании {{ MG }} версий 3.4 и 3.6 для работы трансфера необходимо, чтобы пользователь обладал правами на чтение коллекции `local.oplog.rs`. Чтобы назначить пользователю роль `clusterManager`, предоставляющую такие права, подключитесь к {{ MG }} и выполните команды:

        ```js
        use admin;
        db.grantRolesToUser("<имя пользователя>", ["clusterManager"]);
        ```

{% endlist %}

### Источник {{ MY }} {#source-my}

{% list tabs %}

- {{ mmy-name }}

    1. [Включите режим полного бинарного лога](../../managed-mysql/operations/update.md#change-mysql-config) на источнике с помощью параметра **Binlog row image**.

    1. (опционально) [Настройте лимит](../../managed-mysql/operations/update.md#change-mysql-config) на размер отправляемых кусков данных (chunk) с помощью параметра **Max allowed packet**.

    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к источнику.

        1. [Назначьте пользователю роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-источника.

        1. [Выдайте пользователю привилегии](../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` и `REPLICATION SLAVE`.

    1. {% include [primary-keys-mysql](../../_includes/data-transfer/primary-keys-mysql.md) %}

        {% note info %}

        Если создание первичного ключа завершается ошибкой <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, [увеличьте в настройках СУБД](../../managed-mysql/operations/update.md#change-mysql-config) значение [параметра `Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

        {% endnote %}

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ MY }}](./endpoint/source/mysql.md#additional-settings).

- {{ MY }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Убедитесь, что источник использует подсистему хранения данных низкого уровня MyISAM или InnoDB. При использовании других подсистем трансфер может завершиться с ошибкой.

    1. [Включите режим полного бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) на источнике с помощью параметра `binlog_row_image`.

    1. Если источник репликации — кластер, который находится за балансером, включите для него GTID-режим (`GTID-MODE = ON`).

        Если по какой-то причине включить GTID-режим невозможно, убедитесь, что шаблон имен бинарных логов содержит имя хоста.

        В обоих случаях это позволит продолжить репликацию в случае смены хоста-мастера.

    1. (опционально) [Настройте лимит](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) на размер отправляемых кусков данных (chunk) с помощью параметра `max_allowed_packet`.

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

{% list tabs %}

- Oracle

    1. Создайте пользователя, от имени которого трансфер подключится к источнику:

        ```sql
        CREATE USER <имя пользователя> IDENTIFIED BY <пароль>;
        GRANT CREATE SESSION TO <имя пользователя>;
        ```

    1. Чтобы подготовить источник к трансферу типа `{{ dt-type-copy }}`:

        * Выдайте права созданному пользователю:

            ```sql
            GRANT SELECT ON V$DATABASE TO <имя пользователя>;
            GRANT SELECT ON DBA_EXTENTS TO <имя пользователя>;
            GRANT SELECT ON DBA_OBJECTS TO <имя пользователя>;
            GRANT FLASHBACK ANY TABLE TO <имя пользователя>;
            ```

            Права `FLASHBACK` можно выдать не на все таблицы (`ANY TABLE`), а только на те, которые нужно скопировать.

        * Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно скопировать.

    1. Чтобы подготовить источник к трансферу типа `{{ dt-type-repl }}`:

        * Выдайте права созданному пользователю:

            ```sql
            GRANT SELECT ON V$DATABASE TO <имя пользователя>;
            GRANT SELECT ON V$LOG TO <имя пользователя>;
            GRANT SELECT ON V$LOGFILE TO <имя пользователя>;
            GRANT SELECT ON V$ARCHIVED_LOG TO <имя пользователя>;
            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO <имя пользователя>;
            ```

        * Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно реплицировать.
        * Включите [Minimal Supplemental Logging](https://docs.oracle.com/database/121/SUTIL/GUID-D2DDD67C-E1CC-45A6-A2A7-198E4C142FA3.htm#SUTIL1583) с первичными ключами, для этого выполните:

            ```sql
            ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
            ```

    1. (опционально) Если вы работаете в [CDB-среде](https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89234), выполните дополнительные настройки:

        1. Создайте [пользователя](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/overview-of-managing-a-multitenant-environment.html#GUID-7D303718-2D59-495F-90FB-E51A377B1AD2) `Common User`:

            ```sql
            CREATE USER C##<имя пользователя> IDENTIFIED BY <пароль> CONTAINER=ALL;
            GRANT CREATE SESSION TO C##<имя пользователя>;
            ```

            {% note info %}

            Имя пользователя `Common User` должно иметь префикс `С##`.

            {% endnote %}

            Можно указать только контейнер `cdb$root` и контейнер с таблицами, которые нужно перенести.

        1. Чтобы пользователь мог переключаться на контейнер `cdb$root`, выдайте ему права `ALTER SESSION`:

            ```sql
            GRANT ALTER SESSION TO C##<имя пользователя>;
            ```

        1. Выдайте доступ на чтение нужного [PDB-контейнера](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/overview-of-the-multitenant-architecture.html#GUID-49C0C90D-5A72-4131-8C3D-B07341C75CB2) пользователю:

            ```sql
            GRANT SELECT ANY TABLE TO C##<имя пользователя> CONTAINER=<имя PDB-контейнера>;
            ```

            Можно указать не все таблицы (`ANY TABLE`), а только те, которые нужно перенести.

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
            * `ALL PRIVILEGES` (`CREATE` и `USAGE`) на задаваемую [параметром эндпоинта](./endpoint/source/postgresql.md#additional-settings) схему служебных таблиц, если эндпоинт будет использоваться для типов трансфера _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_.

    1. Если источник репликации — кластер, [включите](../../managed-postgresql/operations/extensions/cluster-extensions.md) для него расширение `pg_tm_aux`. Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее см. в разделе [Решение проблем](../troubleshooting/index.md#master-change).

    1. {% include [Таблицы без первичных ключей](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ PG }}](./endpoint/source/postgresql.md#additional-settings).

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

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ PG }}](./endpoint/source/postgresql.md#additional-settings).

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

Об особенностях переноса данных из {{ PG }} в {{ CH }} трансферами типа _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ см. в разделе [Перенос данных из {{ PG }} в {{ CH }}](../tutorials/rdbms-to-clickhouse.md).

{% endnote %}

### Источник {{ yds-full-name }} {#source-yds}

1. [Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream).
1. (опционально) [Создайте функцию обработки](../../functions/operations/function/function-create.md).

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

1. (опционально) Подготовьте файл схемы данных в формате JSON.

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

        Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md#adduser) с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

- {{ CH }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Создайте базу-приемник. Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. Создайте пользователя с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

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

    1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

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

Сервис не переносит материализованные представления (`MATERIALIZED VIEW`). Подробнее см. в разделе [Особенности работы сервиса с источниками и приемниками](../concepts/index.md#postgresql).


### Приемник {{ ydb-full-name }} {#target-ydb}

Чтобы принимать данные в сервисе {{ ydb-full-name }}, подготовка не требуется.

{% include [airbyte-trademark](../../_includes/data-transfer/airbyte-trademark.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

