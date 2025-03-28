Get your account data for authentication:

{% list tabs group=authentication %}

- Yandex or federated account {#yandex-account}

  1. Get an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md) or [federated account](../../iam/operations/iam-token/create-for-federation.md).
  1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
  1. When accessing {{ vision-name }} via the API, provide the received parameters in each request:

      * For the Vision API and Classifier API:

          Specify the IAM token in the `Authorization` header as follows:

          ```
          Authorization: Bearer <IAM_token>
          ```

          Specify the folder ID in the request body in the `folderId` parameter.

      * For the [OCR API](../../vision/ocr/api-ref/index.md):

          * Specify the IAM token in the `Authorization` header.
          * Specify the folder ID in the `x-folder-id` header.

          ```
          Authorization: Bearer <IAM_token>
          x-folder-id <folder_ID>
          ```

- Service account {#service-account}

  {{ vision-name }} supports two authentication methods based on service accounts:

  * With an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Provide the IAM token in the `Authorization` header in the following format:

          ```
          Authorization: Bearer <IAM_token>
          ```

  * With [API keys](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key).
      1. Provide the API key in the `Authorization` header in the following format:

          ```
          Authorization: Api-Key <API_key>
          ```

  Do not specify the folder ID in your requests, as the service uses the folder the service account was created in.

{% endlist %}