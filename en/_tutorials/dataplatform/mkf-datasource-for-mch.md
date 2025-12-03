

A {{ mch-name }} cluster can ingest data from {{ KF }} topics in real time. This data will be automatically inserted into {{ CH }} [`Kafka`-engine tables]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

To set up data delivery from {{ mkf-name }} to {{ mch-name }}:

1. [Set up {{ KF }} integration for your {{ mch-name }} cluster](#configure-mch-for-kf).
1. [Create Kafka-engine tables in your {{ mch-name }} cluster](#create-kf-table).
1. [Send test data to your {{ mkf-name }} topics](#send-sample-data-to-kf).
1. [Verify that the test data appears in the {{ mch-name }} cluster tables](#fetch-sample-data).

If you no longer need the resources you created, [delete them](#clear-out).

{% note warning %}

This tutorial uses a single-host {{ CH }} cluster. If your cluster has more than one {{ CH }} host, arrange the SQL queries below as [distributed queries]({{ ch.docs }}/sql-reference/statements/create/table) with your cluster name in curly brackets: `CREATE ... ON CLUSTER '{cluster}'`. Additionally, in queries with the `MergeTree` table engine specified, use `ReplicatedMergeTree` instead.

{% endnote %}


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mkf-name }} cluster fee: Covers the use of computational resources allocated to hosts (including {{ ZK }} hosts) and disk storage (see [{{ KF }} pricing](../../managed-kafka/pricing.md)).
* {{ mch-name }} cluster fee: Covers the use of computational resources allocated to hosts (including {{ ZK }} hosts) and disk storage (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

### Set up the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create the required number of {{ mkf-name }} clusters](../../managed-kafka/operations/cluster-create.md) with your preferred [configuration](../../managed-kafka/concepts/instance-types.md). Enable public access to your clusters during creation so you can connect to them from your local machine. Connections from within the {{ yandex-cloud }} network are enabled by default.

    1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with a single shard and a database named `db1`. Enable public access to the cluster during creation so you can connect to it from your local machine. Connections from within the {{ yandex-cloud }} network are enabled by default.

        {% note info %}

        Integration with {{ KF }} is available during [cluster creation](../../managed-clickhouse/operations/cluster-create.md). In this tutorial, however, we will configure the integration [at a later stage](#configure-mch-for-kf).

        {% endnote %}

    
    1. If using security groups, configure them to allow internet access to your clusters:

        * [Guide for {{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups)
        * [Guide for {{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups)


    1. [Create the required number of topics](../../managed-kafka/operations/cluster-topics.md#create-topic) in {{ mkf-name }} clusters. Make sure the topic names are unique.

    1. To enable access to topics for [producers and consumers](../../managed-kafka/concepts/producers-consumers.md), [create](../../managed-kafka/operations/cluster-accounts.md#create-account) two users in each {{ mkf-name }} cluster:

        - Producer: A user assigned the `ACCESS_ROLE_PRODUCER` role.
        - Consumer: A user assigned the `ACCESS_ROLE_CONSUMER` role.

        Usernames are not required to be unique across clusters.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-from-kafka-to-clickhouse.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-fetch-data-from-kafka/blob/main/data-from-kafka-to-clickhouse.tf) configuration file to your current working directory.

        This file describes:

        * Network.
        * Subnet.
        * Default security group and inbound internet rules for the cluster
        * {{ mkf-name }} cluster.
        * Topic and two {{ mkf-name }} users for producer and consumer access.

            To create multiple topics or clusters, duplicate these resource blocks and provide a unique name for each. Usernames are not required to be unique across clusters.

        * {{ mch-name }} cluster with a single shard and a database named `db1`.

    1. In the `data-from-kafka-to-clickhouse.tf` file, specify the following:

        * {{ mkf-name }} version.
        * Usernames and passwords of the accounts with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` roles in your {{ mkf-name }} clusters.
        * Names of topics in the {{ mkf-name }} clusters.
        * Username and password that will be used to access your {{ mch-name }} cluster.

    1. Make sure the {{ TF }} configuration files are correct using this command:

       ```bash
       terraform validate
       ```

       {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Configure additional settings {#additional-settings}

1. Install the following tools:

    - [kafkacat](https://github.com/edenhill/kcat): For reading from and writing to {{ KF }} topics.

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Verify that you can use it to [establish SSL connections to your {{ mkf-name }} clusters](../../managed-kafka/operations/connect/clients.md#bash-zsh).

    - [clickhouse-client]({{ ch.docs }}/interfaces/cli/): For connecting to a database within the {{ mch-name }} cluster.

        1. Add the {{ CH }} [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages):

            ```bash
            sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
            sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
            echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
            /etc/apt/sources.list.d/clickhouse.list
            ```

        1. Install the dependencies:

            ```bash
            sudo apt update && sudo apt install --yes clickhouse-client
            ```

        1. Download the `clickhouse-client` configuration file:

            {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

        Verify that you can [establish an SSL connection to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/clients.md) via clickhouse-client.

    - [jq](https://stedolan.github.io/jq/): For stream processing of JSON files.

        ```bash
        sudo apt update && sudo apt-get install --yes jq
        ```

## Set up {{ KF }} integration for your {{ mch-name }} cluster {#configure-mch-for-kf}

{% list tabs group=instructions %}

- Manually {#manual}

    Configuration depends on how many {{ mkf-name }} clusters you have:

    * Single {{ KF }} cluster: Provide authentication data in the [{{ CH }} settings](../../managed-clickhouse/operations/change-server-level-settings.md#yandex-cloud-interfaces), under **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **Kafka**. The {{ mch-name }} cluster will use these credentials for all topics.

        Authentication data:

        * **Sasl mechanism**: `SCRAM-SHA-512`.
        * **Sasl password**: [User password for the consumer](#before-you-begin).
        * **Sasl username**: [Username for the consumer](#before-you-begin).
        * **Security protocol**: `SASL_SSL`.

    * Multiple {{ KF }} clusters: Create enough [named collections]({{ ch.docs }}/operations/named-collections) containing authentication data for each {{ mkf-name }} topic:

        1. [Connect](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to the `db1` database on your {{ mch-name }} cluster via `clickhouse-client`.

        1. Run the following query as many times as needed providing the authentication data for each topic:

            ```sql
            CREATE NAMED COLLECTION <collection_name> AS
                kafka_broker_list = '<broker_host_FQDN>:9091',
                kafka_topic_list = '<topic_name>',
                kafka_group_name = 'sample_group',
                kafka_format = 'JSONEachRow'
                kafka_security_protocol = 'SASL_SSL',
                kafka_sasl_mechanism = 'SCRAM-SHA-512',
                kafka_sasl_username = '<username_for_consumer>',
                kafka_sasl_password = '<user_password_for_consumer>';
            ```

- {{ TF }} {#tf}

    1. Configuration depends on how many {{ mkf-name }} clusters you have:

        - Single {{ KF }} cluster: Uncomment the `clickhouse.config.kafka` section in the `data-from-kafka-to-clickhouse.tf` file:

            ```hcl
            config {
                kafka {
                    security_protocol = "SECURITY_PROTOCOL_SASL_SSL"
                    sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_512"
                    sasl_username     = "<username_for_consumer>"
                    sasl_password     = "<user_password_for_consumer>"
                }
            }
            ```

        - Multiple {{ KF }} clusters: Uncomment the `clickhouse.config.kafka_topic` section and specify credentials for each {{ mkf-name }} topic:

            ```hcl
            config {
                kafka_topic {
                    name = "<topic_name>"
                    settings {
                    security_protocol = "SECURITY_PROTOCOL_SASL_SSL"
                    sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_512"
                    sasl_username     = "<username_for_consumer>"
                    sasl_password     = "<user_password_for_consumer>"
                    }
                }
            }
            ```

            For multiple topics, duplicate the `kafka_topic` section for each one, specifying the relevant topic names.

    1. Check if the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Create Kafka-engine tables in your {{ mch-name }} cluster {#create-kf-table}

Suppose your {{ KF }} topics receive car sensor data in JSON format. This data will be transmitted as {{ KF }} messages, each containing a string in the following format:

```json
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

For `Kafka` table inserts, the {{ mch-name }} cluster will use the [JSONEachRow format]({{ ch.docs }}/interfaces/formats/#jsoneachrow) that parses rows from {{ KF }} messages into the required column values.

For each {{ KF }} topic, create a separate table for incoming data in your {{ mch-name }} cluster:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to the `db1` database on your {{ mch-name }} cluster via `clickhouse-client`.
1. Run this query:

    {% list tabs group=instructions %}

    - Single {{ KF }} cluster

        ```sql
        CREATE TABLE IF NOT EXISTS db1.<table_name_for_topic>
        (
            device_id String,
            datetime DateTime,
            latitude Float32,
            longitude Float32,
            altitude Float32,
            speed Float32,
            battery_voltage Nullable(Float32),
            cabin_temperature Float32,
            fuel_level Nullable(Float32)
        ) ENGINE = Kafka()
        SETTINGS
            kafka_broker_list = '<broker_host_FQDN>:9091',
            kafka_topic_list = '<topic_name>',
            kafka_group_name = 'sample_group',
            kafka_format = 'JSONEachRow';
        ```

    - Multiple {{ KF }} clusters

        ```sql
        CREATE TABLE IF NOT EXISTS db1.<table_name_for_topic>
        (
            device_id String,
            datetime DateTime,
            latitude Float32,
            longitude Float32,
            altitude Float32,
            speed Float32,
            battery_voltage Nullable(Float32),
            cabin_temperature Float32,
            fuel_level Nullable(Float32)
        ) ENGINE = Kafka(<name_of_collection_with_authentication_data>);
        ```

    {% endlist %}

These tables will be automatically populated with messages consumed from {{ mkf-name }} topics. When reading data, {{ mch-name }} uses the [previously configured credentials](#configure-mch-for-kf) for the [`ACCESS_ROLE_CONSUMER` role account](#before-you-begin).

For more details on creating `Kafka`-engine tables, see this [{{ CH }} article]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

## Send test data to your {{ mkf-name }} topics {#send-sample-data-to-kf}

1. Create a file named `sample.json` with test data:

    ```json
    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-05 17:27:00",
        "latitude": 55.70329032,
        "longitude": 37.65472196,
        "altitude": 427.5,
        "speed": 0,
        "battery_voltage": 23.5,
        "cabin_temperature": 17,
        "fuel_level": null
    }

    {
        "device_id": "rhibbh3y08qm********",
        "datetime": "2020-06-06 09:49:54",
        "latitude": 55.71294467,
        "longitude": 37.66542005,
        "altitude": 429.13,
        "speed": 55.5,
        "battery_voltage": null,
        "cabin_temperature": 18,
        "fuel_level": 32
    }

    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-07 15:00:10",
        "latitude": 55.70985913,
        "longitude": 37.62141918,
        "altitude": 417.0,
        "speed": 15.7,
        "battery_voltage": 10.3,
        "cabin_temperature": 17,
        "fuel_level": null
    }
    ```

1. Send data from `sample.json` to each {{ mkf-name }} topic using `jq` and `kafkacat`:

    ```bash
    jq -rc . sample.json | kafkacat -P \
       -b <broker_host_FQDN>:9091 \
       -t <topic_name> \
       -k key \
       -X security.protocol=SASL_SSL \
       -X sasl.mechanisms=SCRAM-SHA-512 \
       -X sasl.username="<username_for_producer>" \
       -X sasl.password="<user_password_for_producer>" \
       -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file-root }} -Z
    ```

Data is sent using the credentials of the account with the [`ACCESS_ROLE_PRODUCER` role](#before-you-begin). To learn more about setting up an SSL certificate and using `kafkacat`, see [{#T}](../../managed-kafka/operations/connect/clients.md).

## Verify that the test data appears in the {{ mch-name }} cluster tables {#fetch-sample-data}

To access the data, use a materialized view. Once a materialized view is attached to a `Kafka` table, it starts gathering data in the background automatically. This enables the system to continuously consume messages from {{ KF }} and convert them to the required format using `SELECT`.

{% note info %}

We do not recommend reading data directly from the table because {{ CH }} can read a message from a topic only once.

{% endnote %}

To create a materialized view:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to the `db1` database on your {{ mch-name }} cluster via `clickhouse-client`.
1. Run the following queries for each `Kafka` table:

    ```sql
    CREATE TABLE db1.temp_<table_name_for_topic>
    (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE = MergeTree()
    ORDER BY device_id;
    ```

    ```sql
    CREATE MATERIALIZED VIEW db1.<view_name> TO db1.temp_<table_name_for_topic>
        AS SELECT * FROM db1.<table_name_for_topic>;
    ```

To retrieve all data from your materialized view:

1. [Connect](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) to the `db1` database on your {{ mch-name }} cluster via `clickhouse-client`.
1. Run this query:

    ```sql
    SELECT * FROM db1.<view_name>;
    ```

This query will return data sent to the respective {{ mkf-name }} topic.

To learn more about working with data received from {{ KF }}, see this [{{ CH }} article]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    - Delete the clusters:

        - [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-delete.md).
        - [{{ mkf-full-name }}](../../managed-kafka/operations/cluster-delete.md).

    
    - If you reserved public static IP addresses for your clusters, release and [delete them](../../vpc/operations/address-delete.md).


- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
