# Changing cluster settings

After creating a cluster, you can:

- [Change the host class](#change-resource-preset).
- [Increase the storage size](#change-disk-size) (available only for network storage, `network-hdd`, and `network-ssd`).
- [Change {{ MS }} settings](#change-sqlserver-config) according to the {{ MS }} documentation.
- [Move the cluster](#move-cluster) to another folder.

## Change the host class {#change-resource-preset}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Select a new [host class](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.
  1. Click **Save changes**.

- API

  To change the [host class](../concepts/instance-types.md) for the cluster, use the `update` method and pass the following in the request:
  - The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - New host class, in the `configSpec.resources.resourcePresetId` parameter. To find out the list of supported values, use the `list` method for `ResourcePreset`.
  - List of cluster configuration fields to be changed (in this case, `configSpec.resources.resourcePresetId`), in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

## Increasing storage size {#change-disk-size}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Specify the required storage size.
  1. Click **Save changes**.

- API

  To change the storage size for a cluster, use the `update` method and pass the following in the request:
  - The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - Required storage size (in bytes), in the `configSpec.resources.diskSize` parameter.
  - List of user configuration fields to be changed (in this case, `configSpec.resources.diskSize`), in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

## Changing settings {{ MS }} {#change-sqlserver-config}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **DBMS settings**, click **Settings**.
  1. Edit the settings and click **Save**.
  1. Click **Save changes**.

- API

  Use the `update` API method and pass the following in the request:
  - The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The relevant values in the `configSpec.sqlserverConfig_2016sp2` parameter.
  - List of user configuration fields to be changed (in this case, `configSpec.sqlserverConfig_2016sp2`), in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

## Move a cluster {#move-cluster}

{% list tabs %}

- Management console

  To move a cluster to another folder:
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) to the right of the row of the cluster that you want to move.
  1. Click **Move**.
  1. Select the folder you want to move the cluster to.
  1. Click **Move**.

- API

  To move a cluster to another folder, use the `move` API method and pass the following in the request:
  - The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The ID of the destination folder in the `destinationFolderId` parameter.

{% endlist %}

