# Creating an empty disk

You can create an empty disk of the specified size.

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
   1. Select the desired disk type: `HDD`, `SSD`, or `Non-replicated SSD`.
   1. Select the proper block size (the minimum chunk used to store data on the disk). By default, the block size of all created disks is 4 KB, but that's not enough for disks larger than 8 TB.
   1. Specify the necessary disk size. The maximum disk size depends on the chosen block size.
   1. If necessary, select a [schedule](../../concepts/snapshot-schedule.md) to automatically create [snapshots](../../concepts/snapshot.md), or create a new one. For more information about setting up schedules, see the [instructions](../snapshot-control/create-schedule.md).

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

      When creating a disk, you can select only one snapshot schedule. If necessary, after the disk is created, you can add a few more schedules, according to the [instructions](../disk-control/configure-schedule.md#add-schedule).

   1. Click **Create disk**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's create disk commands:

      ```bash
      yc compute disk create --help
      ```

   1. Create a disk in the default folder:

      ```bash
      yc compute disk create \
        --name first-disk \
        --size 10 \
        --description "my first disk via yc"
      ```

      This command creates a 10 GB disk with the name `first-disk` and description `my first disk via yc`.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:

      ```
      yc compute disk list --format yaml
      ```

      Result:
      ```yaml
      - id: fhm4aq4hvq5g3nepvt9b
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "10737418240"
          status: READY
      - id: fhmo6rdqg5folrc3lsaf
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:33:04Z"
          name: second-disk
          description: my second disk via yc
          type_id: network-hdd
          zone_id: {{ region-id }}-a
          size: "8589934592"
          product_ids:
          - f2en2dtd08b5la74mlde
          status: READY
          source_image_id: fdvk34al8k5nltb58shr
          instance_ids:
          - fhm5b617fjnj44ovhcun
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-empty-disk-create](../../../_includes/compute/terraform-empty-disk-create.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
