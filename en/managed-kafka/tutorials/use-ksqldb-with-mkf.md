# Delivering data to ksqlDB

ksqlDB is a database designed for stream processing messages from {{ KF }} topics. Working with message streams in ksqlDB is similar to working with tables in a regular database. The ksqlDB table is automatically updated with data from a topic, and the data that you add to the ksqlDB table is sent to the {{ KF }} topic. For more information, see the [ksqlDB documentation](https://docs.ksqldb.io/en/latest).

To set up data delivery from {{ mkf-name }} to ksqlDB:
1. [Set up {{ KF }} integration for the ksqlDB database](#configure-ksqldb-for-kf).
1. [Review the format of the data coming from {{ mkf-name }}](#explore-kf-data-format).
1. [Create a table in ksqlDB to capture the data stream from the {{ KF }} topic](#create-kf-table).
1. [Get test data from the {{ mkf-name }} cluster](#get-data-from-kf)
1. [Write the test data to ksqlDB](#insert-data-to-ksqldb).
1. [Check that the test data is present in the {{ KF }} topic](#fetch-data-from-kf).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration.

   * If the ksqlDB server is hosted on the internet, create a publicly accessible {{ mkf-name }} cluster.
   
   * If the ksqlDB server is hosted in {{ yandex-cloud }}, create a {{ mkf-name }} cluster on the same [cloud network](../../vpc/concepts/network.md) as ksqlDB.


1. [Create topics](../../managed-kafka/operations/cluster-topics.md#create-topic) in a {{ mkf-name }} cluster:
   1. A service topic named `_confluent-ksql-default__command_topic` with the following settings:
      * Replication factor: `1`.
      * Number of partitions: `1`.
      * Log cleanup policy: `Delete`.
      * Log retention, ms: `-1`.
      * Minimum number of in-sync replicas: `1`.
   1. A service topic named `default_ksql_processing_log`. It may have any settings.
   1. A topic for data storage named `locations`. It may have any settings.

1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-user) named `ksql` and assign it the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` roles for all the previously created topics.

1. Check that you can connect to the ksqlDB server.

1. Install the `kafkacat` utility on the ksqlDB server and check that you can use it to [connect to the {{ mkf-name }} cluster over SSL](../../managed-kafka/operations/connect.md#get-ssl-cert).

1. Install the [jq](https://stedolan.github.io/jq/) utility for stream processing JSON files on the ksqlDB server.

## Set up {{ KF }} integration for the ksqlDB database {#configure-ksqldb-for-kf}

1. Connect to the ksqlDB server.
1. Add the server's SSL certificate to the Java trusted certificate store (Java Key Store) so that ksqlDB can use this certificate for secure connections to the cluster hosts. Make sure to set the password using the `-storepass` parameter for additional storage protection:

   ```bash
   cd /etc/ksqldb && \
   sudo keytool -importcert -alias {{ crt-alias }} -file {{ crt-local-dir }}{{ crt-local-file }} \
   -keystore ssl -storepass <certificate store password> \
   --noprompt
   ```

1. In the ksqlDB `/etc/ksqldb/ksql-server.properties` configuration file, specify the credentials to authenticate in the {{ mkf-name }} cluster:

   ```ini
   bootstrap.servers=<broker 1 FQDN:9091, ..., broker N FQDN:9091>
   sasl.mechanism=SCRAM-SHA-512
   security.protocol=SASL_SSL
   ssl.truststore.location=/etc/ksqldb/ssl
   ssl.truststore.password=<certificate store password>
   sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="ksql" password="<ksql user password>";
   ```

   The broker FQDNs can be requested with a [list of cluster hosts](../operations/cluster-hosts.md#list-hosts), and the cluster name can be requested with a [list of clusters in the folder](../operations/cluster-list.md#list-clusters).

1. Restart the ksqlDB service with the command below:

   ```bash
   sudo systemctl restart confluent-ksqldb.service
   ````

## Review the format of the data coming from {{ mkf-name }} {#explore-kf-data-format}

Processing data streams from {{ mkf-name }} depends on the data representation format in {{ KF }} messages.

In the example, geodata is written to the {{ KF }} `locations` topic in JSON format:
* `profileId`: Identifier.
* `latitude`: Latitude.
* `longitude`: Longitude.

This data will be transmitted as {{ KF }} messages. Each message will contain a JSON object as the following string:

```json
{"profileId": "c2309eec", "latitude": 37.7877, "longitude": -122.4205}
```

ksqlDB stores the values of the corresponding parameters from {{ KF }} messages in a three-column table.

Next, we'll configure the fields of a ksqlDB data stream table.

## Create a table in ksqlDB to capture the data stream from the {{ KF }} topic {#create-kf-table}

Create a table in ksqlDB for writing data from the {{ KF }} topic. The table structure matches the [format of the data](#explore-kf-data-format) from {{ mkf-name }}:
1. Connect to the ksqlDB server.
1. Run the `ksql` client with the command:

   ```bash
   ksql http://0.0.0.0:8088
   ```

1. Run the following query:

   ```sql
   CREATE STREAM riderLocations
   (
     profileId VARCHAR,
     latitude DOUBLE,
     longitude DOUBLE
   ) WITH
   (
     kafka_topic='locations',
     value_format='json',
     partitions=<number of "locations" topic partitions>
   );
   ```

   This data stream table will be automatically populated with messages from the {{ mkf-name }} cluster `locations` topic. KsqlDB uses the `ksql` user [settings](#configure-ksqldb-for-kf) to read messages.

   For more information about creating a data stream table in the ksqlDB engine, see the [ksqlDB documentation](https://www.confluent.io/blog/how-real-time-stream-processing-works-with-ksqldb).

1. Run the following query:

   ```sql
   SELECT * FROM riderLocations WHERE
            GEO_DISTANCE(latitude, longitude, 37.4133, -122.1162) <= 5
            EMIT CHANGES;
   ```

   The query waits for real-time data to appear in the table.

## Get test data from the {{ mkf-name }} cluster {#get-data-from-kf}

1. Connect to the ksqlDB server.
1. Create a `sample.json` file with the following test data:

   ```json
   {
     "profileId": "c2309eec",
     "latitude": 37.7877,
     "longitude": -122.4205
   }

   {
     "profileId": "4ab5cbad",
     "latitude": 37.3952,
     "longitude": -122.0813
   }

   {
     "profileId": "4a7c7b41",
     "latitude": 37.4049,
     "longitude": -122.0822
   }   
   ```

1. Send the `sample.json` file to the `locations` topic of the {{ mkf-name }} cluster using `jq` and `kafkacat`:

   ```bash
   jq -rc . sample.json | kafkacat -P \
      -b <broker 1 FQDN:9091, ..., broker N FQDN:9091> \
      -t locations \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username=ksql \
      -X sasl.password="<ksql user password>" \
      -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
   ```

   Information is sent using the `ksql` user. To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../operations/connect.md).

1. Make sure that the [session](#create-kf-table) displays the data sent to the topic:

   ```text
   +--------------------------+--------------------------+------------------------+
   |PROFILEID                 |LATITUDE                  |LONGITUDE               |
   +--------------------------+--------------------------+------------------------+
   |4ab5cbad                  |37.3952                   |-122.0813               |
   |4a7c7b41                  |37.4049                   |-122.0822               |
   ```

  Data is read using the `ksql` user.

## Write the test data to ksqlDB {#insert-data-to-ksqldb}

1. Connect to the ksqlDB server.
1. Run the `ksql` client with the command:

   ```bash
   ksql http://0.0.0.0:8088
   ```

1. Insert the test data into the `riderLocations` table:

   ```sql
   INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('18f4ea86', 37.3903, -122.0643);
   INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('8b6eae59', 37.3944, -122.0813);
   INSERT INTO riderLocations (profileId, latitude, longitude) VALUES ('4ddad000', 37.7857, -122.4011);
   ```

   This data is sent synchronously to the {{ KF }} `locations` topic using the `ksql` user.

## Check that the test data is present in the {{ KF }} topic {#fetch-data-from-kf}

1. Connect to the ksqlDB server.
1. Check the messages in the `locations` topic of the {{ mkf-name }} cluster using `kafkacat` and the `ksql` user:

   ```bash
   kafkacat -C \
    -b <broker 1 FQDN:9091, ..., broker N FQDN:9091> \
    -t locations \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanisms=SCRAM-SHA-512 \
    -X sasl.username=ksql \
    -X sasl.password="<ksql user password>" \
    -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
   ```

1. Make sure that the console displays the messages you [inserted into the table](#insert-data-to-ksqldb).

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md).
* If you reserved a public static IP for your virtual machine, [delete it](../../vpc/operations/address-delete.md).
* [Delete the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-delete.md).
