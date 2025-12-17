---
title: How to connect to a {{ CH }} cluster from {{ datalens-name }}
description: Follow this guide to connect to a {{ CH }} cluster from {{ datalens-name }}.
---

# Connecting to a {{ CH }} cluster from {{ datalens-name }}

{% include [mdb-datalens-connector-intro](../../_includes/mdb/datalens-connector-intro.md) %}

To use an existing cluster as a data source for {{ datalens-name }}:
1. [Activate {{ datalens-full-name }}](#activate-datalens).
1. [Enable access to the cluster from {{ datalens-name }}](#allow-access).
1. [Create a cluster connection in {{ datalens-name }}](#create-connector).

## Activating {{ datalens-name }} {#activate-datalens}

You can only connect a cluster to {{ datalens-name }} within your cloud if {{ datalens-name }} is activated in the same folder as the cluster.

If {{ datalens-name }} is activated in a different folder, you can connect a cluster as an external resource as long as the cluster is publicly accessible. Learn more about connecting to a cluster from a different folder [here](../../datalens/operations/connection/create-clickhouse.md).

{% include [mdb-activate-datalens](../../_includes/mdb/datalens-activate.md) %}

## Enabling access to a cluster from {{ datalens-name }} {#allow-access}

To enable {{ datalens-name }} to connect to your cluster and work with its data, enable **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** when [creating](cluster-create.md) or [reconfiguring](update.md#change-additional-settings) the cluster.

## Creating a cluster connection {#create-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure **{{ datalens-name }}** is [activated](#activate-datalens) in the appropriate folder and you [can access](#allow-access) the cluster from it.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}**.

     {% cut "I have no **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}** button" %}

     
     If you see a message saying _{{ ui-key.yacloud.mdb.datalens.label_activate-datalens-title }}_ instead of the **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}** button, it means that you either have not activated {{ datalens-name }} yet or have connected it in a different folder. To connect your cluster to a {{ datalens-name }} instance from another folder, follow [this {{ datalens-name }} guide](../../datalens/operations/connection/create-clickhouse.md).


     {% endcut %}

  1. [Set up your connection](#connector-settings).
  1. Check that the settings are correct by clicking **Check connection**.
  1. After successfully checking the connection, click **Create**.

{% endlist %}

After creating the connection, you can:
* [Update](#update-connector) or [delete](#delete-connector) this connection.
* Use this connection to [create datasets](../../datalens/dataset/index.md) from the cluster data.
* Visualize the datasets using [charts](../../datalens/concepts/chart/index.md) and [dashboards](../../datalens/concepts/dashboard.md).


See also an [example of {{ CH }} data visualization](../../tutorials/datalens/data-from-ch-visualization.md).


## Viewing a list of cluster connections {#connectors-list}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}** tab.

     {% cut "My connection is not on the list" %}

     If your connection is missing from the list, it means the cluster is connected to {{ datalens-name }} as an external source. Learn more about {{ datalens-name }} [here](../../datalens/).

     {% endcut %}

{% endlist %}

## Updating a cluster connection {#update-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}** tab.
  1. Select the connection from the list.

     {% cut "My connection is not on the list" %}

     If your connection is missing from the list, it means the cluster is connected to {{ datalens-name }} as an external source. Learn more about {{ datalens-name }} [here](../../datalens/).

     {% endcut %}

  1. Change the [settings](#connector-settings).
  1. Check that the settings are correct by clicking **Check connection**.
  1. After successfully checking the connection, click **Save**.

{% endlist %}

## Deleting a cluster connection {#delete-connector}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the cluster is in.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}** tab.
  1. Select the connection from the list.

     {% cut "My connection is not on the list" %}

     If your connection is missing from the list, it means the cluster is connected to {{ datalens-name }} as an external source. Learn more about {{ datalens-name }} [here](../../datalens/).

     {% endcut %}

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) at the top of the page and select **Delete**.
  1. In the window that opens, click **Delete**.

{% endlist %}

## Connection settings {#connector-settings}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), when [creating](#create-connector) or [updating](#update-connector) a cluster connection:
  1. Specify a name for the connection.
  1. Go to the **Select in folder** tab.
  1. Select the cluster and its host from the drop-down lists or [create a new cluster](cluster-create.md) in the folder with {{ datalens-name }} by clicking **Create new**.
  1. Select the user from the drop-down list.
  1. Enter this user's password.

     Leave the values of the following settings unchanged: **HTTP interface port**, **HTTPS**, **Cache TTL in seconds**, and **Raw SQL level**.

{% endlist %}

{% cut "My cluster and {{ datalens-name }} are in different folders" %}

If your cluster and {{ datalens-name }} are in different folders, use the settings from [this {{ datalens-name }} guide](../../datalens/operations/connection/create-clickhouse.md).

{% endcut %}

If the [**Read only**](cluster-users.md#setting-readonly) setting is enabled for the user, make sure its value is `0` or `2`. Otherwise, the connection will not work.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
