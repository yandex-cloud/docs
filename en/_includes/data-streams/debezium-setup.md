1. This example examines the interaction of Debezium and PostgreSQL. Next, we will assume that Debezium will be installed on the server where PostgreSQL is running. Install Debezium server according to [instructions](https://debezium.io/documentation/reference/stable/operations/debezium-server.html).
1. Go to the `conf` folder and create the `application.properties` file with the following content:
    ```
    debezium.sink.type=kinesis
    debezium.sink.kinesis.region={{ region-id }}
    debezium.sink.kinesis.endpoint=<YDS_STREAM_ENDPOINT>
    debezium.source.connector.class=io.debezium.connector.postgresql.PostgresConnector
    debezium.source.offset.storage.file.filename=data/offsets.dat
    debezium.source.offset.flush.interval.ms=0
    debezium.source.database.hostname=localhost
    debezium.source.database.port=5432
    debezium.source.database.user=<DATABASE_USER>
    debezium.source.database.password=<DATABASE_PASSWORD>
    debezium.source.database.dbname=<DATABASE_NAME>
    debezium.source.database.server.name=debezium
    debezium.source.plugin.name=pgoutput

    debezium.source.transforms=Reroute
    debezium.source.transforms.Reroute.type=io.debezium.transforms.ByLogicalTableRouter
    debezium.source.transforms.Reroute.topic.regex=(.*)
    debezium.source.transforms.Reroute.topic.replacement=<YDS_STREAM_NAME>
    ```

    Where:

    * `<YDS_STREAM_ENDPOINT>`: Full endpoint to the data stream, for example, `https://yds.serverless.yandexcloud.net/{{ region-id }}/b1n89ae43m6he2ooql88r/etn01eg4rn184nemdbb`. The full endpoint is available in the {{yds-full-name}} UI. To view the full endpoint, click **Connect**.
    * `<YDS_STREAM_NAME>`: Data stream name.
    * `<DATABASE_NAME>`: Name of the PostgreSQL database.
    * `<DATABASE_USER>`: User name for connecting to the PostgreSQL database.
    * `<DATABASE_PASSWORD>`: User password for connecting to the PostgreSQL database.
1. Run Debezium with the following command: 
    ```shell
    JAVA_OPTS=-Daws.cborEnabled=false ./run.sh
    ```
1. Make any changes to the PostgreSQL database, for example, insert data into a table.
1. If configured correctly, the following messages will appear in the Debezium console:
    ```
    2022-02-11 07:31:12,850 INFO  [io.deb.con.com.BaseSourceTask] (pool-7-thread-1) 1 records sent during previous 00:19:59.999, last recorded offset: {transaction_id=null, lsn_proc=23576408, lsn_commit=23576120, lsn=23576408, txId=580, ts_usec=1644564672582666}
    ```
    