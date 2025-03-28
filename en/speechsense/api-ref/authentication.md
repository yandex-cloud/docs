# Authentication with the {{ speechsense-full-name }} API

To use the {{ speechsense-name }} API, [create](../../iam/operations/sa/create.md) a service account and use it for authentication.

{% list tabs group=authentication %}

- Service account {#service-account}

   * With an [IAM token](../../iam/concepts/authorization/iam-token.md):

      {% note info %}

      {% include [disclamer](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Provide the IAM token in the `Authorization` header in the following format:

          ```yaml
          Authorization: Bearer <IAM_token>
          ```

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% note info %}

      {% include [disclamer](../../_includes/iam/api-keys-disclaimer.md) %}

      {% endnote %}

      1. [Get an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key).
      1. Provide the API key in the `Authorization` header in the following format:

          ```yaml
          Authorization: Api-Key <API_key>
          ```

   Do not specify the folder ID in your requests, as the service uses the folder the service account was created in.

{% endlist %}
