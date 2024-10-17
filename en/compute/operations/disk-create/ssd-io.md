# Create an ultra high-speed network storage with three replicas (SSD)


You can create an [ultra high-speed network storage](../../concepts/disk.md#nr-disks) with three replicas (SSD), which is a high-performance SSD that offers the same speed features as a non-replicated SSD but also provides redundancy.

The disk size must be a multiple of 93 GB.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a disk.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
   1. Enter the disk name. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Add a disk description, if required.
   1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to place the disk in.
   1. Select `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-io-m3 }}` as the disk type.
   1. Select the required block size.
   1. Specify the required disk size.


   1. {% include [encryption-section-without-sa](../../../_includes/compute/encryption-section-without-sa.md) %}


   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create disks:

      ```bash
      yc compute disk create --help
      ```

   1. To create a high-performance disk named `ssd-io-disk`, run this command:

      ```bash
      yc compute disk create \
        --name ssd-io-disk \
        --zone {{ region-id }}-a \
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
      zone_id: {{ region-id }}-a
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- API {#api}

   Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/Disk/create.md) gRPC API call.

{% endlist %}