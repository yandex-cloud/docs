# Managing connectors

[Connectors](../concepts/connectors.md) manage the transfer of {{ KF }} topics to a different cluster or data storage system.

You can:

* [Get a list of connectors](#list).
* [Get detailed information about a connector](#get).
* [Create a connector](#create) of the right type:
    * [MirrorMaker](#settings-mm2)
    * [S3 Sink](#settings-s3)
* [Edit a connector](#update).
* [Pause a connector](#pause).
* [Resume a connector](#resume).
* [Import a connector to {{ TF }}](#import).
* [Delete a connector](#delete).

## Getting a list of connectors {#list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get the list of cluster connectors, run this command:

    ```bash
    {{ yc-mdb-kf }} connector list --cluster-name=<cluster_name>
    ```

    Result:

    ```text
    +--------------+-----------+
    |     NAME     | TASKS MAX |
    +--------------+-----------+
    | connector559 |         1 |
    | ...          |           |
    +--------------+-----------+
    ```

    You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Connector.list](../api-ref/Connector/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Connector/list.md#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ConnectorService/List](../api-ref/grpc/Connector/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.ConnectorService.List
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Connector/list.md#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) to make sure your request was successful.

{% endlist %}

## Getting detailed information about a connector {#get}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click the connector name.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get detailed information about a connector, run this command:

    ```bash
    {{ yc-mdb-kf }} connector get <connector_name>\
       --cluster-name=<cluster_name>
    ```

    Result:

    ```text
    name: connector785
    tasks_max: "1"
    cluster_id: c9qbkmoiimsl********
    ...
    ```

    You can get the connector name with the [list of cluster connectors](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Connector.get](../api-ref/Connector/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/<connector_name>'
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters), and the connector name, with the [list of cluster connectors](#list).

  1. Check the [server response](../api-ref/Connector/get.md#yandex.cloud.mdb.kafka.v1.Connector) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ConnectorService/Get](../api-ref/grpc/Connector/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.kafka.v1.ConnectorService.Get
     ```

     You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Connector/get.md#yandex.cloud.mdb.kafka.v1.Connector) to make sure your request was successful.

{% endlist %}

## Creating a connector {#create}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click **{{ ui-key.yacloud.kafka.button_create-connector }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, specify:

        * Connector name.
        * Task limit: Number of concurrent tasks. To distribute replication load evenly, we recommend a value of at least `2`.

    1. Under **{{ ui-key.yacloud.kafka.section_properties }}**, specify the connector properties in the following format:

        ```text
        <key>:<value>
        ```

        The key can either be a simple string or include a prefix that indicates whether it belongs to the source or target (a cluster alias in the connector configuration):

        ```text
        <cluster_alias>.<key_body>:<value>
        ```

    1. Select the connector type, [MirrorMaker](#settings-mm2) or [S3 Sink](#settings-s3), and set up its configuration.

        For more information about the supported connector types, see [{#T}](../concepts/connectors.md).

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a [MirrorMaker](#settings-mm2) connector:

  1. See the description of the CLI command for creating a connector:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker create --help
      ```

  1. Create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker create <connector_name> \
         --cluster-name=<cluster_name> \
         --direction=<connector_direction> \
         --tasks-max=<task_limit> \
         --properties=<advanced_properties> \
         --replication-factor=<replication_factor> \
         --topics=<topic_pattern> \
         --this-cluster-alias=<this_cluster_prefix> \
         --external-cluster alias=<external_cluster_prefix>,`
                           `bootstrap-servers=<list_of_broker_host_FQDNs>,`
                           `security-protocol=<security_protocol>,`
                           `sasl-mechanism=<authentication_mechanism>,`
                           `sasl-username=<username>,`
                           `sasl-password=<user_password>,`
                           `ssl-truststore-certificates=<certificates_in_PEM_format>
      ```

      {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

      You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

      `--direction` takes these values:

       * `egress`: If the current cluster is a source cluster.
       * `ingress`: If the current cluster is a target cluster.

  To create an [S3 Sink](#settings-s3) connector:

  1. See the description of the CLI command for creating a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create --help
      ```

  1. Create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create <connector_name> \
         --cluster-name=<cluster_name> \
         --tasks-max=<task_limit> \
         --properties=<advanced_properties> \
         --topics=<topic_pattern> \
         --file-compression-type=<compression_codec> \
         --file-max-records=<file_max_records> \
         --bucket-name=<bucket_name> \
         --access-key-id=<AWS_compatible_static_key_ID> \
         --secret-access-key=<AWS_compatible_static_key_contents> \
         --storage-endpoint=<S3_compatible_storage_endpoint> \
         --region=<S3_compatible_storage_region>
      ```

     You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Check the list of [MirrorMaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. To create a MirrorMaker connector, add the `yandex_mdb_kafka_connector` resource with the `connector_config_mirrormaker` configuration section:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<connector_name>" {
          cluster_id = "<cluster_ID>"
          name       = "<connector_name>"
          tasks_max  = <task_limit>
          properties = {
            <advanced_properties>
          }
          connector_config_mirrormaker {
            topics             = "<topic_pattern>"
            replication_factor = <replication_factor>
            source_cluster {
              alias = "<cluster_prefix>"
              external_cluster {
                bootstrap_servers           = "<list_of_broker_host_FQDNs>"
                sasl_username               = "<username>"
                sasl_password               = "<user_password>"
                sasl_mechanism              = "<authentication_mechanism>"
                security_protocol           = "<security_protocol>"
                ssl-truststore-certificates = "<PEM_certificate_contents>"
              }
            }
            target_cluster {
              alias = "<cluster_prefix>"
              this_cluster {}
            }
          }
        }
        ```

        {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    1. To create an S3 Sink connector, add the `yandex_mdb_kafka_connector` resource with the `connector_config_s3_sink` configuration section:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<connector_name>" {
          cluster_id = "<cluster_ID>"
          name       = "<connector_name>"
          tasks_max  = <task_limit>
          properties = {
            <advanced_properties>
          }
          connector_config_s3_sink {
            topics                = "<topic_pattern>"
            file_compression_type = "<compression_codec>"
            file_max_records      = <file_max_records>
            s3_connection {
              bucket_name = "<bucket_name>"
              external_s3 {
                endpoint          = "<S3_compatible_storage_endpoint>"
                access_key_id     = "<AWS_compatible_static_key_ID>"
                secret_access_key = "<AWS_compatible_static_key_contents>"
              }
            }
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_connector).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To create a [MirrorMaker](#settings-mm2) connector, call the [Connector.create](../api-ref/Connector/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors' \
         --data '{
                   "connectorSpec": {
                     "name": "<connector_name>",
                     "tasksMax": "<task_limit>"
                     "properties": "<advanced_connector_properties>"
                     "connectorConfigMirrormaker": {
                       <Mirrormaker_connector_settings>
                     }
                   }
                 }'
       ```

       You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. To create an [S3 Sink](#settings-s3) connector, call the [Connector.create](../api-ref/Connector/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors' \
         --data '{
                   "connectorSpec": {
                     "name": "<connector_name>",
                     "tasksMax": "<task_limit>"
                     "properties": "<advanced_connector_properties>"
                     "connectorConfigS3Sink": {
                       <S3_Sink_connector_settings>
                     }
                   }
                 }'
       ```

       You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Connector/list.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. To create a [MirrorMaker](#settings-mm2) connector, call the [ConnectorService/Create](../api-ref/grpc/Connector/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "connector_spec": {
                  "name": "<connector_name>",
                  "tasks_max": {
                    "value": "<task_limit>"
                  },
                  "properties": "<advanced_connector_properties>"
                  "connector_config_mirrormaker": {
                    <Mirrormaker_connector_settings>
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Create
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. To create an [S3 Sink](#settings-s3) connector, call the [ConnectorService/Create](../api-ref/grpc/Connector/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "connector_spec": {
                  "name": "<connector_name>",
                  "tasks_max": {
                    "value": "<task_limit>"
                  },
                  "properties": "<advanced_connector_properties>"
                  "connector_config_s3_sink": {
                    <S3_Sink_connector_settings>
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Create
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Connector/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

### MirrorMaker {#settings-mm2}

Specify the MirrorMaker connector parameters as follows:

{% list tabs group=instructions %}

- Management console {#console}

  * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
  * **{{ ui-key.yacloud.kafka.label_replication-factor }}**: Number of replicas the cluster stores for each topic.
  * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}**, specify the parameters for connecting to the source cluster:
    * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Source cluster prefix in the connector settings.

      {% note info %}

      Topics in the target cluster will be created with the specified prefix.

      {% endnote %}

    * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as the source.
    * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Comma-separated list of the FQDNs of the source cluster broker hosts with the port numbers for connection, e.g., `broker1.example.com:9091,broker2.example.com`.

       {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for the connector to access the source cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for the connector to access the source cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Authentication mechanism for username and password validation.
    * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select the connection protocol for the connector:
      * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
      * `SSL`, `SASL_SSL`: To connect with SSL.
    * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

  * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}**, specify the parameters for connecting to the target cluster:
    * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Target cluster prefix in the connector settings.
    * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as the target.
    * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Comma-separated list of the FQDNs of the target cluster broker hosts with the port numbers for connection.

       {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for the connector to access the target cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for the connector to access the target cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Authentication mechanism for username and password validation.
    * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select the connection protocol for the connector:
      * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
      * `SSL`, `SASL_SSL`: To connect with SSL.
    * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

  * To specify additional settings not listed above, create the relevant keys and set their values under **{{ ui-key.yacloud.kafka.section_properties }}** when [creating](#create) or [updating](#update) the connector. Here are some examples of keys:

    * `key.converter`
    * `value.converter`

    For the list of general connector settings, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#connectconfigs).

- CLI {#cli}

    * `--cluster-name`: Cluster name.
    * `--direction`: Connector direction:

        * `ingress`: For a target cluster.
        * `egress`: For a source cluster.

    * `--tasks-max`: Number of concurrent tasks. To distribute replication load evenly, we recommend a value of at least `2`.
    * `--properties`: Comma-separated list of additional connector settings in `<key>:<value>` format. Here are some examples of keys:

        * `key.converter`
        * `value.converter`

        For the list of general connector settings, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#connectconfigs) documentation.

    * `--replication-factor`: Number of replicas the cluster stores for each topic.
    * `--topics`: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * `--this-cluster-alias`: This cluster prefix in the connector settings.
    * `--external-cluster`: External cluster parameters:

        * `alias`: External cluster prefix in the connector settings.
        * `bootstrap-servers`: Comma-separated list of the FQDNs of the external cluster broker hosts with the port numbers for connection.

           {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

        * `security-protocol`: Connection protocol for the connector:

            * `plaintext`, `sasl_plaintext`: To connect without SSL.
            * `ssl`, `sasl_ssl`: To connect with SSL.

        * `sasl-mechanism`: Authentication mechanism for username and password validation.
        * `sasl-username`: Username for the connector to access the external cluster.
        * `sasl-password`: User password for the connector to access the external cluster.
        * `ssl-truststore-certificates`: List of PEM certificates.

- {{ TF }} {#tf}

    * **properties**: Comma-separated list of additional connector settings in `<key>:<value>` format. Here are some examples of keys:

        * `key.converter`
        * `value.converter`

      For the list of general connector settings, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#connectconfigs).

    * **topics**: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * **replication_factor**: Number of replicas the cluster stores for each topic.
    * **source_cluster** and **target_cluster**: Parameters for connecting to the source and target clusters:
        * **alias**: Cluster prefix in the connector settings.

            {% note info %}

            Topics in the target cluster will be created with the specified prefix.

            {% endnote %}

        * **this_cluster**: Option to use the current cluster as the source or target.
        * **external_cluster**: Parameters for connecting to the external cluster:
            * **bootstrap_servers**: Comma-separated list of the FQDNs of the cluster broker hosts with the port numbers for connection.

               {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * **sasl_username**: Username for the connector to access the cluster.
            * **sasl_password**: User password for the connector to access the cluster.
            * **sasl_mechanism**: Authentication mechanism for username and password validation.
            * **security_protocol**: Connection protocol for the connector:
                * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
                * `SSL`, `SASL_SSL`: To connect with SSL.
            * **ssl_truststore_certificates**: PEM certificate contents.

- REST API {#api}

    To configure the MirrorMaker connector, use the `connectorSpec.connectorConfigMirrormaker` parameter:

    * `sourceCluster` and `targetCluster`: Parameters for connecting to the source and target clusters:

        * `alias`: Cluster prefix in the connector settings.

            {% note info %}

            Topics in the target cluster will be created with the specified prefix.

            {% endnote %}

        * `thisCluster`: Option to use the current cluster as the source or target.

        * `externalCluster`: Parameters for connecting to the external cluster:

            * `bootstrapServers`: Comma-separated list of the FQDNs of the cluster broker hosts with the port numbers for connection.

                {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * `saslUsername`: Username for the connector to access the cluster.
            * `saslPassword`: User password for the connector to access the cluster.
            * `saslMechanism`: Authentication mechanism for username and password validation.
            * `securityProtocol`: Connection protocol for the connector:
                * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
                * `SSL`, `SASL_SSL`: To connect with SSL.
            * `sslTruststoreCertificates`: PEM certificate contents.

    * `topics`: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * `replicationFactor`: Number of replicas the cluster stores for each topic.

- gRPC API {#grpc-api}

    To configure the MirrorMaker connector, use the `connector_spec.connector_config_mirrormaker` parameter:

    * `source_cluster` and `target_cluster`: Parameters for connecting to the source and target clusters:

        * `alias`: Cluster prefix in the connector settings.

            {% note info %}

            Topics in the target cluster will be created with the specified prefix.

            {% endnote %}

        * `this_cluster`: Option to use the current cluster as the source or target.

        * `external_cluster`: Parameters for connecting to the external cluster:

            * `bootstrap_servers`: Comma-separated list of the FQDNs of the cluster broker hosts with the port numbers for connection.

                {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * `sasl_username`: Username for the connector to access the cluster.
            * `sasl_password`: User password for the connector to access the cluster.
            * `sasl_mechanism`: Authentication mechanism for username and password validation.
            * `security_protocol`: Connection protocol for the connector:
                * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
                * `SSL`, `SASL_SSL`: To connect with SSL.
            * `ssl_truststore_certificates`: PEM certificate contents.

    * `topics`: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * `replication_factor`: Number of replicas the cluster stores for each topic, provided as an object with the `value` field.

{% endlist %}

### S3 Sink {#settings-s3}

Specify the S3 Sink connector parameters as follows:

{% list tabs group=instructions %}

- Management console {#console}

  * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Pattern for selecting topics to export. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
  * **{{ ui-key.yacloud.kafka.field_connector-compression-type }}**: Message compression codec:

      * `none` (default): No compression
      * `gzip`: [gzip](https://www.gzip.org/) codec
      * `snappy`: [snappy](https://github.com/google/snappy) codec
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

      You cannot change this setting after the cluster is created.

  * **{{ ui-key.yacloud.kafka.field_connector-file-max-records }}**: Maximum number of records that can be written to a single file in an S3-compatible storage. This is an optional setting.
  * Under **{{ ui-key.yacloud.kafka.field_connector-s3-connection }}**, specify the storage connection parameters:
      * **{{ ui-key.yacloud.kafka.field_connector-bucket-name }}**: Storage bucket name.
      * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}**: Endpoint for storage access. Get it from your storage provider.
      * **{{ ui-key.yacloud.kafka.field_connector-region }}**: Region name. This is an optional setting. The default value is `{{ region-id }}`. You can find the list of available regions [here](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

          {% include [basic-aws-region](../../_includes/basic-aws-region.md) %}

      
      * **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}**: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md). This is an optional setting.


  * To specify additional settings not listed above, create the relevant keys and set their values under **{{ ui-key.yacloud.kafka.section_properties }}** when [creating](#create) or [updating](#update) the connector. Here are some examples of keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see [this connector guide](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of general connector settings, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#connectconfigs).

- CLI {#cli}

    * `--cluster-name`: Cluster name.
    * `--tasks-max`: Number of concurrent tasks. To distribute replication load evenly, we recommend a value of at least `2`.
    * `--properties`: Comma-separated list of additional connector settings in `<key>:<value>` format. Here are some examples of keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see [this connector guide](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of general connector settings, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#connectconfigs).

    * `--topics`: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * `--file-compression-type`: Message compression codec. You cannot change this setting after the cluster is created. Valid values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * `--file-max-records`: Maximum number of records that can be written to a single file in an S3-compatible storage.
    * `--bucket-name`: Name of the S3-compatible storage bucket to write data to.
    * `--storage-endpoint`: Endpoint for storage access (get it from your storage provider), e.g., `{{ s3-storage-host }}`.
    * `--region`: Region where the S3-compatible storage bucket resides. The default value is `{{ region-id }}`. You can find the list of available regions [here](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

        {% include [basic-aws-region](../../_includes/basic-aws-region.md) %}

    
    * `--access-key-id`, `--secret-access-key`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- {{ TF }} {#tf}

    * **properties**: Comma-separated list of additional connector settings in `<key>:<value>` format. Here are some examples of keys:

        * `key.converter`
        * `value.converter`
        * `value.converter.schemas.enable`
        * `format.output.type`

      For the list of all connector settings, see [this connector guide](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of general connector settings, see [this {{ KF }} guide](https://kafka.apache.org/documentation/#connectconfigs).

    * **topics**: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * **file_compression_type**: Message compression codec. You cannot change this setting after the cluster is created. Valid values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * **file_max_records**: Maximum number of records that can be written to a single file in an S3-compatible storage.
    * **s3_connection**: S3-compatible storage connection parameters:

        * **bucket_name**: Name of the bucket to write data to.
        * **external_s3**: External S3-compatible storage connection parameters:

            * **endpoint**: Endpoint for storage access (get it from your storage provider), e.g., `{{ s3-storage-host }}`.
            * **region**: Region where the S3-compatible storage bucket resides. The default value is `{{ region-id }}`. You can find the list of available regions [here](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

                {% include [basic-aws-region](../../_includes/basic-aws-region.md) %}

            
            * **access_key_id**, **secret_access_key**: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- REST API {#api}

    To configure the S3 Sink connector, use the `connectorSpec.connectorConfigS3Sink` parameter:

    * `topics`: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * `fileCompressionType`: Message compression codec. You cannot change this setting after the cluster is created. Valid values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * `fileMaxRecords`: Maximum number of records that can be written to a single file in an S3-compatible storage.
    * `s3Connection`: S3-compatible storage connection parameters:
        * `bucketName`: Name of the bucket to write data to.
        * `externalS3`: External storage parameters:
            * `endpoint`: Endpoint for storage access (get it from your storage provider), e.g., `{{ s3-storage-host }}`.
            * `region`: Region where the S3-compatible storage bucket resides. The default value is `{{ region-id }}`. You can find the list of available regions [here](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

                {% include [basic-aws-region](../../_includes/basic-aws-region.md) %}

            
            * `accessKeyId`, `secretAccessKey`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- gRPC API {#grpc-api}

    To configure the S3 Sink connector, use the `connector_spec.connector_config_s3_sink` parameter:

    * `topics`: Pattern for selecting topics to replicate. List topic names separated by commas or `|`. You can also use a regular expression (`.*`), e.g., `analysis.*`. To replicate all topics, specify `.*`.
    * `file_compression_type`: Message compression codec. You cannot change this setting after the cluster is created. Valid values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * `file_max_records`: Maximum number of records that can be written to a single file in an S3-compatible storage. provided as an object with the `value` field.
    * `s3_connection`: S3-compatible storage connection parameters:
        * `bucket_name`: Name of the bucket to write data to.
        * `external_s3`: External storage parameters:
            * `endpoint`: Endpoint for storage access (get it from your storage provider), e.g., `{{ s3-storage-host }}`.
            * `region`: Region where the S3-compatible storage bucket resides. The default value is `{{ region-id }}`. You can find the list of available regions [here](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

                {% include [basic-aws-region](../../_includes/basic-aws-region.md) %}

            
            * `access_key_id`, `secret_access_key`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


{% endlist %}

## Editing a connector {#update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. In the connector row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.kafka.button_edit-connector }}**.
    1. Edit the connector properties as needed.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit a [MirrorMaker](#settings-mm2) connector:

    1. See the description of the CLI command for editing a connector:

        ```bash
        {{ yc-mdb-kf }} connector-mirrormaker update --help
        ```

    1. Run this command, e.g., to update the task limit:

        ```bash
        {{ yc-mdb-kf }} connector-mirrormaker update <connector_name> \
           --cluster-name=<cluster_name> \
           --direction=<connector_direction> \
           --tasks-max=<new_task_limit>
        ```

        Where `--direction` is the connector direction, either `ingress` or `egres`.

        You can get the connector name with the [list of cluster connectors](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

    To update an [S3 Sink](#settings-s3) connector:

    1. See the description of the CLI command for editing a connector:

        ```bash
        {{ yc-mdb-kf }} connector-s3-sink update --help
        ```

    1. Run this command, e.g., to update the task limit:

        ```bash
        {{ yc-mdb-kf }} connector-s3-sink update <connector_name> \
           --cluster-name=<cluster_name> \
           --tasks-max=<new_task_limit>
        ```

        You can get the connector name with the [list of cluster connectors](#list), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Check the list of [MirrorMaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Edit the parameter values in the `yandex_mdb_kafka_connector` resource description:

        * For a MirrorMaker connector:

            ```hcl
            resource "yandex_mdb_kafka_connector" "<connector_name>" {
              cluster_id = "<cluster_ID>"
              name       = "<connector_name>"
              tasks_max  = <task_limit>
              properties = {
                <advanced_properties>
              }
              connector_config_mirrormaker {
                topics             = "<topic_pattern>"
                replication_factor = <replication_factor>
                source_cluster {
                  alias = "<cluster_prefix>"
                  external_cluster {
                    bootstrap_servers           = "<list_of_broker_host_FQDNs>"
                    sasl_username               = "<username>"
                    sasl_password               = "<user_password>"
                    sasl_mechanism              = "<authentication_mechanism>"
                    security_protocol           = "<security_protocol>"
                    ssl-truststore-certificates = "<PEM_certificate_contents>"
                  }
                }
                target_cluster {
                  alias = "<cluster_prefix>"
                  this_cluster {}
                }
              }
            }
            ```

        * For an S3 Sink connector:

            ```hcl
            resource "yandex_mdb_kafka_connector" "<S3_Sink_connector_name>" {
              cluster_id = "<cluster_ID>"
              name       = "<S3_Sink_connector_name>"
              tasks_max  = <task_limit>
              properties = {
                <advanced_properties>
             }
              connector_config_s3_sink {
                topics                = "<topic_pattern>"
                file_max_records      = <file_max_records>
                s3_connection {
                  bucket_name = "<bucket_name>"
                  external_s3 {
                    endpoint          = "<S3_compatible_storage_endpoint>"
                    access_key_id     = "<AWS_compatible_static_key_ID>"
                    secret_access_key = "<AWS_compatible_static_key_contents>"
                  }
                }
              }
            }
            ```

    1. Make sure the settings are correct.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_connector).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Connector.update](../api-ref/Connector/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

       {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

       ```bash
       curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/<connector_name>' \
         --data '{
                   "updateMask": "connectorSpec.tasksMax,connectorSpec.properties,connectorSpec.connectorConfigMirrormaker.<Mirrormaker_1_connector_setting>,...,connectorSpec.connectorConfigMirrormaker.<Mirrormaker_N_connector_setting>,connectorSpec.connectorConfigS3Sink.<S3_Sink_1_connector_setting>,...,connectorSpec.connectorConfigS3Sink.<S3_Sink_N_connector_setting>",
                   "connectorSpec": {
                     "tasksMax": "<task_limit>"
                     "properties": "<advanced_connector_properties>"
                     "connectorConfigMirrormaker": {
                       <Mirrormaker_connector_settings>
                     },
                     "connectorConfigS3Sink": {
                       <S3_Sink_connector_settings>
                     }
                   }
                 }'
       ```

       Where:

       * `updateMask`: Comma-separated string of connector settings you want to update.

            Specify the relevant parameters:
            * `connectorSpec.tasksMax`: To change the connector task limit.
            * `connectorSpec.properties`: To change the connector’s advanced properties.
            * `connectorSpec.connectorConfigMirrormaker.<configuring_Mirrormaker_connector>`: To update the [Mirrormaker](#settings-mm2) connector settings.
            * `connectorSpec.connectorConfigS3Sink.<configuring_S3_Sink_connector>`: To update the [S3 Sink](#settings-s3) connector settings.

       * `connectorSpec`: Specify the MirrorMaker or S3 Sink connector settings.

       You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/Connector/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ConnectorService/Update](../api-ref/grpc/Connector/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "connector_name": "<connector_name>",
                "update_mask": {
                  "paths": [
                    "connector_spec.tasks_max",
                    "connector_spec.properties",
                    "connector_spec.connector_config_mirrormaker.<Mirrormaker_1_connector_setting>",
                    ...,
                    "connector_spec.connector_config_mirrormaker.<Mirrormaker_N_connector_setting>",
                    "connector_spec.connector_config_s3_sink.<S3_Sink_1_connector_setting>",
                    ...,
                    "connector_spec.connector_config_s3_sink.<S3-Sink_N_connector_setting>"
                  ]
                },
                "connector_spec": {
                  "tasks_max": {
                    "value": "<task_limit>"
                  },
                  "properties": "<advanced_connector_properties>"
                  "connector_config_mirrormaker": {
                    <Mirrormaker_connector_settings>
                  },
                  "connector_config_s3_sink": {
                    <S3_Sink_connector_settings>
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Update
        ```

        Where:

        * `update_mask`: List of connector settings you want to update as an array of strings (`paths[]`).

            Specify the relevant parameters:
            * `connector_spec.tasks_max`: To change the connector task limit.
            * `connector_spec.properties`: To change the connector’s advanced properties.
            * `connector_spec.connector_config_mirrormaker.<configuring_Mirrormaker_connector>`: To update the [Mirrormaker](#settings-mm2) connector settings.
            * `connector_spec.connector_config_s3_sink.<configuring_S3_Sink_connector>`: To update the [S3 Sink](#settings-s3) connector settings.
        * `connector_spec`: Specify the MirrorMaker or S3 Sink connector settings.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/grpc/Connector/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Pausing a connector {#pause}

When you pause a connector, the system:

* Terminates the sink connection.
* Deletes data from the connector service topics.

To pause a connector:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the connector name and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To pause a connector, run this command:

    ```bash
    {{ yc-mdb-kf }} connector pause <connector_name> \
       --cluster-name=<cluster_name>
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Connector.pause](../api-ref/Connector/pause.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/pause/<connector_name>'
       ```

       You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/Connector/pause.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ConnectorService/Pause](../api-ref/grpc/Connector/pause.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "connector_name": "<connector_name>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Pause
        ```

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/grpc/Connector/pause.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Resuming a connector {#resume}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the connector name and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To resume a connector, run this command:

    ```bash
    {{ yc-mdb-kf }} connector resume <connector_name> \
       --cluster-name=<cluster_name>
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Connector.pause](../api-ref/Connector/resume.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/resume/<connector_name>'
       ```

       You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/Connector/resume.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ConnectorService/Resume](../api-ref/grpc/Connector/resume.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "connector_name": "<connector_name>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Resume
        ```

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/grpc/Connector/resume.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Importing a connector to {{ TF }} {#import}

You can import the existing connectors to manage them with {{ TF }}.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. In the {{ TF }} configuration file, specify the connector you want to import:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<connector_name>" {}
        ```

    1. Run the following command to import your connector:

        ```hcl
        terraform import yandex_mdb_kafka_connector.<connector_name> <cluster_ID>:<connector_name>
        ```

        To learn more about importing connectors, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_connector#import).

{% endlist %}

## Deleting a connector {#delete}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the connector name and select **{{ ui-key.yacloud.common.delete }}**.
    1. Click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a connector, run this command:

    ```bash
    {{ yc-mdb-kf }} connector delete <connector_name> \
       --cluster-name <cluster_name>
    ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Delete the `yandex_mdb_kafka_connector` resource with the connector description.
    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_kafka_connector).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Connector.pause](../api-ref/Connector/delete.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

       ```bash
       curl \
         --request DELETE \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/<connector_name>'
       ```

       You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/Connector/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ConnectorService/Delete](../api-ref/grpc/Connector/delete.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/connector_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "connector_name": "<connector_name>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.kafka.v1.ConnectorService.Delete
        ```

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters), and the connector name, with the [list of connectors in the cluster](#list).

    1. Check the [server response](../api-ref/grpc/Connector/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
