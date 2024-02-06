# Authentication with the API

To perform operations via the API, you need to authenticate using your account:

{% list tabs group=authentication %}

- Yandex or federated account {#yandex-account}

  1. Get an IAM token for your [Yandex account](../iam/operations/iam-token/create.md) or [federated account](../iam/operations/iam-token/create-for-federation.md).
  1. {% include [iam-token-usage](iam-token-usage.md) %}

- Service accounts {#service-account}

  The service supports two authentication methods based on service accounts:
  * Using an [IAM token](../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../iam/operations/iam-token/create-for-sa.md).
      1. {% include [iam-token-usage](iam-token-usage.md) %}

  * With [API keys](../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../iam/operations/api-key/create.md).
      1. Enter the API key when accessing {{ yandex-cloud }} resources via the API. Include the API key in the `Authorization` header in the following format:

          ```
          Authorization: Api-Key <API key>
          ```

{% endlist %}
