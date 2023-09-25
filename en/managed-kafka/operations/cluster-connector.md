# Managing connectors

[Connectors](../concepts/connectors.md) manage the transfer of {{ KF }} topics to other clusters or data storage systems.

You can:

* [Get a list of connectors](#list)
* [Get detailed information about a connector](#get)
* [Create a connector](#create)
* [Edit a connector](#update)
* [Pause a connector](#pause)
* [Resume a connector](#resume)
* [Delete a connector](#delete)

## Getting a list of connectors {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster connectors, run the command:

   ```bash
   {{ yc-mdb-kf }} connector list --cluster-name=<cluster name>
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

- API

   To get a list of connectors, use the [list](../api-ref/Connector/list.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/List](../api-ref/grpc/connector_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting detailed information about a connector {#get}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click the name of the connector you need.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get detailed information about a connector, run this command:

   ```bash
   {{ yc-mdb-kf }} connector get <connector name>\
      --cluster-name=<cluster name>
   ```

   Result:

   ```text
   name: connector785
   tasks_max: "1"
   cluster_id: c9qbkmoiimslvj8ehkfi
   ...
   ```

   You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get connector details, use the [get](../api-ref/Connector/get.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Get](../api-ref/grpc/connector_service.md#Get) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, retrieve a [list of cluster connectors](#list).

{% endlist %}

## Creating a connector {#create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click **{{ ui-key.yacloud.kafka.button_create-connector }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, specify:

      * Connector name.
      * Task limit: Number of concurrent processes. We recommend a value not less than `2` for even replication load distribution.

   1. Under **{{ ui-key.yacloud.kafka.section_properties }}**, specify the connector properties in the following format:

      ```text
      <key>:<value>
      ```

      The key can either be a simple string or contain a prefix indicating that it belongs to the source or target (a cluster alias in the connector configuration):

      ```text
      <cluster alias>.<key body>:<value>
      ```

   1. Select the connector type: [MirrorMaker](#settings-mm2) or [S3 Sink](#settings-s3).

   1. Specify a configuration for the selected connector.

      For more information about the supported connector types, see [{#T}](../concepts/connectors.md).

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a [MirrorMaker](#settings-mm2) connector:

   1. View a description of the CLI command to create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker create --help
      ```

   1. Create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker create <connector name> \
         --cluster-name=<cluster name> \
         --direction=<connector direction: ingress or egress> \
         --tasks-max=<task limit> \
         --properties=<advanced properties> \
         --replication-factor=<replication factor> \
         --topics=<topic template> \
         --this-cluster-alias=<this cluster indication prefix> \
         --external-cluster alias=<external cluster indication prefix>,`
                           `bootstrap-servers=<list of FQDNs of broker hosts>,`
                           `security-protocol=<security protocol>,`
                           `sasl-mechanism=<encryption mechanism>,`
                           `sasl-username=<username>,`
                           `sasl-password=<user password>,`
                           `ssl-truststore-certificates=<PEM certificates>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

      The `--direction` parameter takes the value:

      * `egress`: If the current cluster is a source cluster.
      * `ingress`: If the current cluster is a target cluster.


   To create an [S3 Sink](#settings-s3) connector:

   1. View a description of the CLI command to create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create --help
      ```

   1. Create a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create <connector name> \
         --cluster-name=<cluster name> \
         --tasks-max=<task limit> \
         --properties=<advanced properties> \
         --topics=<topic template> \
         --file-compression-type=<compression codec> \
         --file-max-records=<maximum number of messages per file> \
         --bucket-name=<bucket name> \
         --access-key-id=<ID of AWS-compatible static key> \
         --secret-access-key=<contents of AWS-compatible static key> \
         --storage-endpoint=<endpoint of S3-compatible storage> \
         --region=<region of S3-compatible storage>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Check the list of [Mirrormaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To create a Mirrormaker connector, add the `yandex_mdb_kafka_connector` resource with the `connector_config_mirrormaker` settings section:

      ```hcl
      resource "yandex_mdb_kafka_connector" "<connector name>" {
        cluster_id = "<cluster ID>"
        name       = "<connector name>"
        tasks_max  = <task limit>
        properties = {
          <advanced properties>
        }
        connector_config_mirrormaker {
          topics             = "<topic template>"
          replication_factor = <replication factor>
          source_cluster {
            alias = "<cluster indication prefix>"
            external_cluster {
              bootstrap_servers           = "<list of FQDNs of broker hosts>"
              sasl_username               = "<username>"
              sasl_password               = "<user password>"
              sasl_mechanism              = "<encryption mechanism>"
              security_protocol           = "<security protocol>"
              ssl-truststore-certificates = "<PEM certificate contents>"
            }
          }
          target_cluster {
            alias = "<cluster indication prefix>"
            this_cluster {}
          }
        }
      }
      ```

   1. To create an S3 Sink connector, add the `yandex_mdb_kafka_connector` resource with the `connector_config_s3_sink` settings section:

      ```hcl
      resource "yandex_mdb_kafka_connector" "<connector name>" {
        cluster_id = "<cluster ID>"
        name       = "<connector name>"
        tasks_max  = <task limit>
        properties = {
          <advanced properties>
        }
        connector_config_s3_sink {
          topics                = "<topic template>"
          file_compression_type = "<compression codec>"
          file_max_records      = <maximum number of messages per file>
          s3_connection {
            bucket_name = "<bucket name>"
            external_s3 {
              endpoint          = "<endpoint of S3-compatible storage>"
              access_key_id     = "<ID of AWS-compatible static key>"
              secret_access_key = "<contents of AWS-compatible static key>"
            }
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm that the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API

   To create a connector, use the [create](../api-ref/Connector/create.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Create](../api-ref/grpc/connector_service.md#Create) gRPC API call and provide the following in the request:

   * In the `clusterId` parameter, the ID of the cluster where you want to create a connector. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector settings in the `connectorSpec` parameter.

{% endlist %}

## Editing a connector {#update}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. In the line with the required connector, click ![image](../../_assets/options.svg) and select **{{ ui-key.yacloud.kafka.button_edit-connector }}**.
   1. Edit the connector properties as needed.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit a [MirrorMaker](#settings-mm2) connector:

   1. View a description of the CLI command to edit a connector:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker update --help
      ```

   1. Run an operation, such as the task limit change operation:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker update <connector name> \
         --cluster-name=<cluster name> \
         --direction=<connector direction: ingress or egress> \
         --tasks-max=<new task limit>
      ```

      You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

   To update the [S3 Sink](#settings-s3) connector:

   1. View a description of the CLI command to edit a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink update --help
      ```

   1. Run an operation, such as the task limit change operation:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink update <connector name> \
         --cluster-name=<cluster name> \
         --tasks-max=<new task limit>
      ```

      You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Check the list of [Mirrormaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Edit the parameter values in the `yandex_mdb_kafka_connector` resource description:

      * For the Mirrormaker connector:

         ```hcl
         resource "yandex_mdb_kafka_connector" "<connector name>" {
           cluster_id = "<cluster ID>"
           name       = "<connector name>"
           tasks_max  = <task limit>
           properties = {
             <advanced properties>
           }
           connector_config_mirrormaker {
             topics             = "<topic template>"
             replication_factor = <replication factor>
             source_cluster {
               alias = "<cluster indication prefix>"
               external_cluster {
                 bootstrap_servers           = "<list of FQDNs of broker hosts>"
                 sasl_username               = "<username>"
                 sasl_password               = "<user password>"
                 sasl_mechanism              = "<encryption mechanism>"
                 security_protocol           = "<security protocol>"
                 ssl-truststore-certificates = "<PEM certificate contents>"
               }
             }
             target_cluster {
               alias = "<cluster indication prefix>"
               this_cluster {}
             }
           }
         }
         ```

      * For the S3 Sink connector:

         ```hcl
         resource "yandex_mdb_kafka_connector" "<S3 Sink connector name>" {
           cluster_id = "<cluster ID>"
           name       = "<S3 Sink connector name>"
           tasks_max  = <task limit>
           properties = {
             <advanced properties>
          }
           connector_config_s3_sink {
             topics                = "<topic template>"
             file_max_records      = <maximum number of messages per file>
             s3_connection {
               bucket_name = "<bucket name>"
               external_s3 {
                 endpoint          = "<endpoint of S3-compatible storage>"
                 access_key_id     = "<ID of AWS-compatible static key>"
                 secret_access_key = "<contents of AWS-compatible static key>"
               }
             }
           }
         }
         ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm that the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API

   To update a connector, use the [update](../api-ref/Connector/update.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Update](../api-ref/grpc/connector_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster where you wish to create a connector in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector settings in the `connectorSpec` parameter.

{% endlist %}

## Pausing a connector {#pause}

When you pause a connector:

* The connection to the target is broken.
* Data is deleted from the connector service topics.

To pause a connector:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the connector and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To pause a connector, run the command:

   ```bash
   {{ yc-mdb-kf }} connector pause <connector name> \
      --cluster-name=<cluster name>
   ```

- API

   To pause a connector, use the [pause](../api-ref/Connector/pause.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Pause](../api-ref/grpc/connector_service.md#Pause) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Resuming a connector {#resume}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the connector and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To resume a connector, run the command:

   ```bash
   {{ yc-mdb-kf }} connector resume <connector name> \
      --cluster-name=<cluster name>
   ```

- API

   To resume a connector, use the [resume](../api-ref/Connector/resume.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Resume](../api-ref/grpc/connector_service.md#Resume) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Deleting a connector {#delete}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the connector and select **{{ ui-key.yacloud.common.delete }}**.
   1. Click **{{ ui-key.yacloud.common.delete }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To delete a connector, run the command:

   ```bash
   {{ yc-mdb-kf }} connector delete <connector name> \
      --cluster-name <cluster name>
   ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the `yandex_mdb_kafka_connector` resource with the description of the desired connector.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm that the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API

   To delete a connector, use the [delete](../api-ref/Connector/delete.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Delete](../api-ref/grpc/connector_service.md#Delete) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Connector parameters {#settings}

### MirrorMaker {#settings-mm2}

{% list tabs %}

- Management console

   * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
   * **{{ ui-key.yacloud.kafka.label_replication-factor }}**: Number of topic copies stored in the cluster.
   * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}**, specify the parameters for connecting to the source cluster:
      * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Prefix for the source cluster in the connector settings.


         {% note info %}

         Topics in the target cluster are created with the indicated prefix.

         {% endnote %}

      * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as a source.
      * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Comma-separated list of the FQDNs of the source cluster broker hosts with the port numbers to connect to, e.g., `broker1.example.com:9091,broker2.example.com`.

         You can request the FQDNs of {{ mkf-name }} broker hosts with a [list of cluster hosts](cluster-hosts.md#list-hosts).

      * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for connecting the connector to the source cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for connecting the connector to the source cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Select a mechanism for name and password encryption.
      * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select a protocol for connecting the connector:
         * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections
         * `SSL`, `SASL_SSL`: For SSL connections
      * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

   * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}**, specify the parameters for connecting to the target cluster:
      * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Prefix for the target cluster in the connector settings.
      * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as a target.
      * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Comma-separated list of the FQDNs or IPs of the target cluster broker hosts with the ports to connect to.

         You can request the FQDNs of {{ mkf-name }} broker hosts with a [list of cluster hosts](cluster-hosts.md#list-hosts).

      * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for connecting the connector to the target cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for connecting the connector to the target cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Select a mechanism for name and password encryption.
      * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select a protocol for connecting the connector:
         * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections
         * `SSL`, `SASL_SSL`: For SSL connections
      * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

   * To specify additional setting values not listed above, create the relevant keys and specify their values under **{{ ui-key.yacloud.kafka.section_properties }}** when [creating](#create) or [editing](#update) a connector. Here are some sample keys:

      * `key.converter`
      * `value.converter`

      For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

- CLI

   * `--cluster-name` is the name of a cluster.
   * `--direction`: Connector direction:

      * `ingress`: If the cluster is a target.
      * `egress`: If the cluster is a source.

   * `--tasks-max`: The number of concurrent processes. A value of at least `2` is recommended for even replication load distribution.
   * `--properties`: A comma-separated list of advanced connector settings in `<key>:<value>` format. Sample keys:

      * `key.converter`
      * `value.converter`

      For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * `--replication-factor`: The number of topic copies stored in the cluster.
   * `--topics`: A template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
   * `--this-cluster-alias`: A prefix to indicate this cluster in the connector settings.
   * `--external-cluster`: Parameters of an external cluster:

      * `alias`: A prefix to indicate the external cluster in the connector settings.
      * `bootstrap-servers`: A comma-separated list of the FQDNs of the external cluster's broker hosts with the port numbers to connect to.
      * `security-protocol`: A connector connection protocol:

         * `plaintext`, `sasl_plaintext`: For non-SSL connections.
         * `ssl`, `sasl_ssl`: For SSL connections.

      * `sasl-mechanism`: A name and password encryption mechanism.
      * `sasl-username`: A username for connecting the connector to the external cluster.
      * `sasl-password`: A user password for connecting the connector to the external cluster.
      * `ssl-truststore-certificates`: A list of PEM certificates.

- {{ TF }}

   * **properties**: A comma-separated list of advanced connector settings in `<key>:<value>` format. Sample keys:

      * `key.converter`
      * `value.converter`

      For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * **topics**: A template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
   * **replication_factor**: The number of topic copies stored in the cluster.
   * **source_cluster** and **target_cluster**: Parameters for connecting to the source cluster and target cluster:
      * **alias**: A prefix to indicate the cluster in the connector settings.

         {% note info %}

         Topics in the target cluster are created with the indicated prefix.

         {% endnote %}

      * **this_cluster**: An option to use the current cluster as a source or target.
      * **external_cluster**: Parameters for connecting to the external cluster:
         * **bootstrap_servers**: A comma-separated list of the FQDNs of the cluster's broker hosts with the port numbers to connect to.
         * **sasl_username**: A username to use for connecting the connector to the cluster.
         * **sasl_password**: A user password to use for connecting the connector to the cluster.
         * **sasl_mechanism**: A name and password encryption mechanism.
         * **security_protocol**: A connector connection protocol:
            * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections.
            * `SSL`, `SASL_SSL`: For SSL connections.
         * **ssl_truststore_certificates**: PEM certificate contents.

{% endlist %}

### S3 Sink {#settings-s3}

{% list tabs %}

- Management console

   * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example, `analysis.*`. To migrate all topics, specify `.*`.
   * **{{ ui-key.yacloud.kafka.field_connector-compression-type }}**: Select the codec to compress messages:

      * `none` (default): No compression
      * `gzip`: [gzip](https://www.gzip.org) codec
      * `snappy`: [snappy](https://github.com/google/snappy) codec.
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec.

      You cannot change this parameter after creating the cluster.

   * (Optional) **{{ ui-key.yacloud.kafka.field_connector-file-max-records }}**: Maximum number of records that can be written to a single file in an S3-compatible storage.
   * Under **{{ ui-key.yacloud.kafka.field_connector-s3-connection }}**, specify the storage connection parameters:
      * **{{ ui-key.yacloud.kafka.field_connector-bucket-name }}**: Storage bucket name
      * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}**: Endpoint for storage access (to be requested from the storage provider)
      * (Optional) **{{ ui-key.yacloud.kafka.field_connector-region }}**: Region name. Default: `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

      
      * (Optional) **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}**: [ID and contents of the AWS compatible key](../../iam/concepts/authorization/access-key.md).


   * To specify additional setting values not listed above, create the relevant keys and specify their values under **{{ ui-key.yacloud.kafka.section_properties }}** when [creating](#create) or [editing](#update) a connector. Here are some sample keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

- CLI

   * `--cluster-name` is the name of a cluster.
   * `--tasks-max`: The number of concurrent processes. A value of at least `2` is recommended for even replication load distribution.
   * `--properties`: A comma-separated list of advanced connector settings in `<key>:<value>` format. Sample keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * `--topics`: A template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
   * `--file-compression-type`: Codec for message compression. You cannot change this parameter after creating the cluster. Acceptable values:

      * `none` (default): No compression.
      * `gzip`: [gzip](https://www.gzip.org) codec.
      * `snappy`: [snappy](https://github.com/google/snappy) codec.
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec.

   * `--file-max-records`: Maximum number of records that can be written to a single file in S3-compatible storage.
   * `--bucket-name`: The name of the bucket in S3-compatible storage to write data to.
   * `--storage-endpoint`: Endpoint for storage access (to find out from storage provider). Example: `{{ s3-storage-host }}`.
   * `--region`: Region where the bucket of S3-compatible storage is located. Default: `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

   
   * `--access-key-id`, `--secret-access-key`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- {{ TF }}

   * **properties**: A comma-separated list of advanced connector settings in `<key>:<value>` format. Sample keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * **topics**: A template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
   * **file_compression_type**: Codec for message compression. You cannot change this parameter after creating the cluster. Acceptable values:

      * `none` (default): No compression.
      * `gzip`: [gzip](https://www.gzip.org) codec.
      * `snappy`: [snappy](https://github.com/google/snappy) codec.
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec.

   * **file_max_records**: Maximum number of records that can be written to a single file in S3-compatible storage.
   * **s3_connection**: S3-compatible storage connection parameters:

      * **bucket_name**: The name of the bucket to write data to.
      * **external_s3**: External S3-compatible storage connection parameters:

         * **endpoint**: Endpoint for storage access (to find out from storage provider). Example: `{{ s3-storage-host }}`.
         * **region**: Region where the bucket of S3-compatible storage is located. Default: `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).

         
         * **access_key_id**, **secret_access_key**: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


{% endlist %}
