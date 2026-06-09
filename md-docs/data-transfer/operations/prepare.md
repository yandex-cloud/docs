# Подготовка к трансферу



## Подготовка источника {#source}

### Источники Airbyte® {#source-airbyte}

#### Источник AWS CloudTrail {#source-aws}

Получите идентификатор ключа и секретный ключ доступа AWS, следуя [инструкции AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).

Подробнее в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/aws-cloudtrail/).

#### Источник BigQuery {#source-bigquery}

Для подготовки источника данных BigQuery:

1. [Создайте учетную запись](https://cloud.google.com/iam/docs/creating-managing-service-accounts) Google Cloud.
1. [Добавьте учетную запись](https://cloud.google.com/iam/docs/granting-changing-revoking-access#granting-console) в качестве участника в проект Google Cloud с ролью `BigQuery User`.
1. [Создайте ключ учетной записи](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) Google Cloud.

Подробнее в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/bigquery).

#### Источник Microsoft SQL Server {#source-mssql}

Airbyte® предъявляет требования к источнику данных Microsoft SQL Server:

1. База данных доступна с компьютера, на котором работает Airbyte®.
1. Создан выделенный пользователь Airbyte® с правами только на чтение и с доступом ко всем таблицам, для которых необходима репликация.

Подробнее в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/mssql).

Airbyte® уже встроен в Data Transfer, поэтому вам не нужно создавать отдельную виртуальную машину для его развертывания и добавления пользователя. Достаточно обеспечить [сетевой доступ](../concepts/network.md) Data Transfer к базе-источнику.

#### Источник S3 {#source-s3}

Если вы используете частный бакет в качестве источника, предоставьте разрешения `read` и `list` учетной записи, которую будете использовать для подключения.

