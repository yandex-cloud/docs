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

    * `<эндпоинт>` — эндпоинт потока данных {{ yds-short-name }}, например, `https://yds.serverless.yandexcloud.net/{{ region-id }}/b1п89ae43m6he********/etn01eg4rn1********`. Эндпоинт можно посмотреть на странице потока (см. [{#T}](../../data-streams/operations/manage-streams.md#list-data-streams)).
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
