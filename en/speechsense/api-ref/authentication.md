# Authentication with the {{ speechsense-full-name }} API

To use the {{ speechsense-name }} API, [create](../../iam/operations/sa/create.md) a service account and use it for authentication.

{% list tabs %}

- Service account

   * Using an [IAM token](../../iam/concepts/authorization/iam-token.md):

      {% note info %}

      {% include [disclamer](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md).
      1. Specify the obtained IAM token in the `Authorization` header in the following format:

          ```
          Authorization: Bearer <IAM token>
          ```

   * With [API keys](../../iam/concepts/authorization/api-key).

      {% note info %}

      {% include [disclamer](../../_includes/iam/api-keys-disclaimer.md) %}

      {% endnote %}

      1. [Get an API key](../../iam/operations/api-key/create.md).
      1. Specify the obtained API key in the `Authorization` header in the following format:

          ```
          Authorization: Api-Key <API key>
          ```

   Do not specify the folder ID in your requests, as the service uses the folder in which the service account was created.

{% endlist %}
