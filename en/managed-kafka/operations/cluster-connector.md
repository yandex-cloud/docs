# Managing connectors

[Connectors](../concepts/connectors.md) manage the transfer of {{ KF }} topics to other clusters or data storage systems.

You can:

* [Get a list of connectors](#list).
* [Get detailed information about a connector](#get).
* [Create a connector](#create).
* [Edit a connector](#update).
* [Pause a connector](#pause).
* [Resume a connector](#resume).
* [Import a connector to {{ TF }}](#import).
* [Delete a connector](#delete).

## Getting a list of connectors {#list}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
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

- API {#api}

   To get a list of connectors, use the [list](../api-ref/Connector/list.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/List](../api-ref/grpc/connector_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting detailed information about a connector {#get}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
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

- API {#api}

   To get connector details, use the [get](../api-ref/Connector/get.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Get](../api-ref/grpc/connector_service.md#Get) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, retrieve a [list of cluster connectors](#list).

{% endlist %}

## Creating a connector {#create}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click **{{ ui-key.yacloud.kafka.button_create-connector }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, specify:

      * Connector name.
      * Task limit: Number of concurrent processes. We recommend a value of at least `2` for even replication load distribution.

   1. Under **{{ ui-key.yacloud.kafka.section_properties }}**, specify the connector properties in the following format:

      ```text
      <key>:<value>
      ```

      The key can either be a simple string or contain a prefix indicating that it belongs to the source or target (a cluster alias in the connector configuration):

      ```text
      <cluster_alias>.<key_body>:<value>
      ```

   1. Select the connector type: [MirrorMaker](#settings-mm2) or [S3 Sink](#settings-s3).

   1. Specify a configuration for the selected connector.

      For more information about the supported connector types, see [{#T}](../concepts/connectors.md).

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a [MirrorMaker](#settings-mm2) connector:

   1. View a description of the CLI command to create a connector:

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
         --topics=<topic_template> \
         --this-cluster-alias=<prefix_for_this_cluster> \
         --external-cluster alias=<prefix_for_external_cluster>,`
                           `bootstrap-servers=<list_of FQDNs_of_broker_hosts>,`
                           `security-protocol=<security_protocol>,`
                           `sasl-mechanism=<encryption_mechanism>,`
                           `sasl-username=<username>,`
                           `sasl-password=<user_password>,`
                           `ssl-truststore-certificates=<certificates_in_PEM_format>
      ```

      {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

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
      {{ yc-mdb-kf }} connector-s3-sink create <connector_name> \
         --cluster-name=<cluster_name> \
         --tasks-max=<task_limit> \
         --properties=<advanced_properties> \
         --topics=<topic_template> \
         --file-compression-type=<compression_codec> \
         --file-max-records=<maximum_number_of_messages_per_file> \
         --bucket-name=<bucket_name> \
         --access-key-id=<ID_of_AWS-compatible_static_key> \
         --secret-access-key=<contents_of_AWS-compatible_static_key> \
         --storage-endpoint=<endpoint_of_S3-compatible_storage> \
         --region=<region_of_S3-compatible_storage>
      ```

      You can retrieve the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Check the list of [Mirrormaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. To create a Mirrormaker connector, add the `yandex_mdb_kafka_connector` resource with the `connector_config_mirrormaker` settings section:

      ```hcl
      resource "yandex_mdb_kafka_connector" "<connector_name>" {
        cluster_id = "<cluster_ID>"
        name       = "<connector_name>"
        tasks_max  = <task_limit>
        properties = {
          <advanced_properties>
        }
        connector_config_mirrormaker {
          topics             = "<topic_template>"
          replication_factor = <replication_factor>
          source_cluster {
            alias = "<prefix_for_the_cluster>"
            external_cluster {
              bootstrap_servers           = "<list_of_FQDNs_of_broker_hosts>"
              sasl_username               = "<username>"
              sasl_password               = "<user_password>"
              sasl_mechanism              = "<encryption_mechanism>"
              security_protocol           = "<security_protocol>"
              ssl-truststore-certificates = "<contents_of_PEM_certificate>"
            }
          }
          target_cluster {
            alias = "<prefix_for_the_cluster>"
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
          topics                = "<topic_template>"
          file_compression_type = "<compression_codec>"
          file_max_records      = <maximum_number_of_messages_per_file>
          s3_connection {
            bucket_name = "<bucket_name>"
            external_s3 {
              endpoint          = "<endpoint_of_S3-compatible_storage>"
              access_key_id     = "<ID_of_AWS-compatible_static_key>"
              secret_access_key = "<contents_of_AWS_compatible_static_key>"
            }
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API {#api}

   To create a connector, use the [create](../api-ref/Connector/create.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Create](../api-ref/grpc/connector_service.md#Create) gRPC API call and provide the following in the request:

   * In the `clusterId` parameter, the ID of the cluster where you want to create a connector. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector settings in the `connectorSpec` parameter.

{% endlist %}

## Editing a connector {#update}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. In the line with the required connector, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.kafka.button_edit-connector }}**.
   1. Edit the connector properties as needed.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To edit a [MirrorMaker](#settings-mm2) connector:

   1. View a description of the CLI command to edit a connector:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker update --help
      ```

   1. Run an operation, such as the task limit change operation:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker update <connector_name> \
         --cluster-name=<cluster_name> \
         --direction=<connector_direction> \
         --tasks-max=<new_task_limit>
      ```

      Where `--direction` is the connector direction: `ingress` or `egress`.

      You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

   To update the [S3 Sink](#settings-s3) connector:

   1. View a description of the CLI command to edit a connector:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink update --help
      ```

   1. Run an operation, such as the task limit change operation:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink update <connector_name> \
         --cluster-name=<cluster_name> \
         --tasks-max=<new_task_limit>
      ```

      You can request the connector name with a [list of cluster connectors](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

   1. Check the list of [Mirrormaker](#settings-mm2) and [S3 Sink](#settings-s3) connector settings.

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Edit the parameter values in the `yandex_mdb_kafka_connector` resource description:

      * For the Mirrormaker connector:

         ```hcl
         resource "yandex_mdb_kafka_connector" "<connector_name>" {
           cluster_id = "<cluster_ID>"
           name       = "<connector_name>"
           tasks_max  = <task_limit>
           properties = {
             <advanced_properties>
           }
           connector_config_mirrormaker {
             topics             = "<topic_template>"
             replication_factor = <replication_factor>
             source_cluster {
               alias = "<prefix_for_the_cluster>"
               external_cluster {
                 bootstrap_servers           = "<list_of_FQDNs_of_broker_hosts>"
                 sasl_username               = "<username>"
                 sasl_password               = "<user_password>"
                 sasl_mechanism              = "<encryption_mechanism>"
                 security_protocol           = "<security_protocol>"
                 ssl-truststore-certificates = "<contents_of_PEM_certificate>"
               }
             }
             target_cluster {
               alias = "<prefix_for_the_cluster>"
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
             topics                = "<topic_template>"
             file_max_records      = <maximum_number_of_messages_per_file>
             s3_connection {
               bucket_name = "<bucket_name>"
               external_s3 {
                 endpoint          = "<endpoint_of_S3-compatible_storage>"
                 access_key_id     = "<ID_of_AWS_compatible_static_key>"
                 secret_access_key = "<contents_of_AWS_compatible_static_key>"
               }
             }
           }
         }
         ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API {#api}

   To update a connector, use the [update](../api-ref/Connector/update.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Update](../api-ref/grpc/connector_service.md#Update) gRPC API call and provide the following in the request:

   * ID of the cluster where you wish to create a connector in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector settings in the `connectorSpec` parameter.

{% endlist %}

## Pausing a connector {#pause}

When you pause a connector:

* The connection to the target is broken.
* Data is deleted from the connector service topics.

To pause a connector:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the name of the connector and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To pause a connector, run the command:

   ```bash
   {{ yc-mdb-kf }} connector pause <connector_name> \
      --cluster-name=<cluster_name>
   ```

- API {#api}

   To pause a connector, use the [pause](../api-ref/Connector/pause.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Pause](../api-ref/grpc/connector_service.md#Pause) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Resuming a connector {#resume}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the name of the connector and select **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To resume a connector, run the command:

   ```bash
   {{ yc-mdb-kf }} connector resume <connector_name> \
      --cluster-name=<cluster_name>
   ```

- API {#api}

   To resume a connector, use the [resume](../api-ref/Connector/resume.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Resume](../api-ref/grpc/connector_service.md#Resume) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

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

        To learn more about importing connectors, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_connect#import).

{% endlist %}

## Deleting a connector {#delete}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Select a cluster and open the **{{ ui-key.yacloud.kafka.label_connectors }}** tab.
   1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the name of the connector and select **{{ ui-key.yacloud.common.delete }}**.
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

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Delete the `yandex_mdb_kafka_connector` resource with the description of the connector you need.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API {#api}

   To delete a connector, use the [delete](../api-ref/Connector/delete.md) REST API method for the [Connector](../api-ref/Connector/index.md) resource or the [ConnectorService/Delete](../api-ref/grpc/connector_service.md#Delete) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Connector parameters {#settings}

### MirrorMaker {#settings-mm2}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example, `analysis.*`. To migrate all topics, specify `.*`.
   * **{{ ui-key.yacloud.kafka.label_replication-factor }}**: Number of topic copies stored in the cluster.
   * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}**, specify the parameters for connecting to the source cluster:
      * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Prefix for the source cluster in the connector settings.

         {% note info %}

         Topics in the target cluster are created with the indicated prefix.

         {% endnote %}

      * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as a source.
      * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Comma-separated list of the FQDNs of the source cluster broker hosts with the port numbers to connect to, e.g., `broker1.example.com:9091,broker2.example.com`.

         {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

      * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for connecting the connector to the source cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for connecting the connector to the source cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Select a mechanism for name and password encryption.
      * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select a protocol for connecting the connector:
         * `plaintext`, `sasl_plaintext`: For non-SSL connections
         * `ssl`, `sasl_ssl`: For SSL connections
      * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

   * Under **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}**, specify the parameters for connecting to the target cluster:
      * **{{ ui-key.yacloud.kafka.field_connector-alias }}**: Prefix for the target cluster in the connector settings.
      * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**: Select this option to use the current cluster as a target.
      * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}**: Сomma-separated list of the FQDNs of the target cluster broker hosts with the port numbers to connect to.

         {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

      * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**: Username for connecting the connector to the target cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}**: User password for connecting the connector to the target cluster.
      * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}**: Select a mechanism for name and password encryption.
      * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}**: Select a protocol for connecting the connector:
         * `plaintext`, `sasl_plaintext`: For non-SSL connections
         * `ssl`, `sasl_ssl`: For SSL connections
      * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}**: Upload a PEM certificate to access the external cluster.

   * To specify additional setting values not listed above, create the relevant keys and specify their values under **{{ ui-key.yacloud.kafka.section_properties }}** when [creating](#create) or [editing](#update) a connector. Here are some sample keys:

      * `key.converter`
      * `value.converter`

      For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

- CLI {#cli}

   * `--cluster-name`: Cluster name.
   * `--direction`: Connector direction:

      * `ingress`: If the cluster is a target.
      * `egress`: If the cluster is a source.

   * `--tasks-max`: Number of concurrent processes. We recommend a value of at least `2` for even replication load distribution.
   * `--properties`: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

      * `key.converter`
      * `value.converter`

      For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * `--replication-factor`: Number of topic copies stored in the cluster.
   * `--topics`: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example, `analysis.*`. To migrate all topics, specify `.*`.
   * `--this-cluster-alias`: Prefix for this cluster in the connector settings.
   * `--external-cluster`: Parameters of an external cluster:

      * `alias`: Prefix for the external cluster in the connector settings.
      * `bootstrap-servers`: Comma-separated list of the FQDNs of the external cluster broker hosts with the port numbers to connect to.

         {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

      * `security-protocol`: Connector connection protocol:

         * `plaintext`, `sasl_plaintext`: For non-SSL connections
         * `ssl`, `sasl_ssl`: For SSL connections

      * `sasl-mechanism`: Name and password encryption mechanism.
      * `sasl-username`: Username for connecting the connector to the external cluster.
      * `sasl-password`: User password for connecting the connector to the external cluster.
      * `ssl-truststore-certificates`: List of PEM certificates.

- {{ TF }} {#tf}

   * **properties**: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

      * `key.converter`
      * `value.converter`

      For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * **topics**: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example, `analysis.*`. To migrate all topics, specify `.*`.
   * **replication_factor**: Number of topic copies stored in the cluster.
   * **source_cluster** and **target_cluster**: Parameters for connecting to the source cluster and target cluster:
      * **alias**: Prefix for the cluster in the connector settings.

         {% note info %}

         Topics in the target cluster are created with the indicated prefix.

         {% endnote %}

      * **this_cluster**: Option to use the current cluster as a source or target.
      * **external_cluster**: Parameters for connecting to the external cluster:
         * **bootstrap_servers**: Comma-separated list of the FQDNs of the cluster broker hosts with the port numbers to connect to.

            {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

         * **sasl_username**: Username for connecting the connector to the cluster.
         * **sasl_password**: User password for connecting the connector to the cluster.
         * **sasl_mechanism**: Name and password encryption mechanism.
         * **security_protocol**: Connector connection protocol:
            * `plaintext`, `sasl_plaintext`: For non-SSL connections
            * `ssl`, `sasl_ssl`: For SSL connections
         * **ssl_truststore_certificates**: PEM certificate contents.

{% endlist %}

### S3 Sink {#settings-s3}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}**: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example, `analysis.*`. To migrate all topics, specify `.*`.
   * **{{ ui-key.yacloud.kafka.field_connector-compression-type }}**: Select the codec to compress messages:

      * `none` (default): No compression
      * `gzip`: [gzip](https://www.gzip.org) codec
      * `snappy`: [snappy](https://github.com/google/snappy) codec
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

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

- CLI {#cli}

   * `--cluster-name`: Cluster name.
   * `--tasks-max`: Number of concurrent processes. We recommend a value of at least `2` for even replication load distribution.
   * `--properties`: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * `--topics`: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example, `analysis.*`. To migrate all topics, specify `.*`.
   * `--file-compression-type`: Codec for message compression. You cannot change this parameter after creating the cluster. Acceptable values include:

      * `none` (default): No compression
      * `gzip`: [gzip](https://www.gzip.org) codec
      * `snappy`: [snappy](https://github.com/google/snappy) codec
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

   * `--file-max-records`: Maximum number of records that can be written to a single file in S3-compatible storage.
   * `--bucket-name`: Name of the bucket in S3-compatible storage to write data to.
   * `--storage-endpoint`: Endpoint for storage access (to find out from storage provider). Example: `{{ s3-storage-host }}`.
   * `--region`: Region where the bucket of S3-compatible storage is located. Default: `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).


   * `--access-key-id`, `--secret-access-key`: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


- {{ TF }} {#tf}

   * **properties**: Comma-separated list of advanced connector settings in `<key>:<value>` format. Here are some sample keys:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      For the list of all connector settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka). For the list of common connector settings, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#connectconfigs).

   * **topics**: Template for selecting topics to replicate. Topic names are separated by a comma or `|` in the list. You can use the `.*` expression, for example, `analysis.*`. To migrate all topics, specify `.*`.
   * **file_compression_type**: Codec for message compression. You cannot change this parameter after creating the cluster. Acceptable values include:

      * `none` (default): No compression
      * `gzip`: [gzip](https://www.gzip.org) codec
      * `snappy`: [snappy](https://github.com/google/snappy) codec
      * `zstd`: [zstd](https://facebook.github.io/zstd/) codec

   * **file_max_records**: Maximum number of records that can be written to a single file in S3-compatible storage.
   * **s3_connection**: S3-compatible storage connection parameters:

      * **bucket_name**: Name of the bucket to write data to.
      * **external_s3**: External S3-compatible storage connection parameters:

         * **endpoint**: Endpoint for storage access (to find out from storage provider). Example: `{{ s3-storage-host }}`.
         * **region**: Region where the bucket of S3-compatible storage is located. Default: `us-east-1`. [Available regions](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).


         * **access_key_id**, **secret_access_key**: [AWS-compatible key ID and contents](../../iam/concepts/authorization/access-key.md).


{% endlist %}
