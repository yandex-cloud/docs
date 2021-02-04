# Changing cluster settings


After creating an {{ KF }} cluster, you can:

- [Update the cluster configuration](#update-cluster).
- [Move the cluster](#move-cluster) from the current folder to another one.

{% note warning %}

If the cluster has dedicated {{ ZK }} hosts, you can't change their [class](../concepts/instance-types.md) or settings. For more information, see [{#T}](../concepts/index.md).

{% endnote %}

## Update the configuration {#update-cluster}

{% note warning %}

The number of {{ KF }} broker hosts can only be increased.

{% endnote %}

{% list tabs %}


- Management console

  1. Go to the folder page and select **{{ mkf-name }}**.

  1. Select the cluster and click **Edit** in the top panel.

  1. Change the required settings:
     - To change the class of [broker hosts](../concepts/brokers.md), select a new [host class](../concepts/instance-types.md) in the corresponding section.
     - To change storage settings, select the [storage type](../concepts/storage.md) and its size in the corresponding section.
     - To change the number of broker hosts in each availability zone that was chosen when [creating a cluster](cluster-create.md#create-cluster), change the value of the corresponding setting.

  1. Click **Save**.


- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - In the `updateMask` parameter, a list of settings to update (in a single line, comma-separated). If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.
  - The new cluster configuration in the `configSpec` parameter.

{% endlist %}


## Move a cluster {#move-cluster}

{% list tabs %}

- API

  To move a cluster from the current folder to a different one, use the [move](../api-ref/Cluster/move.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}
