# Creating a disk snapshot

_A disk snapshot_ is a copy of the disk file system at a certain point in time.

## Preparation {#prepare}

A disk snapshot only contains the data that was already written to the disk when the snapshot was created. If the disk is attached to a running VM, the cache of the apps and OS will not be included in the snapshot.

To ensure the integrity of the snapshot data:

**For Linux systems:**

1. Stop all disk write operations in applications.
1. Run one of the following commands:
    - `sync` to write the OS cache to disk.
    - `fsfreeze -f` to freeze the file system. To unfreeze it, run the `fsfreeze --unfreeze` command.

**For all other systems:**

1. Stop the VM (see [{#T}](../vm-control/vm-stop-and-start.md#stop)).
1. Wait until the VM status changes to `STOPPED`.

## Creating a snapshot {#create}

To create a disk snapshot:

{% list tabs %}

- Management console

  1. In the management console, select the folder where the disk is located.

  1. Select **{{ compute-name }}**.

  1. On the **Virtual machines** page, go to the **Disks** tab.

  1. In the line with the disk name, click ![image](../../../_assets/dots.svg) and select the **Create snapshot** command.

  1. Enter a name for the snapshot.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. If necessary, enter a description of the snapshot.

  1. Click **Create snapshot**.

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI create snapshot commands:

      ```
      $ yc compute snapshot create --help
      ```

  1. Select the disk to take a snapshot of. To get a list of disks in the default folder, run the command:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Create a snapshot in the default folder:

      ```
      $ yc compute snapshot create \
          --name first-snapshot \
          --description "my first snapshot via CLI" \
          --disk-id fhm4aq4hvq5g3nepvt9b
      ```

      This command creates a disk snapshot with the name `first-snapshot` and description `my first snapshot via CLI`.

      {% include [name-format](../../../_includes/name-format.md) %}

- Terraform

  If you don't have Terraform, [install it and configure the Yandex.Cloud provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Describe the resource parameters in the `yandex_compute_snapshot` configuration file.

     Example configuration file structure:

     ```
     resource "yandex_compute_snapshot" "snapshot-1" {
     
       name           = "disk-snapshot"
       source_disk_id = "<disk ID>"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     2. Run the check using the command:

        ```
        $ terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```
        $ terraform apply
        ```

     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

A snapshot is created asynchronously. The snapshot is created with the `CREATING` status immediately after the create command is run. From this point on, you can resume writing data to disk, and disk operations will not affect the data in the snapshot.

Once the snapshot has been created, its status changes to `READY`. From this point on, you can use the snapshot to create images, populate disks, and so on.

{% note alert %}

{% include [include](../../../_includes/compute/duplicated-uuid-note.md) %}

To avoid this, attach the disk to the VM and change all the duplicate UUIDs. Learn more in the [instructions for attaching disks](../vm-control/vm-attach-disk.md).

{% endnote %}

