# Managing connectors

[Connectors](../concepts/connectors.md) manage the transfer of {{ KF }} topics to other clusters or data storage systems.

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

## Get a list of connectors {#list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of cluster connectors, run the command:

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

    You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Connector.list](../api-ref/Connector/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors'
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Connector/list.md#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ConnectorService/List](../api-ref/grpc/Connector/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Connector/list.md#yandex.cloud.mdb.kafka.v1.ListConnectorsResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a connector {#get}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click the name of the connector you need.

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

    You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Connector.get](../api-ref/Connector/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/<connector_name>'
     ```

     You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

  1. View the [server response](../api-ref/Connector/get.md#yandex.cloud.mdb.kafka.v1.Connector) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ConnectorService/Get](../api-ref/grpc/Connector/get.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Connector/get.md#yandex.cloud.mdb.kafka.v1.Connector) to make sure the request was successful.

{% endlist %}

## Creating a connector {#create}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click **{{ ui-key.yacloud.kafka.button_create-connector }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, specify:

        * Connector name.
        * Task limit: Number of concurrent processes. To distribute replication load evenly, we recommend a value of at least `2`.

    1. Under **{{ ui-key.yacloud.kafka.section_properties }}**, specify the connector properties in the following format:

        ```text
        <key>:<value>
        ```

        The key can either be a simple string or contain a prefix indicating that it belongs to the source or target (a cluster alias in the connector configuration):

        ```text
        <cluster_alias>.<key_body>:<value>
        ```

    1. Select the connector type: [MirrorMaker](#settings-mm2) or [S3 Sink](#settings-s3), and set up its configuration.

        For more information about the supported connector types, see [{#T}](../concepts/connectors.md).

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a [MirrorMaker](#settings-mm2) connector:

  1. View the description of the CLI command to create a connector:

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
         --topics=<topics_template> \
         --this-cluster-alias=<this_cluster_prefix> \
         --external-cluster alias=<external_cluster_prefix>,`
                           `bootstrap-servers=<list_of_broker_host_FQDNs>,`
                           `security-protocol=<security_protocol>,`
                           `sasl-mechanism=<encryption_mechanism>,`
                           `sasl-username=<username>,`
                           `sasl-password=<user_password>,`
                           `ssl-truststore-certificates=<certificates_in_PEM_format>
      ```

      {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

      `--direction` takes these values:

       * `egress`: If the current cluster is a source cluster.
       * `ingress`: If the current cluster is a target cluster.

  To create an [S3 Sink](#settings-s3) connector:

  1. View the description of the CLI command to create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create --help
      ```

  1. Create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create <connector_name> \
         --cluster-name=<cluster_name> \
         --tasks-max=<task_limit> \
         --properties=<advanced_properties> \
         --topics=<topics_template> \
         --file-compression-type=<compression_codec> \
         --file-max-records=<file_max_records> \
         --bucket-name=<bucket_name> \
         --access-key-id=<AWS_compatible_static_key_ID> \
         --secret-access-key=<AWS_compatible_static_key_contents> \
         --storage-endpoint=<S3_compatible_storage_endpoint> \
         --region=<S3_compatible_storage_region>
      ```

     You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Check the list of [MirrorMaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. To create a MirrorMaker connector, add the `yandex_mdb_kafka_connector` resource with the `connector_config_mirrormaker` settings section:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<connector_name>" {
          cluster_id = "<cluster_ID>"
          name       = "<connector_name>"
          tasks_max  = <task_limit>
          properties = {
            <advanced_properties>
          }
          connector_config_mirrormaker {
            topics             = "<topics_template>"
            replication_factor = <replication_factor>
            source_cluster {
              alias = "<cluster_prefix>"
              external_cluster {
                bootstrap_servers           = "<list_of_broker_host_FQDNs>"
                sasl_username               = "<username>"
                sasl_password               = "<user_password>"
                sasl_mechanism              = "<encryption_mechanism>"
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

    1. To create an S3 Sink connector, add the `yandex_mdb_kafka_connector` resource with the `connector_config_s3_sink` settings section:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<connector_name>" {
          cluster_id = "<cluster_ID>"
          name       = "<connector_name>"
          tasks_max  = <task_limit>
          properties = {
            <advanced_properties>
          }
          connector_config_s3_sink {
            topics                = "<topics_template>"
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

    For more information, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect) provider documentation.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. To create a [MirrorMaker](#settings-mm2) connector, use the [Connector.create](../api-ref/Connector/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

       You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. To create an [S3 Sink](#settings-s3) connector, use the [Connector.create](../api-ref/Connector/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

       You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Connector/list.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. To create a [MirrorMaker](#settings-mm2) connector, use the [ConnectorService/Create](../api-ref/grpc/Connector/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. To create an [S3 Sink](#settings-s3) connector, use the [ConnectorService/Create](../api-ref/grpc/Connector/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Connector/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

### MirrorMaker {#settings-mm2}

Specify the MirrorMaker connector parameters:

{% list tabs group=instructions %}

- Management console {#console}

  * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
  * **{{ ui-key.yacloud.kafka.label_replication-factor }}**: Number of topic copies stored in the cluster.
  * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}**, specify the parameters for connecting to the source cluster:
    * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Source cluster prefix in the connector settings.

      {% note info %}

      Topics in the target cluster will be created with the specified prefix.

      {% endnote %}

    * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as a source.
    * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Сomma-separated list of the FQDNs of the source cluster broker hosts with the port numbers for connection, e.g., `broker1.example.com:9091,broker2.example.com`.

       {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for connecting the connector to the source cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for connecting the connector to the source cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Select a username and password encryption mechanism.
    * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select a connector connection protocol:
      * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
      * `SSL`, `SASL_SSL`: To connect with SSL.
    * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

  * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}**, specify the parameters for connecting to the target cluster:
    * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Target cluster prefix in the connector settings.
    * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as a target.
    * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Сomma-separated list of the FQDNs of the target cluster broker hosts with the port numbers for connection.

       {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for connecting the connector to the target cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for connecting the connector to the target cluster.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Select a username and password encryption mechanism.
    * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select a connector connection protocol:
      * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
      * `SSL`, `SASL_SSL`: To connect with SSL.
    * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

  * To specify additional setting values not listed above, create the relevant keys and specify their values under **{{ ui-key.yacloud.kafka.section_properties }}** when [creating](#create) or [editing](#update) a connector. Here are some sample keys:

    * `key.converter`
    * `value.converter`

    For the list of common connector settings, see the [{{ KF }}](https://kafka.apache.org/documentation/#connectconfigs) documentation.

- CLI {#cli}

    * `--cluster-name`: Cluster name.
    * `--direction`: Connector direction:

        * `ingress`: For a target cluster.
        * `egress`: For a source cluster.

    * `--tasks-max`: Number of concurrent processes. To distribute replication load evenly, we recommend a value of at least `2`.
    * `--properties`: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

        * `key.converter`
        * `value.converter`

        For the list of common connector settings, see the [{{ KF }}](https://kafka.apache.org/documentation/#connectconfigs) documentation.

    * `--replication-factor`: Number of topic copies stored in the cluster.
    * `--topics`: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * `--this-cluster-alias`: This cluster prefix in the connector settings.
    * `--external-cluster`: External cluster parameters:

        * `alias`: External cluster prefix in the connector settings.
        * `bootstrap-servers`: Comma-separated list of the FQDNs of the external cluster broker hosts with the port numbers for connection.

           {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

        * `security-protocol`: Connector connection protocol:

            * `plaintext`, `sasl_plaintext`: To connect without SSL.
            * `ssl`, `sasl_ssl`: To connect with SSL.

        * `sasl-mechanism`: Username and password encryption mechanism.
        * `sasl-username`: Username for connecting the connector to the external cluster.
        * `sasl-password`: User password for connecting the connector to the external cluster.
        * `ssl-truststore-certificates`: List of PEM certificates.

- {{ TF }} {#tf}

    * **properties**: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

        * `key.converter`
        * `value.converter`

      For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

    * **topics**: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * **replication_factor**: Number of topic copies stored in the cluster.
    * **source_cluster** and **target_cluster**: Parameters for connecting to the source cluster and target cluster:
        * **alias**: Cluster prefix in the connector settings.

            {% note info %}

            Topics in the target cluster will be created with the specified prefix.

            {% endnote %}

        * **this_cluster**: Option to use the current cluster as a source or target.
        * **external_cluster**: Parameters for connecting to the external cluster:
            * **bootstrap_servers**: Comma-separated list of the FQDNs of the cluster broker hosts with the port numbers for connection.

               {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * **sasl_username**: Username for connecting the connector to the cluster.
            * **sasl_password**: User password for connecting the connector to the cluster.
            * **sasl_mechanism**: Username and password encryption mechanism.
            * **security_protocol**: Connector connection protocol:
                * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
                * `SSL`, `SASL_SSL`: To connect with SSL.
            * **ssl_truststore_certificates**: PEM certificate contents.

- REST API {#api}

    MirrorMaker connector settings are specified in the `connectorSpec.connectorConfigMirrormaker` parameter:

    * `sourceCluster` and `targetCluster`: Parameters for connecting to the source cluster and target cluster:

        * `alias`: Cluster prefix in the connector settings.

            {% note info %}

            Topics in the target cluster will be created with the specified prefix.

            {% endnote %}

        * `thisCluster`: Option to use the current cluster as a source or target.

        * `externalCluster`: Parameters for connecting to the external cluster:

            * `bootstrapServers`: Comma-separated list of the FQDNs of the cluster broker hosts with the port numbers for connection.

                {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * `saslUsername`: Username for connecting the connector to the cluster.
            * `saslPassword`: User password for connecting the connector to the cluster.
            * `saslMechanism`: Username and password encryption mechanism.
            * `securityProtocol`: Connector connection protocol:
                * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
                * `SSL`, `SASL_SSL`: To connect with SSL.
            * `sslTruststoreCertificates`: PEM certificate contents.

    * `topics`: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * `replicationFactor`: Number of topic copies stored in the cluster.

- gRPC API {#grpc-api}

    MirrorMaker connector settings are specified in the `connector_spec.connector_config_mirrormaker` parameter:

    * `source_cluster` and `target_cluster`: Parameters for connecting to the source cluster and target cluster:

        * `alias`: Cluster prefix in the connector settings.

            {% note info %}

            Topics in the target cluster will be created with the specified prefix.

            {% endnote %}

        * `this_cluster`: Option to use the current cluster as a source or target.

        * `external_cluster`: Parameters for connecting to the external cluster:

            * `bootstrap_servers`: Comma-separated list of the FQDNs of the cluster broker hosts with the port numbers for connection.

                {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * `sasl_username`: Username for connecting the connector to the cluster.
            * `sasl_password`: User password for connecting the connector to the cluster.
            * `sasl_mechanism`: Username and password encryption mechanism.
            * `security_protocol`: Connector connection protocol:
                * `PLAINTEXT`, `SASL_PLAINTEXT`: To connect without SSL.
                * `SSL`, `SASL_SSL`: To connect with SSL.
            * `ssl_truststore_certificates`: PEM certificate contents.

    * `topics`: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * `replication_factor`: Number of topic copies stored in the cluster. Provided as an object with the `value` field:

{% endlist %}

### S3 Sink {#settings-s3}

Specify the S3 Sink connector parameters:

{% list tabs group=instructions %}

- Management console {#console}

  * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
  * **{{ ui-key.yacloud.kafka.field_connector-compression-type }}**: Select the codec to compress messages:

      * `none` (default): No compression
      * `gzip`: [gzip](https://www.gzip.org/) codec
      * `snappy`: [snappy](https://github.com/google/snappy) codec
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

      You cannot change this parameter after creating the cluster.

  * (Optional) **{{ ui-key.yacloud.kafka.field_connector-file-max-records }}**: Maximum number of records that can be written to a single file in an S3-compatible storage.
  * Under **{{ ui-key.yacloud.kafka.field_connector-s3-connection }}**, specify the storage connection parameters:
      * **{{ ui-key.yacloud.kafka.field_connector-bucket-name }}**: Storage bucket name
      * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}**: Endpoint for storage access (to be requested from the storage provider)
      * (Optional) **{{ ui-key.yacloud.kafka.field_connector-region }}**: Region name. The default value is `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

      
      * (Optional) **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}**: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


  * To specify additional setting values not listed above, create the relevant keys and specify their values under **{{ ui-key.yacloud.kafka.section_properties }}** when [creating](#create) or [editing](#update) a connector. Here are some sample keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }}](https://kafka.apache.org/documentation/#connectconfigs) documentation.

- CLI {#cli}

    * `--cluster-name`: Cluster name.
    * `--tasks-max`: Number of concurrent processes. To distribute replication load evenly, we recommend a value of at least `2`.
    * `--properties`: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }}](https://kafka.apache.org/documentation/#connectconfigs) documentation.

    * `--topics`: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * `--file-compression-type`: Message compression codec. You cannot change this parameter after creating the cluster. Acceptable values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * `--file-max-records`: Maximum number of records that can be written to a single file in an S3-compatible storage.
    * `--bucket-name`: Name of the S3-compatible storage bucket to write data to.
    * `--storage-endpoint`: Endpoint for storage access (to be requested from the storage provider), e.g., `{{ s3-storage-host }}`.
    * `--region`: Region where the S3-compatible storage bucket is located. The default value is `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

    
    * `--access-key-id`, `--secret-access-key`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- {{ TF }} {#tf}

    * **properties**: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

        * `key.converter`
        * `value.converter`
        * `value.converter.schemas.enable`
        * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }}](https://kafka.apache.org/documentation/#connectconfigs) documentation.

    * **topics**: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * **file_compression_type**: Codec for message compression. You cannot change this parameter after creating the cluster. Acceptable values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * **file_max_records**: Maximum number of records that can be written to a single file in an S3-compatible storage.
    * **s3_connection**: S3-compatible storage connection parameters:

        * **bucket_name**: Name of the bucket to write data to.
        * **external_s3**: External S3-compatible storage connection parameters:

            * **endpoint**: Endpoint for storage access (to find out from storage provider), e.g., `{{ s3-storage-host }}`.
            * **region**: Region where the S3-compatible storage bucket is located. The default value is `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

            
            * **access_key_id**, **secret_access_key**: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- REST API {#api}

    The S3 Sink connector settings are specified in the `connectorSpec.connectorConfigS3Sink` parameter:

    * `topics`: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * `fileCompressionType`: Message compression codec. You cannot change this parameter after creating the cluster. Acceptable values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * `fileMaxRecords`: Maximum number of records that can be written to a single file in an S3-compatible storage.
    * `s3Connection`: S3-compatible storage connection parameters:
        * `bucketName`: Name of the bucket to write data to.
        * `externalS3`: External storage parameters:
            * `endpoint`: Endpoint for storage access (to be requested from the storage provider), e.g., `{{ s3-storage-host }}`.
            * `region`: Region where the S3-compatible storage bucket is located. The default value is `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

            
            * `accessKeyId`, `secretAccessKey`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- gRPC API {#grpc-api}

    The S3 Sink connector settings are specified in the `connector_spec.connector_config_s3_sink` parameter:

    * `topics`: Template for selecting topics to replicate. Topic names in the list are separated by a comma or `|`. You may use the `.*` expression, e.g., `analysis.*`. To migrate all topics, put `.*`.
    * `file_compression_type`: Message compression codec. You cannot change this parameter after creating the cluster. Acceptable values:

        * `none` (default): No compression
        * `gzip`: [gzip](https://www.gzip.org/) codec
        * `snappy`: [snappy](https://github.com/google/snappy) codec
        * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

    * `file_max_records`: Maximum number of records that can be written to a single file in an S3-compatible storage. Provided as an object with the `value` field:
    * `s3_connection`: S3-compatible storage connection parameters:
        * `bucket_name`: Name of the bucket to write data to.
        * `external_s3`: External storage parameters:
            * `endpoint`: Endpoint for storage access (to be requested from the storage provider), e.g., `{{ s3-storage-host }}`.
            * `region`: Region where the S3-compatible storage bucket is located. The default value is `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

            
            * `access_key_id`, `secret_access_key`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


{% endlist %}

## Editing a connector {#update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. In the line with the required connector, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.kafka.button_edit-connector }}**.
    1. Edit the connector properties as needed.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit a [MirrorMaker](#settings-mm2) connector:

    1. View the description of the CLI command to edit a connector:

        ```bash
        {{ yc-mdb-kf }} connector-mirrormaker update --help
        ```

    1. Run an operation, e.g., the task limit update operation:

        ```bash
        {{ yc-mdb-kf }} connector-mirrormaker update <connector_name> \
           --cluster-name=<cluster_name> \
           --direction=<connector_direction> \
           --tasks-max=<new_task_limit>
        ```

        Where `--direction` is the connector direction: `ingress` or `egres`.

        You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

    To update the [S3 Sink](#settings-s3) connector:

    1. View the description of the CLI command to edit a connector:

        ```bash
        {{ yc-mdb-kf }} connector-s3-sink update --help
        ```

    1. Run an operation, e.g., the task limit update operation:

        ```bash
        {{ yc-mdb-kf }} connector-s3-sink update <connector_name> \
           --cluster-name=<cluster_name> \
           --tasks-max=<new_task_limit>
        ```

        You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Check the list of [MirrorMaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

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
                topics             = "<topics_template>"
                replication_factor = <replication_factor>
                source_cluster {
                  alias = "<cluster_prefix>"
                  external_cluster {
                    bootstrap_servers           = "<list_of_broker_host_FQDNs>"
                    sasl_username               = "<username>"
                    sasl_password               = "<user_password>"
                    sasl_mechanism              = "<encryption_mechanism>"
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

        * For the S3 Sink connector:

            ```hcl
            resource "yandex_mdb_kafka_connector" "<S3_Sink_connector_name>" {
              cluster_id = "<cluster_ID>"
              name       = "<S3_Sink_connector_name>"
              tasks_max  = <task_limit>
              properties = {
                <advanced_properties>
             }
              connector_config_s3_sink {
                topics                = "<topics_template>"
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

    For more information, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect) provider documentation.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Connector.update](../api-ref/Connector/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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

       * `updateMask`: Comma-separated list of connector parameters to update presented as a single string.

            Specify the relevant parameters:
            * `connectorSpec.tasksMax`: To change the connector's task limit.
            * `connectorSpec.properties`: To change the connector's advanced properties.
            * `connectorSpec.connectorConfigMirrormaker.<configuring_Mirrormaker_connector>`: To update [Mirrormaker](#settings-mm2) connector settings.
            * `connectorSpec.connectorConfigS3Sink.<configuring_S3_Sink_connector>`: To update [S3 Sink](#settings-s3) connector settings.

       * `connectorSpec`: Specify MirrorMaker or S3 Sink connector settings.

       You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/Connector/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ConnectorService/Update](../api-ref/grpc/Connector/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        * `update_mask`: List of connector parameters to update as an array of `paths[]` strings.

            Specify the relevant parameters:
            * `connector_spec.tasks_max`: To change the connector's task limit.
            * `connector_spec.properties`: To change the connector's advanced properties.
            * `connector_spec.connector_config_mirrormaker.<configuring_Mirrormaker_connector>`: To update [Mirrormaker](#settings-mm2) connector settings.
            * `connector_spec.connector_config_s3_sink.<configuring_S3_Sink_connector>`: To update [S3 Sink](#settings-s3) connector settings.
        * `connector_spec`: Specify MirrorMaker or S3 Sink connector settings.

        You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/grpc/Connector/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Pausing a connector {#pause}

When you pause a connector:

* The connection to the target is broken.
* Data is deleted from the connector service topics.

To pause a connector:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the connector name and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To pause a connector, run the command:

    ```bash
    {{ yc-mdb-kf }} connector pause <connector_name> \
       --cluster-name=<cluster_name>
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Connector.pause](../api-ref/Connector/pause.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/pause/<connector_name>'
       ```

       You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/Connector/pause.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ConnectorService/Pause](../api-ref/grpc/Connector/pause.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/grpc/Connector/pause.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Resuming a connector {#resume}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the connector name and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To resume a connector, run the command:

    ```bash
    {{ yc-mdb-kf }} connector resume <connector_name> \
       --cluster-name=<cluster_name>
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Connector.pause](../api-ref/Connector/resume.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/resume/<connector_name>'
       ```

       You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/Connector/resume.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ConnectorService/Resume](../api-ref/grpc/Connector/resume.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/grpc/Connector/resume.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Importing a connector to {{ TF }} {#import}

Using import, you can bring the existing connectors under {{ TF }} management.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. In the {{ TF }} configuration file, specify the connector you want to import:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<connector_name>" {}
        ```

    1. Run the following command to import the connector:

        ```hcl
        terraform import yandex_mdb_kafka_connector.<connector_name> <cluster_ID>:<connector_name>
        ```

        To learn more about importing connectors, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect#import) provider documentation.

{% endlist %}

## Deleting a connector {#delete}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the relevant folder.
    1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the connector name and select **{{ ui-key.yacloud.common.delete }}**.
    1. Click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To delete a connector, run the command:

    ```bash
    {{ yc-mdb-kf }} connector delete <connector_name> \
       --cluster-name <cluster_name>
    ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Delete the `yandex_mdb_kafka_connector` resource with the connector description.
    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect) provider documentation.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Connector.pause](../api-ref/Connector/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

       ```bash
       curl \
         --request DELETE \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>/connectors/<connector_name>'
       ```

       You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/Connector/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ConnectorService/Delete](../api-ref/grpc/Connector/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

        You can request the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters) and the connector name with a [list of connectors in the cluster](#list).

    1. View the [server response](../api-ref/grpc/Connector/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
