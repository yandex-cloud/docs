# Information about existing clusters

You can request detailed information about each {{ mpg-short-name }} cluster you created.

## Getting a list of database clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

  Go to the folder page and select **{{ mpg-name }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To request a list of {{ PG }} clusters in the default folder, run the command:

  ```
  $ {{ yc-mdb-pg }} cluster list
  
  +----------------------+---------------+-----------------------------+--------+---------+
  |          ID          |     NAME      |         CREATED AT          | HEALTH | STATUS  |
  +----------------------+---------------+-----------------------------+--------+---------+
  | c9wlk4v14uq79r9cgcku | mypg          | 2018-11-02T10:04:14.645214Z | ALIVE  | RUNNING |
  | ...                                                                                   |
  +----------------------+---------------+-----------------------------+--------+---------+
  ```

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get information about a {{ PG }} cluster, run the command:

  ```
  $ {{ yc-mdb-pg }} cluster get <cluster name or ID>
  ```

  The cluster name and ID can be requested with a [list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mpg-name }}**.
  1. Click on the name of the cluster you need.
  1. Go to the **Operations** tab.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations, run the command:

  ```
  $ {{ yc-mdb-pg }} cluster list-operations <cluster name or ID>
  ```

  The cluster name and ID can be requested with a [list of clusters in the folder](#list-clusters).

- API

  To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) method.

{% endlist %}

