Create the following environment variables depending on the authentication method:

{% list tabs group=registry_auth %}

- IAM token {#iam-token}

  1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../iam/operations/iam-token/create.md) or [service account](../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.
  1. Create the `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` environment variables:

      ```bash
      export REGISTRY_USERNAME="iam"
      export REGISTRY_PASSWORD="<IAM_token>"
      ```

      Where:

      * `REGISTRY_USERNAME`: Authentication method.
      * `REGISTRY_PASSWORD`: Body of the previously obtained IAM token.

  {% note info %}

  The IAM token's [lifetime](../../iam/concepts/authorization/iam-token.md#lifetime) is limited to {{ iam-token-lifetime }}.

  {% endnote %}

- OAuth token {#oauth-token}

  1. [Get]({{ link-cloud-oauth }}) an OAuth token for the [Yandex account](../../iam/concepts/users/accounts.md#passport) you are going to use for authentication.
  1. Create the `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` environment variables:

      ```bash
      export REGISTRY_USERNAME="oauth"
      export REGISTRY_PASSWORD="<OAuth_token>"
      ```

      Where:

      * `REGISTRY_USERNAME`: Authentication method.
      * `REGISTRY_PASSWORD`: Body of the previously obtained [OAuth token](../../iam/concepts/authorization/oauth-token.md).

  {% note info %}

  The OAuth token is [valid](../../iam/concepts/authorization/oauth-token.md#lifetime) for one year.

  {% endnote %}

- API key {#api-key}

  1. [Create](../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key for the [service account](../../iam/concepts/users/service-accounts.md) you are going to use for authentication.
  1. Create the `REGISTRY_USERNAME` and `REGISTRY_PASSWORD` environment variables:

      ```bash
      export REGISTRY_USERNAME="api_key"
      export REGISTRY_PASSWORD="<API_key>"
      ```

      Where:

      * `REGISTRY_USERNAME`: Authentication method.
      * `REGISTRY_PASSWORD`: Body of the previously created [API key](../../iam/concepts/authorization/api-key.md).

  {% note info %}

  The API key maximum [lifetime](../../iam/concepts/authorization/api-key.md#scoped-api-keys) is set manually when you create the key.

  {% endnote %}

{% endlist %}