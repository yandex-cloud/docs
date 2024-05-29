1. Install the Debezium Server by following this [guide](https://debezium.io/documentation/reference/stable/operations/debezium-server.html).
1. Go to the `conf` folder and create the file `application.properties` with the following content:

   ```text
   debezium.sink.type=kinesis
   debezium.sink.kinesis.region={{ region-id }}
   debezium.sink.kinesis.endpoint=<endpoint>
   debezium.source.connector.class=io.debezium.connector.postgresql.PostgresConnector
   debezium.source.offset.storage.file.filename=data/offsets.dat
   debezium.source.offset.flush.interval.ms=0
   debezium.source.database.hostname=localhost
   debezium.source.database.port=5432
   debezium.source.database.user=<username>
   debezium.source.database.password=<user_password>
   debezium.source.database.dbname=<DB_name>
   debezium.source.database.server.name=debezium
   debezium.source.plugin.name=pgoutput

   debezium.source.transforms=Reroute
   debezium.source.transforms.Reroute.type=io.debezium.transforms.ByLogicalTableRouter
   debezium.source.transforms.Reroute.topic.regex=(.*)
   debezium.source.transforms.Reroute.topic.replacement=<data_stream>
   ```

   Where:

   * `<endpoint>`: Endpoint for a {{ yds-short-name }} data stream, e.g., `https://yds.serverless.yandexcloud.net/{{ region-id }}/b1g89ae43m6he********/etn01eg4rn1********`. You can find the endpoint on the stream page (see [{#T}](../../data-streams/operations/manage-streams.md#list-data-streams)).
   * `<data_stream>`: {{ yds-short-name }} data stream name.
   * `<DB_name>`: {{ PG }} database name.
   * `<username>`: Username for connecting to the {{ PG }} database.
   * `<user_password>`: User password for connecting to the {{ PG }} database.
1. Run Debezium using this command:

   ```bash
   JAVA_OPTS=-Daws.cborEnabled=false ./run.sh
   ```

1. Make some changes to the PostgreSQL database, such as insert data into a table.
1. If the settings are correct, the Debezium console will show messages like:

   ```text
   2022-02-11 07:31:12,850 INFO  [io.deb.con.com.BaseSourceTask](pool-7-thread-1) 1 records sent during previous 00:19:59.999, last recorded offset: {transaction_id=null, lsn_proc=23576408, lsn_commit=23576120, lsn=23576408, txId=580, ts_usec=1644564672582666}
   ```
