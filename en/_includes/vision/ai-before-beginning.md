Get the authorization data for your account:

{% list tabs %}

- User account

   1. Get an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md) or [federated account](../../iam/operations/iam-token/create-for-federation.md).
   1. [Get the ID of the folder](../../resource-manager/operations/folder/get-id.md) that your account has the `{{ roles-vision-user }}` role or higher for.
   1. When accessing {{ vision-name }} via the API, provide the received parameters in each request:

      * For the [Vision API](../../vision/vision/api-ref/index.md) and [Classifier API](../../vision/classifier/api-ref/grpc/index.md):

         Specify the IAM token in the `Authorization` header in the following format:

         ```
         Authorization: Bearer <IAM token>
         ```

         Specify the folder ID in the request body in the `folderId` parameter.

      * For the [OCR API](../../vision/ocr/api-ref/index.md):

         * Specify the IAM token in the `Authorization` header.
         * Specify the folder ID in the `x-folder-id` header.

         ```
         Authorization: Bearer <IAM_token>
         x-folder-id <folder_ID>
         ```

- Service account

   {{ vision-name }} supports two authentication methods based on service accounts:

   * Using an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Specify the obtained IAM token in the `Authorization` header in the following format:

         ```
         Authorization: Bearer <IAM token>
         ```

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Specify the obtained API key in the `Authorization` header in the following format:

         ```
         Authorization: Api-Key <API key>
         ```

   Do not specify the folder ID in your requests, as {{ yagpt-name }} uses the folder where the service account was created.

{% endlist %}