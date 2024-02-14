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
   1. Enter the disk name.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If required, provide an arbitrary description for the disk.
   1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to place the disk in.
   1. Set the disk parameters: [disk type](../../concepts/disk.md#disks_types), [block size](../../concepts/disk.md#maximum-disk-size), and [disk size](../../concepts/disk.md#maximum-disk-size).
   1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and select the image you need in the list below. Use the filter to find the image.

   
   1. {% include [encryption-section-without-sa](../../../_includes/compute/encryption-section-without-sa.md) %}


   1. If required, select a [schedule](../../concepts/snapshot-schedule.md) for automatic snapshot creation, or set up a new schedule. For more information about setting up schedules, see the [guide](../snapshot-control/create-schedule.md).

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

      When creating a disk, you can select only one snapshot schedule. Once the disk is created, you can add a few more schedules by following the [instructions](../disk-control/configure-schedule.md#add-schedule).
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI commands for managing disks and images:

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

   1. Select the identifier (`ID`) or name (`NAME`) of the desired image.

   1. Create a disk from the selected image.

      ```bash
      yc compute disk create <disk_name> \
        --source-image-name <image_name> \
        --description <text_description_of_disk>
      ```
      You can use the `--source-image-name` or `--source-image-id` parameter to specify the image.

      For more information about the `yc compute disk create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/disk/create.md).

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:

      ```bash
      yc compute disk list --format yaml
      ```

      Result:
      ```yaml
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

   1. Retrieve a list of images using the [ImageService/List](../../api-ref/grpc/image_service.md#List) grPC API method or the [list](../../api-ref/Image/list.md) method of the REST API `Image` resource.
   1. Create a disk using the [DiskService/Create](../../api-ref/grpc/disk_service.md#Create) gRPC API method or the [create](../../api-ref/Disk/create.md) method of the REST API `Disk` resource. Specify the image ID in your request.

{% endlist %}

After creation, the disk will have the `CREATING` status. Wait until the disk status changes to `READY` before using it.

#### See also {#see-also}

* [Creating a VM from a custom image](../vm-create/create-from-user-image.md)
* [Attaching a disk to a VM and mounting partitions](../vm-control/vm-attach-disk.md)
* [{#T}](../../../backup/concepts/index.md)
