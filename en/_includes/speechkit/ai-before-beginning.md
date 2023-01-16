To work with the {{ speechkit-name }} API, you need to authenticate using your:

{% list tabs %}

{% if product == "yandex-cloud" %}
- Yandex account

   1. [Get an IAM token](../../iam/operations/iam-token/create.md).
   1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) that your account has the `{{ roles-speechkit-stt }}` role or higher for.
   1. {% include [iam-token-usage](../iam-token-usage-speechkit-v3.md) %}
      {% endif %}

- Federated account

   {% if product == "cloud-il" %}You can also authenticate using a Google account.{% endif %}

   1. [Get an IAM token](../../iam/operations/iam-token/create-for-federation.md).
   1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) that your account has the `{{ roles-speechkit-stt }}` role or higher for.
   1. {% include [iam-token-usage](../iam-token-usage-speechkit-v3.md) %}

- Service account

   {{ speechkit-name }} supports two authentication methods based on service accounts:

   * Using an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Pass the obtained IAM token in the `Authorization` header in the following format:

         ```
         Authorization: Bearer <IAM token>
         ```

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Pass the obtained API key in the `Authorization` header in the following format:

         ```
         Authorization: Api-Key <API key>
         ```

   Don't specify the folder ID in your requests: the service uses the folder where the service account was created.

{% endlist %}
