Configure the CLI to work on behalf of a service account:

1. {% include [cli-install](cli-install.md) %}

1. Create an [authorized key](../iam/concepts/authorization/key.md) for your service account and save the file:

    ```
    yc iam key create --service-account-name my-robot --output key.json
    ```

    If you see `ERROR: service account with name "my-robot" not found`, it means there is no service account with this name in the default folder. If the name is correct, run one of the following commands:
    * Specify the folder with the service account using the `--folder-name` or `--folder-id` parameter:

         ```
         yc iam key create --folder-name my-folder --service-account-name my-robot --output key.json
         ```
    * Specify the service account [ID](../iam/operations/sa/get-id.md) using the `--service-account-id` parameter:

         ```
         yc iam key create --service-account-id b1gnbfd11bq5******** --output key.json
         ```

1. Create a profile to execute operations on behalf of the service account:

    ```
    yc config profile create my-robot-profile
    ```

1. Specify the authorized key of the service account in the profile configuration:

    ```
    yc config set service-account-key key.json
    ```

