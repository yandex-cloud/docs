---
title: "Information about clusters in {{ mms-short-name }}"
description: "You can request detailed information about each {{ mms-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mms-name }}."
---

# Information about existing clusters

You can request detailed information about each {{ mms-short-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ MS }} clusters in a folder, run the following command:

   ```bash
   {{ yc-mdb-ms }} cluster list
   ```

- API

   Use the [list](../api-ref/Cluster/list.md) API method: pass the ID of the required folder in the `folderId` request parameter.

   The response will contain cluster names and IDs.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the desired cluster.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MS }} cluster, run the command:

   ```bash
   {{ yc-mdb-ms }} cluster get <cluster ID or name>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

   Use the [get](../api-ref/Cluster/get.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click on the name of the desired cluster.
   1. Go to the **Operations** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the command:

   ```bash
   {{ yc-mdb-ms }} cluster list-operations <cluster ID or name>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

   Use the [listOperations](../api-ref/Cluster/listOperations.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}
