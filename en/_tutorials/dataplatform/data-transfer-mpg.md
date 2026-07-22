# Delivering data from {{ mpg-full-name }} to {{ mkf-full-name }} using {{ data-transfer-full-name }}

You can track data changes in a {{ mpg-name }} _source cluster_ and send them to a {{ mkf-name }} _target cluster_ using change data capture (CDC).

To set up CDC using {{ data-transfer-name }}:

1. [Set up your infrastructure](#infra).
1. [Prepare the source cluster](#prepare-source).
1. [Set up the target cluster](#prepare-target).
1. [Prepare and activate your transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* {{ mpg-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* {{ mkf-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Set up your infrastructure {#infra}


{% include [public-access](../../_includes/mdb/note-public-access.md) %}


{% list tabs group=instructions %}

- Manually {#manual}

  1. [Create a {{ mpg-name }} source cluster](../../managed-postgresql/operations/cluster-create.md) with any suitable configuration, using the following settings:

      * Database: `db1`.
    
      
      * User: `pg-user`.
      * Hosts: Publicly available.


  
  1. [Create a {{ mkf-name }} target cluster](../../managed-kafka/operations/cluster-create.md) in any suitable configuration with publicly accessible hosts.

  1. If using security groups, configure them to allow internet access to your clusters:

      * [Guide for {{ mpg-name }}](../../managed-postgresql/operations/connect/index.md#configuring-security-groups).
      * [Guide for {{ mkf-name }}](../../managed-kafka/operations/connect/index.md#configuring-security-groups).



- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Download the [cdc-mpg-mkf.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-postgresql-to-kafka/blob/main/cdc-mpg-mkf.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet) in the `ru-central1-a` [availability zone](../../overview/concepts/geo-scope.md).
      * [Security group](../../vpc/concepts/security-groups.md) for the {{ mpg-name }} cluster and rules for access to the cluster from the internet.
      * Security group for the {{ mkf-name }} cluster and rules for access to the cluster from the internet.
      * {{ mpg-name }} cluster with public internet access.
      * Database and user with the [mdb_replication](../../managed-postgresql/concepts/roles.md#mdb-replication) role in the {{ mpg-name }} cluster.
      * {{ mkf-name }} cluster with public internet access.
      * Topic and user with the [ACCESS_ROLE_CONSUMER](../../managed-kafka/concepts/account-roles.md#access-role-consumer) and [ACCESS_ROLE_PRODUCER](../../managed-kafka/concepts/account-roles.md#access-role-producer) roles for this topic in the {{ mkf-name }} cluster.
      * Source and target endpoints.
      * Transfer.

  1. Specify the following in the configuration file:
        
      * `network_name`: Network name.
      * `subnet_name`: Subnet name.
      * `pg_sg_name`: Name of security group for the {{ mpg-name }} cluster.
      * `kf_sg_name`: Name of security group for the {{ mkf-name }} cluster.
      * `pg_cluster_version`: {{ mpg-name }} cluster version.
      * `pg_cluster_name`: {{ mpg-name }} cluster name.
      * `pg_password`: User password in the {{ mpg-name }} cluster.
      * `kf_cluster_version`: {{ mkf-name }} cluster version.
      * `kf_cluster_name`: {{ mkf-name }} cluster name.
      * `kf_password`: User password in the {{ mkf-name }} cluster.
      * `source_endpoint_name`: Source endpoint name.
      * `target_endpoint_name`: Target endpoint name.
      * `transfer_name`: Transfer name.
      * `transfer_enabled = 0`: Disables the creation of endpoints and transfers. They will be created during the [preparation of the transfer](#prepare-transfer).

  1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      {{ TF }} will display any configuration errors detected in your files.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}


{% endlist %}


## Prepare the source cluster {#prepare-source}


1. If you created the infrastructure manually, [assign](../../managed-postgresql/operations/grant.md#grant-role) the [mdb_replication](../../managed-postgresql/concepts/roles.md#mdb-replication) role to `pg-user`. The user needs this role to be able to create a publication through which {{ data-transfer-name }} will receive information about changes in the source cluster data.


1. [Connect](../../managed-postgresql/operations/connect/index.md) to the `db1` database as `pg-user`.

1. Populate the database with test data. In this example, we will use a simple table with car sensor information.

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

## Prepare the target cluster {#prepare-target}


If you created the infrastructure using {{ TF }}, skip this step and proceed to [transfer preparation and activation](#prepare-transfer).


The target cluster's setup will vary depending on the [topic management method](../../managed-kafka/concepts/topics.md#management) you are using. Topic names follow the same convention as [Debezium](https://debezium.io/documentation/reference/connectors/postgresql.html#postgresql-topic-names): `<topic_prefix>.<schema_name>.<table_name>`. In this tutorial, we will use the `cdc` example prefix.

{% list tabs group=topic_management %}

- {{ yandex-cloud }} interfaces {#yc}

    If you manage topics using the {{ yandex-cloud }} interfaces (management console, CLI, API):

    1. [Create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `cdc.public.measurements`.

        If you need to track data changes in multiple tables, create a separate topic for each one.

    1. [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `kafka-user` with the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for the new topic.

- Admin API {#api}

    If you manage topics using the Kafka Admin API:

    1. Create an [admin user](../../managed-kafka/operations/cluster-accounts.md) named `kafka-user`.

    1. In addition to the `ACCESS_ROLE_ADMIN` role, assign the admin user the `ACCESS_ROLE_CONSUMER` and `ACCESS_ROLE_PRODUCER` roles for topics whose names begin with the `cdc` prefix.

        The system will automatically create the required topics when the first change occurs in the monitored tables of the source cluster. While this approach can be convenient for tracking changes across multiple tables, it requires reserving free storage space in your cluster. For more information, see [{#T}](../../managed-kafka/concepts/storage.md).

{% endlist %}


## Prepare and activate a transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Create endpoints](../../data-transfer/operations/endpoint/index.md#create).

      * Source endpoint:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}**:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: Your previously [created](#before-you-begin) {{ mpg-name }} cluster.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `db1`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pg-user`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `pg-user` password.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}**: `public.measurements`.

      * Target endpoint:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Kafka`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.title }}**:
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaConnectionType.managed.title }}`.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}**: Select the target cluster.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}**: Specify the `kafka-user` credentials.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic.title }}**: `cdc.public.measurements`.

            If you need to track changes in multiple tables, fill in the fields as follows:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}**: Enter the `cdc` prefix you used to generate topic names.

  1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with the following settings:

      * **{{ ui-key.yacloud.data-transfer.label_endpoints }}**:
        * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}**: Source endpoint you created earlier.
        * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**: Target endpoint you created earlier.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**.

  1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.


- {{ TF }} {#tf}

  1. Specify `transfer_enabled = 1` in the `cdc-mpg-mkf.tf` file.

  1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      {{ TF }} will display any configuration errors detected in your files.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Endpoints and a transfer will be created. The transfer will be activated automatically as soon as it is created.
  
  1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.
      
      You can check the transfer status in the [management console]({{ link-console-main }}).


{% endlist %}


## Test the transfer {#verify-transfer}

1. Install the `kcat` (`kafkacat`) [utility](https://github.com/edenhill/kcat) and the [PostgreSQL command-line client](https://www.postgresql.org/download/) on your local machine. For example, on Ubuntu 20.04, use this command:

    ```bash
    sudo apt update && sudo apt install kafkacat postgresql-client --yes
    ```

    Check that you can use it to [connect to the {{ mkf-name }} source cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

1. In a separate terminal, run `kafkacat` in consumer mode:

    ```bash
    kafkacat \
        -C \
        -b <broker_host_1_FQDN>:9091,...,<broker_host_N_FQDN>:9091 \
        -t cdc.public.measurements \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=kafka-user \
        -X sasl.password=<password> \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} \
        -Z \
        -K:
    ```

    You can get the FQDNs of broker hosts with the [list of hosts in the {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-hosts.md).

    The utility will print the `public.measurements` table schema along with the data from previously inserted rows.

    {% cut "Message snippet example" %}

    ```json
    {
      "payload": {
        "consumer":"dttuhfpp97l3********"
      },
      "schema": {
        "fields": [
          {
            "field": "consumer",
            "optional":false,
            "type":"string"
          }
        ],
        "name": "__data_transfer_stub.public.__consumer_keeper.Key",
        "optional":false,
        "type":"struct"
      }
    }:{
      "payload": {
        "after": {
          "consumer":"dttuhfpp97l3********l",
          "locked_by":"dttuhfpp97l3********-1",
          "locked_till":"2022-05-15T09:55:18Z"
        },
      "before": null,
      "op":"u",
      "source": {
        "connector":"postgresql",
        "db":"db1",
        "lsn":85865797008,
        "name":"__data_transfer_stub",
        "schema":"public",
        "snapshot":"false",
        "table":"__consumer_keeper",
        "ts_ms":1652608518883,
        "txId":245165,
        "version":"1.1.2.Final",
        "xmin":null
      },
    ...
    ```

    {% endcut %}

1. Connect to the source cluster and populate the `measurements` table with data:

    ```sql
    INSERT INTO public.measurements VALUES ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
    ```

1. Check that the terminal running `kafkacat` shows the information about the new row.

## Delete the resources you created {#clear-out}


Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:


{% list tabs group=instructions %}

- Manually {#manual}

  1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) and [delete](../../data-transfer/operations/transfer.md#delete) the transfer.
  1. [Delete the endpoints](../../data-transfer/operations/endpoint/index.md#delete).
  1. Delete the clusters:

      * [{{ mkf-name }}](../../managed-kafka/operations/cluster-delete.md).
      * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

  
  1. If static public IP addresses were used for accessing the cluster hosts, release and [delete](../../vpc/operations/address-delete.md) them.



- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}


{% endlist %}


