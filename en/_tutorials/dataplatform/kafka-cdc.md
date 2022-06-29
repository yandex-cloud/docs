# Delivering data from {{ mpg-name }} to {{ mkf-name }} using Debezium

You can track data changes in {{ mpg-name }} and send them to {{ mkf-name }} using Change Data Capture (CDC).

To set up CDC using [Debezium](https://debezium.io/documentation/reference/index.html):

1. [Prepare the source cluster](#prepare-source).
1. [Configure Debezium](#setup-debezium).
1. [Prepare the target cluster](#prepare-target).
1. [Launch the process with the Debezium connector](#start-debezium).
1. [Check the health of Debezium](#test-debezium).

If you no longer need these resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

1. Create a *source cluster* [{{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md):

   * With publicly available hosts.
   * With the `db1` database.
   * With the `user1` user.

1. Create a *target [{{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) cluster* in any applicable configuration with publicly available hosts.
   {% if audience != "internal" %}

1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) for Debezium with [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) from {{ marketplace-name }} and a public IP address.

{% else %}

1. Create a virtual machine for Debezium with [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) from {{ marketplace-name }} and a public IP address.

{% endif %}

1. Set up security groups so that you can connect to clusters from the created VM:

   * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#configuring-security-groups);
   * [{{ mkf-name }}](../../managed-kafka/operations/connect.md#configuring-security-groups).
      {% if audience != "internal" %}

1. [Connect to the VM instance](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH and check access to the clusters:

{% else %}

1. Connect to the VM instance over SSH and check access to the clusters:

{% endif %}
    1. Install the dependencies:

       ```bash
       sudo apt update && \
       sudo apt install -y git docker.io kafkacat postgresql-client
       ```

    2. Check that the following clusters are available:
       * [{{ mpg-name }}](../../managed-postgresql/operations/connect.md#connection-string) (use the `psql` utility);
       * [{{ mkf-name }}](../../managed-kafka/operations/connect.md#connection-string) (use the `kafkacat` utility).

## Prepare the source cluster {#prepare-source}

{% list tabs %}

- {{ mpg-name }}

   1. [Assign to the user](../../managed-postgresql/operations/grant.md) `user1` the role `mdb_replication`.

      This is necessary to create a publication for Debezium to monitor changes in a {{ mpg-name }} cluster.

   1. [Connect to the](../../managed-postgresql/operations/connect.md) `db1` database of the {{ mpg-name }} cluster on behalf of `user1`.

   1. Add test data to the database. In this example, a simple table with information from car sensors is used.

      Create a table:

      ```sql
      CREATE TABLE public.measurements(
        "device_id" TEXT PRIMARY KEY NOT NULL,
        "datetime" TIMESTAMP NOT NULL,
        "latitude" REAL NOT NULL,
        "longitude" REAL NOT NULL,
        "altitude" REAL NOT NULL,
        "speed" REAL NOT NULL,
        "battery_voltage" REAL,
        "cabin_temperature" REAL NOT NULL,
        "fuel_level" REAL
      );
      ```

      Populate the table with data:

      ```sql
      INSERT INTO public.measurements VALUES
        ('iv9a94th6rztooxh5ur2', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
        ('rhibbh3y08qmz3sdbrbu', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
        ('iv9a94th678tooxh5ur2', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
      ```

   1. Create a publication for the table:

      ```sql
      CREATE PUBLICATION mpg_publication FOR TABLE public.measurements;
      ```

{% endlist %}

## Configure Debezium {#setup-debezium}

{% list tabs %}

- {{ KFC }}

   1. [Connect to the virtual machine](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

   1. Create a file named `/etc/kafka-connect-worker/worker.properties with worker settings`:

      ```ini
      # AdminAPI connect properties
      bootstrap.servers=<broker host FQDN>:9091
      sasl.mechanism=SCRAM-SHA-512
      security.protocol=SASL_SSL
      ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
      ssl.truststore.password=<password for the certificate store>
      sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<password for the debezium account>";

      # Producer connect properties
      producer.sasl.mechanism=SCRAM-SHA-512
      producer.security.protocol=SASL_SSL
      producer.ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
      producer.ssl.truststore.password=<password for the certificate store>
      producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<password for the debezium account>";

      # Worker properties
      plugin.path=/etc/kafka-connect-worker/plugins
      key.converter=org.apache.kafka.connect.json.JsonConverter
      value.converter=org.apache.kafka.connect.json.JsonConverter
      key.converter.schemas.enable=true
      value.converter.schemas.enable=true
      offset.storage.file.filename=/etc/kafka-connect-worker/worker.offset
      ```

      {{ KFC }} will connect to the {{ mkf-name }} cluster under the `debezium` account that will be created when [preparing a target cluster](#prepare-target).

      You can request the FQDNs of broker hosts with a [list of hosts in the cluster](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

   1. Download and unpack a proper [Debezium connector](https://debezium.io/releases/) to the directory `/etc/kafka-connect-worker/plugins/`.

      The example below uses version `1.6.0`. The required commands depend on the type of source cluster:

      **{{ mpg-name }}**

      ```bash
      sudo mkdir -p ~/examples/mdb/managed-kafka/debezium-cdc/plugins/ && \
      wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/1.6.0.Finaldebezium-connector-postgres-1.6.0.Final-plugin.tar.gz && \
      sudo mkdir -p /etc/kafka-connect-worker/plugins && \
      sudo tar -xzvf debezium-connector-postgres-1.6.0.Final-plugin.tar.gz -C /etckafka-connect-worker/plugins/
      ```

   1. Create the `/etc/kafka-connect-worker/plugins/mdb-connector.properties` file with the Debezium settings for connecting to the source cluster. The file contents depend on the type of the source cluster:

      **{{ mpg-name }}**

      ```ini
      name=debezium-mpg
      connector.class=io.debezium.connector.postgresql.PostgresConnector
      plugin.name=pgoutput
      database.hostname=c-<cluster ID>.rw.{{ dns-zone }}
      database.port=6432
      database.user=user1
      database.password=<user1 password>
      database.dbname=db1
      database.server.name=mpg
      table.include.list=public.measurements
      publication.name=mpg_publication
      slot.name=debezium_slot
      heartbeat.interval.ms=15000
      heartbeat.topics.prefix=__debezium-heartbeat
      ```

      The cluster ID can be requested with a [list of clusters in the folder](../../managed-postgresql/operations/cluster-list.md#list).

      Parameter descriptions:

      * `name`: The name of the Debezium connector.
      * `database.hostname`: A [special FQDN](../../managed-postgresql/operations/connect.md#fqdn-master) to connect to the source cluster master host.
      * `database.user`: The {{ PG }} username.
      * `database.dbname`: The {{ PG }} database name.
      * `database.server.name`: The custom name of the database server that [Debezium will use](#prepare-target) when choosing a topic for sending messages.
      * `table.include.list`: The list of names of tables for which Debezium should track changes. Specify full names that include the schema name (default: `public`). [Debezium will use](#prepare-target) values from this field when selecting a topic for sending messages.
      * `publication.name`: The name of the publication [created on the source cluster](#prepare-source).
      * `slot.name`: The name of the replication slot that will be created by Debezium when working with the publication.
      * `heartbeat.interval.ms` and `heartbeat.topics.prefix`: The heartbeat settings [needed for](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-wal-disk-space) Debezium.

{% endlist %}

## Prepare the target cluster {{ mkf-name }} {#prepare-target}.

The target cluster settings depend on the source cluster type:

{% list tabs %}

- {{ mpg-name }}

   1. [Create the topic](../../managed-kafka/operations/cluster-topics.md#create-topic) `mpg.public.measurements` to store data from the source cluster.

      The following [conventions](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names) are used for topic names: `<server name>.<schema name>.<table name>`.

      According to the [Debezium configuration file](#setup-debezium):

      * The name of the `mpg` server is specified in the `database.server.name parameter`.
      * The name of the `public` schema is specified together with the name of the `measurements` table in the `table.include.list` parameter.

      If you need data from multiple tables, create a separate topic for each of them.

   1. Create the `__debezium-heartbeat.mpg` service topic with the `compact` cleanup policy.

      Names for service topics follow the [conventions](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-property-heartbeat-topics-prefix): `<prefix for heartbeat>.<server name>`.

      According to the [Debezium configuration file](#setup-debezium):

      * The `__debezium-heartbeat` prefix is specified in the `heartbeat.topics.prefix` parameter.
      * The name of the `mpg` server is specified in the `database.server.name parameter`.

      If you need data from multiple source clusters, create a separate service topic for each of them.

   1. [Create a](../../managed-kafka/operations/cluster-accounts.md#create-account) `debezium` account with a password specified in the [worker settings file](#setup-debezium).

      [Grant to it](../../managed-kafka/operations/cluster-accounts.md#grant-permission) the rights to the created topics:

      * `ACCESS_ROLE_CONSUMER`
      * `ACCESS_ROLE_PRODUCER`

{% endlist %}

## Run the process with the Debezium connector {#start-debezium}

1. [Connect to the virtual machine](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

1. To send test data to the cluster, run the worker:

   {% list tabs %}

   - {{ KFC }}

      ```bash
      cd ~/kafka_2.12-2.6.2/bin/ && \
      sudo ./connect-standalone.sh \
          /etc/kafka-connect-worker/worker.properties \
          /etc/kafka-connect-worker/plugins/mdb-connector.properties
      ```

   {% endlist %}

The worker continuously transmits new data from the source cluster to the target cluster.

## Check the health of Debezium {#test-debezium}

1. [Connect to the target cluster](../../managed-kafka/operations/connect.md#connection-string), for example, using [kafkacat](../../managed-kafka/operations/connect.md#bash), and check that the data is arriving.

   `Mpg.public.measurements` topic messages should contain data and their format schema.

   {% cut "Example of the message fragment" %}

   ```json
   {
   "schema": {
       ...
   },
   "payload": {
       "before": null,
       "after": {
           "device_id": "iv9a94th6rztooxh5ur2",
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
           "version": "1.6.0.Final",
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

1. Add data to the table in the source cluster:

   {% list tabs %}

   - {{ mpg-name }}

      1. [Connect to the cluster](../../managed-postgresql/operations/connect.md).

      1. Add another row to the `measurements` table:

         ```sql
         INSERT INTO public.measurements VALUES ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
         ```

   {% endlist %}

1. Make sure that the new data have arrived to the `mpg.public.measurements` topic.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
{% if audience != "internal" %}

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).

1. If you reserved a public static IP address for the VM, [delete it](../../vpc/operations/address-delete.md).

{% else %}

1. Delete the VM.

1. If you reserved a public static IP address for the VM, delete it.

{% endif%}

1. Delete the clusters:

   * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md);
   * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
