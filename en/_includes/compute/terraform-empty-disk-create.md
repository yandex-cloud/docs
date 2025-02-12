To create an empty disk:

1. Define the parameters of the `yandex_compute_disk` resource in the configuration file.

   Here is an example of the configuration file structure:

   ```hcl
   resource "yandex_compute_disk" "empty-disk" {
     name       = "empty-disk"
     type       = "network-hdd"
     zone       = "<availability_zone>"
     size       = <disk_size>
     block_size = <block_size>
   }
   ```

   Where:
   * `name`: Disk name. The name format is as follows:

        {% include [name-format](../../_includes/name-format.md) %}

   * `type`: Disk type.
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md). The availability zone for your disk must match the zone of the placement group where you want to create it. We recommend creating disks in the `{{ region-id }}-a` or `{{ region-id }}-b` availability zone.
   * `size`: Disk size in GB. The maximum disk size depends on the specified block size.
   * `block_size`: Block size in bytes (minimum storage unit on the disk). By default, the block size is 4 KB for all new disks; however, this is insufficient for disks larger than 8 TB. For more information, see [{#T}](../../compute/operations/disk-create/empty-disk-blocksize.md).

   For more information about the `yandex_compute_disk` resource, see the [relevant provider documentation]({{ tf-provider-resources-link }}/compute_disk).

1. Make sure the configuration files are correct.

   1. In the command line, go to the directory where you created the configuration file.
   1. Run a check using this command:

      ```bash
      terraform plan
      ```

   If the configuration is correct, the terminal will display a list of resources to create and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

1. Deploy the cloud resources.

   1. If the configuration does not contain any errors, run this command:

      ```bash
      terraform apply
      ```

   1. Confirm creating the resources.

   All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc compute disk list
      ```