---
title: How to create a disk placement group in {{ compute-full-name }}
description: Follow this guide to create a disk placement group.
---

# Creating a disk placement group


To create a [placement group](../../concepts/disk-placement-group.md) for [non-replicated disks](../../concepts/disk.md#nr-disks):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a disk placement group.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Navigate to the **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.compute.placement-groups.button_create }}** and select **{{ ui-key.yacloud.compute.placement-groups.button_menu-create-disk-placement-group }}**.
  1. Enter a name for the placement group. Follow these naming requirements:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Provide a description for the disk placement group, if required.
  1. Specify the [availability zone](../../../overview/concepts/geo-scope.md).
  1. Select a placement strategy: [spread](../../concepts/disk-placement-group.md#spread) or [partition](../../concepts/disk-placement-group.md#partition).

     If you select the partition placement strategy, specify the number of partitions for non-replicated disks.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating a disk placement group:

     ```bash
     yc compute disk-placement-group create --help
     ```

  1. Create a disk placement group in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) with one of the following placement strategies:
     * [Spread placement](../../concepts/disk-placement-group.md#spread):

       ```bash
       yc compute disk-placement-group create \
         --name <disk_placement_group_name> \
         --zone <availability_zone> \
         --strategy SPREAD
       ```

       Where:
       * `--name`: Disk placement group name.
       * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md).
       * `--strategy`: Placement strategy.
     * [Partition placement](../../concepts/disk-placement-group.md#partition):

       ```bash
       yc compute disk-placement-group create \
         --name <disk_placement_group_name> \
         --zone <availability_zone> \
         --strategy PARTITION \
         --partition-count <number_of_partitions>
       ```

       Where:
       * `--name`: Disk placement group name.
       * `--zone`: Availability zone.
       * `--strategy`: Placement strategy.
       * `--partition-count`: Number of partitions, two to five.
  1. Get a list of disk placement groups in the default folder:

     ```bash
     yc compute disk-placement-group list
     ```

     Result:

     ```text
     +----------------------+---------------------+-------------------+--------+---------------+
     |          ID          |        NAME         |       ZONE        | STATUS |   STRATEGY    |
     +----------------------+---------------------+-------------------+--------+---------------+
     | epd3oalmkmbp******** | drbasic-partition-1 | {{ region-id }}-b | READY  | PARTITION [3] |
     | epdn7r7co1v4******** | drbasic-spread-2    | {{ region-id }}-b | READY  | SPREAD        |
     +----------------------+---------------------+-------------------+--------+---------------+
     ```

  1. Get information about the created disk placement group by specifying its name:

     ```bash
     yc compute disk-placement-group get \
       --name <placement_group_name>
     ```

     Result:

     ```text
     id: epd4sug6kesk********
     folder_id: w3qrbj9swoty********
     created_at: "2021-03-23T12:49:59Z"
     name: first-group
     zone_id: {{ region-id }}-b
     status: READY
     spread_placement_strategy: {}
     ```


- API {#api}

  Use the [create](../../api-ref/DiskPlacementGroup/create.md) REST API method for the [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md) resource or the [DiskPlacementGroupService/Create](../../api-ref/grpc/DiskPlacementGroup/create.md) gRPC API call.

{% endlist %}