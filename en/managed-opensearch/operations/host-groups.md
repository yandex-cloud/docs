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

* [{#T}](#list-groups).
* [{#T}](#add-host-group).
* [{#T}](#update-host-group).
* [{#T}](#delete-host-group).

## Getting a list of host groups in a cluster {#list-groups}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/mdb/host-groups.svg) **Host groups** tab.

- API

   To get a list of host groups in a cluster, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

{% endlist %}

## Adding a host group to a cluster {#add-host-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/mdb/host-groups.svg) **Host groups** tab.
   1. Click ![image](../../_assets/plus-sign.svg) **Add host group**.
   1. Specify the group parameters:

      * [Group type](../concepts/host-groups.md): `{{ OS }}` and `Dashboards`.
      * Name, which must be unique within the cluster.
      * For the `{{ OS }}` host group, select a [host role](../concepts/host-roles.md).
      * Platform, host type, and host class.

         The host class defines the technical characteristics of virtual machines that {{ OS }} nodes are deployed on. All available options are listed under [Host classes](../concepts/instance-types.md).

      * [Disk type](../concepts/storage.md) and data storage size.

         {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      * Host distribution across availability zones and subnets.

      * Number of hosts to create.

      
      * Enable **Public access** if you want to allow [connecting](connect.md) to hosts over the internet.


   1. Click **Create host group**.

   {% note warning %}

   Once you have added a host group, you will not be able to change the **Public access** option. You can only [change](#update-host-group) other configuration settings using the API. However, you can also create a new host group with a different configuration, if required.

   {% endnote %}

- API

   To add a group of `{{ OS }}` hosts, use the [addOpenSearchNodeGroup](../api-ref/Cluster/addOpenSearchNodeGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#AddOpenSearchNodeGroup) gRPC API call.

   To add a group of `Dashboards` hosts, use the [addDashboardsNodeGroup](../api-ref/Cluster/addDashboardsNodeGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/AddDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#AddDashboardsNodeGroup) gRPC API call.

   Provide the group configuration under `nodeGroupSpec` in the request:

   * Host group name in the `name` parameter.
   * [Host class](../concepts/instance-types.md) in the `resources.resourcePresetId` parameter.
   * [Disk type](../concepts/storage.md) in the `resources.diskTypeId` parameter.
   * Data storage size in the `resources.diskSize` parameter.
   * Number of group hosts in the `hostsCount` parameter.
   * List of availability zones in the `zoneIds` parameter.
   * List of subnets in the `subnetIds` parameter.

   
   * Public access settings in the `assignPublicIp` parameter.


   * List of host roles in the `roles` parameter (for `{{ OS }}` host groups only).

{% endlist %}

## Updating a host group configuration {#update-host-group}

{% list tabs %}

- API

   To update the `{{ OS }}` host group configuration, use the [updateOpenSearchNodeGroup](../api-ref/Cluster/updateOpenSearchNodeGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#UpdateOpenSearchNodeGroup) gRPC API call.

   To update the `Dashboards` host group configuration, use the [updateDashboardsNodeGroup](../api-ref/Cluster/updateDashboardsNodeGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#UpdateDashboardsNodeGroup) gRPC API call.

   Provide a new configuration under `nodeGroupSpec` in the request:

   * [Host class](../concepts/instance-types.md) in the `resources.resourcePresetId` parameter.
   * [Disk type](../concepts/storage.md) in the `resources.diskTypeId` parameter.
   * Data storage size in the `resources.diskSize` parameter.
   * Number of group hosts in the `hostsCount` parameter.
   * List of host roles in the `roles` parameter (for `{{ OS }}` host groups only).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Deleting a host group {#delete-host-group}

When deleting a host group, the following limitation applies: you can't delete the only host group with the `DATA` role.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mos-name }}**.
   1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/mdb/host-groups.svg) **Host groups** tab.
   1. Click ![image](../../_assets/options.svg) in the line with the appropriate group and select **Delete**.

- API

   To delete a group of `{{ OS }}` hosts, use the [deleteOpenSearchNodeGroup](../api-ref/Cluster/deleteOpenSearchNodeGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteOpenSearchNodeGroup](../api-ref/grpc/cluster_service.md#DeleteOpenSearchNodeGroup) gRPC API call.

   To delete a group of `Dashboards` hosts, use the [deleteDashboardsNodeGroup](../api-ref/Cluster/deleteDashboardsNodeGroup.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/DeleteDashboardsNodeGroup](../api-ref/grpc/cluster_service.md#DeleteDashboardsNodeGroup) gRPC API call.

   Pass the following in the request:

   * Cluster ID in the `clusterID` parameter.

      {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

   * Name of the host group to delete, in the `name` parameter.

{% endlist %}
