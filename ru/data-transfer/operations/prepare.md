# Подготовка к трансферу

## Подготовка источника {#prepare-source}

### {{ KF }} {#prepare-source-kf}

{% list tabs %}

* Managed Service for Apache Kafka®

    [Создайте учетную запись](../../managed-kafka/operations/cluster-accounts.md#create-account) с ролью `ACCESS_ROLE_CONSUMER` на топик-источник.

* Apache Kafka®

    1. Настройте кластер-источник таким образом, чтобы к нему можно было подключиться из интернета.
    1. [Настройте права доступа](https://kafka.apache.org/documentation/#multitenancy-security) для учетной записи на нужный топик.
    1. Чтобы использовать авторизацию по логину и паролю, [настройте SASL-аутентификацию](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}

### {{ CH }} {#prepare-source-ch}

Чтобы подготовить источник к трансферу:

{% list tabs %}

* {{ mch-name }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления](https://clickhouse.tech/docs/ru/engines/table-engines/special/materializedview/) (MaterializedView).
    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md). При создании выдайте ему доступ к базе источника.

* {{ CH }}

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления](https://clickhouse.tech/docs/ru/engines/table-engines/special/materializedview/) (MaterializedView).
    1. Настройте кластер-источник таким образом, чтобы к нему можно было подключиться из интернета.
    1. Создайте пользователя. При создании выдайте ему доступ к базе источника.

{% endlist %}

### {{ MG }} {#prepare-source-mg}

{% list tabs %}

* {{ mmg-name }}

    [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) с ролью `readWrite` на базу источник.

* {{ MG }}

    1. Убедитесь, что мажорная версия {{ MG }} на приемнике не ниже `4.0`.
    1. [Измените настройки кластера](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) таким образом, чтобы к нему можно было подключиться из интернета. Для этого:

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

    1. Если кластер-источник не использует репликацию, включите ее. Для этого:

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

### {{ MY }} {#prepare-source-my}

Чтобы подготовить источник к трансферу:

{% list tabs %}

- {{ mmy-name }}
    
    {% if audience == "draft" %}
    
    1. Если в схеме данных на источнике есть представления (views), хранимые процедуры (stored procedures) или хранимые функции (stored functions), их нужно перенести вручную после завершения трансфера.

        Схема данных на приемнике воссоздается при помощи DDL-команд, прочитанных из бинарного лога источника. Команда создания представления завершится ошибкой, если в схеме данных на момент выполнения не будет нужных таблиц, колонок или других представлений. Хранимые процедуры и функции могут изменять данные во время работы трансфера, нарушая их целостность. Подробнее см. в документации {{ MY }}:

        - [Создание представлений (views)](https://dev.mysql.com/doc/refman/8.0/en/create-view.html).
        - [Создание хранимых процедур и функций](https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html).
    
    {% endif %}
    
    1. [Включите режим полного бинарного лога](../../managed-mysql/operations/update.md#change-mysql-config) на источнике с помощью параметра **Binlog row image**.

    1. (Опционально) [настройте лимит](../../managed-mysql/operations/update.md#change-mysql-config) на размер отправляемых кусков данных (chunk) с помощью параметра **Max allowed packet**.
       
    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к источнику.

        1. [Назначьте пользователю роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-источника.

        1. [Выдайте пользователю привилегии](../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` и `REPLICATION SLAVE`.
    
    1. Таблицы без первичных ключей не переносятся в режиме репликации (для типов трансфера <q>{{ dt-repl }}</q> и <q>{{ dt-copy-repl }}</q>). Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами, можно:

        - Не переносить такие таблицы, добавив их в черный список в настройках эндпоинта-источника. Данные из таблиц черного списка передаваться не будут.
    
        - Создать первичные ключи (`PRIMARY KEY`) в тех мигрируемых таблицах, где их нет.

        {% include [mysql-primary-keys](../../_includes/data-transfer/mysql-primary-keys.md) %}

        {% note info %}

        Если создание первичного ключа завершается ошибкой «`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`», [увеличьте в настройках СУБД](../../managed-mysql/operations/update.md#change-mysql-config) значение параметра [**Innodb log file size**](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

        {% endnote %}

- {{ MY }}

    1. Убедитесь, что источник использует подсистему хранения данных низкого уровня MyISAM или InnoDB. При использовании других подсистем трансфер может завершиться с ошибкой.

    {% if audience == "draft" %}
    
    1. Если в схеме данных на источнике есть представления (views), хранимые процедуры (stored procedures) или хранимые функции (stored functions), их нужно перенести вручную после завершения трансфера.

        Схема данных на приемнике воссоздается при помощи DDL-команд, прочитанных из бинарного лога источника. Команда создания представления завершится ошибкой, если в схеме данных на момент выполнения не будет нужных таблиц, колонок или других представлений. Хранимые процедуры и функции могут изменять данные во время работы трансфера, нарушая их целостность. Подробнее см. в документации {{ MY }}:

        - [Создание представлений (views)](https://dev.mysql.com/doc/refman/8.0/en/create-view.html).
        - [Создание хранимых процедур и функций](https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html).

    {% endif %}
    
    1. [Включите режим полного бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) на источнике с помощью параметра `binlog_row_image`.

    1. (Опционально) если источник репликации — кластер, который находится за балансером, включите для него GTID-режим (`GTID-MODE = ON`). Если этого не сделать, переезд мастера на другой хост кластера приведет к аварийному завершению трансфера.
    
    Если по какой-то причине включить GTID-режим невозможно, убедитесь, что шаблон имен бинарных логов содержит имя хоста.
    
    1. (Опционально) [настройте лимит](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) на размер отправляемых кусков данных (chunk) с помощью параметра `max_allowed_packet`.

    1. Создайте пользователя для подключения к источнику и выдайте ему необходимые привилегии:

        ```sql
        CREATE USER '<имя пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя базы>.* TO '<имя пользователя>'@'%';
        GRANT REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO '<имя пользователя>'@'%';
        ```

    1. Таблицы без первичных ключей не переносятся в режиме репликации (для типов трансфера <q>{{ dt-repl }}</q> и <q>{{ dt-copy-repl }}</q>). Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами, можно:

        - Не переносить такие таблицы, добавив их в черный список в настройках эндпоинта-источника. Данные из таблиц черного списка передаваться не будут.
    
        - Создать первичные ключи (`PRIMARY KEY`) в тех мигрируемых таблицах, где их нет.

        {% include [mysql-primary-keys](../../_includes/data-transfer/mysql-primary-keys.md) %}

        {% note info %}

        Если создание первичного ключа завершается ошибкой «`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`», увеличьте в настройках СУБД значение параметра [inno_db_log_file_size](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).

        {% endnote %}

{% endlist %}

### {{ PG }} {#prepare-source-pg}

Чтобы подготовить источник к трансферу:

{% list tabs %}

- {{ mpg-name }}
    
    1. Настройте пользователя с нужными правами. После старта трансфер подключится к источнику от имени этого пользователя:
       
        1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser).

        1. Для типов трансфера <q>{{ dt-repl }}</q> и <q>{{ dt-copy-repl }}</q> [назначьте роль](../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` этому пользователю.

        1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect.md), которую нужно мигрировать, от имени владельца базы и [настройте привилегии](../../managed-postgresql/operations/grant.md#grant-privilege):

            * `SELECT` над всеми таблицами базы данных, которые переносит трансфер;
            * `SELECT` над всеми последовательностями базы данных, которые переносит трансфер;
            * `USAGE` на схемы этих таблиц и последовательностей.

    1. (Опционально) если источник репликации — кластер, [включите](../../managed-postgresql/operations/cluster-extensions.md) для него расширение pg_tm_aux. Это позволит продолжить репликацию даже после смены хоста-мастера.
    
    1. Таблицы без первичных ключей или идентификаторов реплик не переносятся в режиме репликации (для типов трансфера <q>{{ dt-repl }}</q> и <q>{{ dt-copy-repl }}</q>). Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами, можно:

        - Не переносить такие таблицы, добавив их в черный список в настройках эндпоинта-источника. Данные из таблиц черного списка передаваться не будут.
        - Добавить идентификатор реплики на таблицах без `primary key`:
            - Для таблиц с индексом установите `REPLICA IDENTITY` по `unique key`:

                ```sql
                ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
                ```

            - Для таблиц без индекса измените `REPLICA IDENTITY`:

                ```sql
                ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
                ```

- {{ PG }}

    1. Создайте пользователя. После старта трансфер подключится к источнику от имени этого пользователя.

        1. Для типа трансфера <q>{{ dt-copy }}</q> создайте пользователя командой:

            ```sql
            CREATE ROLE <имя пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
            ```

        1. Для типов трансфера <q>{{ dt-repl }}</q> и <q>{{ dt-copy-repl }}</q> создайте пользователя с привилегией `REPLICATION` командой:

            ```sql
            CREATE ROLE <имя пользователя> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<пароль>';
            ```

    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер, и привилегию `USAGE` на схемы этих таблиц:

        ```sql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название схемы> TO <имя пользователя>;
        GRANT USAGE ON SCHEMA <название схемы> TO <имя пользователя>;
        ```
    
    1. Установите плагин [wal2json](https://github.com/eulerto/wal2json).
    
    1. (Опционально) если источник репликации — кластер, установите на его хосты плагин [pg_tm_aux](https://github.com/x4m/pg_tm_aux). Это позволит продолжить репликацию даже после смены хоста-мастера.
        
    1. Таблицы без первичных ключей или идентификаторов реплик не переносятся в режиме репликации (для типов трансфера <q>{{ dt-repl }}</q> и <q>{{ dt-copy-repl }}</q>). Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами, можно:

        - Не переносить такие таблицы, добавив их в черный список в настройках эндпоинта-источника. Данные из таблиц черного списка передаваться не будут.
        - Добавить идентификатор реплики на таблицах без `primary key`:
            - Для таблиц с индексом установите `REPLICA IDENTITY` по `unique key`:

                ```sql
                ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
                ```

            - Для таблиц без индекса измените `REPLICA IDENTITY`:

                ```sql
                ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
                ```

{% endlist %}

### {{ yds-full-name }} {#prepare-source-yds}

Чтобы подготовить источник к трансферу:

{% if audience == "external" %}
* [Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream).
{% else %}
* Создайте поток данных.
{% endif %}
* (Опционально) [Создайте функцию обработки](../../functions/operations/function/function-create.md).

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

* (Опционально) Подготовьте файл схемы данных в формате JSON.

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

## Подготовка приемника {#prepare-target}

### {{ CH }} {#prepare-target-ch}

Чтобы подготовить приемник к трансферу:

{% list tabs %}

* {{ mch-name }}

    1. [Создайте базу-приемник](../../managed-clickhouse/operations/databases.md#add-db).

        Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md#adduser). При создании выдайте ему доступ к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

* {{ CH }}

    1. Создайте базу-приемник. Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. Создайте пользователя с доступом к базе-приемнику.

        После старта трансфер подключится к приемнику от имени этого пользователя.

{% endlist %}

### {{ MG }} {#prepare-target-mg}

{% list tabs %}

* Кластер MDB

    Чтобы подготовить приемник к трансферу:

    1. [Создайте базу данных](../../managed-mongodb/operations/databases.md#add-db) с тем же именем, что и на источнике.
    1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) с ролью [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) на созданную базу.

* Пользовательская инсталляция

    Чтобы подготовить приемник к трансферу:

    1. Убедитесь, версия {{ MG }} на приемнике не ниже чем на источнике.
    1. [Измените настройки кластера](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) таким образом, чтобы к нему можно было подключиться из интернета. Для этого:

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

    1. Если кластер-приемник не использует репликацию, включите ее. Для этого:

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

### {{ MY }} {#prepare-target-my}

Чтобы подготовить приемник к трансферу:

{% list tabs %}

- {{ mmy-name }}

    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.

    1. [Установите SQL Mode](../../managed-mysql/operations/update.md#change-mysql-config), который совпадает с источником.

    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к приемнику.

        1. [Назначьте пользователю роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-приемника.

- {{ MY }}

    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.

    1. Убедитесь, что приемник использует подсистему хранения данных низкого уровня MyISAM или InnoDB.

    1. [Установите SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting), который совпадает с источником:

    1. Создайте пользователя для подключения к приемнику и выдайте ему необходимые привилегии:

        ```sql
        CREATE USER '<имя пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя базы>.* TO '<имя пользователя>'@'%';
        ```

{% endlist %}

### {{ objstorage-name }} {#prepare-target-storage}

Чтобы подготовить приемник к трансферу:

   1. [Создайте бакет](../../storage/operations/buckets/create.md) нужной вам конфигурации.
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `storage.uploader`.

### {{ PG }} {#prepare-target-pg}

Чтобы подготовить приемник к трансферу:

{% list tabs %}

- {{ mpg-name }}

    1. Убедитесь, что мажорная версия {{ PG }} на приемнике не ниже версии на источнике.

    1. Отключите на приемнике:

        - проверку целостности внешних ключей;
        - триггеры;
        - другие ограничения (constraints).

        Это необходимо для обеспечения целостности данных по внешним ключам.

        Если вы используете тип трансфера <q>{{ dt-copy-repl }}</q>, настройки можно включить обратно после завершения [стадии копирования](../concepts/transfer-lifecycle.md#copy-and-replication)

    1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser). При создании выдайте ему доступ к базе приемника.

        После старта трансфер подключится к приемнику от имени этого пользователя.

- {{ PG }}

    1. Убедитесь, что мажорная версия {{ PG }} на приемнике не ниже версии на источнике. 

    1. Отключите на приемнике:

        - проверку целостности внешних ключей;
        - триггеры;
        - другие ограничения (constraints).

        Это необходимо для обеспечения целостности данных по внешним ключам.

        Если вы используете тип трансфера <q>{{ dt-copy-repl }}</q>, настройки можно включить обратно после завершения [стадии копирования](../concepts/transfer-lifecycle.md#copy-and-replication).

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
