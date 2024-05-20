# Authentication in {{ search-api-full-name }}

To work with {{ search-api-name }}, you need to send API requests on behalf of a service account. {{ search-api-name }} only supports authentication with [API keys](../../iam/concepts/authorization/api-key.md).

{% note warning %}

API keys do not expire. If your key might have been compromised, invalidate it and issue a new one.

{% endnote %}

1. [Get the service account's folder ID](../../resource-manager/operations/folder/get-id.md).
1. [Get an API key](../../iam/operations/api-key/create.md).
1. Provide the obtained values in each request.

   * For [POST requests](../concepts/post-request.md), provide the folder ID and API key values in the `Authorization` header in the following format:

     ```curl
     Authorization: Api-Key <API_key>
     ```

   Make sure to include your folder ID in the `folderid` field in the request body:

     ```httpget
     https://yandex.<domain>/search/xml?folderid=<folder_ID>
     ```

   * For [GET requests](../concepts/get-request.md), provide the folder ID and API key values in the `folderid` and `apikey` fields of the request body, respectively:

     ```curl
     curl 'https://yandex.<domain>/search/xml?folderid=<folder_ID>&apikey=<API_key_value>&query=<search_query_text>'
     ```
