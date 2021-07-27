---
title: "Information about clusters in {{ mrd-short-name }}"
description: "You can request detailed information about each {{ mrd-short-name }} cluster you create. To get a list of database clusters in a directory, go to the directory page and select the {{ mrd-name }} service."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Information about existing clusters

You can request detailed information about each {{ mrd-short-name }} cluster you created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

  Go to the folder page and select **{{ mrd-name }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ RD }} clusters in the default folder, run the command:

  ```
  $ {{ yc-mdb-rd }} cluster list
  
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
  1. Go to the folder page and select **{{ mrd-name }}**.
  1. Click on the name of the cluster you need.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ RD }} cluster, run the command:

  ```
  $ {{ yc-mdb-rd }} cluster get <cluster name or ID>
  ```

  The cluster name and ID can be requested with a [list of clusters in the folder](#list-clusters).

{% endlist %}

