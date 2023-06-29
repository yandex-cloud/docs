1. Install the Debezium Server by following this [guide](https://debezium.io/documentation/reference/stable/operations/debezium-server.html).
1. Go to the `conf` folder and create the file `application.properties` with the following content:

   ```text
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

   * `<YDS_STREAM_ENDPOINT>`: Endpoint for a {{ yds-short-name }} stream, such as `https://yds.serverless.yandexcloud.net/{{ region-id }}/b1п89ae43m6he2ooql88r/etn01eg4rn184nemdbb`. You can find the endpoint on the stream page (see [{#T}](../../data-streams/operations/manage-streams.md#list-data-streams)).
   * `<YDS_STREAM_NAME>`: Name of the {{ yds-short-name }} stream.
   * `<DATABASE_NAME>`: {{ PG }} database name.
   * `<DATABASE_USER>`: Username for connecting to the {{ PG }} database.
   * `<DATABASE_PASSWORD>`: User password for connecting to the {{ PG }} database.
1. Run Debezium using this command:

   ```bash
   JAVA_OPTS=-Daws.cborEnabled=false ./run.sh
   ```

1. Make some changes to the PostgreSQL database, such as insert data into a table.
1. If the settings are correct, the Debezium console will show messages like:

   ```text
   2022-02-11 07:31:12,850 INFO  [io.deb.con.com.BaseSourceTask] (pool-7-thread-1) 1 records sent during previous 00:19:59.999, last recorded offset: {transaction_id=null, lsn_proc=23576408, lsn_commit=23576120, lsn=23576408, txId=580, ts_usec=1644564672582666}
   ```
