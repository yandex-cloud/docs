# Changing cluster settings

After creating a cluster, you can:

* [Change the host class](#change-resource-preset).

* [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd`, and `network-ssd`).

## Change the host class {#change-resource-preset}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. To change the class of {{ ES }} hosts with the *Data node* role:
     1. Go to the **Data node** tab.
     1. Under **Host class**, select the desired class for the host.
  1. To change the class of {{ ES }} hosts with the *Master node* role:
     1. Go to the **Master node** tab.
     1. Under **Host class**, select the desired class for the host.
  1. Click **Save**.

- API

  To change the [host class](../concepts/instance-types.md) for the cluster, use the [update](../api-ref/Cluster/update.md) method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Host class in the parameters:
    - `configSpec.elasticsearchSpec.dataNode.resources.resourcePresetId` (for hosts with the *Data node* role).
    - `configSpec.elasticsearchSpec.masterNode.resources.resourcePresetId` (for hosts with the *Master node* role).
  - The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

  To request a list of supported values, use the [list](../api-ref/ResourcePreset/list.md) method for the `ResourcePreset` resources.

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Select the cluster and click **Edit** in the top panel.
  1. To increase the disk size for {{ ES }} hosts with the *Data node* role:
     1. Go to the **Data node** tab.
     1. Under **Storage**, specify the disk size.
  1. To increase the disk size for {{ ES }} hosts with the *Master node* role:
     1. Go to the **Master node** tab.
     1. Under **Storage**, specify the disk size.
  1. Click **Save**.


- API

  To change the disk size for a cluster, use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Required disk size (in bytes) in the parameters:
    - `configSpec.elasticsearchSpec.dataNode.resources.diskSize` (for hosts with the *Data node* role).
    - `configSpec.elasticsearchSpec.masterNode.resources.diskSize`  (for hosts with the *Master node* role).
  - The list of settings to update in the `updateMask` parameter. If this parameter is omitted, the API method resets any cluster settings that aren't explicitly specified in the request to their default values.

{% endlist %}

