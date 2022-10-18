# Creating a disk snapshot

A _disk snapshot_ is a copy of the disk file system at a specific point in time.

## Setup {#prepare}

A disk snapshot only contains the data that was already written to the disk when the snapshot was created. If the disk is attached to a running VM, the cache of the apps and OS will not be included in the snapshot.

To ensure the integrity of the snapshot data:

**Linux systems:**

1. Stop all disk write operations in applications.
1. Run one of the following commands:
   - `sync` to write the OS cache to disk.
   - `fsfreeze -f` to freeze the file system. To unfreeze it, run the `fsfreeze --unfreeze` command.

**For other systems:**

1. Stop the virtual machine (see [{#T}](../vm-control/vm-stop-and-start.md#stop)).
1. Wait until the VM status changes to `STOPPED`.

## Creating a snapshot {#create}

To create a disk snapshot:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the disk is located.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/disks-pic.svg) **Disks**.
   1. In the row with the desired disk, click ![image](../../../_assets/horizontal-ellipsis.svg) and select **Create snapshot**.
   1. Enter a name for the snapshot:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If necessary, enter a description of the snapshot.
   1. Click **Create**.

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

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the resource parameters in the `yandex_compute_snapshot` configuration file.

      Example configuration file structure:

      ```hcl
      resource "yandex_compute_snapshot" "snapshot-1" {
        name           = "disk-snapshot"
        source_disk_id = "<disk ID>"
      }
      ```

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

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

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

A snapshot is created asynchronously. The snapshot is created with the `Creating` status immediately after the create command is run. From this point on, you can resume writing data to disk, and disk operations will not affect the data in the snapshot.

Once the snapshot has been created, the snapshot status will change to `Ready`. From this point on, you can use the snapshot to create images, populate disks, and so on.

{% note alert %}

{% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

To avoid this, attach the disk to the VM and change all the duplicate UUIDs. Learn more in the [instructions for attaching disks](../vm-control/vm-attach-disk.md).

{% endnote %}


#### See also {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)