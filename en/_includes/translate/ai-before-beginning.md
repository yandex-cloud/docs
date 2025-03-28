{{ translate-name }}'s API interface requires you to submit your authentication credentials in each request. The authentication method depends on the type of account used to send your request:

{% list tabs group=authentication %}

- Yandex or federated account {#yandex-account}
  
  {% include [user-auth](user-auth.md) %}
  
- Service account {#service-account}

  1. Choose one of the authentication methods:
     * Get an [IAM token](../../iam/operations/iam-token/create-for-sa.md). Provide the IAM token in the `Authorization` header in the following format:
     
        ```yaml
        Authorization: Bearer <IAM_token>
        ```

     * [Create an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key). Provide the API key in the `Authorization` header in the following format:

        ```yaml
        Authorization: Api-Key <API_key>
        ```
  1. [Assign the service account](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-translate-user }}` role or higher for the folder where it was created.

      Do not specify the folder ID in your requests, as the service uses the folder the service account was created in.
  
{% endlist %}

