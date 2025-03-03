# Authentication with the {{ foundation-models-full-name }} API

To use the {{ foundation-models-full-name }} API, you need to get authenticated:

{% list tabs group=authentication %}

- Yandex or federated account {#yandex-account}

  1. Get an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md) or [federated account](../../iam/operations/iam-token/create-for-federation.md).
  1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has the minimum required role to work with the model:
     * `{{ roles-yagpt-user }}` or higher: For text generation models.
     * `{{ roles-yaart-user }}` or higher: For {{ yandexart-name }}.
     * `ai.assistants.editor` and `{{ roles-yagpt-user }}` or higher: For {{ assistant-api }}.
     
     You will need the folder ID to get the model's URI.

  1. When accessing {{ foundation-models-name }} via the API, specify the IAM token in the `Authorization` header of each request:

      ```bash
      Authorization: Bearer <IAM_token>
      ```

- Service account {#service-account}

   To access {{ foundation-models-name }}, your service account needs at least the minimum required role:
     * `{{ roles-yagpt-user }}` or higher: For text generation models.
     * `{{ roles-yaart-user }}` or higher: For {{ yandexart-name }}.
     * `ai.assistants.editor` and `{{ roles-yagpt-user }}` or higher: For {{ assistant-api }}.
      
   The {{ foundation-models-name }} API supports two methods of authentication with a service account:

   * With an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Provide the IAM token in the `Authorization` header in the following format:

         ```bash
         Authorization: Bearer <IAM_token>
         ```

   * With [API keys](../../iam/concepts/authorization/api-key.md).

     {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Provide the API key in the `Authorization` header in the following format:

         ```bash
         Authorization: Api-Key <API_key>
         ```

   Do not specify the folder ID in your request headers, as the service uses the folder the service account was created in. However, you will need the parent folder ID to get the model's URI.

{% endlist %}
