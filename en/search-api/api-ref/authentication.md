---
title: How to authenticate with the {{ search-api-full-name }}'s API v2
description: In this section, you will find methods for authenticating with {{ search-api-name }}'s API v2.
---

# Authentication with the API v2

{{ search-api-name }}'s [API v2](../concepts/index.md#api-v2) interface requires you to submit your authentication credentials in each request. The authentication method depends on the type of account used to send your request:

{% list tabs group=authentication %}

- Yandex or federated account {#yandex-account}
  
  1. Get an IAM token to authenticate your [Yandex account](../../iam/operations/iam-token/create.md) or [federated account](../../iam/operations/iam-token/create-for-federation.md). Provide the token in the `Authorization` header of each request in the following format:

      ```yaml
      Authorization: Bearer <IAM_token>
      ```

  1. [Assign](../../iam/operations/roles/grant.md#cloud-or-folder) the user the `search-api.webSearch.user` role for the folder to use for {{ search-api-name }} requests. Make sure to include the folder ID in the `folderId` (`folder_id`) field in the body of each request.
  
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
  1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the service account the `search-api.webSearch.user` role for the folder where it was created and which will be used for {{ search-api-name }} requests. Make sure to include the folder ID in the `folderId` (`folder_id`) field in the body of each request.
  
{% endlist %}

#### See also {#see-also}

* [{#T}](../operations/web-search.md)
* [{#T}](../security/index.md)