# Обработка потока изменений Debezium

[Debezium](https://debezium.io) — это сервис для захвата изменений в базах данных (Change Data Capture) и отправки их на обработку в другие системы. С помощью {{ yds-full-name }} можно захватывать эти изменения и отправлять их в {{ sf-name }}.

Ниже приведена архитектура решения:
![debezium](../../_assets/data-streams/debezium.png)

## Настройка {#setup}
Для получения потока данных необходимо:
1. [Создать поток данных](#create_stream) {{ yds-full-name }}.
1. [Настроить реквизиты подключения](#credentials) к {{ yds-full-name }}.
1. [Настроить и запустить](#debezium_server) Debezium Server.
1. [Настроить триггер](#sftrigger) в {{ sf-name }} для обработки данных.

### Создание потока данных {#create_stream}

Создайте поток данных {{ yds-full-name }} с именем `debezium`. Процедура создания потока данных подробно описана в [документации {{ yds-full-name }}](../operations/manage-streams.md)

### Настройка реквизитов подключения к {{ yds-full-name }} {#credentials}

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роль `editor` на ваш каталог.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.
1. Настройте AWS CLI:
    1. Установите [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) и выполните команду:

        ```bash
        aws configure
        ```

    1. Последовательно введите:

        * `AWS Access Key ID [None]:` — [идентификатор ключа](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `AWS Secret Access Key [None]:` — [секретный ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `Default region name [None]:` — зону доступности `{{ region-id }}`.

### Настройка Debezium Server {#debezium_server}

В этом примере рассматривается взаимодействие Debezium и {{ PG }}. Далее будем считать, что Debezium будет устанавливаться на сервере, где запущен {{ PG }}.

1. Установите Debezium Server по [инструкции](https://debezium.io/documentation/reference/stable/operations/debezium-server.html).
1. Перейдите в каталог `conf` и создайте файл `application.properties` со следующим содержимым:

    ```text
    debezium.sink.type=kinesis
    debezium.sink.kinesis.region={{ region-id }}
    debezium.sink.kinesis.endpoint=<эндпоинт>
    debezium.source.connector.class=io.debezium.connector.postgresql.PostgresConnector
    debezium.source.offset.storage.file.filename=data/offsets.dat
    debezium.source.offset.flush.interval.ms=0
    debezium.source.database.hostname=localhost
    debezium.source.database.port=5432
    debezium.source.database.user=<имя_пользователя>
    debezium.source.database.password=<пароль_пользователя>
    debezium.source.database.dbname=<имя_БД>
    debezium.source.database.server.name=debezium
    debezium.source.plugin.name=pgoutput

    debezium.source.transforms=Reroute
    debezium.source.transforms.Reroute.type=io.debezium.transforms.ByLogicalTableRouter
    debezium.source.transforms.Reroute.topic.regex=(.*)
    debezium.source.transforms.Reroute.topic.replacement=<поток_данных>
    ```

    Где:

    * `<эндпоинт>` — эндпоинт потока данных {{ yds-short-name }}, например, `https://yds.serverless.yandexcloud.net/{{ region-id }}/b1g89ae43m6he********/etn01eg4rn1********`. Эндпоинт можно посмотреть на странице потока (см. [{#T}](../operations/manage-streams.md#list-data-streams)).
    * `<поток_данных>` — название потока данных {{ yds-short-name }}.
    * `<имя_БД>` — название базы данных {{ PG }}.
    * `<имя_пользователя>` — имя пользователя для подключения к базе данных {{ PG }}.
    * `<пароль_пользователя>` — пароль пользователя для подключения к базе данных {{ PG }}.
1. Запустите Debezium следующей командой:

    ```bash
    JAVA_OPTS=-Daws.cborEnabled=false ./run.sh
    ```

1. Выполните какие-либо изменения в базе данных PostgreSQL, например, вставьте данные в таблицу.
1. При правильной настройке в консоли Debezium появятся сообщения вида:

    ```text
    2022-02-11 07:31:12,850 INFO  [io.deb.con.com.BaseSourceTask] (pool-7-thread-1) 1 records sent during previous 00:19:59.999, last recorded offset: {transaction_id=null, lsn_proc=23576408, lsn_commit=23576120, lsn=23576408, txId=580, ts_usec=1644564672582666}
    ```

## Настроить триггер в {{ sf-name }} {#sftrigger}

Создайте триггер в {{ sf-name }} к потоку данных {{ yds-full-name }} `debezium`, который был создан выше. 

Процедура создания триггера подробно описана в [документации {{ sf-name }}](../../functions/concepts/trigger/data-streams-trigger.md).

В триггер {{ sf-name }} будут отправлять нотификации обо всех изменениях в базе данных. В коде триггера вы можете обработать эти изменения, реализовав любую необходимую программную обработку.