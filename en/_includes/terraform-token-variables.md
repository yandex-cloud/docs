{% list tabs %}

- Bash

   ```bash
   export YC_TOKEN=$(yc iam create-token)
   export YC_CLOUD_ID=$(yc config get cloud-id)
   export YC_FOLDER_ID=$(yc config get folder-id)
   ```

   Where:
   * `YC_TOKEN`: [IAM token](../iam/concepts/authorization/iam-token.md).
   * `YC_CLOUD_ID`: Cloud ID.
   * `YC_FOLDER_ID`: Folder ID.

- PowerShell

   ```powershell
   $Env:YC_TOKEN=$(yc iam create-token)
   $Env:YC_CLOUD_ID=$(yc config get cloud-id)
   $Env:YC_FOLDER_ID=$(yc config get folder-id)
   ```

   Where:
   * `YC_TOKEN`: [IAM token](../iam/concepts/authorization/iam-token.md).
   * `YC_CLOUD_ID`: Cloud ID.
   * `YC_FOLDER_ID`: Folder ID.

{% endlist %}

{% note info %}

{% include [iam-token-lifetime](iam-token-lifetime.md) %}

{% endnote %}
