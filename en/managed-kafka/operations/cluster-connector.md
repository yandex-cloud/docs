# Managing connectors

[Connectors](../concepts/connectors.md) manage the transfer of {{ KF }} topics to other clusters or data storage systems.

You can:

* [Get a list of connectors](#list-connectors), 
* [Create a connector](#create-connector),
* [Pause a connector](#pause-connector),
* [Resume a connector](#resume-connector),
* [Delete a connector](#delete-connector).

## Getting a list of connectors {#list-connectors}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.

- API

   Use the [list](../api-ref/Connector/list.md) API method and pass the cluster ID in the `clusterId` request parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Creating a connector {#create-connector}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
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

      The key can either be a simple string or contain a prefix indicating that it belongs to the source or target (a cluster alias in the [connector configuration](#settings-mm2)):

      ```text
      <cluster alias>.<key body>:<value>
      ```

   1. Set the [MirrorMaker](#settings-mm2) connector configuration:

      For more information about the supported connector types, see [{#T}](../concepts/connectors.md).

   1. Click **Create**.

- API

   Use the [create](../api-ref/Connector/create.md) API method and pass the following information in the request:
   * In the `clusterId` parameter, the ID of the cluster where you want to create a connector. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector settings in the `connectorSpec` parameter.

{% endlist %}

## Pausing a connector {#pause-connector}

When you pause a connector:

* The connection to the target is broken.
* Data is deleted from the connector service topics.

To pause a connector:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired connector and select **Pause**.

- API

   Use the [pause](../api-ref/Connector/pause.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Resuming a connector {#resume-connector}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired connector and select **Resume**.

- API

   Use the [resume](../api-ref/Connector/resume.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Deleting a connector {#delete-connector}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Select a cluster and open the **Connectors** tab.
   1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the desired connector and select **Delete**.
   1. Click **Delete**.

- API

   Use the [delete](../api-ref/Connector/delete.md) API method and pass the following in the request:
   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * Connector name in the `connectorName` parameter. To find out the name, [retrieve a list of cluster connectors](#list-connectors).

{% endlist %}

## Connector parameters {#connector-settings}

### MirrorMaker {#settings-mm2}

* **Topics**: A template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use the `.*` expression, for example `analysis.*`. To migrate all topics, specify `.*`.
* **Replication factor** — the number of topic copies stored in the cluster.
* Under **Source cluster**, specify the parameters for connecting to the source cluster:
   * **Alias**: A prefix to indicate the source cluster in the connector settings.

      {% note info %}

      Topics in the target cluster are created with the indicated prefix.

      {% endnote %}

   * **Use this cluster**: Select this option to use the current cluster as a source.
   * **Bootstrap servers**: A comma-separated list of the FQDNs of the source cluster's broker hosts with the port numbers to connect to.

      You can request {{ mkf-name }} broker FQDNs with a [list of hosts in the cluster](cluster-hosts.md#list-hosts).

   * **SASL username**: The username to use for connecting the connector to the source cluster.
   * **SASL password**: The user password to use for connecting the connector to the source cluster.
   * **SASL mechanism**: Select a mechanism for name and password encryption.
   * **Security protocol**: Select a protocol for connecting the connector:
      * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections.
      * `SSL`, `SASL_SSL`: For SSL connections.

* Under **Target cluster**, specify the parameters for connecting to the target cluster:
   * **Alias**: A prefix to indicate the target cluster in the connector settings.
   * **Use this cluster**: Select this option to use the current cluster as a target.
   * **Bootstrap servers**: A comma-separated list of the FQDNs of the target cluster's broker hosts with the port numbers to connect to.

      You can request {{ mkf-name }} broker FQDNs with a [list of hosts in the cluster](cluster-hosts.md#list-hosts).

   * **SASL username**: The username to use for connecting the connector to the target cluster.
   * **SASL password**: The user password to use for connecting the connector to the target cluster.
   * **SASL mechanism**: Select a mechanism for name and password encryption.
   * **Security protocol**: Select a protocol for connecting the connector:
      * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections.
      * `SSL`, `SASL_SSL`: For SSL connections.
