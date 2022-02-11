To add a user to the created VM, specify the `user-data` parameter with user metadata under `metadata`. To do this:

1. Create a text metadata file, for example:

    {% include [user-data](../../_includes/compute/user-data.md) %}

1. In the `main.tf` file, replace `ssh-keys` with the `user-data` parameter and specify the metadata file path:

    ```
    metadata = {
        user-data = "${file("<file path>/meta.txt")}"
    }
    ```

To learn more about working with metadata, see [VM instance metadata](../../compute/concepts/vm-metadata).

