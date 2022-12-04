---
title: "Information about existing Elasticsearch clusters"
description: "You can request detailed information about each {{ mes-name }} cluster you created."
keywords:
  - Information about Elasticsearch hosts
  - Elasticsearch hosts
  - Elasticsearch
---

# Information about existing {{ ES }} clusters

You can request detailed information about each {{ mes-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of clusters, run the command:

   ```bash
   {{ yc-mdb-es }} cluster list
   ```

- API

   Use the `list` API method: pass the ID of the required folder in the `folderId` request parameter.

   The response will contain cluster names and IDs.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the desired cluster.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get cluster details, run the command:

   ```bash
   {{ yc-mdb-es }} cluster get <cluster name or ID>
   ```

   You can request a cluster name and ID with a [list of clusters in the folder](#list-clusters).

- API

   Use the `get` API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

The operation list shows operations with clusters and related resources (for example, hosts and shards).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Click on the name of the desired cluster.
   1. Go to the **Operations** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster operations, run the command:

   ```bash
   {{ yc-mdb-es }} cluster list-operations <cluster name and ID>
   ```

   You can request a cluster name and ID with a [list of clusters in the folder](#list-clusters).

- API

   Use the `listOperations` API method: pass the ID of the required cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endlist %}
