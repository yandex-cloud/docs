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
