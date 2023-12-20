---
title: "Tutorial on connecting to\_a {{ MY }} cluster from {{ datalens-name }}"
description: "From this tutorial, you will learn how to connect to a {{ MY }} cluster from {{ datalens-name }}."
---

# Connecting to a {{ MY }} cluster from {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

To use an existing cluster as a data source for {{ datalens-full-name }}:
1. [Activate {{ datalens-name }}](#activate-datalens).
1. [Enable access to the cluster from {{ datalens-name }}](#allow-access).
1. [Create a cluster connection in {{ datalens-name }}](#create-connector).

## Activating {{ datalens-name }} {#activate-datalens}

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Allowing access to a cluster from {{ datalens-name }} {#allow-access}

To enable {{ datalens-name }} to connect to your cluster and work with its data, activate the **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}** option when [creating a cluster](cluster-create.md) or [updating its settings](update.md#change-additional-settings).

## Creating a connection to a cluster {#create-connector}

{% list tabs %}

- Management console

   1. Make sure that {{ datalens-name }} is [activated](#activate-datalens) in the appropriate folder and you [can access](#allow-access) the cluster from it.
   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}** tab.
   1. Click **Create connection**.

      {% cut "I have no "Create connection" button" %}

      If you see a message saying "DataLens not activated" instead of the **Create connection** button, it means that you either did not activate {{ datalens-name }} or connected it in a different folder. To connect your cluster to a {{ datalens-name }} instance from another folder, follow the [guide](../../datalens/operations/connection/create-mysql.md) in the {{ datalens-name }} documentation.

      {% endcut %}

   1. Specify the [connection settings](#connector-settings).
   1. In the top-right corner, select the connection scope from the drop-down list:
      * Available only to me.
      * Available to the company.
   1. Check that the settings are correct by clicking **Check connection**.
   1. If they are, click **Create connection**.
   1. Specify a name for the connection.
   1. Click **Create**.

{% endlist %}

Once the connection is created, you can:
* [Update](#update-connector) or [delete](#delete-connector) the connection.
* [Create datasets](../../datalens/concepts/dataset/index.md) with cluster data using the connection.
* Visualize the datasets using [charts](../../datalens/concepts/chart/index.md) and [dashboards](../../datalens/concepts/dashboard.md).

## Viewing a list of cluster connections {#connectors-list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}** tab.

{% endlist %}

## Updating a cluster connection {#update-connector}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}** tab.
   1. Select a connection from the list.
   1. Edit the connection [settings](#connector-settings) and scope.
   1. Check that the settings are correct by clicking **Check connection**.
   1. After successfully checking the connection, click **Save**.

{% endlist %}

## Deleting a cluster connection {#delete-connector}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **Managed Service for MySQL**.
   1. Click on the name of the cluster and select the **DataLens** tab.
   1. Select a connection from the list.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) at the top of the page and select **Delete**.
   1. In the window that opens, click **Delete**.

{% endlist %}

## Connection settings {#connector-settings}

{% list tabs %}

- Management console

   If the cluster and {{ datalens-name }} are in the same folder:
   1. Open the **Select in folder** tab.
   1. Select the cluster and its host from the drop-down lists or [create a new cluster](cluster-create.md) in the folder with {{ datalens-name }} by clicking **Create new**.
   1. Select the database and user from the drop-down lists.
   1. Enter the password for the user. For more information, refer to also [{#T}](../../datalens/operations/connection/create-mysql.md) and [{#T}](../../datalens/concepts/dataset/settings.md#access-management) in the {{ datalens-name }} documentation.

   If the cluster and {{ datalens-name }} are in different folders:
   1. Go to the **Specify manually** tab.
   1. Use the settings from the [tutorial](../../datalens/operations/connection/create-mysql.md) in the {{ datalens-name }} documentation.

{% endlist %}