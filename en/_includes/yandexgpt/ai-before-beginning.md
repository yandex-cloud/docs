# Authentication with the {{ yagpt-name }} API

To work with the {{ yagpt-name }} API, you need to get authenticated using your:

{% list tabs %}

- Yandex account

   1. [Get an IAM token](../../iam/operations/iam-token/create.md).
   1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-yagpt-user }}` or higher role.
   1. When accessing {{ yagpt-name }} via the API, provide the received parameters in each request:

      * Specify the IAM token in the `Authorization` header.
      * Specify the folder ID in the `x-folder-id` header.

      ```
      Authorization: Bearer <IAM_token>
      x-folder-id: <folder_ID>
      ```

- Federated account

   1. [Get an IAM token](../../iam/operations/iam-token/create-for-federation.md).
   1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-yagpt-user }}` or higher role.
   1. When accessing {{ yagpt-name }} via the API, provide the received parameters in each request:

      * Specify the IAM token in the `Authorization` header.
      * Specify the folder ID in the `x-folder-id` header.

      ```bash
      Authorization: Bearer <IAM_token>
      x-folder-id: <folder_ID>
      ```

- Service account

   To access {{ yagpt-name }}, your service account needs the `{{ roles-yagpt-user }}` role or higher. {{ yagpt-name }} supports two methods of authentication with a service account:

   * Using an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Specify the obtained IAM token in the `Authorization` header in the following format:

         ```bash
         Authorization: Bearer <IAM token>
         ```

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Specify the obtained API key in the `Authorization` header in the following format:

         ```bash
         Authorization: Api-Key <API key>
         ```

   Do not specify the folder ID in your requests, as {{ yagpt-name }} uses the folder in which the service account was created.

{% endlist %}