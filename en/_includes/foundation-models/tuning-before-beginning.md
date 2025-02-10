To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `ai.editor` [role](../../foundation-models/security/index.md#languageModels-user) to it.
  1. [Get](../../iam/operations/api-key/create.md) the service account API key and save it.

      {% include [sdk-auth-details-paragraph](./sdk-auth-details-paragraph.md) %}
  1. Use the [pip](https://pip.pypa.io/en/stable/) package manager to install the [{{ ml-sdk-name }} library](../../foundation-models/sdk/index.md):

      ```bash
      pip install yandex-cloud-ml-sdk
      ```

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](./yandexgpt/ai-before-beginning.md) %}
  1. Install [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. {% include [curl](../curl.md) %}
  1. (Optional) Install the [jq](https://stedolan.github.io/jq/) JSON stream processor.
  1. [Get an IAM token](../../iam/operations/iam-token/create.md) used for authentication in the API.
  
     {% note info %}

     The IAM token has a short [lifetime](../../iam/concepts/authorization/iam-token.md#lifetime): no more than {{ iam-token-lifetime }}.

     {% endnote %}
   
{% endlist %}