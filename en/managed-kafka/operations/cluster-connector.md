# Managing connectors

[Connectors](../concepts/connectors.md) manage the transfer of {{ KF }} topics to other clusters or data storage systems.

You can:

* [Get a list of connectors](#list-connectors)
* [Create a connector](#create-connector)
* [Pause a connector](#pause-connector)
* [Resume a connector](#resume-connector)
* [Delete a connector](#delete-connector)

## Getting a list of connectors {#list-connectors}

{% list tabs %}

- Management console
    1. Go to the [catalog page]({{ link-console-main }}) and select **{{ mkf-name }}**.
    1. Go to the **Connectors** tab.

{% endlist %}

## Creating a connector {#create-connector}

{% list tabs %}

- Management console

    1. Go to the [catalog page]({{ link-console-main }}) and select **{{ mkf-name }}**.
    1. Go to the **Connectors** tab.
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

    1. Set the connector configuration:
        * [MirrorMaker](#settings-mm2).

        For more information about the supported connector types, see [{#T}](../concepts/connectors.md).

    1. Click **Create**.

{% endlist %}

## Pausing a connector {#pause-connector}

When you pause a connector:

* The connection to the target is broken.
* Data is deleted from the connector service topics.

To pause a connector:

{% list tabs %}

- Management console

    1. Go to the [catalog page]({{ link-console-main }}) and select **{{ mkf-name }}**.
    1. Go to the **Connectors** tab.
    1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the connector and select **Pause**.

{% endlist %}

## Resuming a connector {#resume-connector}

{% list tabs %}

- Management console
    1. Go to the [catalog page]({{ link-console-main }}) and select **{{ mkf-name }}**.
    1. Go to the **Connectors** tab.
    1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the connector and select **Resume**.

{% endlist %}

## Deleting a connector {#delete-connector}

{% list tabs %}

- Management console

    1. Go to the [catalog page]({{ link-console-main }}) and select **{{ mkf-name }}**.
    1. Go to the **Connectors** tab.
    1. Click ![ellipsis](../../_assets/horizontal-ellipsis.svg) next to the name of the connector and select **Delete**.
    1. Click **Delete**.

{% endlist %}

## Connector parameters {#connector-settings}

### MirrorMaker {#settings-mm2}

* **Topics**: A template for selecting topics to replicate. Topic names are listed separated by a comma or `|`. You can use prefixes with `*`.
* Under **Source cluster**, specify the parameters for connecting to the source cluster:
  * **Alias**: A prefix to indicate the source cluster in the connector settings.
  * **Use this cluster**: Select this option to use the current cluster as a source.
  * **Bootstrap servers**: A comma-separated list of the FQDNs of the source cluster's broker hosts with the port numbers to connect to.

     You can request {{ mkf-name }} broker FQDNs with [a list of hosts in the cluster](cluster-hosts.md#list-hosts).

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

     You can request {{ mkf-name }} broker FQDNs with [a list of hosts in the cluster](cluster-hosts.md#list-hosts).

  * **SASL username**: The username to use for connecting the connector to the target cluster.
  * **SASL password**: The user password to use for connecting the connector to the target cluster.
  * **SASL mechanism**: Select a mechanism for name and password encryption.
  * **Security protocol**: Select a protocol for connecting the connector:
    * `PLAINTEXT`, `SASL_PLAINTEXT`: For non-SSL connections.
    * `SSL`, `SASL_SSL`: For SSL connections.
