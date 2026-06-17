# Обработка потока изменений Debezium

[Debezium](https://debezium.io) — это сервис для захвата изменений в базах данных (Change Data Capture) и отправки их на обработку в другие системы. С помощью Yandex Data Streams можно захватывать эти изменения и отправлять их в Cloud Functions.

Ниже приведена архитектура решения:
![debezium](../../_assets/data-streams/debezium.png)

## Настройка {#setup}
Для получения потока данных необходимо:
1. [Создать поток данных](#create_stream) Yandex Data Streams.
1. [Настроить реквизиты подключения](#credentials) к Yandex Data Streams.
1. [Настроить и запустить](#debezium_server) Debezium Server.
1. [Настроить триггер](#sftrigger) в Cloud Functions для обработки данных.

### Создание потока данных {#create_stream}

Создайте поток данных Yandex Data Streams с именем `debezium`. Процедура создания потока данных подробно описана в [документации Yandex Data Streams](../operations/manage-streams.md)

### Настройка реквизитов подключения к Yandex Data Streams {#credentials}

1. Войдите в [консоль управления](https://console.yandex.cloud). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
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
        * `Default region name [None]:` — зону доступности `ru-central1`.

### Настройка Debezium Server {#debezium_server}

В этом примере рассматривается взаимодействие Debezium и PostgreSQL. Далее будем считать, что Debezium будет устанавливаться на сервере, где запущен PostgreSQL.

1. Установите Debezium Server по [инструкции](https://debezium.io/documentation/reference/stable/operations/debezium-server.html).
1. Перейдите в каталог `conf` и создайте файл `application.properties` со следующим содержимым:

    ```text
    debezium.sink.type=kinesis
    debezium.sink.kinesis.region=ru-central1
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

    * `<эндпоинт>` — эндпоинт потока данных Data Streams, например, `https://yds.serverless.yandexcloud.net/ru-central1/b1g89ae43m6he********/etn01eg4rn1********`. Эндпоинт можно посмотреть на странице потока (смотрите [Посмотреть список потоков](../operations/manage-streams.md#list-data-streams)).
    * `<поток_данных>` — название потока данных Data Streams.
    * `<имя_БД>` — название базы данных PostgreSQL.
    * `<имя_пользователя>` — имя пользователя для подключения к базе данных PostgreSQL.
    * `<пароль_пользователя>` — пароль пользователя для подключения к базе данных PostgreSQL.
1. Запустите Debezium следующей командой:

    ```bash
    JAVA_OPTS=-Daws.cborEnabled=false ./run.sh
    ```

1. Выполните какие-либо изменения в базе данных PostgreSQL, например, вставьте данные в таблицу.
1. При правильной настройке в консоли Debezium появятся сообщения вида:

    ```text
    2022-02-11 07:31:12,850 INFO  [io.deb.con.com.BaseSourceTask] (pool-7-thread-1) 1 records sent during previous 00:19:59.999, last recorded offset: {transaction_id=null, lsn_proc=23576408, lsn_commit=23576120, lsn=23576408, txId=580, ts_usec=1644564672582666}
    ```

## Настроить триггер в Cloud Functions {#sftrigger}

Создайте триггер в Cloud Functions к потоку данных Yandex Data Streams `debezium`, который был создан выше. 

Процедура создания триггера подробно описана в [документации Cloud Functions](../../functions/concepts/trigger/data-streams-trigger.md).

В триггер Cloud Functions будут отправлять нотификации обо всех изменениях в базе данных. В коде триггера вы можете обработать эти изменения, реализовав любую необходимую программную обработку.