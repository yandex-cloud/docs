To authenticate under a [service account](../../iam/concepts/users/service-accounts.md), you can use an [API key](../../iam/concepts/authorization/api-key.md) or an [IAM token](../../iam/concepts/authorization/iam-token.md); to authenticate under a user account, you can only use an IAM token.

Get your account details for authentication in the {{ translate-name }} API:

{% list tabs group=auth_keys %}

- API key {#api-key}

  1. If you do not have a service account, [create](../../iam/operations/sa/create.md) one.
  1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-translate-user }}` [role](../../translate/security/index.md#translate-user) for the folder to the service account.
  1. [Get the ID of the folder](../../resource-manager/operations/folder/get-id.md) your service account was created in. Make sure to include the folder ID in the `folderId` field in the body of each request.
  1. [Create](../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key with the `yc.ai.translate.execute` [scope](../../iam/concepts/authorization/api-key.md#scoped-api-keys).
  
      Provide the key in the `Authorization` header of each request in the following format:

      ```yaml
      Authorization: Api-Key <API_key>
      ```

- IAM token {#iam-token}

  1. [Get the ID of any folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-translate-user }}` [role](../../translate/security/index.md#translate-user) or higher. Make sure to include the folder ID in the `folderId` field in the body of each request.
  1. Get an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md), [federated account](../../iam/operations/iam-token/create-for-federation.md) or [service account](../../iam/operations/iam-token/create-for-sa.md).
  
      Provide the token in the `Authorization` header of each request in the following format:

      ```yaml
      Authorization: Bearer <IAM_token>
      ```

{% endlist %}