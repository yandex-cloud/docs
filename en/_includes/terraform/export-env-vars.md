Write your profile’s sensitive data, namely IAM token, cloud and folder IDs, into environment variables:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  export YC_TOKEN=$(yc iam create-token)
  export YC_CLOUD_ID=$(yc config get cloud-id)
  export YC_FOLDER_ID=$(yc config get folder-id)
  ```

- PowerShell {#powershell}

  ```powershell
  $Env:YC_TOKEN=$(yc iam create-token)
  $Env:YC_CLOUD_ID=$(yc config get cloud-id)
  $Env:YC_FOLDER_ID=$(yc config get folder-id)
  ```

{% endlist %}

Where:

`yc iam create-token`: Getting an IAM token for the current session.
`yc config get cloud-id`: Getting the cloud ID from the current CLI profile.
`yc config get folder-id`: Getting the folder ID from the current CLI profile.


As the result, the IAM token, cloud ID, and folder ID will be saved in the environment variables.
