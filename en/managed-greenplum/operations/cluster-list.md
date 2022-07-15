# Information about existing clusters

You can request detailed information about each {{ mgp-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   Go to the folder page and select **{{ mgp-name }}**.

- API

   Use the API [list](../api-ref/Cluster/list.md) method.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mgp-name }}**.
   1. Click on the name of the desired cluster.

- API

   Use the [get](../api-ref/Cluster/get.md) API method and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select the ![operations.svg](../../_assets/mdb/operations.svg) **Operations** tab.

- API

   Use the [listOperations](../api-ref/Cluster/listOperations.md) API method and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
