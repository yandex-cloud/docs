# Authorization and authentication in {{ yandex-cloud }}

When a user does something with a resource in {{ yandex-cloud }}, {{ iam-short-name }} checks whether they have the access permissions required to perform this operation.

Users get permissions along with resource roles. For more information about how roles are assigned and how the list of permissions is checked, see [{#T}](../access-control/index.md).

## Authentication in {{ yandex-cloud }} {#authentication}

Before authorization, a user must get authenticated, i.e., they must log in using their account. Authentication is performed in different ways depending on the type of account and the interface used:

* [Authentication with a Yandex account](#passport)
* [Service account authentication](#sa)
* [Federated user authentication](#saml-federation)

### Authentication using a Yandex account {#passport}

{% list tabs group=instructions %}

- Management console {#console}

  When logging in to your Yandex or Yandex 360 account, you will be authenticated automatically.


- CLI {#cli}

  To perform operations in the CLI, authenticate by following [this guide](../../../cli/operations/authentication/user.md). After this, authentication will work automatically.


- API {#api}

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  To perform operations in the API:
  
  1. [Get an IAM token](../../operations/iam-token/create.md) in exchange for your [OAuth token](oauth-token.md).
  1. {% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

     {% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endlist %}

### Service account authentication {#sa}

{% list tabs group=instructions %}

- CLI {#cli}

  To perform operations in the CLI, authenticate by following [this guide](../../../cli/operations/authentication/service-account.md). After this, authentication will work automatically.

- API {#api}

  There are three ways to perform operations on behalf of a service account:

  * Using an [IAM token](iam-token.md):

      This is the recommended authentication method, but IAM tokens have a short [lifetime](iam-token.md#lifetime). This makes it a good method for applications that automatically request an IAM token.

    [Instructions for how to get an IAM token](../../operations/iam-token/create-for-sa.md).
  * With [API keys](api-key).

      {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

      [Instructions for how to get an API key](../../operations/authentication/manage-api-keys.md#create-api-key).
  * Using [static access keys](access-key.md). Use this method for services with an AWS-compatible API, such as {{ objstorage-name }} and {{ message-queue-name }}.

      [Instructions for how to get a static access key](../../operations/authentication/manage-access-keys.md#create-access-key).

{% endlist %}

### Federated user authentication {#saml-federation}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [federated-user-auth](../../../_includes/iam/federated-user-auth.md) %}

  The authentication process for a federated user depends on the IdP server settings. For more information, see [{#T}](../../../organization/concepts/add-federation.md).

- CLI {#cli}

  To perform operations in the CLI, authenticate by following [this guide](../../../cli/operations/authentication/federated-user.md).

  {% include [include](../../../_includes/cli/success-auth-via-federation.md) %}

{% endlist %}

#### See also {#see-also}

[{#T}](../users/accounts.md)