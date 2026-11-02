# Transferring data from a {{ mkf-full-name }} topic into an {{ IBRG }} table in {{ objstorage-full-name }}

You can set up data transfer from a [{{ mkf-name }} topic](../../../managed-kafka/concepts/topics.md#topics) into an {{ IBRG }} table. Use [{{ mtr-full-name }}](../../../managed-trino/index.yaml) to create a schema and a table. The data will be stored in an [{{ objstorage-name }}](../../../storage/index.yaml) bucket, and the metadata, in [{{ metastore-name }}](../../../metadata-hub/concepts/metastore.md). In {{ mkf-name }}, configure [{{ ui-key.yacloud.kafka.label_connector_icebergsink }} connector](../../../managed-kafka/concepts/connectors.md#iceberg-sink) to transfer data from a topic to the table.

You can also use a PySpark job to create an {{ IBRG }} table via [{{ msp-full-name }}](../../../managed-spark/index.yaml). For more information, see [this tutorial](../../../managed-spark/tutorials/spark-simple-rw-job.md).

To set up data transfer:

1. [Set up your infrastructure](#infra).
1. [Create an {{ IBRG }} table](#create-iceberg-table).
1. [Create a connector and test it](#connector-create).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* {{ mkf-name }} cluster: use of computing resources allocated to hosts and storage size (see [{{ mkf-name }} pricing](../../../managed-kafka/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).
* {{ metastore-name }} cluster: computing resources of the cluster components (see [{{ metadata-hub-full-name }} pricing](../../../metadata-hub/pricing.md)).
* {{ mtr-name }} cluster: computing resources of the cluster components and the amount of {{ yandex-cloud }} egress traffic (see [{{ mtr-name }} pricing](../../../managed-trino/pricing.md)).
* {{ objstorage-name }} bucket: use of storage, data operations (see [{{ objstorage-name }} pricing](../../../storage/pricing.md)).
* NAT gateway: hourly use of the gateway and its outgoing traffic (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Set up your infrastructure {#infra}

1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) named `sa-metastore` and assign it the following roles:

    * [storage.editor](../../../storage/security/index.md#storage-editor): For using the {{ objstorage-name }} bucket.
    * [managed-metastore.integrationProvider](../../../metadata-hub/security/metastore-roles.md#managed-metastore-integrationProvider): For [communication between the {{ metastore-name }} cluster and {{ yandex-cloud }} services](../../../metadata-hub/concepts/metastore-impersonation.md).

1. Create a service account named `sa-trino` and assign it the following roles:

    * [storage.editor](../../../storage/security/index.md#storage-editor): For using the {{ objstorage-name }} bucket.
    * [managed-trino.integrationProvider](../../../managed-trino/security.md#managed-trino-integrationProvider): For [communication between the {{ mtr-name }} cluster and {{ yandex-cloud }} services](../../../managed-trino/concepts/impersonation.md).

1. [Create an {{ objstorage-name }} bucket](../../../storage/operations/buckets/create.md).
1. [Create a static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the `sa-metastore` service account.

    Save the key ID and secret key, as you will need them when [creating a connector](#connector-create).

1. [Create a cloud network](../../../vpc/operations/network-create.md) named `demo-network`.

    This will automatically create three subnets in different availability zones.

1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) for the `demo-network-{{ region-id }}-a` subnet.

    A NAT gateway is required for communication between the {{ metastore-name }} cluster and {{ yandex-cloud }} services.

1. In `demo-network`, [create a security group](../../../vpc/operations/security-group-create.md) named `metastore-sg` for the {{ metastore-name }} cluster and [add the rules](../../../metadata-hub/operations/metastore/configure-security-group.md) required for the cluster to that group.

1. In `demo-network`, create a security group named `mkf-sg` for the {{ mkf-name }} cluster and add the following rules to that group:

    * Rule for incoming traffic allowing connections to the cluster over the internet:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mkf-ssl }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    * Rule for outgoing traffic allowing access to {{ metastore-name }}:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-metastore }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

1. [Create a {{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-create.md) with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `sa-metastore`.
    * **{{ ui-key.yacloud.metastore.label_warehouse-bucket }}**: Name of the bucket.
    * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `demo-network`.
    * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}**: `demo-network-{{ region-id }}-a`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `metastore-sg`.

1. [Create a {{ mtr-name }} cluster](../../../managed-trino/operations/cluster-create.md) with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `demo-network`.
    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `sa-trino`.
    * Catalog properties:

      * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}**: `iceberg`.
      * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**: `Iceberg`.
      * **Metastore type**: `Hive Metastore`.
      * **URI**: `thrift://<Metastore_cluster_IP_address>:9083`.

        You can get the {{ metastore-name }} cluster IP address along with the [cluster info](../../../metadata-hub/operations/metastore/cluster-list.md#get-cluster).

      * **File storage**: `{{ objstorage-full-name }}`.

1. [Create a {{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-create.md) with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `demo-network`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `mkf-sg`.
    * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}**: Enabled.

      {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

1. In your {{ mkf-name }} cluster, [create the following topics](../../../managed-kafka/operations/cluster-topics.md#create-topic):

    * `iceberg_control_topic`: For managing the connector.
    * `my_topic`: For messaging.

1. In your {{ mkf-name }} cluster, [create a user](../../../managed-kafka/operations/cluster-accounts.md#create-account) named `kafka-producer` with the [producer](../../../managed-kafka/concepts/producers-consumers.md) role and grant them access to `my_topic`.

    This user is used to publish messages to `my_topic`.


## Create an {{ IBRG }} table {#create-iceberg-table}

1. [Connect](../../../managed-trino/operations/connect.md) to your {{ mtr-name }} cluster.
1. Run the following SQL queries:

    1. Create a schema:

        ```sql
        CREATE SCHEMA iceberg.myschema
        WITH (
          location = 's3a://<bucket_name>/iceberg/warehouse/myschema'
        );
        ```

    1. Create a table:

        ```sql
        CREATE TABLE iceberg.myschema.mytable (
          id BIGINT,
          name VARCHAR,
          created_at VARCHAR
        )
        WITH (format = 'PARQUET');
        ```

1. Make sure you have successfully created the `iceberg/warehouse/myschema/mytable-*/metadata/` [folder structure](../../../storage/operations/objects/list.md), where `*` is the system component of the table name.


## Create a connector and test it {#connector-create}

1. In {{ mkf-name }}, [create a connector](../../../managed-kafka/operations/cluster-connector.md#create) of the `{{ ui-key.yacloud.kafka.label_connector_icebergsink }}` type with the following settings:

    * **{{ ui-key.yacloud.kafka.field_connector-control-topic }}**: `iceberg_control_topic`.
    * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: `my_topic`.
    * **{{ ui-key.yacloud.kafka.field_connector-static-tables }}**: `myschema.mytable`.
    * **{{ ui-key.yacloud.kafka.field_connector-catalog-uri }}**: `thrift://<Metastore_cluster_IP_address>:9083`.

      You can get the {{ metastore-name }} cluster IP address along with the [cluster info](../../../metadata-hub/operations/metastore/cluster-list.md#get-cluster).

    * **{{ ui-key.yacloud.kafka.field_connector-warehouse }}**: `s3a://<bucket_name>/iceberg/warehouse`.
    * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}**: `storage.yandexcloud.net`.
    * **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}**: Static key data [you got earlier](#infra).
    * **{{ ui-key.yacloud.kafka.field_connector-commit-interval-ms }}**: `5000` milliseconds.
    * **{{ ui-key.yacloud.kafka.section_properties }}**:

      * `key.converter`: `org.apache.kafka.connect.json.JsonConverter`
      * `key.converter.schemas.enable`: `false`
      * `value.converter`: `org.apache.kafka.connect.json.JsonConverter`
      * `value.converter.schemas.enable`: `false`

1. Test the connector:

    1. [Install an SSL certificate](../../../managed-kafka/operations/connect/index.md#get-ssl-cert).
    1. [Install kcat (kafkacat)](../../../managed-kafka/operations/connect/clients.md#bash-zsh).
    1. Send a message to `my_topic`:

        ```bash
        echo '{"id":1,"name":"Alice","created_at":"2024-01-15T10:30:00"}' | kcat -P \
            -b <broker_FQDN>:9091 \
            -t my_topic \
            -X security.protocol=SASL_SSL \
            -X sasl.mechanism=SCRAM-SHA-512 \
            -X sasl.username="kafka-producer" \
            -X sasl.password="<password>" \
            -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
        ```

        For more information on getting a broker host FQDN, see [{#T}](../../../managed-kafka/operations/connect/index.md#get-fqdn).

1. After committing, verify that the `data` folder containing data in `PARQUET` format has been created under `iceberg/warehouse/myschema/mytable-*/` in the bucket.

    To view the written data, run the following SQL query in {{ mtr-name }}:

    ```sql
    SELECT * FROM iceberg.myschema.mytable;
    ```


## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need, so you will not be charged for them:

1. [{{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-delete.md).
1. [{{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-delete.md).
1. [{{ mtr-name }} cluster](../../../managed-trino/operations/cluster-delete.md).
1. [{{ objstorage-name }} bucket](../../../storage/operations/buckets/delete.md). Before deleting the bucket, [delete all its objects](../../../storage/operations/objects/delete.md).
1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md).
