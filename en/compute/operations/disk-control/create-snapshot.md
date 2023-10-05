# Creating a disk snapshot

A _disk snapshot_ is a copy of the disk file system at a specific point in time.

{% include [snapshot-disk-types](../../../_includes/compute/snapshot-disk-types.md) %}

## Setup {#prepare}

A disk snapshot only contains the data that had already been written to the disk when the snapshot was created. If the disk is attached to a running VM, the OS and app cache will not be included in the snapshot.

To ensure the integrity of the snapshot data:

**Linux systems:**

1. Stop all disk write operations in applications.

1. Write the OS cache to the disk:

   ```bash
   sync
   ```

1. Freeze the file system:

   ```bash
   sudo fsfreeze --freeze <mount_point>
   ```
   Where `--freeze` is the parameter to freeze the file system. Instead of `<mount_point>`, specify the folder the file system is connected to. For example, `/mnt/vdc2`.

1. Create a snapshot following the instructions [below](#create).

1. Unfreeze the file system:

   ```bash
   sudo fsfreeze --unfreeze <mount_point>
   ```
   Where `--unfreeze` is the parameter to unfreeze the file system. Instead of `<mount_point>`, specify the folder the file system is connected to. For example, `/mnt/vdc2`.

**For other systems:**

1. Stop the virtual machine (see [{#T}](../vm-control/vm-stop-and-start.md#stop)).
1. Wait until the VM status changes to `STOPPED`.

## Creating a snapshot {#create}

To create a disk snapshot:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. In the line of the disk, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
   1. Enter a name for the snapshot:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If necessary, enter a description of the snapshot.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create snapshot commands:

      ```bash
      yc compute snapshot create --help
      ```

   1. Select the disk to take a snapshot of. To get a list of disks in the default folder, run the command:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Create a snapshot in the default folder:

      ```bash
      yc compute snapshot create \
        --name first-snapshot \
        --description "my first snapshot via CLI" \
        --disk-id fhm4aq4hvq5g3nepvt9b
      ```

      As a result, a disk snapshot is created with the name `first-snapshot` and description `my first snapshot via CLI`.

      {% include [name-format](../../../_includes/name-format.md) %}

- API

  1. Get the list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API call.
  1. Create a snapshot using the [create](../../api-ref/Snapshot/create.md) REST API method for the [Snapshot](../../api-ref/Snapshot/index.md) resource or the [SnapshotService/Create](../../api-ref/grpc/snapshot_service.md#Create) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the resource parameters in the `yandex_compute_snapshot` configuration file.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_compute_snapshot" "snapshot-1" {
        name           = "disk-snapshot"
        source_disk_id = "<disk ID>"
      }
      ```

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

{% endlist %}

An HDD or SSD snapshot is created asynchronously. The snapshot is created with the `Creating` status immediately after the create command is run. From this point on, you can resume writing data to disk, and disk operations will not affect the data in the snapshot.

While creating a snapshot of a high-performance or non-replicated SSD, any write operations will be suspended and the disk will be read-only. All suspended writes (if they are requested on the guest OS side) will be completed after the snapshot is created.

Once a snapshot is created, the snapshot status will change to `Ready`. From this point on, you can use the snapshot to create images, populate disks, and so on.

{% note alert %}

{% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

To avoid this, attach the disk to the VM and change all the duplicate UUIDs. Learn more in the [instructions for attaching disks](../vm-control/vm-attach-disk.md).

{% endnote %}


#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
* [{#T}](../disk-create/from-snapshot.md)
