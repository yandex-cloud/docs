To create an empty disk:

1. Describe the resource parameters in the `yandex_compute_disk` configuration file.

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
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md). The availability zone for a disk must be the same as that of the placement group where you want to create the disk. We recommend creating disks in the `{{ region-id }}-a` or `{{ region-id }}-b` availability zone.
   * `size`: Disk size in GB. The maximum disk size depends on the specified block size.
   * `block_size`: Block size in bytes (the minimum storage size for information on the disk). By default, the block size of all created disks is 4 KB; however, this is not enough for disks larger than 8 TB. For more information, see [{#T}](../../compute/operations/disk-create/empty-disk-blocksize.md).

   For more information about the `yandex_compute_disk` resource, see the [provider documentation]({{ tf-provider-resources-link }}/compute_disk).

1. Make sure the configuration files are correct.

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

   1. Confirm that you want to create the resources.

   All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```bash
   yc compute disk list
   ```
