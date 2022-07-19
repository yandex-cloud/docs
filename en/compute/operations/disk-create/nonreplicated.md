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
      
            
      {% include [nrd-az](../../../_includes/compute/nrd-az.md) %}
      
      
   1. Select **Non-replicated SSD** as disk type.
   1. Select the desired block size.
   1. Specify the desired disk size.
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
   1. Select **Non-replicated SSD** as disk type.
   1. Select a disk placement group.
   1. Specify the desired disk size.
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

{% endlist %}
