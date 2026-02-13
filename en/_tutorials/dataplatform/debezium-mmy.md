# Transferring data from {{ mmy-full-name }} to {{ mkf-full-name }} using Debezium

You can track data changes in {{ mmy-name }} and send them to {{ mkf-name }} using change data capture (CDC).

In this tutorial, you will learn how to create a virtual machine in {{ yandex-cloud }} and set up [Debezium](https://debezium.io/documentation/reference/index.html), an open-source software framework for CDC.


## Required paid resources {#paid-resources}

* {{ mkf-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* {{ mmy-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* VM instance: use of computing resources, storage, public IP address, and OS (see [{{ compute-name }} pricing](../../compute/pricing.md)).


## Getting started {#before-you-begin}

1. [Create a _source cluster_](../../managed-mysql/operations/cluster-create.md) with the following settings:

    * Hosts: Publicly available
    * Database: `db1`
    * User: `user1`

1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration with publicly accessible hosts.

1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) running [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) with a public IP address.


1. If you use security groups, configure them to allow connections to the clusters from the internet and from the VM you created, and to allow SSH access to that VM from the internet:

    * [Configuring {{ mkf-name }} cluster security groups](../../managed-kafka/operations/connect/index.md#configuring-security-groups).
    * [Configuring {{ mmy-name }} cluster security groups](../../managed-mysql/operations/connect/index.md#configure-security-groups).


1. [Connect to your VM over SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) and complete its initial setup:

    1. Install the dependencies:

        ```bash
        sudo apt update && \
            sudo apt install kafkacat openjdk-17-jre mysql-client --yes
        ```

        Make sure you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    1. Create a directory for {{ KF }}:

        ```bash
        sudo mkdir -p /opt/kafka/
        ```

    1. Download the archive with {{ KF }} executables and unpack it into this directory. For example, to download and unpack {{ KF }} 3.0, run this command:

        ```bash
        wget https://archive.apache.org/dist/kafka/3.0.0/kafka_2.13-3.0.0.tgz && \
        sudo tar xf kafka_2.13-3.0.0.tgz --strip 1 --directory /opt/kafka/
        ```

        You can check the current {{ KF }} version on the [project’s download page](https://kafka.apache.org/downloads).

    1. Install certificates on the VM and make sure you can access the clusters:

        * [{{ mkf-name }}](../../managed-kafka/operations/connect/clients.md) (use `kafkacat`).
        * [{{ mmy-name }}](../../managed-mysql/operations/connect/index.md#get-ssl-cert) (use `mysql`).

    1. Create a directory to store the files required for the Debezium connector:

        ```bash
        sudo mkdir -p /etc/debezium/plugins/
        ```

    1. To enable the Debezium connector to connect to {{ mkf-name }} broker hosts, add the SSL certificate to Java Key Store. For extra storage security, specify a password of at least six characters in the `-storepass` setting:

        ```bash
        sudo keytool \
            -importcert \
            -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/{{ crt-local-file }} \
            -keystore /etc/debezium/keystore.jks \
            -storepass <JKS_password> \
            --noprompt
        ```

## Set up the source cluster {#prepare-source}

1. [Assign](../../managed-mysql/operations/cluster-users.md#update-settings) the `REPLICATION CLIENT` and `REPLICATION SLAVE` global privileges to `user1`.

1. [Connect](../../managed-mysql/operations/connect/index.md) to the `db1` database as `user1`.

1. Populate the database with test data. In this example, we will use a simple table with car sensor information.

    1. Create a table:

        ```sql
        CREATE TABLE measurements (
          `device_id` VARCHAR(32) PRIMARY KEY NOT NULL,
          `datetime` TIMESTAMP NOT NULL,
          `latitude` REAL NOT NULL,
          `longitude` REAL NOT NULL,
          `altitude` REAL NOT NULL,
          `speed` REAL NOT NULL,
          `battery_voltage` REAL,
          `cabin_temperature` REAL NOT NULL,
          `fuel_level` REAL
        );
        ```

    1. Populate the table with data:

        ```sql
        INSERT INTO measurements VALUES
          ('iv9a94th6rzt********', '2020-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
          ('rhibbh3y08qm********', '2020-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32),
          ('iv9a94th678t********', '2020-06-07 15:00:10', 55.70985913, 37.62141918,  417.0, 15.7, 10.3, 17, NULL);
        ```

## Set up the Debezium connector {#setup-debezium}

1. Connect to the VM over SSH.

1. Download the current [Debezium connector](https://debezium.io/releases/) and unpack into the `/etc/debezium/plugins/` directory.

    You can check the current connector version on the [project page](https://debezium.io/releases/). Below are commands for `1.9.4.Final`.

    ```bash
    VERSION="1.9.4.Final"
    wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/${VERSION}/debezium-connector-mysql-${VERSION}-plugin.tar.gz && \
    sudo tar -xzvf debezium-connector-mysql-${VERSION}-plugin.tar.gz -C /etc/debezium/plugins/
    ```

1. Create a file named `/etc/debezium/mdb-connector.conf` with Debezium connector settings for connecting to the source cluster:

    ```init
    name=debezium-mmy
    connector.class=io.debezium.connector.mysql.MySqlConnector
    database.hostname=c-<cluster_ID>.rw.{{ dns-zone }}
    database.port=3306
    database.user=user1
    database.password=<user1_password>
    database.dbname=db1
    database.server.name=mmy
    database.ssl.mode=required_identity
    table.include.list=db1.measurements
    heartbeat.interval.ms=15000
    heartbeat.topics.prefix=__debezium-heartbeat

    snapshot.mode=never
    include.schema.changes=false
    database.history.kafka.topic=dbhistory.mmy
    database.history.kafka.bootstrap.servers=<broker_host_1_FQDN>:9091,...,<broker_host_N_FQDN>:9091

    # Producer settings
    database.history.producer.security.protocol=SSL
    database.history.producer.ssl.truststore.location=/etc/debezium/keystore.jks
    database.history.producer.ssl.truststore.password=<JKS_password>
    database.history.producer.sasl.mechanism=SCRAM-SHA-512
    database.history.producer.security.protocol=SASL_SSL
    database.history.producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<debezium_user_password>";

    # Consumer settings
    database.history.consumer.security.protocol=SSL
    database.history.consumer.ssl.truststore.location=/etc/debezium/keystore.jks
    database.history.consumer.ssl.truststore.password=<JKS_password>
    database.history.consumer.sasl.mechanism=SCRAM-SHA-512
    database.history.consumer.security.protocol=SASL_SSL
    database.history.consumer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="debezium" password="<debezium_user_password>";
    ```

    Where:

    * `name`: Logical name of the Debezium connector. It is used for the connector’s internal needs.
    * `database.hostname`: [Special FQDN](../../managed-mysql/operations/connect/fqdn.md#fqdn-master) for connecting to the master host of the source cluster.

        You can get the cluster ID from the [list of clusters in your folder](../../managed-mysql/operations/cluster-list.md#list-clusters).

    * `database.user`: {{ MY }} username.
    * `database.dbname`: {{ MY }} database name.
    * `database.server.name`: Name of the database server that [Debezium will use](#prepare-target) when choosing a topic for sending messages.
    * `table.include.list`: Names of tables for which Debezium will capture changes. Specify full names that include the database name (`db1`). [Debezium will use](#prepare-target) values from this field when choosing a topic for sending messages.
    * `heartbeat.interval.ms` and `heartbeat.topics.prefix`: Heartbeat settings [required](https://debezium.io/documentation/reference/connectors/mysql.html#mysql-property-heartbeat-interval-ms) for Debezium.
    * `database.history.kafka.topic`: Name of the service topic where the connector publishes notifications about schema changes in the source cluster.

## Set up the target cluster {#prepare-target}

1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) to store data from the source cluster:

    * **{{ ui-key.yacloud.common.name }}**: `mmy.db1.measurements`.

        Data topic names [follow](https://debezium.io/documentation/reference/connectors/mysql.html#mysql-topic-names) the `<server_name>.<database_name>.<table_name>` convention.

        According to the [Debezium configuration file](#setup-debezium):

        * `database.server.name` specifies the server name, `mmy`.
        * `table.include.list` specifies the database name, `db1`, along with the table name, `measurements`.

    If you need to track data changes in multiple tables, create a separate topic for each one.

1. Create a service topic for tracking the connector status:

    * **{{ ui-key.yacloud.common.name }}**: `__debezium-heartbeat.mmy`.

        Service topic names [follow](https://debezium.io/documentation/reference/connectors/mysql.html#mysql-property-heartbeat-topics-prefix) the `<prefix_for_heartbeat>.<server_name>` convention.

        According to the [Debezium configuration file](#setup-debezium):

        * `heartbeat.topics.prefix` specifies the prefix, `__debezium-heartbeat`.
        * `database.server.name` specifies the server name, `mmy`.

    * **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}**: `Compact`.

    If you need to capture data from multiple source clusters, create a separate service topic for each one.

1. Create a service topic for tracking to data format schema changes:

    * **{{ ui-key.yacloud.common.name }}**: `dbhistory.mmy`.
    * **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}**: `Delete`.
    * **{{ ui-key.yacloud.kafka.label_partitions }}**: `1`.

1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `debezium`.

1. [Grant](../../managed-kafka/operations/cluster-accounts.md#grant-permission) `debezium` the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` permissions for the topics you created.

## Run the Debezium connector {#run-connector}

1. Create a file with Debezium worker settings:

    `/etc/debezium/worker.conf`

    ```ini
    # AdminAPI connect properties
    bootstrap.servers=<broker_host_1_FQDN>:9091,...,<broker_host_N_FQDN>:9091
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

1. In a separate terminal, run the connector:

    ```bash
    sudo /opt/kafka/bin/connect-standalone.sh \
        /etc/debezium/worker.conf \
        /etc/debezium/mdb-connector.properties
    ```

## Check that Debezium works properly {#verify-debezium}

1. In a separate terminal, run `kafkacat` in consumer mode:

    ```bash
    kafkacat \
        -C \
        -b <broker_host_1_FQDN>:9091,...,<broker_host_N_FQDN>:9091 \
        -t mmy.db1.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=debezium \
        -X sasl.password=<password> \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/{{ crt-local-file }} \
        -Z \
        -K:
    ```

    The output will return the data format schema of the `db1.measurements` table and information about the previously added rows.

    {% cut "Message snippet example" %}

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
            "connector": "mysql",
            "name": "mmy",
            "ts_ms": 1628245046882,
            "snapshot": "true",
            "db": "db1",
            "sequence": "[null,\"4328525512\"]",
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

1. [Connect to the source cluster](../../managed-mysql/operations/connect/index.md) and add another row to the `measurements` table:

    ```sql
    INSERT INTO measurements VALUES ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Make sure the terminal running `kafkacat` displays details about the added row.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md).

    If you reserved a public static IP address for the virtual machine, release and [delete it](../../vpc/operations/address-delete.md).

1. Delete the clusters:

    * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
    * [{{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
