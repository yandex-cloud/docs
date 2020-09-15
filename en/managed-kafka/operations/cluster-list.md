# Information about existing clusters

You can request detailed information about each {{ mkf-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

  Go to the folder page and select **{{ mkf-name }}**.

{% if api != "noshow" %}

- API

  Use the [list](../api-ref/Cluster/list.md) API method: pass the ID of the required folder in the `folderId` request parameter.

  The response will contain cluster names and IDs.

{% endif %}

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click on the name of the cluster you need.

{% if api != "noshow" %}

- API

  Use the [get](../api-ref/Cluster/get.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](#list-clusters).

{% endif %}

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% include [list-operations-about](../../_includes/mdb/list-operations-about.md) %}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mkf-name }}**.
  1. Click on the name of the cluster you need.

  1. Go to the **Operations** tab.

{% if api != "noshow" %}

- API

  To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) method.

{% endif %}

{% endlist %}
