# Authorization in Yandex.Cloud

When a user does something with a resource in Yandex.Cloud, IAM checks whether the user has the necessary access rights to perform this operation.

Users get permissions along with resource roles. For more information about how roles are assigned and how the list of permissions is checked, see [{#T}](../access-control/index.md).

## Authentication in Yandex.Cloud

Before authorization, a user must get authenticated, meaning they must log in under their account. Authentication is performed in different ways, depending on the type of account and the interface used.

### Authentication with a Yandex.Passport account {#passport}

{% list tabs %}

- Management console

  Authentication is carried out automatically when you log in to your Yandex or Yandex.Connect account.

- CLI

  To configure authentication in the CLI, enter your [OAuth token](oauth-token.md) during [profile initialization](../../../cli/quickstart.md#initialize). The token will be saved in the profile configuration and authentication will work automatically.

- API

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  To perform operations in the API:

  1. [Get an IAM token](../../operations/iam-token/create.md) in exchange for your [OAuth token](oauth-token.md).

  2. {% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

      {% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endlist %}

### Service account authentication {#sa}

{% list tabs %}

- CLI

  To perform operations on behalf of your service account, specify the path to its authorized key in the `service-account-key` configuration during [profile initialization](../../../cli/quickstart.md#initialize). The key will be saved in the profile configuration and authentication will work automatically.

- API

  There are three ways to perform operations on behalf of a service account:

  * Using an [IAM token](iam-token.md).

      This is the recommended authentication method, but IAM tokens have a short [lifetime](iam-token.md#lifetime). Therefore, such a method is good for applications that will request the IAM token automatically.
      * [Instructions for how to get an IAM token](../../operations/iam-token/create-for-sa.md).
      * [How to get an IAM token from inside the VM](../../../compute/operations/vm-connect/auth-inside-vm.md).

  * Using [API keys](api-key).

      {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

      [Instructions for how to get an API key](../../operations/api-key/create.md).

  * Using [static access keys](access-key.md). This method should be used in services with an AWS-compatible API, such as {{ objstorage-name }} and {{ message-queue-name }}.

      [Instructions for how to get a static access key](../../operations/sa/create-access-key.md).

{% endlist %}

### Federated user authentication {#saml-federation}

{% include [federated-user-auth](../../../_includes/iam/federated-user-auth.md) %}

The authentication process for a federated user depends on the IdP server settings. For more information, see [{#T}](../users/identity-federations.md)

