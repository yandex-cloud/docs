---
title: "Authentication in the {{ speechkit-full-name }} API"
description: "To perform operations using the {{ speechkit-full-name }} API, you need to authenticate using your service, federated, or Yandex account. Specify the obtained IAM token in the API request in Authorization: Bearer format <IAM-TOKEN>"
---

{% if audience=="external" %}

# Authentication in the {{ speechkit-name }} API

To work with the {{ speechkit-name }} API, you need to authenticate using your:

{% list tabs %}

{% if product == "yandex-cloud" %}
- Yandex account

   1. [Get an IAM token](../../iam/operations/iam-token/create.md).
   1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) that your account has the `{{ roles-speechkit-stt }}` role or higher for.
   1. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}
      {% endif %}

- Federated account

   {% if product == "cloud-il" %}You can also authenticate using a Google account.{% endif %}

   1. [Get an IAM token](../../iam/operations/iam-token/create-for-federation.md).
   1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) that your account has the `{{ roles-speechkit-stt }}` role or higher for.
   1. {% include [iam-token-usage](../../_includes/iam-token-usage-speechkit-v3.md) %}

- Service accounts

   {{ speechkit-name }} supports two authentication methods based on service accounts:

   * Using an [IAM token](../../iam/concepts/authorization/iam-token.md):

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Pass the obtained IAM token in the `Authorization` header in the following format:

         ```
         Authorization: Bearer <IAM token>
         ```

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Pass the obtained API key in the `Authorization` header in the following format:

         ```
         Authorization: Api-Key <API key>
         ```

   Don't specify the folder ID in your requests: the service uses the folder where the service account was created.

{% endlist %}

{% endif %}

#### See also {#see-also}

* [{#T}](../../iam/concepts/index.md#accounts)
* [What roles are required for performing operations](../security/index.md)
