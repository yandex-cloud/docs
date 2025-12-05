---
title: How to connect to a {{ PG }} cluster from {{ datalens-name }}
description: Follow this guide to connect to a {{ PG }} cluster from {{ datalens-name }}.
---

# Connecting to a {{ PG }} cluster from {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

To use an existing cluster as a data source for {{ datalens-full-name }}:
1. [Activate {{ datalens-name }}](#activate-datalens).
1. [Enable access to the cluster from {{ datalens-name }}](#allow-access).
1. [Create a cluster connection in {{ datalens-name }}](#create-connector).

## Activating {{ datalens-name }} {#activate-datalens}

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Enabling {{ datalens-name }} access to the cluster {#allow-access}

To allow {{ datalens-name }} to connect to your cluster and work with its data, enable **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** when [creating](cluster-create.md) the cluster or [updating its settings](update.md#change-additional-settings).

![screen01](../../_assets/managed-postgresql/operations/datalens-connect/screen01.png)

## Creating a cluster connection {#create-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure {{ datalens-name }} is [activated](#activate-datalens) in the relevant folder and has [permission](#allow-access) to access the cluster.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.

     ![screen02](../../_assets/managed-postgresql/operations/datalens-connect/screen02.png)

  1. Click the relevant cluster’s name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}**.

     ![screen03](../../_assets/managed-postgresql/operations/datalens-connect/screen03.png)

     {% cut "I have no **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}** button" %}

     If you see the _{{ ui-key.yacloud.mdb.datalens.label_activate-datalens-title }}_ message instead of the **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}** button, you have either not yet activated {{ datalens-name }} or activated it in a different folder. To connect your cluster to a {{ datalens-name }} instance from another folder, follow [this {{ datalens-name }} guide](../../datalens/operations/connection/create-postgresql.md).

     {% endcut %}

  1. [Set up your connection](#connector-settings).
  1. Check that the settings are correct by clicking **Check connection**.
  1. After a successful connection test, click **Create connection**.

     ![screen04](../../_assets/managed-postgresql/operations/datalens-connect/screen04.png)

  1. In the window that opens, specify the connection name and click **Create**.

     ![screen05](../../_assets/managed-postgresql/operations/datalens-connect/screen05.png)

{% endlist %}

After creating the connection, you can:
* [Update](#update-connector) or [delete](#delete-connector) this connection.
* Use this connection to [create datasets](../../datalens/dataset/index.md) from the cluster data.
* Visualize the datasets using [charts](../../datalens/concepts/chart/index.md) and [dashboards](../../datalens/concepts/dashboard.md).

## Viewing a list of cluster connections {#connectors-list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}** tab.

     ![screen11](../../_assets/managed-postgresql/operations/datalens-connect/screen11.png)

{% endlist %}

## Updating a cluster connection {#update-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}** tab.
  1. Select the connection from the list.

     ![screen12](../../_assets/managed-postgresql/operations/datalens-connect/screen12.png)

  1. Change the [settings](#connector-settings).
  1. Check that the settings are correct by clicking **Check connection**.
  1. After a successful connection test, click **Save changes**.

     ![screen06](../../_assets/managed-postgresql/operations/datalens-connect/screen06.png)

{% endlist %}

## Deleting a cluster connection {#delete-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_datalens }}** tab.
  1. Select the connection from the list.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) at the top of the page and select **Delete**.

     ![screen07](../../_assets/managed-postgresql/operations/datalens-connect/screen07.png)

  1. In the window that opens, click **Delete**.

     ![screen08](../../_assets/managed-postgresql/operations/datalens-connect/screen08.png)

{% endlist %}

## Connection settings {#connector-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. If your cluster and {{ datalens-name }} are in the same organization:
     1. Navigate to the **Select in organization** tab.
     1. Select the cloud and folder where your cluster is located.
     1. Select the cluster and its host from the drop-down lists or [create a new cluster](cluster-create.md) in the folder with {{ datalens-name }} by clicking **Create new**.
     1. Leave the **Port** setting unchanged.
     1. Select **Path to database** from the drop-down list.
     1. Select the user from the drop-down list.
     1. Enter this user's password.
     1. Specify the cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).
     1. Configure the **Raw SQL level**.

        ![screen09](../../_assets/managed-postgresql/operations/datalens-connect/screen09.png)

     1. To explicitly specify collation for your database queries, navigate to **Advanced connection settings**. Select a **Query-level collation** mode:
        * **Auto**: Applies the default setting. The decision to enable the `en_US` locale is delegated to {{ datalens-name }}.
        * **On**: Applies the {{ datalens-name }} setting. The `en_US` locale is specified for individual expressions within a query. This ensures the server uses the appropriate sorting logic, regardless of its settings or the specific tables involved. Use the {{ datalens-name }} setting if your database locale is incompatible with {{ datalens-name }}. For more information about the locale and the `LC_COLLATE` setting, see [Creating a cluster](./cluster-create.md#create-cluster).
        * **Off**: Applies the default setting. {{ datalens-name }} uses database-level locale settings.

        ![screen10](../../_assets/managed-postgresql/operations/datalens-connect/screen10.png)

   1. If the cluster and {{ datalens-name }} belong to different organizations, apply the configuration from this {{ datalens-name }} [tutorial](../../datalens/operations/connection/create-postgresql.md).

{% endlist %}
