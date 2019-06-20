# Authentication in the API

To perform operations in Yandex.Cloud via the API, you need to authenticate using your account.

{% list tabs %}

- Yandex account
  
  To perform operations with a Yandex account, you need an [IAM token](../iam/concepts/authorization/iam-token.md):
  
  1. [Get an IAM token](../iam/operations/iam-token/create.md) for your Yandex account.
  
  2. {% include [iam-token-usage](iam-token-usage.md) %}
  
      {% include [iam-token-lifetime](iam-token-lifetime.md) %}
  
- Service account
  
  The service supports two authentication methods based on service accounts:
  
  * Using [API keys](../iam/concepts/authorization/api-key).
  
      {% include [api-keys-disclaimer](iam/api-keys-disclaimer.md) %}
  
      1. [Get an API key](../iam/operations/api-key/create.md).
  
      2. Specify the received API key when accessing Yandex.Cloud resources via the API. Pass the API key in the `Authorization` header in the following format:
  
          ```
          Authorization: Api-Key <API-KEY>
          ```
  
  * Using an [IAM token](../iam/concepts/authorization/iam-token.md):
  
      1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md).
  
      2. {% include [iam-token-usage](iam-token-usage.md) %}
  
          {% include [iam-token-lifetime](iam-token-lifetime.md) %}
  
{% endlist %}

