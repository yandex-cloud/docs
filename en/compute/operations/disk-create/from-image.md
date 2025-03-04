---
title: How to recover a disk from an image in {{ compute-full-name }}
description: Follow this guide to recover a disk from an image.
---

# Recovering a disk from an image

{% note info %}

{% include [boot-disk-recover](../../../_includes/compute/boot-disk-recover.md) %}

{% endnote %}

To create a disk from an [image](../../concepts/image.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a disk.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Enter a name for the disk.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Provide a description for the disk, if required.
  1. Select the [availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
  1. Set the disk parameters, such as [disk type](../../concepts/disk.md#disks_types), [block size](../../concepts/disk.md#maximum-disk-size), and [disk size](../../concepts/disk.md#maximum-disk-size).
  1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the image you need from the list below. Use the filter to find the image.
  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Select or set up a [schedule](../../concepts/snapshot-schedule.md) for automatically creating disk snapshots, if required. For more information about setting up schedules, see [Creating a disk snapshot schedule](../snapshot-control/create-schedule.md).

     {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

     When creating a disk, you can only select a single snapshot schedule. After the disk is created, you can add a few more schedules by following [this guide](../disk-control/configure-schedule.md#add-schedule).
  1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI commands for managing disks and images:

      ```bash
      yc compute disk create --help
      yc compute image --help
      ```

  1. Get a list of images in the default folder:

      ```bash
      yc compute image list
      ```

      Result:
      ```text
      +----------------------+------------+--------+----------------------+--------+
      |          ID          |    NAME    | FAMILY |     PRODUCT IDS      | STATUS |
      +----------------------+------------+--------+----------------------+--------+
      | fd8ool134m70******** | test-image |        | f2e3eaei7io3******** | READY  |
      | fd8u2d7plgpu******** | image-2    |        |                      | READY  |
      +----------------------+------------+--------+----------------------+--------+
      ```

  1. Select `ID` or `NAME` of the image you need.

  1. Create a disk from the selected image:

      ```bash
      yc compute disk create <disk_name> \
        --source-image-name <image_name> \
        --description <text_description_of_disk> \
        --kms-key-id <key_ID>
      ```

      Where:

      * `--source-image-name`: Image name. You can use either `--source-image-name` or `--source-image-id` to specify the image.
      * `description`: Text description of the disk.
      * `--kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create en encrypted disk. This is an optional parameter.

        {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
        
        {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

        {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

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

  1. Get a list of images using the [ImageService/List](../../api-ref/grpc/Image/list.md) gRPC API call or the [list](../../api-ref/Image/list.md) REST API method for the `Image` resource.
  1. Create a disk using the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call or the [create](../../api-ref/Disk/create.md) REST API method for the `Disk` resource. Specify the image ID in your request.

{% endlist %}

Once created, the disk will get the `CREATING` status. Wait until the disk status changes to `READY` before using it.


#### See also {#see-also}

* [Creating a VM from a custom image](../vm-create/create-from-user-image.md)
* [Attaching a disk to a VM and mounting partitions](../vm-control/vm-attach-disk.md)
* [{#T}](../../../backup/concepts/index.md)
