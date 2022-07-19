---
title: "Information about clusters in {{ mkf-name }}"
description: "You can request detailed information about each {{ mkf-name }} cluster you create. To get a list of database clusters in a directory, go to the directory page and select the {{ mkf-name }} service."
---

# Information about existing clusters

You can request detailed information about each {{ mkf-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.

{% if api != "noshow" %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ KF }} clusters in the default folder, run the command:

   ```
   {{ yc-mdb-kf }} cluster list
   ```

   Result:

   ```
   +----------------------+----------+---------------------+--------+---------+
   |          ID          |   NAME   |     CREATED AT      | HEALTH | STATUS  |
   +----------------------+----------+---------------------+--------+---------+
   | c9qaruvk2mmaeaf8h0el | kafka750 | 2020-12-18 05:21:27 | ALIVE  | RUNNING |
   | ...                                                                      |
   +----------------------+----------+---------------------+--------+---------+
   ```

- API

   Use the [list](../api-ref/Cluster/list.md) API method: pass the ID of the required folder in the `folderId` request parameter.

   The response will contain cluster names and IDs.

{% endif %}

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click on the name of the desired cluster.

{% if api != "noshow" %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ KF }} cluster, run the command:

   ```
   {{ yc-mdb-kf }} cluster get <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

   Use the [get](../api-ref/Cluster/get.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endif %}

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/mkf-list-operations-about.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to Billing.
   1. In the list of services, select **{{ mkf-name }}**.
   1. Click on the name of the desired cluster.
   1. Go to the **Operations** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the command:

   ```
   {{ yc-mdb-kf }} cluster list-operations <cluster name and ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

{% if api != "noshow" %}

- API

   To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) method.

{% endif %}

{% endlist %}
