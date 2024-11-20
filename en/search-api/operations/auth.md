---
title: How to authenticate with the {{ search-api-full-name }} API v1
description: This section describes the methods of authentication with the {{ search-api-name }}'s API v1.
---

# Authentication with the API v1

To work with {{ search-api-name }} using [API v1](../concepts/index.md#api-v1), you need to send API requests on behalf of a service account. API v1 only supports authentication with [API keys](../../iam/concepts/authorization/api-key.md).

{% note warning %}

If your API key may have been compromised, revoke it and issue a new one.

{% endnote %}

1. [Get the service account's folder ID](../../resource-manager/operations/folder/get-id.md).
1. [Get an API key](../../iam/operations/api-key/create.md).
1. Provide the obtained values in each request:

    {% list tabs %}

    - GET requests

      In [GET requests](../concepts/get-request.md), provide the folder ID and API key values in the `folderid` and `apikey` fields of the [request URL](../concepts/get-request.md#get-request-format), respectively:
   
      ```text
      curl 'https://yandex.<domain>/search/xml?folderid=<folder_ID>&apikey=<API_key_value>&query=<search_request_text>'
      ```

    - POST requests

      In [POST requests](../concepts/post-request.md), provide the API key value in the `Authorization` request header in the following format:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Api-Key <API_key>" \
        ...
      ```

      Provide the folder ID to the [request URL](../concepts/post-request.md#post-request-format) in the `folderid` field:

      ```text
      https://yandex.<domain>/search/xml?folderid=<folder_ID>
      ```

    {% endlist %}