To add a user to the [VM](../../compute/concepts/vm.md) being created, under `metadata`, include the `user-data` parameter with the user metadata. To do this:
1. Create a UTF-8 encoded text file containing the metadata, for example:

   {% include [user-data](../../_includes/compute/user-data.md) %}

1. In the `main.tf` file, replace `ssh-keys` with the `user-data` parameter and specify the metadata file path:

   ```hcl
   metadata = {
     user-data = "${file("<file_path>/meta.txt")}"
   }
   ```

For more information about working with metadata, see [{#T}](../../compute/concepts/vm-metadata).