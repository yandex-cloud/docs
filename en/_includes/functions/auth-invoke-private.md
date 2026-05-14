* [IAM token](../../iam/concepts/authorization/iam-token.md):

    * [Guide](../../iam/operations/iam-token/create.md) for a Yandex account.
    * [Guide](../../iam/operations/iam-token/create-for-sa.md) for a service account.
    * [Guide](../../iam/operations/iam-token/create-for-federation.md) for a federated account.
    * [Guide](../../iam/operations/iam-token/create-for-local.md) for a local account.

    Provide the IAM token in the `Authorization` header in the following format:

    ```text
    Authorization: Bearer <IAM_token>
    ```

    IAM tokens are valid for up to 12 hours.

* Service account [API key](../../iam/operations/authentication/manage-api-keys.md).

    Provide the API key in the `Authorization` header in the following format:

    ```text
    Authorization: Api-Key <API_key>
    ```

    {% include [api-keys-disclaimer](../iam/api-keys-disclaimer.md) %}