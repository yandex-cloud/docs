# Setting up {{ yandex-cloud }} {{ TF }} provider authentication

To authenticate and manage your {{ yandex-cloud }} infrastructure, you can use {{ TF }} as a:
* [Service account](../iam/concepts/users/service-accounts.md) using an [IAM token](#service-account) or [authorized key](#service-account-key).
* [User account](#users).
    * [Yandex account](../iam/concepts/users/accounts.md#passport).
    * [Federated account](../iam/concepts/users/accounts.md#saml-federation).
    * [Local user](../iam/concepts/users/accounts.md#local).


## Authenticating as a service account using an IAM token {#service-account}

{% include [authentication-intro](../_includes/terraform/authentication-intro.md) %}

{% include [authentication-sa](../_includes/terraform/authentication-sa.md) %}


## Authenticating as a service account using an authorized key {#service-account-key}

Allows you to routinely authenticate with the same authorized key you once generated. A long-lived key, however, is less secure than [impersonation and an IAM token](#service-account).

To authenticate as a service account using an authorized key:
1. If you do not have a service account, [create](../iam/operations/sa/create.md) one.
1. [Assign](../iam/operations/sa/assign-role-for-sa.md) to the service account the roles it needs to manage {{ yandex-cloud }} resources.
1. [Create](../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) an authorized key for the service account and save it to the `key.json` file.
1. Write your sensitive data, namely authorized key file path, cloud and folder IDs, into environment variables:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      export YC_SERVICE_ACCOUNT_KEY_FILE="<key_file_path>"
      export YC_CLOUD_ID="<cloud_ID>"
      export YC_FOLDER_ID="<folder_ID>"
      ```

    - PowerShell {#powershell}

      ```powershell
      $Env:YC_SERVICE_ACCOUNT_KEY_FILE="<key_file_path>"
      $Env:YC_CLOUD_ID="<cloud_ID>"
      $Env:YC_FOLDER_ID="<folder_ID>"
      ```

    {% endlist %}

    Where:

    * `YC_SERVICE_ACCOUNT_KEY_FILE`: Path to the authorized key file named `key.json`.
    * `YC_CLOUD_ID`: Cloud ID.
    * `YC_FOLDER_ID`: Folder ID.

    {% note info %}

    When running the `plan` and `apply` commands, you can provide these values directly as command line arguments without specifying them in the configuration:

    ```bash
    terraform apply -var="cloud_id=<cloud_ID>" -var="folder_id=<folder_ID>"
    ```

    {% endnote %}

{% include [provider-config-example](../_includes/terraform/provider-config-example.md) %}


## Authenticating as a user account {#user}

{% include [authentication-intro](../_includes/terraform/authentication-intro.md) %}

{% include [authentication-users](../_includes/terraform/authentication-users.md) %}
