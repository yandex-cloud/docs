# Подготовка к трансферу

## Подготовка источника {#source}

### Источник {{ KF }} {#source-kf}

{% list tabs %}

* Managed Service for Apache Kafka®

    [Создайте учетную запись](../../managed-kafka/operations/cluster-accounts.md#create-account) с ролью `ACCESS_ROLE_CONSUMER` на топик-источник.

* Apache Kafka®

    1. Настройте кластер-источник, чтобы к нему можно было подключиться из интернета.
    1. [Настройте права доступа](https://kafka.apache.org/documentation/#multitenancy-security) для учетной записи на нужный топик.
    1. (Опционально) Чтобы использовать авторизацию по логину и паролю, [настройте SASL-аутентификацию](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}

### Источник {{ CH }} {#source-ch}

{% list tabs %}

* {{ mch-name }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления](https://clickhouse.tech/docs/ru/engines/table-engines/special/materializedview/) (MaterializedView).
    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md) с доступом к базе источника.

* {{ CH }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления](https://clickhouse.tech/docs/ru/engines/table-engines/special/materializedview/) (MaterializedView).
    1. Настройте кластер-источник, чтобы к нему можно было подключиться из интернета.
    1. Создайте пользователя с доступом к базе источника.

{% endlist %}

### Источник {{ MG }} {#source-mg}

{% list tabs %}

* {{ mmg-name }}

    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ mmg-name }}. Если нагрузка на базы выше 10000 транзакций на запись в секунду, создайте несколько эндпойнтов и трансферов. Подробнее см. в разделе [Подготовка источника {{ MG }}](../../data-transfer/operations/source-endpoint.md#settings-mongodb).
    1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) с ролью `readWrite` на базу источник.

* {{ MG }}

    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ MG }}. Если нагрузка на базы выше 10000 транзакций на запись в секунду, создайте несколько эндпойнтов и трансферов. Подробнее см. в разделе [Подготовка источника {{ MG }}](../../data-transfer/operations/source-endpoint.md#settings-mongodb).
    1. Убедитесь, что мажорная версия {{ MG }} на приемнике не ниже `4.0`.
    1. [Настройте кластер-источник](https://docs.mongodb.com/manual/core/security-mongodb-configuration/), чтобы к нему можно было подключиться из интернета:

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
        use <имя базы>
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

{% endlist %}

### Источник {{ MY }} {#source-my}

{% list tabs %}

- {{ mmy-name }}

    1. [Включите режим полного бинарного лога](../../managed-mysql/operations/update.md#change-mysql-config) на источнике с помощью параметра **Binlog row image**.

    1. (Опционально) [Настройте лимит](../../managed-mysql/operations/update.md#change-mysql-config) на размер отправляемых кусков данных (chunk) с помощью параметра **Max allowed packet**.

    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к источнику.

        1. [Назначьте пользователю роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-источника.

        1. [Выдайте пользователю привилегии](../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` и `REPLICATION SLAVE`.

    1. {% include [Таблицы без первичных ключей](../../_includes/data-transfer/primary-keys-mysql.md) %}

        {% note info %}

        Если создание первичного ключа завершается ошибкой <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, [увеличьте в настройках СУБД](../../managed-mysql/operations/update.md#change-mysql-config) значение [параметра `Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

        {% endnote %}

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в разделе [Параметры эндпойнта-источника {{ MY }}](source-endpoint.md#settings-mysql).

- {{ MY }}

    1. Убедитесь, что источник использует подсистему хранения данных низкого уровня MyISAM или InnoDB. При использовании других подсистем трансфер может завершиться с ошибкой.

    1. [Включите режим полного бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) на источнике с помощью параметра `binlog_row_image`.

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

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}). Подробнее см. в разделе [Параметры эндпойнта для источника {{ MY }}](source-endpoint.md#settings-mysql).

{% endlist %}

### Источник {{ PG }} {#source-pg}

{% list tabs %}

* {{ mpg-name }}

    1. Настройте пользователя, от имени которого трансфер подключится к источнику:

        1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser).

        1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ [назначьте роль](../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` этому пользователю.

        1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect.md), которую нужно мигрировать, от имени владельца базы и [настройте привилегии](../../managed-postgresql/operations/grant.md#grant-privilege):

            * `SELECT` над всеми таблицами базы данных, которые переносит трансфер;
            * `SELECT` над всеми последовательностями базы данных, которые переносит трансфер;
            * `USAGE` на схемы этих таблиц и последовательностей.

    1. Если источник репликации — кластер, [включите](../../managed-postgresql/operations/cluster-extensions.md) для него расширение `pg_tm_aux`. Это позволит продолжить репликацию в случае смены хоста-мастера.

    1. {% include [Таблицы без первичных ключей](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в разделе [Параметры эндпойнта для источника {{ PG }}](source-endpoint.md#settings-postgresql).

* {{ PG }}

    1. Настройте пользователя, от имени которого трансфер подключится к источнику:

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

    1. Установите плагин [wal2json](https://github.com/eulerto/wal2json).

    1. Если источник репликации — кластер, установите на его хосты плагин [pg_tm_aux](https://github.com/x4m/pg_tm_aux). Это позволит продолжить репликацию в случае смены хоста-мастера.

    1. {% include [Таблицы без первичных ключей](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в разделе [Параметры эндпойнта для источника {{ PG }}](source-endpoint.md#settings-postgresql).

    1. Если на источнике настроена репликация через [Patroni](https://github.com/zalando/patroni), добавьте в его конфигурацию [блок ignore_slots](https://patroni.readthedocs.io/en/latest/SETTINGS.html?highlight=ignore_slots#dynamic-configuration-settings):

       ```yaml
       ignore_slots:
         - database: <имя базы данных, для которой настроен трансфер>
           name: <имя слота репликации>
           plugin: wal2json
           type: logical
       ```
       
       Имя базы данных и имя слота репликации должны совпадать со значениями, указанными в [настройках эндпойнта для источника](../../data-transfer/operations/source-endpoint.md#settings-postgresql). По-умолчанию `имя слота репликации` совпадает с `ID трансфера`.

       В противном случае начало этапа репликации завершится ошибкой:
      
       ```
       Warn(Termination): unable to create new pg source: Replication slotID <имя слота репликации> does not exist.
       ```

{% endlist %}

### Источник {{ yds-full-name }} {#source-yds}

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

    * `int64`
    * `int32`
    * `int16`
    * `int8`
    * `uint64`
    * `uint32`
    * `uint16`
    * `uint8`
    * `double`
    * `boolean`
    * `string`
    * `utf8`
    * `any`
    * `datetime`

## Подготовка приемника {#target}

### Приемник {{ CH }} {#target-ch}

{% list tabs %}

- {{ mch-name }}

    1. [Создайте базу-приемник](../../managed-clickhouse/operations/databases.md#add-db).

        Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md#adduser) с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

- {{ CH }}

    1. Создайте базу-приемник. Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. Создайте пользователя с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

{% endlist %}

### Приемник {{ MG }} {#target-mg}

{% list tabs %}

* Кластер MDB

    1. [Создайте базу данных](../../managed-mongodb/operations/databases.md#add-db) с тем же именем, что и на источнике.
    1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) с ролью [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) на созданную базу.

* Пользовательская инсталляция

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

{% endlist %}

### Приемник {{ MY }} {#target-my}

{% list tabs %}

* {{ mmy-name }}

    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.

    1. [Установите SQL Mode](../../managed-mysql/operations/update.md#change-mysql-config), который совпадает с источником.

    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к приемнику.

        1. [Назначьте пользователю роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-приемника.

* {{ MY }}

    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.

    1. Убедитесь, что приемник использует подсистему хранения данных низкого уровня MyISAM или InnoDB.

    1. [Установите SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting), который совпадает с источником.

    1. Создайте пользователя для подключения к приемнику и выдайте ему необходимые привилегии:

        ```sql
        CREATE USER '<имя пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя базы>.* TO '<имя пользователя>'@'%';
        ```

{% endlist %}

### Приемник {{ objstorage-name }} {#target-storage}


   1. [Создайте бакет](../../storage/operations/buckets/create.md) нужной вам конфигурации.
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `storage.uploader`.

### Приемник {{ PG }} {#target-pg}

{% list tabs %}

* {{ mpg-name }}

    1. Убедитесь, что мажорная версия {{ PG }} на приемнике не ниже версии на источнике.

    1. Отключите на приемнике:

        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

        {% note warning %}

        Эти настройки не следует включать обратно до окончания трансфера для обеспечения целостности данных по внешним ключам.

        Если вы используете тип трансфера _{{ dt-type-copy-repl }}_, настройки можно включить обратно после завершения [стадии копирования](../concepts/transfer-lifecycle.md#copy-and-replication).

        {% endnote %}

    1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) с доступом к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

* {{ PG }}

    1. Убедитесь, что мажорная версия {{ PG }} на приемнике не ниже версии на источнике.

    1. Отключите на приемнике:

        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

        {% note warning %}

        Эти настройки не следует включать обратно до окончания трансфера для обеспечения целостности данных по внешним ключам.

        Если вы используете тип трансфера _{{ dt-type-copy-repl }}_, настройки можно включить обратно после завершения [стадии копирования](../concepts/transfer-lifecycle.md#copy-and-replication).

        {% endnote %}

    1. Создайте пользователя командой:

        ```sql
        CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы командой:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <название базы> TO <имя пользователя>;
        ```

        Если база не пустая, то пользователь должен быть ее владельцем (owner):

        ```sql
        ALTER DATABASE <название базы> OWNER TO <имя пользователя>;
        ```

        После старта трансфер подключится к приемнику от имени этого пользователя.

{% endlist %}

### {{ ydb-full-name }} {#prepare-source-ydb}

Чтобы принимать данные в сервисе {{ ydb-name }}, подготовка не требуется.
