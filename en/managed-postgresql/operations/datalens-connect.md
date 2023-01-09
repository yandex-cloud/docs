# Connecting to a {{ PG }} cluster from {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

To use an existing cluster as a data source for {{ datalens-full-name }}:
1. [Activate {{ datalens-name }}](#activate-datalens).
1. [Enable access to the cluster from {{ datalens-name }}](#allow-access).
1. [Create a cluster connection in {{ datalens-name }}](#create-connector).

## Activating {{ datalens-name }} {#activate-datalens}

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Allowing access to a cluster from {{ datalens-name }} {#allow-access}

To enable {{ datalens-name }} to connect to your cluster and work with its data, activate the **Access from {{ datalens-name }}** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings).

## Creating a connection to a cluster {#create-connector}

{% list tabs %}

- Management console

   1. Make sure that {{ datalens-name }} is [activated](#activate-datalens) in the necessary folder and cluster access from it is [allowed](#allow-access).
   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.
   1. Click **Create connection**.

      {% cut "I don't have a "Create connection" button" %}

      If instead of the **Create connection** button you see a "{{ datalens-name }} not activated" message, it means that you either didn't activate {{ datalens-name }} or connected it in a different folder. To connect your cluster to a {{ datalens-name }} instance from another folder, follow the [instructions](../../datalens/operations/connection/create-postgresql.md) in the {{ datalens-name }} documentation.

      {% endcut %}

   1. Specify the [connection settings](#connector-settings).
   1. In the upper-right corner, select the connection scope from the drop-down list:
      * Available only to me.
      * Available to the company.
   1. Check that the settings are correct by clicking **Check connection**.
   1. After successfully checking the connection, click **Create connection**.
   1. In the resulting window, enter a name for the connection and click **Create**.

{% endlist %}

Once the connection is created, you can:
* [Update](#update-connector) or [delete](#delete-connector) the connection.
* [Create datasets](../../datalens/concepts/dataset/index.md) with cluster data using the connection.
* Visualize the datasets using [charts](../../datalens/concepts/chart/index.md) and [dashboards](../../datalens/concepts/dashboard.md).

## Viewing a list of cluster connections {#connectors-list}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.

{% endlist %}

## Updating a cluster connection {#update-connector}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.
   1. Select a connection from the list.
   1. Edit the connection [settings](#connector-settings) and scope.
   1. Check that the settings are correct by clicking **Check connection**.
   1. After successfully checking the connection, click **Save changes**.

{% endlist %}

## Deleting a cluster connection {#delete-connector}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mpg-name }}**.
   1. Click the name of the desired cluster and open the **{{ datalens-name }}** tab.
   1. Select a connection from the list.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) at the top of the page and select **Delete**.
   1. In the window that opens, click **Delete**.

{% endlist %}

## Connection settings {#connector-settings}

{% list tabs %}

- Management console

   1. Specify a name for the connection.
   1. If the cluster and {{ datalens-name }} are in the same folder:
      1. Go to the **Select in cloud** tab.
      1. Select the cluster and its host from the drop-down lists or [create a new cluster](cluster-create.md) in the folder with {{ datalens-name }} by clicking **Create new**.
      1. Leave the **Port** setting value unchanged.
      1. Select a **database name** from the drop-down list.
      1. Select a user from the drop-down list.
      1. Enter this user's password.
      1. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
      1. Configure a **SQL query access level**.
      1. To explicitly define a collation for DB queries, go to **Advanced connection settings**. Select a mode to configure **Setting collate in a query**:
         * **Auto**: The default setting is used, {{ datalens-name }} decides whether to enable the `en_US` locale.
         * **On**: The {{ datalens-name }} setting is used, the `en_US` locale is specified for individual expressions in a query. This makes the server use the appropriate sorting logic, regardless of the server settings and specific tables. Use the {{ datalens-name }} setting if the DB locale is incompatible with {{ datalens-name }} performance. For more information about the locale and `LC_COLLATE`, see [{#T}](../../managed-postgresql/operations/cluster-create.md#create-cluster).
         * **Off**: The default setting is used, {{ datalens-name }} only uses the existing parameters of the DB locale.
   1. If the cluster and {{ datalens-name }} are in different folders, use the settings from the [instructions](../../datalens/operations/connection/create-postgresql.md) in the {{ datalens-name }} documentation.

{% endlist %}