Подробнее в [документации Airbyte®](https://docs.airbyte.com/integrations/sources/s3/).


### Источник Apache Kafka® {#source-kf}

{% list tabs %}

- Managed Service for Apache Kafka®
    
    
    [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с ролью `ACCESS_ROLE_CONSUMER` на топике-источнике.


- Apache Kafka®
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. [Настройте доступ к кластеру-источнику из Yandex Cloud](../concepts/network.md#source-external).
    
    1. [Настройте права доступа](https://kafka.apache.org/42/security/authorization-and-acls/#examples) пользователя к нужному топику.
    
    1. Выдайте права `READ` консьюмер-группе, идентификатор которой совпадает с идентификатором трансфера.
    
        ```text
        bin/kafka-acls --bootstrap-server localhost:9092 \
          --command-config adminclient-configs.conf \
          --add \
          --allow-principal User:username \
          --operation Read \
          --group <идентификатор_трансфера>
        ```
    
    1. (Опционально) Чтобы использовать авторизацию по логину и паролю, [настройте SASL-аутентификацию](https://kafka.apache.org/42/security/authentication-using-sasl/).

{% endlist %}

### Источник ClickHouse® {#source-ch}

{% note info %}

Yandex Data Transfer не может переносить базы данных ClickHouse®, в названии которых есть дефис.


При переносе таблиц с движками, отличными от движков на базе `ReplicatedMergeTree` и `Distributed`, в многохостовом кластере ClickHouse® трансфер завершится с ошибкой: `the following tables have not Distributed or Replicated engines and are not yet supported`.

{% endnote %}

{% list tabs %}

* Managed Service for ClickHouse®

    
    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления](https://clickhouse.com/docs/ru/materialized-views) (MaterializedView).

       В случае многохостового кластера будут перенесены таблицы и материализованные представления только с движками на базе `ReplicatedMergeTree` либо `Distributed`. Проверьте, что данные таблицы и представления присутствуют на всех хостах кластера.

    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md) с доступом к базе источника. В настройках пользователя укажите для [параметра](../../managed-clickhouse/concepts/settings-list.md#setting-max-execution-time) **Max execution time**  значение не менее `1000000`.

* ClickHouse®

    1. Убедитесь, что переносимые таблицы используют движки семейства `MergeTree`. Будут перенесены только эти таблицы и [материализованные представления](https://clickhouse.com/docs/ru/materialized-views) (MaterializedView).

       В случае многохостового кластера будут перенесены таблицы и материализованные представления только с движками на базе `ReplicatedMergeTree` либо `Distributed`. Проверьте, что данные таблицы и представления присутствуют на всех хостах кластера.

    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).

    1. [Настройте доступ к кластеру-источнику из Yandex Cloud](../concepts/network.md#source-external).

    1. Создайте пользователя с доступом к базе источника. В настройках пользователя укажите для параметра **Max execution time**  значение не менее `1000000`.

{% endlist %}

### Источник Greenplum® {#source-gp}


{% note info %}

Данные, хранящиеся в `MATERIALIZED VIEW`, не переносятся. Для переноса данных из `MATERIALIZED VIEW` создайте обыкновенный `VIEW`, ссылающийся на переносимый `MATERIALIZED VIEW`.

{% endnote %}

{% list tabs %}

- Yandex MPP Analytics for PostgreSQL

    
    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:
    
        ```pgsql
        CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-мастерам](../../managed-greenplum/concepts/index.md) кластера.
    
    1. Если предполагается использовать [параллельное копирование](../concepts/sharded.md), настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-сегментам](../../managed-greenplum/concepts/index.md) кластера в режиме прямого доступа (utility mode). Для этого убедитесь, что для кластера включена настройка "Доступ из Data Transfer".
    
    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над таблицами, которые переносит трансфер, и привилегию `USAGE` на схемы, в которых находятся эти таблицы.
    
       Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.
    
       Таблицы, для которых не выданы необходимые привилегии, недоступны для Data Transfer. Эти таблицы обрабатываются так же, как если бы они отсутствовали.
    
       В этом примере привилегии выдаются на все таблицы в выбранной схеме:
    
        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_пользователя>;
        GRANT USAGE ON SCHEMA <название_схемы> TO <имя_пользователя>;
        ```

- Greenplum®
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:
    
        ```pgsql
        CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-мастерам](../../managed-greenplum/concepts/index.md) кластера.
    
    1. Если предполагается использовать [параллельное копирование](../concepts/sharded.md), настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-сегментам](../../managed-greenplum/concepts/index.md) кластера в режиме прямого доступа (utility mode).
    
    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над таблицами, которые переносит трансфер, и привилегию `USAGE` на схемы, в которых находятся эти таблицы.
    
       Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.
    
       Таблицы, для которых не выданы необходимые привилегии, недоступны для Data Transfer. Эти таблицы обрабатываются так же, как если бы они отсутствовали.
    
       В этом примере привилегии выдаются на все таблицы базы данных:
    
        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_пользователя>;
        GRANT USAGE ON SCHEMA <название_схемы> TO <имя_пользователя>;
        ```

{% endlist %}

Data Transfer взаимодействует с Greenplum® по-разному в зависимости от настроек трансфера и содержимого кластера-источника. Подробная информация доступна в разделе [настройка эндпоинта-источника Greenplum®](endpoint/source/greenplum.md).


### Источник MongoDB {#source-mg}


{% list tabs %}

- Yandex StoreDoc (Managed Service for MongoDB)


    1. Оцените общее количество баз данных для трансфера и общую нагрузку на Yandex StoreDoc. Если нагрузка на базы выше 10 000 операций записи в секунду, создайте несколько эндпоинтов и трансферов. Подробнее читайте в разделе [Передача данных из эндпоинта-источника MongoDB/Yandex StoreDoc (Managed Service for MongoDB)](endpoint/source/mongodb.md).
    
    1. [Создайте пользователя](../../storedoc/operations/cluster-users.md#adduser) с ролью `readWrite` на каждую базу в источнике, которая будет реплицироваться. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__data_transfer.__dt_cluster_time`.

- MongoDB
    
    1. Оцените общее количество баз данных для трансфера и общую нагрузку на MongoDB. Если нагрузка на базы выше 10 000 операций записи в секунду, создайте несколько эндпоинтов и трансферов. Подробнее читайте в разделе [Передача данных из эндпоинта-источника MongoDB/Yandex StoreDoc (Managed Service for MongoDB)](endpoint/source/mongodb.md).
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Убедитесь, что версия MongoDB на приемнике не ниже `4.0`.
    
    1. Убедитесь, что кластер MongoDB сконфигурирован таким образом, чтобы на запросы к нему он возвращал корректно разрешающиеся IP-адреса или FQDN (Fully Qualified Domain Name).
    
    1. [Настройте доступ к кластеру-источнику из Yandex Cloud](../concepts/network.md#source-external). Чтобы настроить кластер-источник для подключения из интернета:
        
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
              replSetName: <имя_набора_реплик>
            ```
        
        1. Перезапустите сервис `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
        
        1. Подключитесь к MongoDB и инициализируйте набор реплик командой:
        
            ```javascript
            rs.initiate({
                _id: "<имя_набора_реплик>",
                members: [{
                    _id: 0,
                    host: "<IP-адрес_который_слушает_Yandex_StoreDoc>:<порт>"
                }]
            });
            ```
    
    1. Создайте пользователя с ролью `readWrite` на все базы в источнике, которые будут реплицироваться:
    
        ```javascript
        use admin
        db.createUser({
            user: "<имя_пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя_базы-источника_1>",
                    role: "readWrite"
                },
                {
                    db: "<имя_базы-источника_2>",
                    role: "readWrite"
                },
                ...
            ]
        });
        ```
    
       После старта трансфер подключится к источнику от имени этого пользователя. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__data_transfer.__dt_cluster_time`.
    
       {% note info %}
    
       Для версий MongoDB, начиная с 3.6, достаточно выдать созданному пользователю роль `read` на реплицируемые базы.
    
       {% endnote %}
    
    1. При использовании MongoDB, начиная с версии 3.6, для работы трансфера необходимо, чтобы пользователь обладал правами на чтение коллекции `local.oplog.rs`, а также на запись с чтением коллекции `__data_transfer.__dt_cluster_time`. Чтобы назначить пользователю роль `clusterAdmin`, предоставляющую такие права, подключитесь к MongoDB и выполните команды:
    
        ```js
        use admin;
        db.grantRolesToUser("<имя_пользователя>", ["clusterAdmin"]);
        ```
    
       Для выдачи более гранулярных прав можно назначить роль `clusterMonitor`, необходимую для чтения коллекции `local.oplog.rs`, а также дать доступ на чтение и запись системной коллекции `__data_transfer.__dt_cluster_time`.

{% endlist %}

### Источник MySQL® {#source-my}

{% list tabs %}

- Managed Service for MySQL®

    
    1. [Включите режим полного бинарного лога](../../managed-mysql/operations/update.md#change-mysql-config) на источнике, установив значение `FULL` или `NOBLOB` для [параметра **Binlog row image**](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image).
 
    1. (Опционально) [Настройте лимит](../../managed-mysql/operations/update.md#change-mysql-config) на размер отправляемых кусков данных (chunk) с помощью параметра **Max allowed packet**.
    
    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к источнику.
        
        1. [Выдайте пользователю привилегию](../../managed-mysql/operations/grant.md#grant-privilege) `ALL_PRIVILEGES` для базы-источника.
        
        1. [Выдайте пользователю административные привилегии](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) `REPLICATION CLIENT` и `REPLICATION SLAVE`.
    
    1. Для типов трансфера _**Репликация**_ и _**Копирование и репликация**_ таблицы без уникальных индексов не переносятся. 
       
       Если в таблице, содержащей строку, есть первичный ключ, то при изменении строки в бинарный лог записываются только столбцы первичного ключа. Если первичного ключа нет, но есть уникальный индекс, все столбцы которого не равны `NULL`, то в бинарный лог записываются только эти столбцы. Если нет ни первичного ключа, ни уникального индекса без `NULL`, то в бинарный лог записываются все столбцы в строке.
       
       Чтобы сохранить работоспособность трансфера при переносе базы, содержащей таблицы без уникальных индексов:
       
       * Не переносите такие таблицы. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](endpoint/source/mysql.md#additional-settings).
       
       * Создайте уникальные индексы, например первичные ключи (`PRIMARY KEY`), в тех мигрируемых таблицах, где их нет.
       
           1. Чтобы получить список таблиц без первичного ключа, выполните запрос:
       
               ```sql
               SELECT
                   tab.table_schema AS database_name,
                   tab.table_name AS table_name,
                   tab.table_rows AS table_rows,
                   tco.*
               FROM information_schema.tables tab
                   LEFT JOIN information_schema.table_constraints tco
                       ON (tab.table_schema = tco.table_schema
                           AND tab.table_name = tco.table_name
               )
               WHERE
                   tab.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
                   AND tco.constraint_type IS NULL
                   AND tab.table_type = 'BASE TABLE';
               ```
       
           1. Изучите структуру таблиц без первичного ключа, которые необходимо перенести на приемник:
       
               ```sql
               SHOW CREATE TABLE <имя_базы>.<имя_таблицы>;
               ```
       
           1. Добавьте простой или составной первичный ключ к таблицам, которые необходимо перенести на приемник:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD PRIMARY KEY (<столбец_или_группа_столбцов>);
               ```
       
           1. Если в переносимой на приемник таблице нет столбца или группы столбцов, подходящих на роль первичного ключа, создайте новый столбец:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
               ```
    
       {% note info %}
    
       Если создание первичного ключа завершается ошибкой _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, [увеличьте в настройках СУБД](../../managed-mysql/operations/update.md#change-mysql-config) значение [параметра `Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).
    
       {% endnote %}
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _**Репликация**_ и _**Копирование и репликация**_). Подробнее — в [описании дополнительных настроек эндпоинта для источника MySQL®](endpoint/source/mysql.md#additional-settings).

- MySQL®
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Убедитесь, что источник использует подсистему хранения данных низкого уровня MyISAM или InnoDB. При использовании других подсистем трансфер может завершиться с ошибкой.
    
    1. [Включите режим полного бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) на источнике, установив значение `FULL` или `NOBLOB` для параметра `binlog_row_image`.

       {% note info %}

       Для MariaDB 11.4 и выше задайте параметр `binlog_legacy_event_pos = true`.

       {% endnote %}    
    
    1. [Задайте строковый формат бинарного лога](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_format) на источнике, установив значение `ROW` для параметра `binlog_format`.

    1. Для типов трансфера _**Репликация**_ и _**Копирование и репликация**_:

        * [Укажите путь к расположению бинарного лог-файла](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#option_mysqld_log-bin) в параметре `log_bin`.

        * Выведите информацию о бинарном логе с помощью запроса [SHOW MASTER STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-master-status.html) (для версий MySQL® 5.7 и 8.0) или [SHOW BINARY LOG STATUS](https://dev.mysql.com/doc/refman/8.4/en/show-binary-log-status.html) (для версии MySQL® 8.4). Запрос должен возвращать строку с информацией, а не пустой ответ.

    1. Если источник репликации — кластер, который находится за балансером, включите для него GTID-режим (`GTID-MODE = ON`).
    
       Если по какой-то причине включить GTID-режим невозможно, убедитесь, что шаблон имен бинарных логов содержит имя хоста.
    
       В обоих случаях это позволит продолжить репликацию в случае смены хоста-мастера.
    
    1. (Опционально) [Настройте лимит](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) на размер отправляемых кусков данных (chunk) с помощью параметра `max_allowed_packet`.
    
    1. Создайте пользователя для подключения к источнику и выдайте ему необходимые привилегии:
    
        ```sql
        CREATE USER '<имя_пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя_базы>.* TO '<имя_пользователя>'@'%';
        GRANT REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO '<имя_пользователя>'@'%';
        ```

    1. Для типов трансфера _**Репликация**_ и _**Копирование и репликация**_ таблицы без уникальных индексов не переносятся. 
       
       Если в таблице, содержащей строку, есть первичный ключ, то при изменении строки в бинарный лог записываются только столбцы первичного ключа. Если первичного ключа нет, но есть уникальный индекс, все столбцы которого не равны `NULL`, то в бинарный лог записываются только эти столбцы. Если нет ни первичного ключа, ни уникального индекса без `NULL`, то в бинарный лог записываются все столбцы в строке.
       
       Чтобы сохранить работоспособность трансфера при переносе базы, содержащей таблицы без уникальных индексов:
       
       * Не переносите такие таблицы. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](endpoint/source/mysql.md#additional-settings).
       
       * Создайте уникальные индексы, например первичные ключи (`PRIMARY KEY`), в тех мигрируемых таблицах, где их нет.
       
           1. Чтобы получить список таблиц без первичного ключа, выполните запрос:
       
               ```sql
               SELECT
                   tab.table_schema AS database_name,
                   tab.table_name AS table_name,
                   tab.table_rows AS table_rows,
                   tco.*
               FROM information_schema.tables tab
                   LEFT JOIN information_schema.table_constraints tco
                       ON (tab.table_schema = tco.table_schema
                           AND tab.table_name = tco.table_name
               )
               WHERE
                   tab.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
                   AND tco.constraint_type IS NULL
                   AND tab.table_type = 'BASE TABLE';
               ```
       
           1. Изучите структуру таблиц без первичного ключа, которые необходимо перенести на приемник:
       
               ```sql
               SHOW CREATE TABLE <имя_базы>.<имя_таблицы>;
               ```
       
           1. Добавьте простой или составной первичный ключ к таблицам, которые необходимо перенести на приемник:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD PRIMARY KEY (<столбец_или_группа_столбцов>);
               ```
       
           1. Если в переносимой на приемник таблице нет столбца или группы столбцов, подходящих на роль первичного ключа, создайте новый столбец:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
               ```
    
       {% note info %}
    
       Если создание первичного ключа завершается ошибкой _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, увеличьте в настройках СУБД значение параметра [`inno_db_log_file_size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).
    
       {% endnote %}
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _**Репликация**_ и _**Копирование и репликация**_). Подробнее — в [описании дополнительных настроек эндпоинта для источника MySQL®](endpoint/source/mysql.md#additional-settings).

{% endlist %}

### Источник Elasticsearch {#source-es}


Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).

Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).

### Источник OpenSearch {#source-os}

{% list tabs %}

- OpenSearch

  
  Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
  
  Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).


{% endlist %}

### Источник Oracle {#source-oracle}

{% note info %}

В некоторых версиях Oracle для системных объектов вместо префикса `V$` используются `V_$`. Например, `V_$DATABASE` вместо `V$DATABASE`.

Измените префиксы, если вы столкнулись с ошибкой вида `can only select from fixed tables/views` при выдаче прав на системные объекты.

{% endnote %}

{% list tabs %}

- Oracle
    
    * Чтобы подготовить источник к трансферу типа _**Копирование**_:
        
        1. Создайте пользователя, от имени которого трансфер подключится к источнику:
        
            ```sql
            CREATE USER <имя_пользователя> IDENTIFIED BY <пароль>;
            GRANT CREATE SESSION TO <имя_пользователя>;
            ```
        
        1. Выдайте права созданному пользователю:
        
           ```sql
           GRANT SELECT ON V$DATABASE TO <имя_пользователя>;
           GRANT SELECT ON DBA_EXTENTS TO <имя_пользователя>;
           GRANT SELECT ON DBA_OBJECTS TO <имя_пользователя>;
           GRANT FLASHBACK ANY TABLE TO <имя_пользователя>;
           ```
        
           При необходимости, право `FLASHBACK` можно выдать не на все таблицы (`ANY TABLE`), а только на те, которые нужно скопировать.
        
        1. Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно скопировать.
    
    * Чтобы подготовить источник к трансферу типа _**Репликация**_:
        
        1. Создайте пользователя, от имени которого трансфер подключится к источнику:
        
           ```sql
           CREATE USER <имя_пользователя> IDENTIFIED BY <пароль>;
           ALTER USER <имя_пользователя> DEFAULT tablespace USERS TEMPORARY tablespace TEMP;
           ALTER USER <имя_пользователя> quote unlimited on USERS;

           GRANT 
               CREATE SESSION,
               execute_catalog_role,
               SELECT ANY TRANSACTION,
               SELECT ANY DISCTIONARY,
               CREATE PROCEDURE,
               LOGMINING 
           TO <имя_пользователя>;
           ```
        
        1. Выдайте права созданному пользователю:
        
            ```sql
            GRANT SELECT ON V$DATABASE TO <имя_пользователя>;
            GRANT SELECT ON V$LOG TO <имя_пользователя>;
            GRANT SELECT ON V$LOGFILE TO <имя_пользователя>;
            GRANT SELECT ON V$ARCHIVED_LOG TO <имя_пользователя>;

            GRANT SELECT ON dba_objects TO <имя_пользователя>;
            GRANT SELECT ON dba_extents TO <имя_пользователя>;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO <имя_пользователя>;
            ```
        
        1. Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно реплицировать.
        1. Включите [Minimal Supplemental Logging](https://docs.oracle.com/database/121/SUTIL/GUID-D2DDD67C-E1CC-45A6-A2A7-198E4C142FA3.htm#SUTIL1583) с первичными ключами, для этого выполните:
        
            ```sql
            ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
            ```
    
    * Если вы работаете в [CDB-среде](https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89234), выполните следующие настройки:
        
        1. Создайте [пользователя](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/overview-of-managing-a-multitenant-environment.html#GUID-7D303718-2D59-495F-90FB-E51A377B1AD2) `Common User`:
        
            ```sql
            CREATE USER C##<имя_пользователя> IDENTIFIED BY <пароль> CONTAINER=all;
            ALTER USER C##<имя_пользователя> DEFAULT TABLESPACE USERS temporary tablespace TEMP CONTAINER=all;
            ALTER USER C##<имя_пользователя> quota unlimited on USERS CONTAINER=all;
            ALTER USER C##<имя_пользователя> SET container_data = (cdb$root, <имя_вашей_PCB>) CONTAINER=current;

            GRANT 
                CREATE SESSION,
                execute_catalog_role,
                SELECT ANY TRANSACTION,
                SELECT ANY DICTIONALY,
                CREATE PROCEDURE,
                LOGMINING,
                SET CONTAINER
            TO C##<имя_пользователя> CONTAINER=ALL;
            ```
        
           При необходимости, можно указать только контейнер `cdb$root` и контейнер с таблицами, которые нужно перенести.
        
        1. Чтобы пользователь мог переключаться на контейнер `cdb$root`, выдайте ему права `ALTER SESSION`:
        
            ```sql
            GRANT ALTER SESSION TO C##<имя_пользователя>;
            ```
        
        1. Выдайте права созданному пользователю:
        
            ```sql
            GRANT SELECT ON V$DATABASE TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$LOG TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$LOGFILE TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$ARCHIVED_LOG TO C##<имя_пользователя> CONTAINER=ALL;

            GRANT SELECT ON dba_objects TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON dba_extents TO C##<имя_пользователя> CONTAINER=ALL;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO C##<имя_пользователя> CONTAINER=ALL;
            ```

{% endlist %}

### Источник PostgreSQL {#source-pg}

{% note info %}

При трансфере из PostgreSQL в любой тип приемника объекты типа [large objects](https://www.postgresql.org/docs/current/largeobjects.html) не переносятся.

При переносе данных с типом `TIMESTAMP WITHOUT TIME ZONE` применяется часовой пояс, указанный в параметре `timezone` базы данных источника PostgreSQL.

{% cut "Пример" %}

В колонке с типом данных `TIMESTAMP WITHOUT TIME ZONE` записано значение `1970-01-01 00:00:00`. То, как при трансфере будет перенесено значение, зависит от параметра `timezone` в БД:

* Если значение параметра равно `Etc/UTC`, то время переносится как `1970-01-01 00:00:00+00`.
* Если значение параметра равно `Europe/Moscow`, то время переносится как `1970-01-01 00:00:00+03`.

{% endcut %}

Данные, хранящиеся в `MATERIALIZED VIEW`, не переносятся. Для переноса данных из `MATERIALIZED VIEW` создайте обыкновенный `VIEW`, ссылающийся на переносимый `MATERIALIZED VIEW`.

Если определение переносимого `VIEW` содержит вызов `VOLATILE` [функции](https://www.postgresql.org/docs/current/xfunc-volatility.html), то трансфер читает данные из такого `VIEW` с уровнем изоляции `READ UNCOMMITTED`. Консистентность между данными в этом `VIEW` и данными других переносимых объектов не гарантируется. Чтение из `MATERIALIZED VIEW` в определении `VIEW` равносильно вызову `VOLATILE` функции.

Большие объекты в [системе хранения TOAST](https://www.postgresql.org/docs/12/storage-toast.html) и данные с [типом bytea](https://www.postgresql.org/docs/12/datatype-binary.html) переносятся без ограничений.

{% endnote %}

{% list tabs %}

- Managed Service for PostgreSQL

    
    1. Настройте пользователя, от имени которого трансфер подключится к источнику:
        
        1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser).
        
        1. Для типов трансфера _**Репликация**_ и _**Копирование и репликация**_ [назначьте роль](../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` этому пользователю.
        
        1. [Подключитесь к базе данных](../../managed-postgresql/operations/connect/index.md), которую нужно мигрировать, от имени владельца базы и [настройте привилегии](../../managed-postgresql/operations/grant.md#grant-privilege):

            * Выдайте привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер:

              ```sql
              GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

            * Выдайте привилегию на выполнение операции `SELECT` над всеми последовательностями базы данных, которые переносит трансфер:

              ```sql
              GRANT SELECT ON ALL SEQUENCES IN SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

            * Выдайте привилегию `USAGE` на схемы, где хранятся эти таблицы и последовательности:

              ```sql
              GRANT USAGE ON SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

            * Выдайте привилегию `ALL PRIVILEGES` (`CREATE` и `USAGE`) на задаваемую [параметром эндпоинта](endpoint/source/postgresql.md#additional-settings) схему для хранения служебных таблиц `__consumer_keeper` и `__data_transfer_mole_finder`, если эндпоинт будет использоваться для типов трансфера _**Репликация**_ или _**Копирование и репликация**_:

              ```sql
              GRANT ALL PRIVILEGES ON SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

    1. Настройте [количество подключений пользователя](../concepts/work-with-endpoints.md#postgresql-connection-limit) к базе данных.

    1. Если источник репликации — кластер, выполните настройки:

        * [Включите](../../managed-postgresql/operations/extensions/cluster-extensions.md) для него расширение `pg_tm_aux`. Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее читайте в разделе [Решение проблем](../troubleshooting/index.md#master-change).

        * Укажите в кластере значение [настройки](../../managed-postgresql/concepts/settings-list.md#setting-wal-keep-size) `Wal keep size`. В случае смены хоста-мастера хранимой в [WAL](https://www.postgresql.org/docs/current/wal-intro.html) на новом мастере истории должно хватать для продолжения репликации с того же места. Если истории недостаточно, трансфер может завершиться [ошибкой](endpoint/source/postgresql.md#no-wal-story). В качестве минимального значения настройки `Wal keep size` рекомендуется взять среднее значение из графика **Source buffer size** в [мониторинге Data Transfer](monitoring.md). Если на диске достаточно свободных ресурсов, укажите значение настройки с запасом.

    1. Для типов трансфера _**Репликация**_ и _**Копирование и репликация**_ таблицы без первичных ключей не переносятся. Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами:
       
       * Не переносите таблицы без первичных ключей. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](endpoint/source/postgresql.md#additional-settings.md).
       * Добавьте идентификатор реплики на таблицах без `primary key`:
           * Для таблиц с индексом установите `REPLICA IDENTITY` по `unique key`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
               ```
       
           * Для таблиц без индекса измените `REPLICA IDENTITY`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
               ```
             В этом случае Data Transfer будет воспринимать такие таблицы как таблицы, в которых первичный ключ является составным, и в него входят все колонки таблицы.
       
       Если в таблице нет первичных ключей, тогда в логической репликации [не будет событий изменений строк](https://www.postgresql.org/docs/current/logical-replication-publication.html) (`UPDATE`, `DELETE`).
       
       * Во время трансфера из PostgreSQL в PostgreSQL, если у вас в источнике трансфера не будет исключена таблица без первичных ключей, то вы увидите ошибку: 
       
          ```text
           failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed: "public"."MY_TBL": no key columns found
           ```
       
        * Во время трансфера из PostgreSQL в другую базу данных, если у вас будет добавлена таблица без первичных ключей, то вы увидите ошибку:
       
          ```text
          failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed:
          "public"."MY_TBL": no key columns found
          ```
    
    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.

    1. Если база данных содержит таблицы, в которых есть генерируемые столбцы, то такие таблицы не переносятся, и трансфер завершается ошибкой. Подробнее читайте в разделе [Решение проблем](../troubleshooting/index.md#generated-columns). Чтобы сохранить работоспособность трансфера при переносе базы данных с такими таблицами, добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](endpoint/source/postgresql.md#additional-settings.md).

    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы PostgreSQL `pg_stat_activity`:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _**Репликация**_ и _**Копирование и репликация**_). Подробнее — в [описании дополнительных настроек эндпоинта для источника PostgreSQL](endpoint/source/postgresql.md#additional-settings).
    
    1. Для параллельного чтения из таблицы по диапазонам убедитесь, что указан первичный ключ. После этого укажите количество воркеров и потоков в блоке **Среда выполнения** в [параметрах трансфера](transfer.md#create).
    
    1. Настройте мониторинг WAL-лога. {#wal-setup-recommendation}

       Для трансферов типа _**Репликация**_ и _**Копирование и репликация**_ используется [логическая репликация](https://www.postgresql.org/docs/current/logicaldecoding.html). Для этого сам трансфер создает слот репликации со значением `slot_name`, равным идентификатору трансфера, который можно получить, выбрав трансфер в списке ваших трансферов. WAL может расти по разным причинам: из-за долгой транзакции или из-за проблемы на трансфере. Поэтому рекомендуется настроить мониторинг WAL-лога на стороне источника.

        1. Для мониторинга размера использованного хранилища или диска [настройте алерт средствами мониторинга](../../managed-postgresql/operations/monitoring.md#monitoring-hosts) (см. описание `disk.used_bytes`).
        
        1. Задайте максимальный размер WAL при репликации в [настройке](../../managed-postgresql/concepts/settings-list.md#setting-max-slot-wal-keep-size) `Max slot wal keep size`. Редактирование данной настройки доступно начиная с 13 версии PostgreSQL. Если вы хотите экстренно запретить операции чтения трансферу, то [удалите слот репликации](../../managed-postgresql/operations/replication-slots.md#delete). 
        
           {% note warning %}
        
           При значении настройки `-1` (размер не ограничен) открытые логические слоты репликации, из которых не считывается информация, будут препятствовать удалению WAL-файлов. В результате WAL-файлы займут все дисковое пространство и вы потеряете возможность подключаться к кластеру.
        
           {% endnote %}
        
        1. [Настройте алерт](../../managed-postgresql/operations/monitoring.md) средствами Yandex Monitoring на метрику, которая используется для `Total size of WAL files`. Пороговые значения должны быть меньше, чем указаны для метрики `disk.used_bytes`, так как на диске, кроме данных, хранятся временные файлы, WAL-лог и другие типы данных. Текущий размер слота можно мониторить средствами БД через запрос, указав правильный `slot_name`, равный идентификатору трансфера:
        
            ```sql
            SELECT slot_name, pg_size_pretty(pg_current_wal_lsn() - restart_lsn), active_pid, catalog_xmin, restart_lsn, confirmed_flush_lsn
            FROM pg_replication_slots WHERE slot_name = '<идентификатор_трансфера>'
            ```

- PostgreSQL
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Настройте пользователя, от имени которого трансфер подключится к источнику:

        1. Создайте нового пользователя:
            
            * Для типа трансфера _**Копирование**_ создайте пользователя командой:
            
                ```sql
                CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
                ```
            
            * Для типов трансфера _**Репликация**_ и _**Копирование и репликация**_ создайте пользователя с привилегией `REPLICATION` командой:
            
                ```sql
                CREATE ROLE <имя_пользователя> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<пароль>';
                ```
        
        1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер:
        
            ```sql
            GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_пользователя>;
            ```
        
        1. Выдайте созданному пользователю привилегию на схемы переносимой базы данных:

            * Для типа трансфера _**Копирование**_ выдайте привилегию `USAGE`:
        
                ```sql
                GRANT USAGE ON SCHEMA <название_схемы> TO <имя_пользователя>;
                ```

            * Для типа трансфера _**Репликация**_ и _**Копирование и репликация**_ выдайте привилегии `CREATE` и `USAGE` (`ALL PRIVILEGES`), необходимые для создания [служебных таблиц](endpoint/source/postgresql.md#additional-settings):

                ```sql
                GRANT ALL PRIVILEGES ON SCHEMA <название_схемы> TO <имя_пользователя>;
                ```

        1. Выдайте созданному пользователю привилегию `SELECT` на все последовательности базы данных, которые переносит трансфер:

            ```sql
            GRANT SELECT ON ALL SEQUENCES IN SCHEMA <название_схемы> TO <имя_пользователя>;
            ```

        1. Выдайте созданному пользователю привилегию `CONNECT`, если настройки кластера-источника по умолчанию не позволяют выполнять подключение для новых пользователей:

            ```sql
            GRANT CONNECT ON DATABASE <название_базы_данных> TO <имя_пользователя>;
            ```

    1. Настройте конфигурацию PostgreSQL:
    
        1. Внесите изменения в конфигурацию и настройки аутентификации кластера-источника. Для этого отредактируйте файлы `postgresql.conf`  и `pg_hba.conf` (на дистрибутивах Debian и Ubuntu они по умолчанию расположены в каталоге `/etc/postgresql/<версия_PostgreSQL>/main/`):
        
            1. Задайте максимальное количество подключений пользователя. Для этого в файле `postgresql.conf` отредактируйте параметр `max_connections`:
        
                ```ini
                max_connections = <количество_подключений>
                ```
                
                Где `<количество_подключений>` — максимальное число подключений. Подробнее о том, как настроить этот параметр, читайте в разделе [Особенности работы с эндпоинтами](../concepts/work-with-endpoints.md#postgresql-connection-limit).
        
                Текущее количество подключений вы можете посмотреть в системной таблице `pg_stat_activity`:
        
                ```sql
                SELECT count(*) FROM pg_stat_activity;
                ```
        
            1. Установите уровень логирования для [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html). Для этого установите значение `logical` для настройки [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) в `postgresql.conf`:
        
                ```ini
                wal_level = logical
                ```
        
            1. (Опционально) Настройте SSL: это поможет не только шифровать данные, но и сжимать их. Чтобы включить использование SSL, задайте нужное значение в файле `postgresql.conf`:
        
                ```ini
                ssl = on
                ```
            
            1. Разрешите подключение к кластеру. Для этого отредактируйте [параметр](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-LISTEN-ADDRESSES) `listen_addresses` в файле `postgresql.conf`. Например, чтобы кластер-источник принимал запросы на подключение со всех IP-адресов:
        
                ```ini
                listen_addresses = '*'
                ```
        
            1. Настройте аутентификацию в файле `pg_hba.conf`:
        
                {% list tabs %}
        
                - SSL
        
                    ```txt
                    hostssl         all            all             <IP-адрес_подключения>      md5
                    hostssl         replication    all             <IP-адрес_подключения>      md5
                    ```
        
                - Без SSL
        
                    ```txt
                    host         all            all             <IP-адрес_подключения>      md5
                    host         replication    all             <IP-адрес_подключения>      md5
                    ```
        
                {% endlist %}
        
                Где `<IP-адрес_подключения>` может быть как точным IP-адресом, так и диапазоном IP-адресов. Например, чтобы разрешить доступ из сети Yandex Cloud, вы можете указать [все публичные IP-адреса](../../overview/concepts/public-ips.md) Yandex Cloud.
        1. Если в кластере-источнике работает файрвол, разрешите входящие соединения с нужных адресов.
        
        1. Чтобы применить настройки, перезапустите сервис PostgreSQL:
        
           ```bash
           sudo systemctl restart postgresql
           ```
        
        1. Проверьте статус сервиса PostgreSQL после перезапуска:
        
           ```bash
           sudo systemctl status postgresql
           ```

    1. Установите и включите расширение [wal2json](https://github.com/eulerto/wal2json).

        * Linux
            
            1. Подключите [официальный репозиторий PostgreSQL](https://www.postgresql.org/download/) для вашего дистрибутива.
            1. Обновите список доступных пакетов и установите пакет `wal2json` для используемой версии PostgreSQL.
        
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
                
                * замените строки `C:\postgres\pg103` на путь к каталогу с установленной версией PostgreSQL, например:
                
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
                    (Get-Content .\wal2json.vcxproj).replace('<WindowsTargetPlatformVersion>8.1', '<WindowsTargetPlatformVersion><установленная_версия_Windows_SDK>') | `
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
                
                1. Скопируйте файл `wal2json.dll` из каталога `build/release` в каталог `lib` установленной версии PostgreSQL.
    
    1. Если источник репликации — кластер, установите и включите на его хостах расширение [pg_tm_aux](https://github.com/x4m/pg_tm_aux). Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее читайте в разделе [Решение проблем](../troubleshooting/index.md#master-change).
    
    1. Для типов трансфера _**Репликация**_ и _**Копирование и репликация**_ таблицы без первичных ключей не переносятся. Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами:
       
       * Не переносите таблицы без первичных ключей. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](endpoint/source/postgresql.md#additional-settings.md).
       * Добавьте идентификатор реплики на таблицах без `primary key`:
           * Для таблиц с индексом установите `REPLICA IDENTITY` по `unique key`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
               ```
       
           * Для таблиц без индекса измените `REPLICA IDENTITY`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
               ```
             В этом случае Data Transfer будет воспринимать такие таблицы как таблицы, в которых первичный ключ является составным, и в него входят все колонки таблицы.
       
       Если в таблице нет первичных ключей, тогда в логической репликации [не будет событий изменений строк](https://www.postgresql.org/docs/current/logical-replication-publication.html) (`UPDATE`, `DELETE`).
       
       * Во время трансфера из PostgreSQL в PostgreSQL, если у вас в источнике трансфера не будет исключена таблица без первичных ключей, то вы увидите ошибку: 
       
          ```text
           failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed: "public"."MY_TBL": no key columns found
           ```
       
        * Во время трансфера из PostgreSQL в другую базу данных, если у вас будет добавлена таблица без первичных ключей, то вы увидите ошибку:
       
          ```text
          failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed:
          "public"."MY_TBL": no key columns found
          ```
    
    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.

    1. Если база данных содержит таблицы, в которых есть генерируемые столбцы, то такие таблицы не переносятся, и трансфер завершается ошибкой. Подробнее читайте в разделе [Решение проблем](../troubleshooting/index.md#generated-columns). Чтобы сохранить работоспособность трансфера при переносе базы данных с такими таблицами, добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](endpoint/source/postgresql.md#additional-settings.md).

    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы PostgreSQL `pg_stat_activity`:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _**Репликация**_ и _**Копирование и репликация**_). Подробнее — в [описании дополнительных настроек эндпоинта для источника PostgreSQL](endpoint/source/postgresql.md#additional-settings).
    
    1. Для параллельного чтения из таблицы по диапазонам убедитесь, что указан первичный ключ. После этого укажите количество [воркеров](../concepts/index.md#worker) и потоков в блоке **Среда выполнения** в [параметрах трансфера](transfer.md#create).
    
    1. Если на источнике настроена репликация через [Patroni](https://github.com/zalando/patroni), добавьте в его конфигурацию [блок ignore_slots](https://patroni.readthedocs.io/en/latest/SETTINGS.html?highlight=ignore_slots#dynamic-configuration-settings):
    
       ```yaml
       ignore_slots:
         - database: <база_данных>
           name: <слот_репликации>
           plugin: wal2json
           type: logical
       ```
    
       Где:
        
        * `database` — имя базы данных, для которой настроен трансфер.
        * `name` — имя слота репликации.

       Имя базы данных и имя слота репликации должны совпадать со значениями, указанными в [настройках эндпоинта для источника](endpoint/source/postgresql.md). По умолчанию `имя слота репликации` совпадает с `ID трансфера`.

       В противном случае начало этапа репликации завершится ошибкой:
    
       ```
       Warn(Termination): unable to create new pg source: Replication slotID <имя_слота_репликации> does not exist.
       ```
    
    1. Настройте мониторинг WAL-лога. Для трансферов типа _**Репликация**_ и _**Копирование и репликация**_ используется [логическая репликация](https://www.postgresql.org/docs/current/logicaldecoding.html). Для этого сам трансфер создает слот репликации со значением `slot_name`, равным идентификатору трансфера, который можно получить, выбрав трансфер в списке ваших трансферов. WAL может расти по разным причинам: из-за долгой транзакции или из-за проблемы на трансфере. Поэтому рекомендуется настроить мониторинг WAL-лога на стороне источника.
        
        1. Настройте алерты на основе [рекомендаций по использованию диска](https://www.postgresql.org/docs/current/diskusage.html).
        
        1. [Установите максимальный размер WAL](https://www.postgresql.org/docs/current/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE). Эта возможность доступна, начиная с версии PostgreSQL 13.
        
        1. Текущий размер слота можно отслеживать средствами БД через запрос, указав правильный `slot_name`, равный идентификатору трансфера:
        
            ```sql
            SELECT slot_name, pg_size_pretty(pg_current_wal_lsn() - restart_lsn), active_pid, catalog_xmin, restart_lsn, confirmed_flush_lsn
            FROM pg_replication_slots WHERE slot_name = '<идентификатор_трансфера>'
            ```    

{% endlist %}

{% note info %}

Об особенностях переноса данных из PostgreSQL в ClickHouse® трансферами типа _**Репликация**_ и _**Копирование и репликация**_ читайте в разделе [Асинхронная репликация данных из PostgreSQL в ClickHouse®](../tutorials/rdbms-to-clickhouse.md).

{% endnote %}



### Источник Yandex Data Streams {#source-yds}

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
            "name": "<имя_поля>",
            "type": "<тип>"
        },
        ...
        {
            "name": "<имя_поля>",
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


### Источник Yandex Managed Service for YDB {#source-ydb}

Если вы выбрали режим базы данных Dedicated, [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.


## Подготовка приемника {#target}

### Приемник ClickHouse® {#target-ch}

{% list tabs %}

- Managed Service for ClickHouse®

    1. [Создайте базу-приемник](../../managed-clickhouse/operations/databases.md#add-db).

       Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. [Создайте пользователя](../../managed-clickhouse/operations/cluster-users.md#adduser) с доступом к базе приемника.

       После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Если в кластере включено [управление пользователями через SQL](../../managed-clickhouse/operations/cluster-users.md#sql-user-management), выдайте созданному пользователю права:

        ```sql
        GRANT CLUSTER ON *.* TO <имя_пользователя>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <имя_базы_данных>.* TO <имя_пользователя>
        GRANT SELECT(macro, substitution) ON system.macros TO <имя_пользователя>
        ``` 

       Если управление пользователями через SQL выключено, [права назначаются](../../managed-clickhouse/operations/cluster-users.md) через консоль управления и CLI.

    1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) и [настройте ее](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    1. Назначьте кластеру Managed Service for ClickHouse® созданную группу безопасности.

- ClickHouse®

    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).

    1. Создайте базу-приемник. Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. Создайте пользователя с доступом к базе приемника.

       После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Выдайте созданному пользователю права:

        ```sql
        GRANT CLUSTER ON *.* TO <имя_пользователя>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <имя_базы_данных>.* TO <имя_пользователя>
        GRANT SELECT(macro, substitution) ON system.macros TO <имя_пользователя>
        ```

{% endlist %}

### Приемник Greenplum® {#target-gp}


{% list tabs %}

- Yandex MPP Analytics for PostgreSQL
    
    1. Отключите на приемнике следующие настройки:
        
        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

       {% note warning %}

       Не включайте эти настройки до окончания трансфера. Это обеспечит целостность данных по внешним ключам.

       {% endnote %}
    
    1. Создайте пользователя:
    
        ```sql
        CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```
    
    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:
    
        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя_базы> TO <имя_пользователя>;
        ```
    
       Если база не пустая, то пользователь должен быть ее владельцем (owner):
    
        ```sql
        ALTER DATABASE <имя_базы> OWNER TO <имя_пользователя>;
        ```
    
       После старта трансфер подключится к приемнику от имени этого пользователя.

- Greenplum®
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Отключите на приемнике следующие настройки:
        
        * проверку целостности внешних ключей;
        * триггеры;
        * другие ограничения (constraints).

       {% note warning %}

       Не включайте эти настройки до окончания трансфера. Это обеспечит целостность данных по внешним ключам.

       {% endnote %}
    
    1. Создайте пользователя:
    
        ```sql
        CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```
    
    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:
    
        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя_базы> TO <имя_пользователя>;
        ```
    
       Если база не пустая, то пользователь должен быть ее владельцем (owner):
    
        ```sql
        ALTER DATABASE <имя_базы> OWNER TO <имя_пользователя>;
        ```
    
       После старта трансфер подключится к приемнику от имени этого пользователя.

{% endlist %}


### Приемник MongoDB {#target-mg}


{% list tabs %}

- Yandex StoreDoc (Managed Service for MongoDB)
    
    1. [Создайте базу данных](../../storedoc/operations/databases.md#add-db).
    1. [Создайте пользователя](../../storedoc/operations/cluster-users.md#adduser) с ролью [`readWrite`](../../storedoc/concepts/users-and-roles.md#readWrite) на созданную базу.
    1. Чтобы шардировать переносимые коллекции в кластере-приемнике Yandex StoreDoc:
        1. Следуя [инструкции](../../storedoc/tutorials/sharding.md), создайте и настройте в базе-приемнике пустые шардированные коллекции.
        
           Сервис Data Transfer не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.
        
        1. Если шардирование происходит по ключу, отличному от `_id` (используется по умолчанию), [назначьте пользователю роль](../../storedoc/operations/cluster-users.md#updateuser) `mdbShardingManager`.
        
        1. При [создании эндпоинта для приемника](endpoint/target/mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.
        
           Выбор политики `DROP` приведет к тому, что при активации трансфера сервис удалит из базы-приемника все данные, в т. ч. шардированные коллекции, и создаст вместо них новые, нешардированные.


- MongoDB
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Убедитесь, что версия MongoDB на приемнике не ниже, чем на источнике.
    
    1. Убедитесь, что кластер MongoDB сконфигурирован таким образом, чтобы на запросы к нему он возвращал корректно разрешающиеся IP-адреса или FQDN (Fully Qualified Domain Name).
    
    1. Настройте кластер-приемник, чтобы к нему можно было подключиться из интернета:
        
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
              replSetName: <имя_набора_реплик>
            ```
        
        1. Перезапустите сервис `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
        
        1. Подключитесь к MongoDB и инициализируйте набор реплик командой:
        
            ```javascript
            rs.initiate({
                _id: "<имя_набора_реплик>",
                members: [{
                    _id: 0,
                    host: "<IP-адрес_который_слушает_Yandex_StoreDoc>:<порт>"
                }]
            });
            ```
    
    1. Подключитесь к кластеру и создайте базу-приемник:
    
        ```javascript
        use <имя_базы>
        ```
    
    1. Создайте пользователя с правами `readWrite` на базу-приемник:
    
        ```javascript
        use admin;
        db.createUser({
            user: "<имя_пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя_базы-приемника>",
                    role: "readWrite"
                }
            ]
        });
        ```
    
       После старта трансфер подключится к приемнику от имени этого пользователя.
    
    1. Чтобы шардировать переносимые коллекции в кластере-приемнике:
        
        1. Подготовьте базу данных и создайте в ней пустые коллекции с теми же именами, что и на источнике.
        
           Сервис Data Transfer не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.
        
        1. Включите шардирование для базы-приемника:
        
            ```javascript
            sh.enableSharding("<имя_базы-приемника>")
            ```
        
        1. Задайте шардирование для каждой коллекции с учетом ее пространства имен:
        
            ```javascript
            sh.shardCollection("<имя_базы-приемника>.<имя_коллекции>", { <имя_поля>: <1|"hashed">, ... });
            ```
           
        
        1. Чтобы убедиться в том, что шардирование настроено и включено, получите список доступных шардов:
        
            ```javascript
            sh.status()
            ```
        
        1. Если для шардирования используется ключ, отличный от `_id` (значение по умолчанию), назначьте системную роль `clusterManager` пользователю, от имени которого сервис Data Transfer будет подключаться к кластеру-приемнику:
        
            ```javascript
            use admin;
            db.grantRolesToUser("<имя_пользователя>", ["clusterManager"]);
            ```
        
        1. При [создании эндпоинта для приемника](endpoint/target/mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.
        
           Выбор политики `DROP` приведет к тому, что при активации трансфера сервис удалит из базы-приемника все данные, в т. ч. шардированные коллекции, и создаст вместо них новые, нешардированные.


{% endlist %}

### Приемник MySQL® {#target-my}

{% list tabs %}

- Managed Service for MySQL®
    
    1. Убедитесь, что мажорная версия MySQL® на приемнике не ниже версии на источнике.
    
    1. [Установите SQL Mode](../../managed-mysql/operations/update.md#change-mysql-config), который совпадает с источником.
    
    1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) для подключения к приемнику.
        
        1. [Назначьте пользователю роль](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-приемника.

- MySQL®
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Убедитесь, что мажорная версия MySQL® на приемнике не ниже версии на источнике.
    
    1. Убедитесь, что приемник использует подсистему хранения данных низкого уровня MyISAM или InnoDB.
    
    1. [Установите SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting), который совпадает с источником.
    
    1. Создайте пользователя для подключения к приемнику и выдайте ему необходимые привилегии:
    
        ```sql
        CREATE USER '<имя_пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя_базы>.* TO '<имя_пользователя>'@'%';
        ```

{% endlist %}

### Приемник Yandex Object Storage {#target-storage}

1. [Создайте бакет](../../storage/operations/buckets/create.md) нужной вам конфигурации.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `storage.uploader`.

### Приемник Elasticsearch {#target-es}


Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).

Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).

* Убедитесь, что количество колонок в источнике не превышает максимальное количество полей в индексах Elasticsearch. Максимальное количество полей задается в [параметре](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-settings-limit.html#mapping-settings-limit) `index.mapping.total_fields.limit` и по умолчанию составляет `1000`.

    Чтобы увеличить значение параметра, [настройте шаблон](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-template.html#indices-put-template), по которому максимальное количество полей в создаваемых индексах будет равно указанному значению.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
        --user <имя_пользователя_Elasticsearch>:<пароль> \
        --header 'Content-Type: application/json' \
        --request PUT "https://<FQDN_кластера_Elasticsearch>:9200/_template/index_defaults" \
        --data '
            {
                "index_patterns": "cdc*",
                "settings": {
                    "index": {
                        "mapping": {
                            "total_fields": {
                                "limit": "2000"
                            }
                        }
                    }
                }
            }'
    ```

    При такой настройке шаблона, все новые индексы с маской `cdc*` смогут содержать до `2000` полей.

    {% endcut %}

    Для настройки шаблона можно также использовать [интерфейс Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-index-templates).

    Проверить текущее значение параметра `index.mapping.total_fields.limit` можно с помощью [интерфейса Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#view-edit-indices), либо выполнив запрос:

    ```bash
    curl \
        --user <имя_пользователя_Elasticsearch>:<пароль> \
        --header 'Content-Type: application/json' \
        --request GET 'https://<FQDN_кластера_Elasticsearch>:9200/<название_индекса>/_settings/*total_fields.limit?include_defaults=true'
    ```

* По умолчанию при трансфере данных в единичный индекс задействуется только один хост. Чтобы распределить нагрузку между хостами при передаче больших объемов данных, [настройте шаблон](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-template.html#indices-put-template), по которому создаваемые индексы будут заранее разбиты на шарды.

    {% cut "Пример запроса для настройки шаблона" %}

    ```bash
    curl \
        --user <имя_пользователя_Elasticsearch>:<пароль> \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<FQDN_кластера_Elasticsearch>:9200/_template/index_defaults' \
        --data '
            {
                "index_patterns": "cdc*",
                "settings" : {
                    "index" : {
                        "number_of_shards" : 15,
                        "number_of_replicas" : 1
                    }
                }
            }'
    ```

    {% endcut %}

    При такой настройке шаблона, все новые индексы с маской `cdc*` будут разбиты на `15` шардов.

    Для настройки шаблона можно также использовать [интерфейс Kibana](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-index-templates).

### Приемник OpenSearch {#target-os}

{% list tabs %}

- Managed Service for OpenSearch

  * Убедитесь, что количество колонок в источнике не превышает максимальное количество полей в индексах OpenSearch. Максимальное количество полей задается в параметре `index.mapping.total_fields.limit` и по умолчанию составляет `1000`.
  
      {% note warning %}
  
      Превышение лимита приведет к ошибке `Limit of total fields [1000] has been exceeded` и остановке трансфера.
  
      {% endnote %}
  
      Чтобы увеличить значение параметра, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому максимальное количество полей в создаваемых индексах будет равно указанному значению.
  
      {% cut "Пример запроса для настройки шаблона" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT "https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_template/index_defaults" \
      --data '
          {
              "index_patterns": "cdc*",
              "settings": {
                  "index": {
                      "mapping": {
                          "total_fields": {
                              "limit": "2000"
                          }
                      }
                  }
              }
          }'
      ```
  
      При такой настройке шаблона все новые индексы с маской `cdc*` смогут содержать до `2000` полей.
  
      {% endcut %}
  
      Для настройки шаблона можно также использовать [интерфейс OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).
  
      Чтобы проверить текущее значение параметра `index.mapping.total_fields.limit`, выполните запрос:
  
      ```bash
      curl \
          --user <имя_пользователя_OpenSearch>:<пароль> \
          --header 'Content-Type: application/json' \
          --request GET 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/<название_индекса>/_settings/*total_fields.limit?include_defaults=true'
      ```
  
  * По умолчанию при трансфере данных в единичный индекс задействуется только один хост. Чтобы распределить нагрузку между хостами при передаче больших объемов данных, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому создаваемые индексы будут заранее разбиты на шарды.
  
      {% cut "Пример запроса для настройки шаблона" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_template/index_defaults' \
      --data '
          {
              "index_patterns": "cdc*",
              "settings" : {
                  "index" : {
                      "number_of_shards" : 15,
                      "number_of_replicas" : 1
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      При такой настройке шаблона, все новые индексы с маской `cdc*` будут разбиты на `15` шардов.
  
      Для настройки шаблона можно также использовать [интерфейс OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).
  
  * Чтобы повысить безопасность и доступность данных, установите политику, которая будет создавать новый индекс при выполнении хотя бы одного из условий (рекомендуемые значения):
  
      * Когда размер индекса превысит 50 ГБ.
      * Когда возраст индекса превысит 30 дней.
  
      Создать и включить политику можно с помощью запросов. Подробнее о политиках см. [в документации OpenSearch](https://opensearch.org/docs/latest/im-plugin/ism/policies/).
  
      {% cut "Пример запроса для создания политики" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_plugins/_ism/policies/rollover_policy' \
      --data '
          {
              "policy": {
                  "description": "Example rollover policy",
                  "default_state": "rollover",
                  "schema_version": 1,
                  "states": [
                      {
                          "name": "rollover",
                          "actions": [
                              {
                                  "rollover": {
                                      "min_index_age": "30d",
                                      "min_primary_shard_size": "50gb"
                                  }
                              }
                          ],
                          "transitions": []
                      }
                  ],
                  "ism_template": {
                      "index_patterns": ["log*"],
                      "priority": 100
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      {% cut "Пример запроса для назначения политике псевдонима" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_index_template/ism_rollover' \
      --data '
          {
              "index_patterns": ["log*"],
              "template": {
                  "settings": {
                      "plugins.index_state_management.rollover_alias": "log"
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      {% cut "Пример запроса для создания индекса с псевдонимом политики" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/log-000001' \
      --data '
          {
              "aliases": {
                  "log": {
                      "is_write_index": true
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      {% cut "Пример запроса для проверки, прикреплена ли политика к индексу" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request GET 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_plugins/_ism/explain/log-000001?pretty'
      ```
  
      {% endcut %}

- OpenSearch
    
    * Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
      
      Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).

  * Убедитесь, что количество колонок в источнике не превышает максимальное количество полей в индексах OpenSearch. Максимальное количество полей задается в параметре `index.mapping.total_fields.limit` и по умолчанию составляет `1000`.
  
      {% note warning %}
  
      Превышение лимита приведет к ошибке `Limit of total fields [1000] has been exceeded` и остановке трансфера.
  
      {% endnote %}
  
      Чтобы увеличить значение параметра, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому максимальное количество полей в создаваемых индексах будет равно указанному значению.
  
      {% cut "Пример запроса для настройки шаблона" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT "https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_template/index_defaults" \
      --data '
          {
              "index_patterns": "cdc*",
              "settings": {
                  "index": {
                      "mapping": {
                          "total_fields": {
                              "limit": "2000"
                          }
                      }
                  }
              }
          }'
      ```
  
      При такой настройке шаблона все новые индексы с маской `cdc*` смогут содержать до `2000` полей.
  
      {% endcut %}
  
      Для настройки шаблона можно также использовать [интерфейс OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).
  
      Чтобы проверить текущее значение параметра `index.mapping.total_fields.limit`, выполните запрос:
  
      ```bash
      curl \
          --user <имя_пользователя_OpenSearch>:<пароль> \
          --header 'Content-Type: application/json' \
          --request GET 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/<название_индекса>/_settings/*total_fields.limit?include_defaults=true'
      ```
  
  * По умолчанию при трансфере данных в единичный индекс задействуется только один хост. Чтобы распределить нагрузку между хостами при передаче больших объемов данных, [настройте шаблон](https://opensearch.org/docs/latest/im-plugin/index-templates/), по которому создаваемые индексы будут заранее разбиты на шарды.
  
      {% cut "Пример запроса для настройки шаблона" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_template/index_defaults' \
      --data '
          {
              "index_patterns": "cdc*",
              "settings" : {
                  "index" : {
                      "number_of_shards" : 15,
                      "number_of_replicas" : 1
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      При такой настройке шаблона, все новые индексы с маской `cdc*` будут разбиты на `15` шардов.
  
      Для настройки шаблона можно также использовать [интерфейс OpenSearch Dashboards](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).
  
  * Чтобы повысить безопасность и доступность данных, установите политику, которая будет создавать новый индекс при выполнении хотя бы одного из условий (рекомендуемые значения):
  
      * Когда размер индекса превысит 50 ГБ.
      * Когда возраст индекса превысит 30 дней.
  
      Создать и включить политику можно с помощью запросов. Подробнее о политиках см. [в документации OpenSearch](https://opensearch.org/docs/latest/im-plugin/ism/policies/).
  
      {% cut "Пример запроса для создания политики" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_plugins/_ism/policies/rollover_policy' \
      --data '
          {
              "policy": {
                  "description": "Example rollover policy",
                  "default_state": "rollover",
                  "schema_version": 1,
                  "states": [
                      {
                          "name": "rollover",
                          "actions": [
                              {
                                  "rollover": {
                                      "min_index_age": "30d",
                                      "min_primary_shard_size": "50gb"
                                  }
                              }
                          ],
                          "transitions": []
                      }
                  ],
                  "ism_template": {
                      "index_patterns": ["log*"],
                      "priority": 100
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      {% cut "Пример запроса для назначения политике псевдонима" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_index_template/ism_rollover' \
      --data '
          {
              "index_patterns": ["log*"],
              "template": {
                  "settings": {
                      "plugins.index_state_management.rollover_alias": "log"
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      {% cut "Пример запроса для создания индекса с псевдонимом политики" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request PUT 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/log-000001' \
      --data '
          {
              "aliases": {
                  "log": {
                      "is_write_index": true
                  }
              }
          }'
      ```
  
      {% endcut %}
  
      {% cut "Пример запроса для проверки, прикреплена ли политика к индексу" %}
  
      ```bash
      curl \
      --user <имя_пользователя_OpenSearch>:<пароль> \
      --header 'Content-Type: application/json' \
      --request GET 'https://<адрес_хоста_OpenSearch_с_ролью_DATA>:9200/_plugins/_ism/explain/log-000001?pretty'
      ```
  
      {% endcut %}

{% endlist %}

### Приемник PostgreSQL {#target-pg}

{% list tabs %}

- Managed Service for PostgreSQL
    
    1. Убедитесь, что мажорная версия PostgreSQL на приемнике не ниже версии на источнике.
     
    1. При трансфере из PostgreSQL [включите те же расширения](../../managed-postgresql/operations/extensions/cluster-extensions.md) в базе приемника, что и в базе источника.

        Если в базе источника расширения установлены в пользовательскую схему, и эти расширения используются в DDL переносимых объектов, то вручную создайте в приемнике DDL. В этих DDL обращение к функции должно быть без указания схемы. В политике очистки эндпоинта-приемника установите значение `Truncate`, чтобы трансфер не удалил эти объекты.

    1. Выберите политику очистки таблиц трансфера `Drop`.

        Если вы вручную создали в приемнике DDL, используйте политику `Truncate`. При политике `Truncate` эти DDL не будут удалены.

    1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) с доступом к базе приемника.
    
    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:
    
        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя_базы> TO <имя_пользователя>;
        ```
    
       Если база не пустая, то пользователь должен быть ее владельцем (owner):
    
        ```sql
        ALTER DATABASE <имя_базы> OWNER TO <имя_пользователя>;
        ```
    
       После старта трансфер подключится к приемнику от имени этого пользователя.
    1. Если в приемнике включена опция [сохранение границ транзакций](endpoint/target/postgresql.md#additional-settings), выдайте созданному пользователю все привилегии на создание служебной таблицы `__data_transfer_lsn` в [текущей схеме](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (обычно `public`) на приемнике:
    
       ```sql
       GRANT ALL PRIVILEGES ON SCHEMA <имя_схемы> TO <имя_пользователя>;
       ```

    1. Настройте [количество подключений пользователя](../concepts/work-with-endpoints.md#postgresql-connection-limit) к базе данных.

- PostgreSQL
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис Cloud Interconnect](../../interconnect/concepts/index.md) или [VPN](../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом Data Transfer](../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../concepts/network.md#source-external).
    
    1. Убедитесь, что мажорная версия PostgreSQL на приемнике не ниже версии на источнике.
    
    1. Включите те же расширения в базе приемника, что и в базе источника.
    
    1. Убедитесь, что на приемнике выбрана политика очистки `DROP таблиц трансфера`.
    
    1. Создайте пользователя:
    
        ```sql
        CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```
    
    1. Выдайте созданному пользователю все привилегии на базу данных, схемы и переносимые таблицы:
    
        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <имя_базы> TO <имя_пользователя>;
        ```
    
       Если база не пустая, то пользователь должен быть ее владельцем (owner):
    
        ```sql
        ALTER DATABASE <имя_базы> OWNER TO <имя_пользователя>;
        ```
    
       После старта трансфер подключится к приемнику от имени этого пользователя.
    
    1. Если в приемнике включена опция [сохранение границ транзакций](endpoint/target/postgresql.md#additional-settings), выдайте созданному пользователю все привилегии на создание служебной таблицы `__data_transfer_lsn` в [текущей схеме](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (обычно `public`) на приемнике:
    
        ```sql
        GRANT ALL PRIVILEGES ON SCHEMA <имя_схемы> TO <имя_пользователя>;
        ```

    1. Настройте [количество подключений пользователя](../concepts/work-with-endpoints.md#postgresql-connection-limit) к базе данных.

{% endlist %}

Данные, хранящиеся в `MATERIALIZED VIEW`, не переносятся. Для переноса данных из `MATERIALIZED VIEW` создайте обыкновенный `VIEW`, ссылающийся на переносимый `MATERIALIZED VIEW`.

Если определение переносимого `VIEW` содержит вызов `VOLATILE` [функции](https://www.postgresql.org/docs/current/xfunc-volatility.html), то трансфер читает данные из такого `VIEW` с уровнем изоляции `READ UNCOMMITTED`. Консистентность между данными в этом `VIEW` и данными других переносимых объектов не гарантируется. Чтение из `MATERIALIZED VIEW` в определении `VIEW` равносильно вызову `VOLATILE` функции.


### Приемник Yandex Managed Service for YDB {#target-ydb}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `ydb.editor`.
1. Для базы данных в Dedicated-режиме [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.


_Airbyte® является зарегистрированным товарным знаком Airbyte, Inc в США и/или других странах._

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._