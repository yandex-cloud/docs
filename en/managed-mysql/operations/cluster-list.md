---
title: "Information about clusters in {{ mmy-short-name }}"
description: "You can request detailed information about each {{ mmy-short-name }} cluster you create. To get a list of database clusters in a directory, go to the directory page and select the {{ mmy-name }} service."
---

# Information about existing clusters

You can request detailed information about each {{ mmy-short-name }} cluster you created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

  Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ MY }} clusters in the default folder, run the command:

  ```
  {{ yc-mdb-my }} cluster list

  +----------------------+--------------+---------------------+--------+---------+
  |          ID          |     NAME     |     CREATED AT      | HEALTH | STATUS  |
  +----------------------+--------------+---------------------+--------+---------+
  | c9q5k4ve76jspng95lav | mysql-test   | 2019-07-09 11:05:25 | ALIVE  | RUNNING |
  | ...                                                                          |
  +----------------------+--------------+---------------------+--------+---------+
  ```

- API

  Use the [list](../api-ref/Cluster/list.md) API method and pass the folder ID in the `folderId` request parameter.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
  1. Click on the name of the desired cluster.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ MY }} cluster, run the command:

  ```
  {{ yc-mdb-my }} cluster get <cluster name or ID>
  ```

  You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

  Use the [get](../api-ref/Cluster/get.md) API method and pass the cluster ID in the `clusterId` request parameter.

  {% include [Getting the Cluster ID](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Management console

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmy-name }}**.
  1. Click on the name of the desired cluster.
  1. On the left-hand panel, select ![image](../../_assets/mdb/operations.svg) **Operations**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations, run the command:

  ```
  {{ yc-mdb-my }} cluster list-operations <cluster name and ID>
  ```

  You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

  Use the [listOperations](../api-ref/Cluster/listOperations.md) API method and pass the cluster ID in the `clusterId` request parameter.

  {% include [Getting the Cluster ID](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}
