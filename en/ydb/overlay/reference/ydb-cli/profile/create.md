# Creating a profile

In a {{ ydb-short-name }} CLI profile, you can specify the endpoint, full DB path, and the authorization method for the user that commands will be run by. The parameters specified in the profile can be omitted when running {{ ydb-short-name }} CLI commands.

Using profiles, you can quickly switch the {{ ydb-short-name }} CLI command execution context. To switch to the desired profile, [activate](activate.md) it. You can also specify a profile for executing commands using a global parameter named `profile`.

To create a profile named `example`:

{% note info %}

If a profile with this name already exists, you'll be prompted to change its settings.

{% endnote %}

1. Run the command:

    ```bash
    {{ ydb-cli }} config profile create example
    ```

1. Enter the endpoint or don't save this parameter for the profile:

    ```text
    Pick desired action to configure endpoint:
     [1] Set a new endpoint value
     [2] Don't save endpoint for profile "example"
    Please enter your numeric choice: 
    ```

1. Enter the DB path or don't save this parameter for the profile:

    ```text
    Pick desired action to configure database:
     [1] Set a new database value
     [2] Don't save database for profile "example"
    Please enter your numeric choice: 
    ```

1. Select the authentication method or don't save this parameter for the profile:

    ```text
    Pick desired action to configure authentication method:
     [1] Use IAM token (iam-token) cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
     [2] Use OAuth token of a Yandex Passport user (yc-token) cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
     [3] Use metadata service on a virtual machine (use-metadata-credentials) cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
     [4] Use security account key file (sa-key-file) cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
     [5] Don't save authentication data for profile "example"
    Please enter your numeric choice: 
    ```

1. Specify whether to activate the profile you're creating as the default profile:

    ```text
    Activate profile "example" to use by default? (current active profile is not set) y/n:
    ```
