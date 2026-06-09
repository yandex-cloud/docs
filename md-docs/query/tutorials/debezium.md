# Обработка потока изменений Debezium

[Debezium](https://debezium.io) — это сервис для захвата изменений в базах данных и отправки их на обработку в другие системы. С помощью {{ yds-full-name }} можно захватывать эти изменения, а с помощью {{ yq-full-name }} выполнять их обработку. Обработанные данные можно:

* отправить в {{ monitoring-full-name }} для построения графика и алертинга;
* записать в поток {{ yds-short-name }} и далее отправить на обработку в {{ sf-full-name }};
* записать в поток {{ yds-short-name }} и далее передать в {{ data-transfer-full-name }} [для отправки в различные системы хранения](../../data-streams/tutorials/data-ingestion.md).

![debezium-architecture](../../_assets/query/debezium-architecture.png)

В этом сценарии вы отправите изменения базы данных [{{ PG }}](https://www.postgresql.org/) в поток {{ yds-short-name }} с помощью Debezium, а затем выполните к ним запрос с помощью {{ yq-name }}. В результате выполнения запроса вы получите количество изменений в таблицах БД, сгруппированное по интервалам продолжительностью 10 секунд. Рассматривается установка Debezium на сервер, где уже установлена и запущена {{ PG }}.

Для выполнения сценария:

1. [Создайте поток данных {{ yds-name }}](#create-yds-stream).
1. [Настройте реквизиты подключения к потоку](#credentials).
1. [Настройте Debezium Server](#debezium-server).
1. [Подключите {{ yq-name }} к потоку данных](#connect-query).
1. [Выполните запрос к данным](#query).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Создайте поток данных {{ yds-name }} {#create-yds-stream}

[Создайте поток данных](../../data-streams/operations/manage-streams.md#create-data-stream) c именем `debezium`.

## Настройте реквизиты подключения к потоку {#credentials}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роль `editor` на ваш каталог.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.
1. На сервере, где уже установлена и запущена {{ PG }}, настройте [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html):
    1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) и выполните команду:

        ```bash
        aws configure
        ```

    1. Последовательно введите:

        * `AWS Access Key ID [None]:` — [идентификатор ключа](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `AWS Secret Access Key [None]:` — [секретный ключ](../../iam/concepts/authorization/access-key.md) сервисного аккаунта.
        * `Default region name [None]:` — зону доступности `{{ region-id }}`.

## Настройте Debezium Server {#debezium-server}

На сервере, где уже установлена и запущена PostgreSQL:

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

    * `<эндпоинт>` — эндпоинт потока данных {{ yds-short-name }}, например, `https://yds.serverless.yandexcloud.net/{{ region-id }}/b1g89ae43m6he********/etn01eg4rn1********`. Эндпоинт можно посмотреть на странице потока (см. [{#T}](../../data-streams/operations/manage-streams.md#list-data-streams)).
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

## Подключите {{ yq-name }} к потоку данных {#connect-query}

1. [Создайте соединение](../operations/connection.md#create) с именем `yds-connection` и типом `{{ ui-key.yql.yq-connection.action_datastreams }}`.
1. На странице создания привязки:
    * Введите имя привязки `debezium`.
    * Укажите поток данных `cdebezium`.
    * Добавьте колонку `data` с типом `JSON`.
1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Выполните запрос к данным {#query}

В редакторе запросов в интерфейсе {{ yq-name }} выполните следующий запрос:

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

* [{#T}](../sources-and-sinks/data-streams.md).