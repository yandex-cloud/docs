# Changing cluster settings

After creating an {{ KF }} cluster, you can:

- [Update the cluster configuration](#update-cluster).
- [Move the cluster](#move-cluster) from the current folder to another one.

## Update the configuration {#update-cluster}

{% list tabs %}

{% if api != "noshow" %}

- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The new cluster configuration in the `configSpec` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't explicitly specified in the `configSpec` parameter to their default values.
  To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

  {% endnote %}

{% endif %}

{% endlist %}

## Move a cluster {#move-cluster}

{% list tabs %}

{% if api != "noshow" %}

- API

  To move a cluster from the current folder to a different one, use the [move](../api-ref/Cluster/move.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The ID of the destination folder in the `destinationFolderId` parameter.

{% endif %}

{% endlist %}
