Some commands require that you specify unique IDs for your cloud and folder. You can specify their details in the profile or use a specific flag for these commands.

1. Specify the cloud in your profile:

    ```bash
    yc config set cloud-id <cloud_ID>
    ```

    You can also use the `--cloud-id` parameter to [run commands](../cli/concepts/index.md#manage-properties).
1. Specify a folder in the profile:

    ```bash
    yc config set folder-id <folder_ID>
    ```

    You can also use the `--folder-id` parameter to [run commands](../cli/concepts/index.md#manage-properties).

All operations in this profile will be performed on behalf of the linked service account. You can [change the profile parameters](../cli/operations/profile/manage-properties.md) or [switch to another profile](../cli/operations/profile/profile-activate.md).
