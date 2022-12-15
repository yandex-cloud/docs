---
title: "Information about clusters in {{ mmg-short-name }}"
description: "You can request detailed information about each {{ mmg-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mmg-name }}."
---

# Information about existing {{ MG }} clusters

You can request detailed information about each {{ mmg-short-name }} cluster you created.


## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ MG }} clusters in the default folder, run the command:

   ```
   yc managed-mongodb cluster list
   
   +----------------------+------------+-----------------------------+--------+---------+
   |          ID          |    NAME    |         CREATED AT          | HEALTH | STATUS  |
   +----------------------+------------+-----------------------------+--------+---------+
   | c9wlk4v14uq79r9cgcku | mymg       | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
   | ...                                                                                |
   +----------------------+------------+-----------------------------+--------+---------+
   ```

{% endlist %}


## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the desired cluster.

   {% note tip %}
   

   To request access to [Point-in-Time-Recovery](../concepts/backup.md) (PITR) in the [Preview](../../overview/concepts/launch-stages.md) mode, click **Request access** in the **Point-in-time recovery** line and fill out the form.


   {% endnote %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ MG }} cluster, run the command:

   ```
   {{ yc-mdb-mg }} cluster get <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the desired cluster.
   1. On the left-hand panel, select ![image](../../_assets/mdb/operations.svg) **Operations**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the command:

   ```
   {{ yc-mdb-mg }} cluster list-operations <cluster name and ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

   To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) method.

{% endlist %}
