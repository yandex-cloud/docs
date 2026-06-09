# Обработка потока изменений Debezium

[Debezium](https://debezium.io) — это сервис для захвата изменений в базах данных и отправки их на обработку в другие системы. С помощью Yandex Data Streams можно захватывать эти изменения, а с помощью Yandex Query выполнять их обработку. Обработанные данные можно:

* отправить в Yandex Monitoring для построения графика и алертинга;
* записать в поток Data Streams и далее отправить на обработку в Yandex Cloud Functions;
* записать в поток Data Streams и далее передать в Yandex Data Transfer [для отправки в различные системы хранения](../../data-streams/tutorials/data-ingestion.md).

![debezium-architecture](../../_assets/query/debezium-architecture.png)

В этом сценарии вы отправите изменения базы данных [PostgreSQL](https://www.postgresql.org/) в поток Data Streams с помощью Debezium, а затем выполните к ним запрос с помощью Query. В результате выполнения запроса вы получите количество изменений в таблицах БД, сгруппированное по интервалам продолжительностью 10 секунд. Рассматривается установка Debezium на сервер, где уже установлена и запущена PostgreSQL.

Для выполнения сценария:

1. [Создайте поток данных Data Streams](#create-yds-stream).
1. [Настройте реквизиты подключения к потоку](#credentials).
1. [Настройте Debezium Server](#debezium-server).
1. [Подключите Query к потоку данных](#connect-query).
1. [Выполните запрос к данным](#query).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Создайте поток данных Data Streams {#create-yds-stream}

[Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream) c именем `debezium`.

## Настройте реквизиты подключения к потоку {#credentials}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роль `editor` на ваш каталог.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.
1. На сервере, где уже установлена и запущена PostgreSQL, настройте [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html):
    1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) и выполните команду:

        ```bash
        aws configure
        ```

    1. Последовательно введите:

        * `AWS Access Key ID [None]:` — [идентификатор ключа](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `AWS Secret Access Key [None]:` — [секретный ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `Default region name [None]:` — зону доступности `ru-central1`.

## Настройте Debezium Server {#debezium-server}

На сервере, где уже установлена и запущена PostgreSQL:

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

    * `<эндпоинт>` — эндпоинт потока данных Data Streams, например, `https://yds.serverless.yandexcloud.net/ru-central1/b1g89ae43m6he********/etn01eg4rn1********`. Эндпоинт можно посмотреть на странице потока (см. [Посмотреть список потоков](../../data-streams/operations/manage-streams.md#list-data-streams)).
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

## Подключите Query к потоку данных {#connect-query}

1. [Создайте соединение](../operations/connection.md#create) с именем `yds-connection` и типом `Data Streams`.
1. На странице создания привязки:
    * Введите имя привязки `debezium`.
    * Укажите поток данных `cdebezium`.
    * Добавьте колонку `data` с типом `JSON`.
1. Нажмите кнопку **Создать**.

## Выполните запрос к данным {#query}

В редакторе запросов в интерфейсе Query выполните следующий запрос:

```sql
$debezium_data = 
SELECT 
    JSON_VALUE(data,"$.payload.source.table") AS table_name, 
    DateTime::FromMilliseconds(cast(JSON_VALUE(data,"$.payload.source.ts_ms") AS Uint64)) AS `timestamp`
FROM bindings.`debezium`;

SELECT 
    table_name, 
    HOP_END() 
FROM 
    $debezium_data 
GROUP BY 
    HOP(`timestamp`, "PT10S", "PT10S", "PT10S"),
    table_name
LIMIT 2;
```

{% note info %}

Данные из потокового источника передаются в виде бесконечного потока. Чтобы остановить обработку и получить результат в консоли, данные в примере ограничены с помощь оператора `LIMIT`, который задает количество строк результата.

{% endnote %}

## См. также {#see-also}

* [Чтение данных из Data Streams с помощью соединений в Query](../sources-and-sinks/data-streams.md).