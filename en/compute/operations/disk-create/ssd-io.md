# Creating a high-performance SSD

You can create a separate [high-performance](../../concepts/disk.md#nr-disks) SSD that combines the high speed of a non-replicated disk with redundancy.

The size of a disk must be a multiple of 93 GB.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a disk.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
   1. Enter the disk name.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Add a description for the disk, if required.
   1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to place the disk in.

      
      {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}


   1. Select `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd-io-m3 }}` as disk type.
   1. Select the desired block size.
   1. Specify the desired disk size.
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create disks:

      ```bash
      yc compute disk create --help
      ```

   1. To create a high-performance disk named `ssd-io-disk`, run this command:

      ```bash
      yc compute disk create \
        --name ssd-io-disk \
        --zone ru-central1-a \
        --type network-ssd-io-m3 \
        --size 93G
      ```

      Result:

      ```text
      id: a7li08c1************
      folder_id: aoerb349************
      created_at: "2023-07-18T14:42:21Z"
      name: ssd-io-disk
      type_id: network-ssd-io-m3
      zone_id: ru-central1-a
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- API

   Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/disk_service.md#Create) gRPC API call.

{% endlist %}