A {{ mch-name }} cluster can get data from {{ KF }} topics in real time. {{ mch-name }} automatically inserts data sent to {{ CH }} tables on the [`Kafka` engine]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

To set up data delivery from {{ mkf-name }} to {{ mch-name }}:

1. [Set up integration with {{ KF }} for the {{ mch-name }} cluster](#configure-mch-for-kf).
1. [In the {{ mch-name }} cluster, create tables on the Kafka engine](#create-kf-table).
1. [Send test data to {{ mkf-name }} topics](#send-sample-data-to-kf).
1. [Check that the test data is present in the {{ mch-name }} cluster tables](#fetch-sample-data).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create the required number of {{ mkf-name }} clusters](../../managed-kafka/operations/cluster-create.md) in any suitable [configuration](../../managed-kafka/concepts/instance-types.md). To connect to clusters from a user's local machine instead of the {{ yandex-cloud }} cloud network, enable public access to clusters when creating them.

   1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with a single shard and a database named `db1`. To connect to the cluster from the user's local machine rather than doing so from the {{ yandex-cloud }} cloud network, enable public access to the cluster when creating it.

      {% note info %}

      You can set up {{ KF }} integration when [creating a cluster](../../managed-clickhouse/operations/cluster-create.md). In this tutorial, integration will be set up [later](#configure-mch-for-kf).

      {% endnote %}

   1. [Create the required number of topics](../../managed-kafka/operations/cluster-topics.md#create-topic) in {{ mkf-name }} clusters. Make sure topic names are unique.

   1. To enable [producers and consumers](../../managed-kafka/concepts/producers-consumers.md) to work with topics, [create](../../managed-kafka/operations/cluster-accounts.md#create-account) two users per {{ mkf-name }} cluster:

      - A user with the `ACCESS_ROLE_PRODUCER` role for the producer.
      - A user with the `ACCESS_ROLE_CONSUMER` role for the consumer.

      Users in different clusters may have the same names.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [data-from-kafka-to-clickhouse.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-from-kafka-to-clickhouse/data-from-kafka-to-clickhouse.tf) configuration file to the same working directory.

      This file describes:

      * Network.
      * Subnet.
      * Default security group and rules required to connect to the clusters from the internet.
      * A {{ mkf-name }} cluster with a description of one topic and two users on whose behalf the producer and consumer will connect to the topic, respectively.

         To create multiple topics or clusters, duplicate blocks with their description and specify new unique names. Users in different clusters may have the same names.

      * A {{ mch-name }} cluster with a single shard and a database named `db1`.

   1. Specify in the file `data-from-kafka-to-clickhouse.tf`:

      * Usernames and passwords of users with the `ACCESS_ROLE_PRODUCER` and `ACCESS_ROLE_CONSUMER` roles in {{ mkf-name }} clusters.
      * Names of the {{ mkf-name }} clusters' topics.
      * Username and password that will be used to access a {{ mch-name }} cluster.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Configure additional settings {#additional-settings}

1. Install the utilities:

   - [kafkacat](https://github.com/edenhill/kcat) to read and write data to {{ KF }} topics.

      ```bash
      sudo apt update && sudo apt install --yes kafkacat
      ```

      Check that you can use it to [connect to {{ mkf-name }} clusters over SSL](../../managed-kafka/operations/connect.md#connection-string).

   - [clickhouse-client]({{ ch.docs }}/interfaces/cli/): to connect to the database in the {{ mch-name }} cluster.

      1. Connect the {{ CH }} [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages):

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

      1. Download the configuration file for `clickhouse-client`:

         {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

      Check that you can use it to [connect to the {{ mch-name }} cluster over SSL](../../managed-clickhouse/operations/connect.md#connection-string).

   - [jq](https://stedolan.github.io/jq/) for JSON file stream processing.

      ```bash
      sudo apt update && sudo apt-get install --yes jq
      ```

## Set up integration with {{ KF }} for the {{ mch-name }} cluster {#configure-mch-for-kf}

{% list tabs group=instructions %}

- Manually {#manual}

   Depending on the number of {{ mkf-name }} clusters:

   - If there is a single {{ KF }} cluster, [specify authentication data](../../managed-clickhouse/operations/update.md#change-clickhouse-config) under **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **Kafka**. In this case, the {{ mch-name }} cluster will use these authentication credentials to access any topic.
   - If there are multiple {{ KF }} clusters, specify authentication data for each {{ mkf-name }} topic in the [{{ mch-name }} cluster settings](../../managed-clickhouse/operations/update.md#change-clickhouse-config) under **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **Kafka topics**.

   Authentication data:

   - **Name**: Topic name (for multiple {{ KF }} clusters).
   - **Sasl mechanism**: `SCRAM-SHA-512`.
   - **Sasl password**: [User password for the consumer](#before-you-begin).
   - **Sasl username**: [Username for the consumer](#before-you-begin).
   - **Security protocol**: `SASL_SSL`.

- {{ TF }} {#tf}

   1. Depending on the number of {{ mkf-name }} clusters:

      - If there is a single {{ KF }} cluster, uncomment the `clickhouse.config.kafka` section in the `data-from-kafka-to-clickhouse.tf` file:

         ```hcl
         config {
             kafka {
                 security_protocol = "SECURITY_PROTOCOL_SASL_SSL"
                 sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_512"
                 sasl_username     = "<username_for_the_consumer>"
                 sasl_password     = "<user_password_for_the_consumer>"
             }
         }
         ```

      - If there are multiple {{ KF }} clusters, uncomment the `clickhouse.config.kafka_topic` section and specify the authentication credentials for each {{ mkf-name }} topic:

         ```hcl
         config {
             kafka_topic {
                 name = "<topic_name>"
                 settings {
                 security_protocol = "SECURITY_PROTOCOL_SASL_SSL"
                 sasl_mechanism    = "SASL_MECHANISM_SCRAM_SHA_512"
                 sasl_username     = "<username_for_the_consumer>"
                 sasl_password     = "<user_password_for_the_consumer>"
                 }
             }
         }
         ```

         If there are multiple topics in the clusters, duplicate the `kafka_topic` section as many times as required and specify the respective topic names.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## In the {{ mch-name }} cluster, create tables on the Kafka engine {#create-kf-table}

For example, {{ KF }} topics receive some data from car sensors in JSON format. This data will be sent as {{ KF }} messages, each containing a string like this:

```json
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

The {{ mch-name }} cluster will insert data into tables run on the `Kafka` engine in [JSONEachRow format]({{ ch.docs }}/interfaces/formats/#jsoneachrow). This engine will convert strings from {{ KF }} messages to relevant column values.

For each {{ KF }} topic, create a separate table in your {{ mch-name }} cluster to write incoming data to:

1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.
1. Run the following query:

   ```sql
   CREATE TABLE IF NOT EXISTS db1.<topic_table_name>
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
       kafka_broker_list = '<broker_host_FQDN>:9091'
       kafka_topic_list = '<topic_name>',
       kafka_group_name = 'sample_group',
       kafka_format = 'JSONEachRow';
   ```

The created tables will be automatically populated with messages that are read from {{ mkf-name }} topics. To read data, {{ mch-name }} uses the [settings previously set](#configure-mch-for-kf) for [users with the `ACCESS_ROLE_CONSUMER` role](#before-you-begin).

To learn more about creating a table on the `Kafka` engine, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

## Send test data to {{ mkf-name }} topics {#send-sample-data-to-kf}

1. Create a `sample.json` file with the following test data:

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

1. Send the data from the `sample.json` file to each {{ mkf-name }} topic using `jq` and `kafkacat`:

   ```bash
   jq -rc . sample.json | kafkacat -P \
      -b <broker_host_FQDN>:9091 \
      -t <topic_name> \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanisms=SCRAM-SHA-512 \
      -X sasl.username="<username_for_the_producer>" \
      -X sasl.password="<user_password_for_the_producer>" \
      -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file-root }} -Z
   ```

Data is sent on behalf of users [with the `ACCESS_ROLE_PRODUCER` role](#before-you-begin). To learn more about setting up an SSL certificate and working with `kafkacat`, see [{#T}](../../managed-kafka/operations/connect.md).

## Check that the test data is present in the {{ mch-name }} cluster tables {#fetch-sample-data}

To access the data, use a materialized view. When a materialized view is added to a table on the `Kafka` engine, it starts collecting data in the background. This allows you to continuously receive messages from {{ KF }} and convert them to the required format using `SELECT`.

{% note info %}

Since {{ CH }} can read a message from a topic only once, we do not recommend reading data directly from the table.

{% endnote %}

To create a materialized view:

1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.
1. Run the following queries for each table on the `Kafka` engine:

   ```sql
   CREATE TABLE db1.temp_<topic_table_name>
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
   CREATE MATERIALIZED VIEW db1.<view_name> TO db1.temp_<topic_table_name>
       AS SELECT * FROM db1.<topic_table_name>;
   ```

To get all the data from the appropriate materialized view:

1. [Connect](../../managed-clickhouse/operations/connect.md#connection-string) to the `db1` database of the {{ mch-name }} cluster using `clickhouse-client`.
1. Run the following query:

   ```sql
   SELECT * FROM db1.<view_name>;
   ```

The query will return a table with data sent to the respective {{ mkf-name }} topic.

To learn more about how to work with data received from {{ KF }}, see the [{{ CH }} documentation]({{ ch.docs }}/engines/table-engines/integrations/kafka/).

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   - Delete the clusters:

      - [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-delete.md).
      - [{{ mkf-full-name }}](../../managed-kafka/operations/cluster-delete.md).

   
   - If you reserved public static IP addresses for the clusters, release and [delete them](../../vpc/operations/address-delete.md).


- {{ TF }} {#tf}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the configuration file `data-from-kafka-to-clickhouse.tf`.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in the configuration file `data-from-kafka-to-clickhouse.tf` will be deleted.

{% endlist %}
