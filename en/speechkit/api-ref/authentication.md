# Authentication in the API


To perform operations via the API, you need to authenticate using your account:

{% list tabs %}

- Yandex account

   1. [Get an IAM token](../../iam/operations/iam-token/create.md).
   2. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

- Service accounts

   The service supports two authentication methods based on service accounts:

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Enter the API key when accessing {{ yandex-cloud }} resources via the API. Pass the API key in the `Authorization` header in the following format:

         ```
         Authorization: Api-Key <API key>
         ```
   * Using an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

- Federated account

   1. [Get an IAM token](../../iam/operations/iam-token/create-for-federation.md).
   1. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

{% endlist %}
