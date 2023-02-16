---
title: "Managing {{ OS }} host groups"
description: "You can get a list of {{ OS }} cluster hosts and add, edit, or delete cluster host groups."
keywords:
  - Managing OpenSearch host groups
  - OpenSearch host groups
  - OpenSearch
---

# Managing {{ OS }} host groups

In {{ OS }} clusters, you can't add, update, or delete individual hosts. Instead, you can manage [host groups](../concepts/host-groups.md):

* [{#T}](#list-hosts).
* [{#T}](#add-host-group).
* [{#T}](#update-host-group).
* [{#T}](#delete-host-group).

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click on the name of the cluster you need and select the **Hosts** tab.

- API

   Use the [listHosts](../api-ref/Cluster/listHosts.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a host group to a cluster {#add-host-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click on the name of the desired cluster and select the **Host groups** tab.
   1. Click **Add host group**.
   1. Specify the group parameters:

      * Name.
      * [Type](../concepts/host-groups.md) and one or more [roles](../concepts/host-roles.md) of the hosts in the group.
      * The platform, host type, and host class.

         The host class defines the technical characteristics of virtual machines that {{ OS }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

      * [Disk type](../concepts/storage.md) and data storage size.

         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      * Host distribution across availability zones and subnets.

      * The number of hosts to create.

      
      * Enable **Public access** if you want to allow [connecting](connect.md) to hosts over the internet.


   1. Click **Create host group**.

   {% note warning %}

   After creating the host group, you can only [change its configuration](#update-host-group) using the API. However, you can also create a new host group with a different configuration if needed.

   {% endnote %}

- API

   To add an `OPENSEARCH` or `DASHBOARDS` host group, use the [addOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) or [addDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md) API method, respectively, and pass the group configuration in the `nodeGroupSpec` request block:

   * Host group name in the `name` parameter.
   * [Host class](../concepts/instance-types.md) in the `resources.resourcePresetId` parameter.
   * [Disk type](../concepts/storage.md) in the `resources.diskTypeId` parameter.
   * Data storage size in the `resources.diskSize` parameter.
   * Number of group hosts in the `hostsCount` parameter.
   * A list of availability zones in the `zoneIds` parameter.
   * A list of subnets in the `subnetIds` parameter.

   
   * Public access settings, in the `assignPublicIp` parameter.


   * List of host roles in the `roles` parameter (for `OPENSEARCH` host groups only).

{% endlist %}

## Updating a host group configuration {#update-host-group}

{% list tabs %}

- API

   To update the configuration of an `OPENSEARCH` or `DASHBOARDS` host group, use the [updateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) or [updateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md) API method, respectively, and pass a new configuration in the `nodeGroupSpec` request block:

   * [Host class](../concepts/instance-types.md) in the `resources.resourcePresetId` parameter.
   * Data storage size in the `resources.diskSize` parameter.
   * Number of group hosts in the `hostsCount` parameter.
   * List of host roles in the `roles` parameter (for `OPENSEARCH` host groups only).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a host group {#delete-host-group}

When deleting a host group, the following limitation applies: you can't delete the only host group with the `DATA` role.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click on the name of the desired cluster and select the **Host groups** tab.
   1. Click ![image](../../_assets/options.svg) in the line with the appropriate group and select **Delete**.

- API

   To delete an `OPENSEARCH` or `DASHBOARDS` host group, use the [deleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) or [deleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md) API method, respectively, and pass the following in the request:

   * The cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The name of the host group to delete, in the `name` parameter.

{% endlist %}
