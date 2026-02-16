---
title: How to connect to a {{ MY }} cluster from {{ datalens-name }}
description: Follow this guide to connect to a {{ MY }} cluster from {{ datalens-name }}.
---

# Connecting to a {{ MY }} cluster from {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

To use an existing cluster as a data source for {{ datalens-full-name }}:
1. [Activate {{ datalens-name }}](#activate-datalens).
1. [Enable access to the cluster from {{ datalens-name }}](#allow-access).
1. [Create a cluster connection in {{ datalens-name }}](#create-connector).

## Activating {{ datalens-name }} {#activate-datalens}

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Enabling access to a cluster from {{ datalens-name }} {#allow-access}

To enable {{ datalens-name }} to connect to your cluster and work with its data, enable **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}** when [creating](cluster-create.md) or [reconfiguring](update.md#change-additional-settings) the cluster.

## Creating a cluster connection {#create-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure {{ datalens-name }} is [activated](#activate-datalens) in the relevant folder and has [permission](#allow-access) to access the cluster.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}** tab.
  1. Click **Create connection**.

     {% cut "I have no **Create connection** button" %}

     If you see a message saying _DataLens not activated_ instead of the **Create connection** button, it means that you either have not activated {{ datalens-name }} yet or have activated it in a different folder. To connect your cluster to a {{ datalens-name }} instance from another folder, follow [this {{ datalens-name }} guide](../../datalens/operations/connection/create-mysql.md).

     {% endcut %}

  1. [Set up your connection](#connector-settings).
  1. In the top-right corner, select the connection scope from the drop-down list:
     * Available only to me.
     * Available to the company.
  1. Check that the settings are correct by clicking **Check connection**.
  1. After a successful check, click **Create connection**.
  1. Specify a name for the connection.
  1. Click **Create**.

{% endlist %}

After creating the connection, you can:
* [Update](#update-connector) or [delete](#delete-connector) this connection.
* Use this connection to [create datasets](../../datalens/dataset/index.md) from the cluster data.
* Visualize the datasets using [charts](../../datalens/concepts/chart/index.md) and [dashboards](../../datalens/concepts/dashboard.md).

## Viewing a list of cluster connections {#connectors-list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}** tab.

{% endlist %}

## Updating a cluster connection {#update-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.mysql.cluster.switch_datalens }}** tab.
  1. Select the connection from the list.
  1. Edit the connection [settings](#connector-settings) and scope as needed.
  1. Check that the settings are correct by clicking **Check connection**.
  1. After successfully checking the connection, click **Save**.

{% endlist %}

## Deleting a cluster connection {#delete-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **Managed Service for MySQL**.
  1. Click the name of your cluster and open the **DataLens** tab.
  1. Select the connection from the list.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) at the top of the page and select **Delete**.
  1. In the window that opens, click **Delete**.

{% endlist %}

## Connection settings {#connector-settings}

{% list tabs group=instructions %}

- Management console {#console}

  If your cluster and {{ datalens-name }} are in the same folder:
  1. Open the **Select in folder** tab.
  1. Select the cluster and its host from the drop-down lists or [create a new cluster](cluster-create.md) in the folder with {{ datalens-name }} by clicking **Create new**.
  1. Select the database and user from the drop-down lists.
  1. Enter the user password. See also [{#T}](../../datalens/operations/connection/create-mysql.md) and [{#T}](../../datalens/dataset/create-dataset.md#access) in the {{ datalens-name }} documentation.

  If your cluster and {{ datalens-name }} are in different folders:
  1. Navigate to the **Specify manually** tab.
  1. Use the settings from [this {{ datalens-name }} guide](../../datalens/operations/connection/create-mysql.md).

{% endlist %}