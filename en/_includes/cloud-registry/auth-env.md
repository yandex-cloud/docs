Select the authentication method:

{% list tabs group=registry_auth %}

- IAM token {#iam-token}

    Get an [IAM token](../../iam/concepts/authorization/iam-token.md) for the [Yandex account](../../iam/operations/iam-token/create.md) or [service account](../../iam/operations/iam-token/create-for-sa.md) you are going to use for authentication.

    {% note info %}

    The IAM token's [lifetime](../../iam/concepts/authorization/iam-token.md#lifetime) is limited to {{ iam-token-lifetime }}.

    {% endnote %}

- API key {#api-key}

    [Create](../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key for the [service account](../../iam/concepts/users/service-accounts.md) you are going to use for authentication.

    {% note info %}

    The API key maximum [lifetime](../../iam/concepts/authorization/api-key.md#scoped-api-keys) is set manually when you create the key.

    {% endnote %}

{% endlist %}
