Configure the CLI to work on behalf of a service account:

1. {% include [cli-install](cli-install.md) %}
1. Create an authorized key for your service account and save the file. Specify the service account using the `--service-account-name` or `--service-account-id` option:

    ```
    yc iam key create --service-account-name my-robot --output key.json
    ```
1. Create a profile to execute operations on behalf of the service account:

    ```
    yc config profile create my-robot-profile
    ```
1. Specify the authorized key of the service account in the profile configuration:

    ```
    yc config set service-account-key key.json
    ```

