

# Authentication in the API

To perform operations via the API, you need to authenticate using your account:

{% list tabs %}

- Yandex account

   1. [Get an IAM token](../../iam/operations/iam-token/create.md).
   1. Get [the ID of a folder](../../resource-manager/operations/folder/get-id.md) that your account has the `editor` or a higher role for.
   1. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

- Service accounts

   {{ speechkit-name }} supports two authentication methods based on service accounts:

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Pass the obtained API key in the `Authorization` header in the following format:

         ```
         Authorization: Api-Key <API key>
         ```
   * Using an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Pass the obtained IAM token in the `Authorization` header in the following format:

         ```
         Authorization: Bearer <IAM token>
         ```

   Don't specify the folder ID in your requests: the service uses the folder where the service account was created.

- Federated account

   1. [Get an IAM token](../../iam/operations/iam-token/create-for-federation.md).
   1. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

{% endlist %}


#### See also {#see-also}

* [What roles are required for performing operations](../security/index.md)