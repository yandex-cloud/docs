# Creating a non-replicated disk

You can create a stand-alone [non-replicated](../../concepts/disk.md#nr-disks) disk or add a disk to a disk placement group.

The size of a non-replicated disk must be a multiple of 93 GB.

## Create a separate non-replicated disk {#nr-disk}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a disk.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/disks-pic.svg) **Disks**.
   1. Click **Create disk**.
   1. Enter the disk name.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If necessary, add a description of the disk.
   1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to place the disk in.

      {% if product == "yandex-cloud" %}

      {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}

      {% endif %}

   1. Select **Non-replicated SSD**as disk type.
   1. Select the desired block size.
   1. Specify the desired disk size.
   1. If necessary, select a [schedule](../../concepts/snapshot-schedule.md) to automatically create [snapshots](../../concepts/snapshot.md), or create a new one. For more information about setting up schedules, see the [instructions](../snapshot-control/create-schedule.md).

      When creating a disk, you can select only one snapshot schedule. If necessary, after the disk is created, you can add a few more schedules, according to the [instructions](../disk-control/configure-schedule.md#add-schedule).

   1. Click **Create disk**.

- CLI

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
      id: epdb2517b9709hkifodg
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2021-03-10T10:03:31Z"
      name: nr-disk
      type_id: network-ssd-nonreplicated
      zone_id: {{ region-id }}-b
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
      * `name`: Non-replicated disk name. Name format:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `size`: A non-replicated disk's size must be a multiple of 93 GB.
      * `block_size`: Block size in bytes (the minimum storage size for information on the disk). The maximum disk size depends on the chosen block size. By default, the block size of all created disks is 4 KB, but that's not enough for disks larger than 8 TB. For more information, see [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).
      * `type`: Type of the disk being created. Specify `network-ssd-nonreplicated` to create a non-replicated disk.
      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md).

         {% if product == "yandex-cloud" %} {% include [nrd-az](../../../_includes/compute/nrd-az.md) %} {% endif %}

      For more information about the `yandex_compute_disk` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/compute_disk#example-usage---non-replicated-disk).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

         ```bash
         yc compute disk list
         ```

{% endlist %}

## Create a non-replicated disk in a placement group {#nr-disk-in-group}

You can only create a disk in an existing disk placement group.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a disk.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/disks-pic.svg) **Disks**.
   1. Click **Create disk**.
   1. Enter the disk name.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If necessary, add a description of the disk.
   1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to place the disk in.

      The availability zone for a disk must be the same as that of the placement group where you want to create the disk.
   1. Select **Non-replicated SSD**as disk type.
   1. Select a disk placement group.
   1. Specify the desired disk size.
   1. If necessary, select a [schedule](../../concepts/snapshot-schedule.md) to automatically create [snapshots](../../concepts/snapshot.md), or create a new one. For more information about setting up schedules, see the [instructions](../snapshot-control/create-schedule.md).

      If you want to set another schedule, you can [add](../disk-control/configure-schedule.md#add-schedule) it after the disk is created.

   1. Click **Create disk**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create disks:

      ```bash
      yc compute disk create --help
      ```

   1. To create a non-replicated disk in the disk placement group named `my-group`, run the command:

      ```bash
      yc compute disk create \
        --name nr-disk \
        --type network-ssd-nonreplicated \
        --size 93 \
        --disk-placement-group-name my-group
      ```

      Result:

      ```text
      done (1s)
      id: epdtncic35rug5570q1p
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2021-03-10T11:17:57Z"
      name: nr-disk
      type_id: network-ssd-nonreplicated
      zone_id: {{ region-id }}-b
      size: "99857989632"
      block_size: "4096"
      status: READY
      disk_placement_policy:
        placement_group_id: epdn946ilslhiug1vh7v
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of your non-replicated disk and specify the disk placement group in the `disk_placement_group_id` field:

      ```hcl
      resource "yandex_compute_disk" "nr" {
        name       = "non-replicated-disk-name"
        size       = 93
        block_size = 4096
        type       = "network-ssd-nonreplicated"
        zone       = "{{ region-id }}-b"
        disk_placement_policy {
          disk_placement_group_id = yandex_compute_disk_placement_group.this.id
        }
      }

      resource "yandex_compute_disk_placement_group" "this" {
        zone = "{{ region-id }}-b"
      }
      ```

      Where:
      * `name`: Non-replicated disk name. Name format:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `size`: A non-replicated disk's size must be a multiple of 93 GB.
      * `block_size`: Block size in bytes (the minimum storage size for information on the disk). The maximum disk size depends on the chosen block size. By default, the block size of all created disks is 4 KB, but that's not enough for disks larger than 8 TB. For more information, see [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).
      * `type`: Type of the disk being created. Specify `network-ssd-nonreplicated` to create a non-replicated disk.
      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md). The availability zone for a disk must be the same as that of the placement group where you want to create the disk.

         {% if product == "yandex-cloud" %} {% include [nrd-az](../../../_includes/compute/nrd-az.md) %} {% endif %}

      * `disk_placement_group_id`: ID of the disk placement group.

      For more information about the `yandex_compute_disk` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/compute_disk#example-usage---non-replicated-disk).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

         ```bash
         yc compute disk list
         ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
