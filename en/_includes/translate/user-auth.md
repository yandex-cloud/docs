1. Get an IAM token to authenticate your [Yandex account](../../iam/operations/iam-token/create.md) or [federated account](../../iam/operations/iam-token/create-for-federation.md). Transmit the token in the `Authorization` header of each request in the following format:

   ```yaml
   Authorization: Bearer <IAM token>
   ```

1. [Get the ID of any folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-translate-user }}` [role](../../translate/security/index.md) or higher. Make sure to include your folder ID in the `folderId` field in the body of each request.
