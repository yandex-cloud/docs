---
title: "Information about clusters in {{ mrd-short-name }}"
description: "You can request detailed information about each {{ mrd-short-name }} cluster you created. To get a list of database clusters in a folder, go to the folder page and select {{ mrd-name }}."
---

# Information about existing {{ RD }} clusters

You can request detailed information about each {{ mrd-short-name }} cluster you created.


## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder to get a list of clusters for.
   1. Select **{{ mrd-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ RD }} clusters in the default folder, run the command:

   ```
   {{ yc-mdb-rd }} cluster list
   ```

   Result:

   ```
   +----------------------+---------------+-----------------------------+--------+---------+
   |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
   +----------------------+---------------+-----------------------------+--------+---------+
   | c9qp9beeg4oth6lcqvt0 | myredis       | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
   | ...                                                                                   |
   +----------------------+---------------+-----------------------------+--------+---------+
   ```

{% endlist %}


## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder to get cluster details for.
   1. Select **{{ mrd-name }}**.
   1. Click on the name of the desired cluster.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ RD }} cluster, run the command:

   ```
   {{ yc-mdb-rd }} cluster get <cluster name or ID>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

{% endlist %}
