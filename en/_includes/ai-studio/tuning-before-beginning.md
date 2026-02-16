To use the examples:

{% list tabs group=programming_language %}

- Management console {#console}

  You can start working from the management console right away.

- SDK {#sdk}

  1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `ai.editor` [role](../../ai-studio/security/index.md#ai-editor).
  1. [Get](../../iam/operations/authentication/manage-api-keys.md#create-api-key) and save the service account's API key with `yc.ai.foundationModels.execute` as the specified [scope](../../iam/concepts/authorization/api-key.md#scoped-api-keys).

      {% include [sdk-auth-details-paragraph](./sdk-auth-details-paragraph.md) %}
  1. Use the [pip](https://pip.pypa.io/en/stable/) package manager to install the [{{ ml-sdk-name }} library](../../ai-studio/sdk/index.md):

      ```bash
      pip install yandex-ai-studio-sdk
      ```

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](./yandexgpt/ai-before-beginning.md) %}
  1. {% include [curl](../curl.md) %}
  1. Install [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. (Optional) Install the [jq](https://stedolan.github.io/jq/) JSON stream processor.
  1. [Get an IAM token](../../iam/operations/iam-token/create.md) used for authentication in the API.
  
      The [account](../../iam/concepts/users/accounts.md) for which you want to obtain the [IAM token](../../iam/concepts/authorization/iam-token.md) must have the `ai.editor` [role](../../ai-studio/security/index.md#ai-editor) or higher.
  
      {% note info %}

      The IAM token has a short [lifetime](../../iam/concepts/authorization/iam-token.md#lifetime) up to {{ iam-token-lifetime }}.

      {% endnote %}
   
{% endlist %}