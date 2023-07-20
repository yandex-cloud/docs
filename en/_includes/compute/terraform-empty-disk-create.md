To create an empty disk:

1. Describe the resource parameters in the `yandex_compute_disk` configuration file.

   Example configuration file structure:

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
   * `name`: Disk name. Name format:

      {% include [name-format](../../_includes/name-format.md) %}

   * `type`: Type of the disk being created.
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md). The availability zone for a disk must be the same as that of the placement group where you want to create the disk. We recommend creating disks in the `{{ region-id }}-a` or `{{ region-id }}-b` availability zone.
   * `size`: Disk size in GB. The maximum disk size depends on the chosen block size.
   * `block_size`: Block size in bytes (the minimum storage size for information on the disk). By default, the block size of all created disks is 4 KB, but that's not enough for disks larger than 8 TB. For more information, see [{#T}](../../compute/operations/disk-create/empty-disk-blocksize.md).

   For more information about the `yandex_compute_disk` resource, see the [provider documentation]({{ tf-provider-resources-link }}/compute_disk).

1. Make sure that the configuration files are valid.

   1. In the command line, go to the directory where you created the configuration file.
   1. Run the check using the command:

      ```bash
      terraform plan
      ```

   If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

1. Deploy the cloud resources.

   1. If the configuration doesn't contain any errors, run the command:

      ```bash
      terraform apply
      ```

   1. Confirm that you want to create the resources.

   Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

   ```bash
   yc compute disk list
   ```
