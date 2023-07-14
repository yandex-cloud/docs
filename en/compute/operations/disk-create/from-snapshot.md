# Recovering a disk from a snapshot

To create a disk from a [snapshot](../../concepts/snapshot.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a disk.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
   1. Enter the disk name.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If required, provide an arbitrary description for the disk.
   1. Select the [availability zone](../../../overview/concepts/geo-scope.md) to place the disk in.
   1. Set the disk parameters: [disk type](../../concepts/disk.md#disks_types), [block size](../../concepts/disk.md#maximum-disk-size), and [disk size](../../concepts/disk.md#maximum-disk-size).
   1. If required, select a [schedule](../../concepts/snapshot-schedule.md) for automatic snapshot creation, or set up a new schedule. For more information about setting up schedules, see the [instructions](../snapshot-control/create-schedule.md).

      {% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

      When creating a disk, you can select only one snapshot schedule. Once the disk is created, you can add a few more schedules by following the [instructions](../disk-control/configure-schedule.md#add-schedule).

   1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-snapshot }}` and then select the snapshot you need from the list below. Use the filter to find the snapshot.
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI commands for managing disks and their snapshots:

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
      | fd84hanhvjqljepbgqr4 | disk-1-1668075122980 | f2ef3frbftr2f3hq3uji | READY    |
      | fd85mc22cospn62qq5dg | disk-2-1669114692462 | f2ef3frbftr2f3hq3uji | READY    |
      +----------------------+----------------------+----------------------+----------+
      ```

   1. Select the ID (`ID`) or the name (`NAME`) of the desired snapshot.

   1. Create a disk from the selected snapshot.

      ```bash
      yc compute disk create <disk_name> \
        --source-snapshot-name <snapshot_name> \
        --description <text_description_of_disk>
      ```
      You can use the `--source-snapshot-name` or `--source-snapshot-id` parameter to specify the snapshot.

      For more information about the `yc compute disk create` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/disk/create.md).

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:

      ```bash
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

- API

   1. Retrieve a list of snapshots using the [SnapshotService/List](../../api-ref/grpc/snapshot_service.md#List) gRPC API method or the [list](../../api-ref/Snapshot/list.md) method of the REST API `Snapshot` resource.
   1. Create a disk using the [DiskService/Create](../../api-ref/grpc/disk_service.md#Create) gRPC API method or the [create](../../api-ref/Disk/create.md) method of the REST API `Disk` resource. Specify the snapshot ID in your request.

{% endlist %}

After creation, the disk will have the `CREATING` status. Wait until the disk status changes to `READY` before using it.

#### See also {#see-also}

* [Creating a VM with disks from snapshots](../vm-create/create-from-snapshots.md)
* [Attaching a disk to a VM and mounting partitions](../vm-control/vm-attach-disk.md)
* [Creating a snapshot schedule](../snapshot-control/create-schedule.md)
* [{#T}](../../../backup/concepts/index.md)
