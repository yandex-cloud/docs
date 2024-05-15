# Delivering data from {{ mpg-full-name }} to {{ mkf-full-name }} using Debezium

You can track data changes in {{ mpg-name }} and send them to {{ mkf-name }} using Change Data Capture (CDC).

In this article, you will learn how to create a virtual machine in {{ yandex-cloud }} and set up [Debezium](https://debezium.io/documentation/reference/index.html), software used for CDC.

## Getting started {#before-you-begin}

1. [Create a _source cluster_](../../managed-postgresql/operations/cluster-create.md) with the following settings:

   * Hosts: Publicly available
   * Database: `db1`
   * User: `user1`

1. [Create a {{ mkf-name }} _target cluster_](../../managed-kafka/operations/cluster-create.md) in any applicable configuration with publicly available hosts.

1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) with [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) and a public IP address.


1. If you are using security groups, configure them to enable connecting to the clusters both from the internet and from the created VM. In addition, enable connecting to this VM over SSH from the internet:

   * [Configuring {{ mkf-name }} cluster security groups](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
   * [Configuring {{ mpg-name }} cluster security groups](../../managed-postgresql/operations/connect.md#configuring-security-groups).


1. [Connect to a virtual machine over SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) and perform preliminary setup:

   1. Install the dependencies:

      ```bash
      sudo apt update && \
          sudo apt install kafkacat openjdk-17-jre postgresql-client --yes
      ```

   1. Create a folder for {{ KF }}:

      ```bash
      sudo mkdir -p /opt/kafka/
      ```

   1. Download and unpack the archive with {{ KF }} executable files in this folder. For example, to download and unpack {{ KF }} 3.0, run the command:

      ```bash
      wget https://archive.apache.org/dist/kafka/3.0.0/kafka_2.13-3.0.0.tgz && \
      sudo tar xf kafka_2.13-3.0.0.tgz --strip 1 --directory /opt/kafka/
      ```

      You can check the current {{ KF }} version on the [page with project downloads](https://kafka.apache.org/downloads).

   1. Install certificates on the VM and check the availability of clusters:

      * [{{ mkf-name }}](../../managed-kafka/operations/connect/clients.md) (use `kafkacat`).
      * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#get-ssl-cert) (use `psql`).

   1. Create a folder that will store the files required for the operation of the Debezium connector:

      ```bash
      sudo mkdir -p /etc/debezium/plugins/
      ```

   1. The Debezium connector can connect to {{ mkf-name }} broker hosts if an SSL certificate is added to Java secure storage (Java Key Store). For added storage security, add a password that is at least 6 characters long to the `-storepass` parameter:

      ```bash
      sudo keytool \
          -importcert \
          -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/{{ crt-local-file }} \
          -keystore /etc/debezium/keystore.jks \
          -storepass <JKS_password> \
          --noprompt
      ```

## Preparing the source cluster {#prepare-source}

1. [Assign to the user](../../managed-postgresql/operations/grant.md) `user1` the role `mdb_replication`.

   This is necessary to create a publication for Debezium to monitor changes in a {{ mpg-name }} cluster.

1. [Connect to the `db1` database](../../managed-postgresql/operations/connect.md) on behalf of `user1`.

1. Add test data to the database. In this example, a simple table with information from car sensors is used.

   Create a table:

   ```sql
   CREATE TABLE public.measurements (
       "device_id" text PRIMARY KEY NOT NULL,
       "datetime" timestamp NOT NULL,
       "latitude" real NOT NULL,
       "longitude" real NOT NULL,
       "altitude" real NOT NULL,
       "speed" real NOT NULL,
       "battery_voltage" real,
       "cabin_temperature" real NOT NULL,
       "fuel_level" real
   );
   ```

   Populate the table with data:

   ```sql
   INSERT INTO public.measurements VALUES
       ('iv9a94th6rzt********', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
       ('rhibbh3y08qm********', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
       ('iv9a94th678t********', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
   ```

1. Create a publication for the table:

   ```sql
   CREATE PUBLICATION mpg_publication FOR TABLE public.measurements;
   ```

## Configure Debezium {#setup-debezium}

1. Connect to the virtual machine over SSH.

1. Download and unpack a proper [Debezium connector](https://debezium.io/releases/) to the folder `/etc/debezium/plugins/`.

   You can check the current connector version on the [project page](https://debezium.io/releases/). The commands for version `1.9.4.Final` are below.

   ```bash
   VERSION="1.9.4.Final"
   wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/${VERSION}/debezium-connector-postgres-${VERSION}-plugin.tar.gz && \
   sudo tar -xzvf debezium-connector-postgres-${VERSION}-plugin.tar.gz -C /etc/debezium/plugins/
   ```

1. Create the file `/etc/debezium/mdb-connector.conf` with Debezium connector settings for connecting to the source cluster:

   ```ini
   name=debezium-mpg
   connector.class=io.debezium.connector.postgresql.PostgresConnector
   plugin.name=pgoutput
   database.hostname=c-<cluster_ID>.rw.{{ dns-zone }}
   database.port=6432
   database.user=user1
   database.password=<user1_password>
   database.dbname=db1
   database.server.name=mpg
   table.include.list=public.measurements
   publication.name=mpg_publication
   slot.name=debezium_slot
   heartbeat.interval.ms=15000
   heartbeat.topics.prefix=__debezium-heartbeat
   snapshot.mode=always
   ```

   Where:

   * `name`: Logical name of the Debezium connector. Used for the connector's internal needs.
   * `database.hostname`: [Special FQDN](../../managed-postgresql/operations/connect.md#fqdn-master) to connect to the source cluster master host.

      You can get the cluster ID with a [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list).

   * `database.user`: {{ PG }} username.
   * `database.dbname`: {{ PG }} database name.
   * `database.server.name`: Name of the database server that [Debezium will use](#prepare-target) when choosing a topic for sending messages.
   * `table.include.list`: Names of tables for which Debezium should track changes. Specify full names that include the schema name (default: `public`). [Debezium will use](#prepare-target) values from this field when selecting a topic for sending messages.
   * `publication.name`: Name of the publication [created on the source cluster](#prepare-source).
   * `slot.name`: Name of the replication slot that will be created by Debezium when working with the publication.
   * `heartbeat.interval.ms` and `heartbeat.topics.prefix`: Heartbeat settings [required for](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-wal-disk-space) Debezium.
   * `snapshot.mode`: [Type of the snapshot created](https://debezium.io/documentation/reference/stable/connectors/postgresql.html#postgresql-connector-snapshot-mode-options) at connector startup. For the connector to run properly, set this parameter to `always`.

## Prepare the target cluster{#prepare-target}

1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) to store data from the source cluster:

   * **{{ ui-key.yacloud.common.name }}**: `mpg.public.measurements`.

      Data topic names [follow](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names) the `<server_name>.<schema_name>.<table_name>` convention.

      According to the [Debezium configuration file](#setup-debezium):

      * The name of the `mpg` server is specified in the `database.server.name parameter`.
      * The name of the `public` schema is specified together with the name of the `measurements` table in the `table.include.list` parameter.

   If you need to track data changes in multiple tables, create a separate topic for each one of them.

1. Create a service topic to track the connector status:

   * **{{ ui-key.yacloud.common.name }}**: `__debezium-heartbeat.mpg`.

      Names for service topics [follow](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-property-heartbeat-topics-prefix) the `<prefix_for_heartbeat>.<server_name>` convention.

      According to the [Debezium configuration file](#setup-debezium):

      * The `__debezium-heartbeat` prefix is specified in the `heartbeat.topics.prefix` parameter.
      * The name of the `mpg` server is specified in the `database.server.name parameter`.

   * **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}**: `Compact`.

   If you need data from multiple source clusters, create a separate service topic for each of them.

1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `debezium`.

1. [Grant to the `debezium` user the rights](../../managed-kafka/operations/cluster-accounts.md#grant-permission) `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` to the created topics.

## Start Debezium {#run-connector}

1. Create a file with Debezium worker settings:

   `/etc/debezium/worker.conf`

   ```ini
   # AdminAPI connect properties
   bootstrap.servers=<FQDN_of_broker_host_1>:9091,...,<FQDN_of_broker_host_N>:9091
   sasl.mechanism=SCRAM-SHA-512
   security.protocol=SASL_SSL
   ssl.truststore.location=/etc/debezium/keystore.jks
   ssl.truststore.password=<JKS_password>
   sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<debezium_user_password>";

   # Producer connect properties
   producer.sasl.mechanism=SCRAM-SHA-512
   producer.security.protocol=SASL_SSL
   producer.ssl.truststore.location=/etc/debezium/keystore.jks
   producer.ssl.truststore.password=<JKS_password>
   producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<debezium_user_password>";

   # Worker properties
   plugin.path=/etc/debezium/plugins/
   key.converter=org.apache.kafka.connect.json.JsonConverter
   value.converter=org.apache.kafka.connect.json.JsonConverter
   key.converter.schemas.enable=true
   value.converter.schemas.enable=true
   offset.storage.file.filename=/etc/debezium/worker.offset
   ```

1. In a separate terminal, start the connector:

   ```bash
   sudo /opt/kafka/bin/connect-standalone.sh \
       /etc/debezium/worker.conf \
       /etc/debezium/mdb-connector.conf
   ```

## Check the health of Debezium {#verify-debezium}

1. In a separate terminal, run the `kafkacat` utility in consumer mode:

   ```bash
   kafkacat \
       -C \
       -b <FQDN_of_broker_host_1>:9091,...,<FQDN_of_broker_host_N>:9091 \
       -t mpg.db1.measurements \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username=debezium \
       -X sasl.password=<password> \
       -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/{{ crt-local-file }} \
       -Z \
       -K:
   ```

   The data format schema of the `db1.public.measurements` table and the information about the previously added rows will be printed.

   {% cut "Example of the message fragment" %}

   ```json
   {
   "schema": {
       ...
   },
   "payload": {
       "before": null,
       "after": {
           "device_id": "iv9a94th6rzt********",
           "datetime": 1591378020000000,
           "latitude": 55.70329,
           "longitude": 37.65472,
           "altitude": 427.5,
           "speed": 0.0,
           "battery_voltage": 23.5,
           "cabin_temperature": 17.0,
           "fuel_level": null
       },
       "source": {
           "version": "1.8.1.Final",
           "connector": "postgresql",
           "name": "mpg",
           "ts_ms": 1628245046882,
           "snapshot": "true",
           "db": "db1",
           "sequence": "[null,\"4328525512\"]",
           "schema": "public",
           "table": "measurements",
           "txId": 8861,
           "lsn": 4328525328,
           "xmin": null
       },
       "op": "r",
       "ts_ms": 1628245046893,
       "transaction": null
     }
   }
   ```

   {% endcut %}

1. [Connect to the source cluster](../../managed-postgresql/operations/connect.md).

   When connecting, the `ERROR Postgres roles LOGIN and REPLICATION are not assigned to user` error may occur. You can ignore it, as it does not affect Debezium performance.

1. Add another row to the `measurements` table:

   ```sql
   INSERT INTO public.measurements VALUES ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
   ```

1. Make sure the terminal running `kafkacat` displays details about the added row.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. Delete the [virtual machine](../../compute/operations/vm-control/vm-delete.md).

   If you reserved a public static IP address for the virtual machine, release and [delete it](../../vpc/operations/address-delete.md).

1. Delete the clusters:

   * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
   * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
