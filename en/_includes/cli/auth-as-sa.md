1. {% include [list-sas](./list-sas.md) %}
1. Create an authorized key for the service account and save it to a file named `key.json`:

    ```bash
    yc iam key create \
      --service-account-name default-sa \
      --output key.json \
      --folder-id <folder_ID>
    ```

    Where:
    * `--service-account-name`: Name of the service account you got earlier.
    * `--output`: Name of the file to save the authorized key to.
    * `--folder-id`: ID of the folder with the service account.

    Result:

    ```text
    id: aje83v701b1u********
    service_account_id: aje3932acd0c********
    created_at: "2019-08-26T12:31:25Z"
    key_algorithm: RSA_2048
    ```

1. If you created an authorized key on your local machine and want to use it to authenticate in the CLI on a VM, [copy it over SCP](../../compute/operations/vm-connect/scp-sftp.md#scp) beforehand.
1. Add the service account authorized key to the CLI profile.

    1. Create a new CLI profile:

        ```bash
        yc config profile create sa-profile
        ```

    1. Add an authorized key:

        ```bash
        yc config set service-account-key key.json
        ```

1. Make sure the parameters for the service account are added correctly:

    ```bash
    yc config list
    ```
    
    Result:

    ```text
    service-account-key:
      id: aje83v701b1u********
      service_account_id: aje3932acd0c********
      created_at: "2019-08-26T12:31:25Z"
      key_algorithm: RSA_2048
      public_key: |
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBg...
        -----END PUBLIC KEY-----
      private_key: |
        -----BEGIN PRIVATE KEY-----
        MIIEvwIBAD...
        -----END PRIVATE KEY-----
    ```

1. Configure your profile to run commands.

    {% include [add-folder](../cli-add-folder.md) %}
