# Creating a non-replicated disk

You can create a stand-alone [non-replicated](../../concepts/disk.md#nr-disks) disk or add such a disk to a disk placement group.

The size of a disk must be a multiple of 93 GB.

## Create a separate non-replicated disk {#nr-disk}

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

      
      {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}


   1. Select `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd-nonreplicated }}` as the disk type.
   1. Select the required block size.
   1. Specify the required disk size.

   
   1. {% include [encryption-section-without-sa](../../../_includes/compute/encryption-section-without-sa.md) %}


   1. If required, select a [schedule](../../concepts/snapshot-schedule.md) to automatically create [snapshots](../../concepts/snapshot.md), or create a new one. For more information about setting up schedules, see the [guide](../snapshot-control/create-schedule.md).

      When creating a disk, you can select only one snapshot schedule. After the disk is created, you can add a few more schedules, if required, by following [this guide](../disk-control/configure-schedule.md#add-schedule).

   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create disks:

      ```bash
      yc compute disk create --help
      ```

   1. To create a non-replicated disk named `nr-disk`, run the command:

      ```bash
      yc compute disk create \
        --name nr-disk \
        --type network-ssd-nonreplicated \
        --size 93
      ```

      Result:

      ```text
      done (1s)
      id: epdb2517b970********
      folder_id: b1g7gvsi89m3********
      created_at: "2021-03-10T10:03:31Z"
      name: nr-disk
      type_id: network-ssd-nonreplicated
      zone_id: {{ region-id }}-b
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the non-replicated disk's parameters:

      ```hcl
      resource "yandex_compute_disk" "nr" {
        name       = "<non-replicated_disk_name>"
        size       = <non-replicated_disk_size>
        block_size = <block_size>
        type       = "network-ssd-nonreplicated"
        zone       = "<availability_zone>"
      }
      ```

      Where:
      * `name`: Non-replicated disk name. The naming requirements are as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `size`: A non-replicated disk's size must be a multiple of 93 GB.
      * `block_size`: Block size in bytes (the minimum storage size for information on the disk). The maximum disk size depends on the specified block size. By default, the block size of all created disks is 4 KB; however, this is not enough for disks larger than 8 TB. For more information, see [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).
      * `type`: Disk type. Specify `network-ssd-nonreplicated` to create a non-replicated disk.
      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md).

          {% include [nrd-az](../../../_includes/compute/nrd-az.md) %} 

      For more information about the `yandex_compute_disk` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_disk#example-usage---non-replicated-disk).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

         ```bash
         yc compute disk list
         ```

- API {#api}

   Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/disk_service.md#Create) gRPC API call.

{% endlist %}

## Create a non-replicated disk in a placement group {#nr-disk-in-group}

You can only create a disk in an existing disk placement group.

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

      The availability zone for a disk must be the same as that of the placement group where you want to create the disk.
   1. Select `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd-nonreplicated }}` as the disk type.
   1. Select a disk placement group.

      If you select a group with the [partition placement](../../concepts/disk-placement-group.md#partition), specify the number of the partition you want to add the disk to.
   1. Specify the required disk size.
   1. If required, select a [schedule](../../concepts/snapshot-schedule.md) to automatically create [snapshots](../../concepts/snapshot.md), or create a new one. For more information about setting up schedules, see the [guide](../snapshot-control/create-schedule.md).

      If you want to set another schedule, you can [add](../disk-control/configure-schedule.md#add-schedule) it after the disk is created.
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create disks:

      ```bash
      yc compute disk create --help
      ```

   1. In a placement group, create a non-replicated disk in the default folder using one of the strategies:
      * [Spread placement](../../concepts/disk-placement-group.md#spread):

         ```bash
         yc compute disk create \
           --name <disk_name> \
           --type network-ssd-nonreplicated \
           --size <disk_size> \
           --disk-placement-group-name <placement_group_name>
         ```

         Where:
         * `--name`: Disk name
         * `--type`: Disk type
         * `--size`: Disk size
         * `--disk-placement-group-name`: Placement group name

         Result:

         ```text
         done (1s)
         id: epdtncic35ru********
         folder_id: b1g7gvsi89m3********
         created_at: "2021-03-10T11:17:57Z"
         name: nr-disk
         type_id: network-ssd-nonreplicated
         zone_id: {{ region-id }}-b
         size: "99857989632"
         block_size: "4096"
         status: READY
         disk_placement_policy:
           placement_group_id: epdn946ilslh********
         ```

      * [Partition placement](../../concepts/disk-placement-group.md#partition):
         ```bash
         yc compute disk create \
           --name <disk_name> \
           --type network-ssd-nonreplicated \
           --size <disk_size> \
           --disk-placement-group-name <placement_group_name> \
           --disk-placement-group-partition <partition_number>
         ```

         Where:
         * `--name`: Disk name
         * `--type`: Disk type
         * `--size`: Disk size
         * `--disk-placement-group-name`: Placement group name
         * `--disk-placement-group-partition`: Placement group partition number

         Result:

         ```text
         done (1s)
         id: epdtncic35ru********
         folder_id: b1g7gvsi89m3********
         created_at: "2021-03-10T11:17:57Z"
         name: nr-disk
         type_id: network-ssd-nonreplicated
         zone_id: {{ region-id }}-b
         size: "99857989632"
         block_size: "4096"
         status: READY
         disk_placement_policy:
           placement_group_id: epdn946ilslh********
           placement_group_partition: 2
         ```


- API {#api}

   Use the [create](../../api-ref/Disk/create.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/Create](../../api-ref/grpc/disk_service.md#Create) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
