{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the disk.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. In the line with the disk, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
  1. Enter a name for the snapshot. Follow these naming requirements:

      {% include [name-format](../name-format.md) %}

  1. Provide a description for the snapshot, if required.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI commands for creating snapshots:

      ```bash
      yc compute snapshot create --help
      ```

  1. Select the disk to create a snapshot of. To get a list of disks in the default folder, run this command:

      {% include [compute-disk-list](../compute/disk-list.md) %}

  1. Create a snapshot in the default folder:

      ```bash
      yc compute snapshot create \
        --name first-snapshot \
        --description "my first snapshot via CLI" \
        --disk-id fhm4aq4hvq5g********
      ```

      This will create a disk snapshot named `first-snapshot` and described as `my first snapshot via CLI`.

      The snapshot naming requirements are as follows:

      {% include [name-format](../name-format.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_snapshot` resource in the configuration file.

     Here is an example of the configuration file structure:
     
     ```hcl
     resource "yandex_compute_snapshot" "snapshot-1" {
       name           = "disk-snapshot"
       source_disk_id = "<disk_ID>"
     }
     ```

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}/).

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources.

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  1. Get a list of disks using the [list](../../compute/api-ref/Disk/list.md) REST API method for the [Disk](../../compute/api-ref/Disk/index.md) resource or the [DiskService/List](../../compute/api-ref/grpc/Disk/list.md) gRPC API call.
  1. Create a snapshot using the [create](../../compute/api-ref/Snapshot/create.md) REST API method for the [Snapshot](../../compute/api-ref/Snapshot/index.md) resource or the [SnapshotService/Create](../../compute/api-ref/grpc/Snapshot/create.md) gRPC API call.

{% endlist %}