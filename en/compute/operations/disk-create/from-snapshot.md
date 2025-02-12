---
title: How to recover a disk from a snapshot in {{ compute-full-name }}
description: Follow this guide to recover a disk from a snapshot.
---

# Recovering a disk from a snapshot

{% note info %}

{% include [boot-disk-recover](../../../_includes/compute/boot-disk-recover.md) %}

{% endnote %}

To create a disk from a [snapshot](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a disk.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Enter a name for the disk. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Provide a description for the disk, if required.
  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) the disk will be in.
  1. Set the disk parameters, such as [disk type](../../concepts/disk.md#disks_types), [block size](../../concepts/disk.md#maximum-disk-size), and [disk size](../../concepts/disk.md#maximum-disk-size).
  1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` and then select the snapshot you need from the list below. Use the filter to find the snapshot.
  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Select or set up a [schedule](../../concepts/snapshot-schedule.md) for automatically creating disk snapshots, if required. For more information about setting up schedules, see [Creating a disk snapshot schedule](../snapshot-control/create-schedule.md).

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     When creating a disk, you can only select a single snapshot schedule. After the disk is created, you can add a few more schedules by following [this guide](../disk-control/configure-schedule.md#add-schedule).

  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI commands for managing disks and disk snapshots:

      ```bash
      yc compute disk create --help
      yc compute snapshot --help
      ```

  1. Get a list of snapshots in the default folder:

      ```bash
      yc compute snapshot list
      ```
      Result:
      ```text
      +----------------------+----------------------+----------------------+----------+
      |          ID          |         NAME         |     PRODUCT IDS      |  STATUS  |
      +----------------------+----------------------+----------------------+----------+
      | fd84hanhvjql******** | disk-1-1668075122980 | f2ef3frbftr2******** | READY    |
      | fd85mc22cosp******** | disk-2-1669114692462 | f2ef3frbftr2******** | READY    |
      +----------------------+----------------------+----------------------+----------+
      ```

  1. Select `ID` or `NAME` of the snapshot you need.

  1. Create a disk from the selected snapshot:

      ```bash
      yc compute disk create <disk_name> \
        --source-snapshot-name <snapshot_name> \
        --description <text_description_of_disk>
      ```
      You can use either `--source-snapshot-name` or `--source-snapshot-id` to specify the snapshot.

      For more information about the `yc compute disk create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/disk/create.md).

  1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:

      ```bash
      yc compute disk list --format yaml
      ```

      Result:
      ```text
      - id: fhm4aq4hvq5g********
          folder_id: b1gm3og7ei7a********
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "10737418240"
          status: READY
      - id: fhmo6rdqg5fo********
          folder_id: b1gm3og7ei7a********
          created_at: "2018-10-29T07:33:04Z"
          name: second-disk
          description: my second disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "8589934592"
          product_ids:
          - f2en2dtd08b5********
          status: READY
          source_image_id: fdvk34al8k5n********
          instance_ids:
          - fhm5b617fjnj********
      ```

- API {#api}

  1. Get a list of snapshots using the [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md) gRPC API call or the [list](../../api-ref/Snapshot/list.md) REST API method for the `Snapshot` resource.
  1. Create a disk using the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call or the [create](../../api-ref/Disk/create.md) REST API method for the `Disk` resource. Specify the snapshot ID in your request.

{% endlist %}

Once created, the disk will get the `CREATING` status. Wait until the disk status changes to `READY` before using it.


#### See also {#see-also}

* [Creating a VM with disks from snapshots](../vm-create/create-from-snapshots.md)
* [Attaching a disk to a VM and mounting partitions](../vm-control/vm-attach-disk.md)
* [Creating a snapshot schedule](../snapshot-control/create-schedule.md)
* [Encryption in {{ compute-name }}](../../concepts/encryption.md)
* [{#T}](../../../backup/concepts/index.md)
