# Authenticating when invoking a private function via HTTPS

To invoke a private function via HTTPS, you must authenticate. To do this, get:

* The [IAM token](../../../iam/concepts/authorization/iam-token.md):
   * [Instructions](../../../iam/operations/iam-token/create.md) for a Yandex account.
   * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
   * [Instructions](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.

   Pass the obtained IAM token in the `Authorization` header using the following format:
   ```
   Authorization: Bearer <IAM TOKEN>
   ```
   IAM tokens are valid for 12 hours maximum.

* The [API key](../../../iam/operations/api-key/create) for the service account.

   Pass the obtained API key in the `Authorization` header using the following format:
   ```
   Authorization: Api-Key <API key>
   ```
   API keys do not expire. This means that this authentication method is simpler, but less secure. Use it if you can't request an IAM token automatically.
