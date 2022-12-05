# Connecting to a {{ CH }} cluster from {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

To use an existing cluster as a data source for {{ datalens-name }}:
1. [Activate{{ datalens-name }}](#activate-datalens).
1. [Enable access to the cluster from {{ datalens-name }}](#allow-access).
1. [Create a cluster connection in {{ datalens-name }}](#create-connector).

## Activating {{ datalens-name }} {#activate-datalens}

You can connect a cluster to {{ datalens-name }} within your cloud only if {{ datalens-name }} is activated in the same folder as the cluster.

If {{ datalens-name }} is activated in a different folder, you can connect a cluster as an external resource provided that public access to the cluster is enabled. [Learn more about how to connect to a cluster from a different folder](../../datalens/operations/connection/create-clickhouse.md).

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Allowing access to a cluster from {{ datalens-name }} {#allow-access}

To enable {{ datalens-name }} to connect to your cluster and work with its data, activate the **Access from {{ datalens-name }}** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings).

## Creating a connection to a cluster {#create-connector}

{% list tabs %}

- Management console

   1. Make sure that **{{ datalens-name }}** is [activated](#activate-datalens) in the appropriate folder and [allowed](#allow-access) to access the cluster.
   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.
   1. Click **Create connection**.

      {% cut "I have no "Create connection" button" %}

      {% if audience != "internal" %}

      If instead of the **Create connection** button you see a "{{ datalens-name }} not activated" message, it means that you either didn't activate {{ datalens-name }} or connected it in a different folder. To connect your cluster to a {{ datalens-name }} instance from another folder, follow the [instructions](../../datalens/operations/connection/create-clickhouse.md) in the {{ datalens-name }} documentation.

      {% else %}

      If instead of the **Create connection** button you see a "{{ datalens-name }} not activated" message, it means that you either didn't activate {{ datalens-name }} or connected it in a different folder.

      {% endif %}

      {% endcut %}

   1. Specify the [connection settings](#connector-settings).
   1. Check that the settings are correct by clicking **Check connection**.
   1. After successfully checking the connection, click **Create**.

{% endlist %}

Once the connection is created, you can:
* [Update](#update-connector) or [delete](#delete-connector) the connection.
* [Create datasets](../../datalens/concepts/dataset/index.md) with cluster data using the connection.
* Visualize the datasets using [charts](../../datalens/concepts/chart/index.md) and [dashboards](../../datalens/concepts/dashboard.md).

{% if audience != "internal" %}

See an [example of data visualization from {{ CH }}](../../tutorials/datalens/data-from-ch-visualization.md).

{% endif %}

## Viewing a list of cluster connections {#connectors-list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.

      {% cut "My connection is not in the list" %}

      If the desired connection is missing from the list, this means that the cluster is connected to {{ datalens-name }} as an external source. [Learn more about {{ datalens-name }}](../../datalens/).

      {% endcut %}

{% endlist %}

## Updating a cluster connection {#update-connector}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.
   1. Select a connection from the list.

      {% cut "My connection is not in the list" %}

      If the desired connection is missing from the list, this means that the cluster is connected to {{ datalens-name }} as an external source. [Learn more about {{ datalens-name }}](../../datalens/).

      {% endcut %}

   1. Change the [settings](#connector-settings).
   1. Check that the settings are correct by clicking **Check connection**.
   1. After successfully checking the connection, click **Save**.

{% endlist %}

## Deleting a cluster connection {#delete-connector}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.
   1. Select a connection from the list.

      {% cut "My connection is not in the list" %}

      If the desired connection is missing from the list, this means that the cluster is connected to {{ datalens-name }} as an external source. [Learn more about {{ datalens-name }}](../../datalens/).

      {% endcut %}

   1. Click ![image](../../_assets/horizontal-ellipsis.svg) at the top of the page and select **Delete**.
   1. Confirm the deletion.

{% endlist %}

## Connection settings {#connector-settings}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}), when [creating](#create-connector) or [updating](#update-connector) a cluster connection:
   1. Specify a name for the connection.
   1. Go to the **Select in folder** tab.
   1. Select the cluster and its host from the drop-down lists or [create a new cluster](cluster-create.md) in the folder with {{ datalens-name }} by clicking **Create new**.
   1. Select a user from the drop-down list.
   1. Enter this user's password.

      Leave the values of the following settings unchanged: **HTTP interface port**, **HTTPS**, **Cache lifetime in seconds**, and **Raw SQL level**.

{% endlist %}

{% cut "The cluster and {{ datalens-name }} are in different folders" %}

If the cluster and {{ datalens-name }} are in different folders, use the settings from the [instructions](../../datalens/operations/connection/create-clickhouse.md) in the {{ datalens-name }} documentation.

{% endcut %}

If the [**Read only** setting](cluster-users.md#setting-readonly) is selected for the user, make sure its value is `0` or `2`.

Otherwise, the connection won't work.
