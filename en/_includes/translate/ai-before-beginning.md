The {{ translate-name }} API requires you to send your authentication credentials in each request. The authentication method depends on the type of account used to send your request:

{% list tabs group=authentication %}

- Yandex or federated account {#yandex-account}

   {% include [user-auth](user-auth.md) %}

- Service account {#service-account}

   1. Choose one of the authentication methods:
      * Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md). Include the IAM token in the `Authorization` header in the following format:

         ```yaml
         Authorization: Bearer <IAM token>
         ```

      * [Create an API key](../../iam/operations/api-key/create.md). Include the API key in the `Authorization` header in the following format:

         ```yaml
         Authorization: Api-Key <API key>
         ```
   1. [Assign the service account](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-translate-user }}` role or higher for the folder where it was created.

      Do not specify the folder ID in your requests, as {{ yagpt-name }} uses the folder in which the service account was created.

{% endlist %}

