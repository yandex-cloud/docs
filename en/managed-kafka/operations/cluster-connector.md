# Managing connectors

[Connectors](../concepts/connectors.md) manage the transfer of {{ KF }} topics to other clusters or data storage systems.

You can:

* [Get a list of connectors](#list).
* [Create a connector](#create).
* [Edit a connector](#update).
* [Pause a connector](#pause).
* [Resume a connector](#resume).
* [Delete a connector](#delete).

## Getting a list of connectors {#list}

{% list tabs %}

* Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.

* API

   Use the [list](../api-ref/Connector/list.md) API method and pass the cluster ID in the `clusterId` request parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a connector {#create}

{% list tabs %}

* Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. Click **Create connector**.
   1. Under **Basic parameters**, specify:

      * Connector name.
      * Task limit: The number of concurrent processes. A value of at least `2` is recommended for even replication load distribution.

   1. Under **Additional properties**, specify the connector properties in the following format:

      ```text
      <key>:<value>
      ```

      The key can either be a simple string or contain a prefix indicating that it belongs to the source or target (a cluster alias in the connector configuration):

      ```text
      <cluster alias>.<key body>:<value>
      ```

   1. Select the connector type: [MirrorMaker](#settings-mm2) or [S3 sink](#settings-s3).

   1. Specify a configuration for the selected connector.

      For more information about the supported connector types, see [{#T}](../concepts/connectors.md).

   1. Click **Create**.

* {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add the `yandex_mdb_kafka_connector` resource:

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
              bootstrap_servers = "<list of FQDNs of broker hosts>"
              sasl_username     = "<username>"
              sasl_password     = "<user password>"
              sasl_mechanism    = "<encryption mechanism>"
              security_protocol = "<security protocol>"
            }
          }
          target_cluster {
            alias = "<cluster indication prefix>"
            this_cluster {}
          }
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_kafka_connect).

* API

   Use the [create](../api-ref/Connector/create.md) API method and pass the following information in the request:

   * In the `clusterId` parameter, the ID of the cluster where you want to create a connector. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector settings in the `connectorSpec` parameter.

{% endlist %}

## Editing a connector {#update}

{% list tabs %}

* Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. In the line with the required connector, click ![image](../../_assets/options.svg) and select **Edit connector**.
   1. Edit the connector properties as needed.
   1. Click **Save**.

* API

   Use the [update](../api-ref/Connector/update.md) API method and pass the following in the request:

   * ID of the cluster where you wish to create a connector in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector settings in the `connectorSpec` parameter.

{% endlist %}

## Pausing a connector {#pause}

When you pause a connector:

* The connection to the target is broken.
* Data is deleted from the connector service topics.

To pause a connector:

{% list tabs %}

* Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired connector and select **Pause**.

* API

   Use the [pause](../api-ref/Connector/pause.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Resuming a connector {#resume}

{% list tabs %}

* Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired connector and select **Resume**.

* API

   Use the [resume](../api-ref/Connector/resume.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Deleting a connector {#delete}

{% list tabs %}

* Management console

   1. In the [management console]({{ link-console-main }}), go to the desired folder.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired connector and select **Delete**.
   1. Click **Delete**.

* {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Delete the `yandex_mdb_kafka_connector` resource with the description of the desired connector.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_kafka_connect).

* API

   Use the [delete](../api-ref/Connector/delete.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Connector parameters {#settings}

### MirrorMaker {#settings-mm2}

{% list tabs %}

* Management console

   * **Topics**: A template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
   * **Replication factor** — the number of topic copies stored in the cluster.
   * Under **Source cluster**, specify the parameters for connecting to the source cluster:
      * **Alias**: A prefix to indicate the source cluster in the connector settings.

         {% note info %}

         Topics in the target cluster are created with the indicated prefix.

         {% endnote %}

      * **Use this cluster**: Select this option to use the current cluster as a source.
      * **Bootstrap servers**: A comma-separated list of the FQDNs of the source cluster's broker hosts with the port numbers to connect to. For example: `broker1.example.com:9091,broker2.example.com`.

         You can request the FQDNs of {{ mkf-name }} broker hosts with a [list of cluster hosts](cluster-hosts.md#list-hosts).

      * **SASL username**: The username to use for connecting the connector to the source cluster.
      * **SASL password**: The user password to use for connecting the connector to the source cluster.
      * **SASL mechanism**: Select a mechanism for name and password encryption.
      * **Security protocol**: Select a protocol for connecting the connector:
         * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections.
         * `SSL`, `SASL_SSL`: For SSL connections.

   * Under **Target cluster**, specify the parameters for connecting to the target cluster:
      * **Alias**: A prefix to indicate the target cluster in the connector settings.
      * **Use this cluster**: Select this option to use the current cluster as a target.
      * **Bootstrap servers**: Comma-separated list of the FQDNs or IPs of the target cluster's broker hosts with the ports to connect to.

         You can request the FQDNs of {{ mkf-name }} broker hosts with a [list of cluster hosts](cluster-hosts.md#list-hosts).

      * **SASL username**: The username to use for connecting the connector to the target cluster.
      * **SASL password**: The user password to use for connecting the connector to the target cluster.
      * **SASL mechanism**: Select a mechanism for name and password encryption.
      * **Security protocol**: Select a protocol for connecting the connector:
         * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections.
         * `SSL`, `SASL_SSL`: For SSL connections.

* {{ TF }}

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

{% endlist %}

### S3 Sink {#settings-s3}

* **Topics**: Template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
* **Compression type**: Select the codec to compress messages:

   * `none` (default): No compression.
   * `gzip`: The [gzip](https://www.gzip.org) codec.
   * `snappy`: The [snappy](https://github.com/google/snappy) codec.
   * `zstd`: The [zstd](https://facebook.github.io/zstd/) codec.

* (Optional) **Max records per file**: The maximum number of records that can be written into a single file in S3 storage.

* Under **S3 connection**, specify the storage connection parameters:

   * **Bucket name**: Storage bucket name.
   * **Endpoint**: Endpoint for storage access (to find out from storage provider).
   * (Optional) **Region**: Region description. Default: `us-east-1`.

   {% if audience != "internal" %}

   * (Optional) **Access key ID**, **Secret key**: [Service account key ID and body](../../iam/operations/authorized-key/create.md).

   {% endif %}

   To specify additional setting values not on this list, create the relevant keys and specify their values under **Advanced properties** when [creating](#create) or [editing](#update) a connector:

   * `key.converter`
   * `value.converter`
   * `value.converter.schemas.enable`
   * `format.output.type`

   For more information about advanced settings, see the [connector documentation](https://github.com/aiven/s3-connector-for-apache-kafka).
