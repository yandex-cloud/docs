{{ yandex-cloud }} uses the [cloud-init](https://cloud-init.io) mechanism to add users and change many other parameters of the new [virtual machine's](../../compute/concepts/vm.md) OS. To do this, provide the `cloud-init` configuration text in the `user-data` parameter under `metadata`. In our case, these will be system users:
1. Create a UTF-8 encoded text file containing the metadata, for example:

   {% include [user-data](../../_includes/compute/user-data.md) %}

1. In the `main.tf` file, replace `ssh-keys` with the `user-data` parameter and specify the metadata file path:

   ```hcl
   metadata = {
     user-data = "${file("<path_to_file>/meta.txt")}"
   }
   ```

For more information about working with metadata, see [{#T}](../../compute/concepts/vm-metadata.md).
