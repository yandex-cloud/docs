To add a user to a VM being created, under `metadata`, include the `user-data` parameter with the user metadata. To do this:

1. Create a UTF-8 encoded text file containing the metadata, for example:

   {% include [user-data](../_includes/compute/user-data.md) %}

1. In the `main.tf` file, replace `ssh-keys` with the `user-data` parameter and specify the metadata file path:

   ```
   metadata = {
       user-data = "${file("<file path>/meta.txt")}"
   }
   ```

For more information about working with metadata, see [VM instance metadata](../compute/concepts/vm-metadata).
