A service account using [impersonation](../../iam/concepts/access-control/impersonation.md) is the recommended and most secure way to get authenticated.

When creating an IAM token, impersonate the service account you created by specifying its ID in the `--impersonate-service-account-id` parameter. As a result, {{ TF }} will manage the folder's resources under the service account and use the service account's IAM token.

{% include [impersonation-role-notice](../cli/impersonation-role-notice.md) %}

To authenticate as a service account:

1. If you do not have the {{ yandex-cloud }} CLI yet, [install it](../../cli/operations/install-cli.md).

1. In the {{ yandex-cloud }} CLI, [create](../../cli/operations/profile/profile-create.md) a new profile or [activate](../../cli/operations/profile/profile-activate.md) a previously created one.

1. Authenticate under your [Yandex account](../../cli/operations/authentication/user.md), [federated](../../cli/operations/authentication/federated-user.md) account, or [local](../../cli/operations/authentication/local-user.md) user account.

1. If you do not have a service account, [create](../../iam/operations/sa/create.md) one.

1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the service account the roles needed to manage {{ yandex-cloud }} resources.

1. Write the credentials to the environment variables using impersonation:

    - Bash {#bash}

      ```bash
      export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <service_account_ID>)
      export YC_CLOUD_ID=$(yc config get cloud-id)
      export YC_FOLDER_ID=$(yc config get folder-id)
      ```

    - PowerShell {#powershell}

      ```powershell
      $Env:YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <service_account_ID>)
      $Env:YC_CLOUD_ID=$(yc config get cloud-id)
      $Env:YC_FOLDER_ID=$(yc config get folder-id)
      ```

    {% endlist %}

    Where `<service_account_ID>` is the service account ID.

As a result, the service account's IAM token, cloud ID, and folder ID will be saved in the environment variables.

{% include [iam-refresh](iam-refresh.md) %}

{% include [provider-config-example](provider-config-example.md) %}
