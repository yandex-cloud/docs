# Authentication with the {{ ai-studio-full-name }} API

To use the {{ ai-studio-full-name }} API, you need to get authenticated:

{% list tabs group=authentication %}

- Yandex account, federated account, or local account {#yandex-account}

  1. Get an IAM token for a [Yandex account](../../iam/operations/iam-token/create.md), [federated account](../../iam/operations/iam-token/create-for-federation.md), or [local account](../../iam/operations/iam-token/create-for-local.md).
  1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has at least the minimum role for the functionality:
     * `{{ roles-yagpt-user }}` or higher: For text generation models.
     * `{{ roles-yaart-user }}` or higher: For {{ yandexart-name }}.
     * `ai.assistants.editor` and `{{ roles-yagpt-user }}` or higher: For {{ responses-api }}.
     * `ai.models.user` or higher: For {{ realtime-api }}.
     * `serverless.mcpGateways.editor` or higher: To manage MCP servers.
     
     You will need the folder ID to get the model's URI.

  1. When accessing {{ ai-studio-name }} via the API, specify the IAM token in the `Authorization` header of each request:

      ```bash
      Authorization: Bearer <IAM_token>
      ```

- Service account {#service-account}

   To access {{ ai-studio-name }}, your service account needs at least the minimum required role:
     * `{{ roles-yagpt-user }}` or higher: For text generation models.
     * `{{ roles-yaart-user }}` or higher: For {{ yandexart-name }}.
     * `ai.assistants.editor` and `{{ roles-yagpt-user }}` or higher: For {{ responses-api }}.
     * `ai.models.user` or higher: For {{ realtime-api }}.
     * `serverless.mcpGateways.editor` or higher: To manage MCP servers. The {{ mcp-hub-name }} API supports only IAM token authentication.

   The {{ ai-studio-name }} APIs support two service account authentication methods:

   * With an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Provide the IAM token in the `Authorization` header in the following format:

         ```bash
         Authorization: Bearer <IAM_token>
         ```

   * With [API keys](../../iam/concepts/authorization/api-key.md).

     {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key).
      1. Provide the API key in the `Authorization` header in the following format:

         ```bash
         Authorization: Api-Key <API_key>
         ```

   Do not specify the folder ID in your request headers, as the service uses the folder the service account was created in. However, you will need the parent folder ID to get the model's URI.

{% endlist %}
