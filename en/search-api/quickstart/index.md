---
title: How to get started with {{ search-api-full-name }}
description: Follow this guide to set up your {{ yandex-cloud }} workspace and get started with {{ search-api-name }} using the API v2 interface.
---

# How to get started with the {{ search-api-name }} via API v2

[API v2](../concepts/index.md#api-v2) is the recommended {{ search-api-name }} interface. API v2 is fully integrated into the [{{ yandex-cloud }} ecosystem](../../overview/concepts/services.md) and supports both [API key](../../iam/concepts/authorization/api-key.md) authentication as well as the more secure [authentication](../api-ref/authentication.md) based on short-lived [IAM tokens](../../iam/concepts/authorization/iam-token.md).

For {{ search-api-name }} prices, see [{#T}](../pricing.md).

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Get your cloud ready {#initial-setup}

1. [Create](../../iam/operations/sa/create.md) a service account you will use to send requests to {{ search-api-name }}.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) the `search-api.webSearch.user` [role](../../search-api/security/index.md#search-api-webSearch-user) to the service account you created.
1. [Create](../../iam/operations/authentication/manage-api-keys.md#create-api-key) an API key for the [service account](../../iam/concepts/users/service-accounts.md) with `yc.search-api.execute` for its [scope](../../iam/concepts/authorization/api-key.md#scoped-api-keys).
1. To use the examples, install the [cURL](https://curl.haxx.se) and [jq](https://stedolan.github.io/jq) utilities.

The following examples use [API key](../../iam/concepts/authorization/api-key.md) authentication. To use an [IAM token](../../iam/concepts/authorization/iam-token.md) for authentication, edit the `Authorization` header in the request examples. For more information, see [{#T}](../../search-api/api-ref/authentication.md).

In the provided examples, requests to {{ search-api-name }} are [REST API](../api-ref/) requests. For sample [gRPC API](../api-ref/grpc/) request, see [{#T}](../operations/web-search.md).

## Create a search query {#form-request}

In the example, the request returns a page of search results for the `coffee machine` query in [HTML](../concepts/html-response.md) and [XML](../concepts/response.md) formats.

1. Create a [request body](../concepts/web-search.md#parameters) file (e.g., `body.json`) with the [ID of the folder](../../resource-manager/operations/folder/get-id.md) you are going to use for {{ search-api-name }} in the `folderId` field:

    {% list tabs group=search_api_request %}

    - HTML {#html}

      **body.json**

      ```json
      {
          "query": {
            "searchType": "SEARCH_TYPE_RU",
            "queryText": "coffee machine"
          },
          "folderId": "<folder_ID>",
          "responseFormat": "FORMAT_HTML",
          "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36"
      }
      ```

    - XML {#xml}

      **body.json**

      ```json
      {
          "query": {
            "searchType": "SEARCH_TYPE_RU",
            "queryText": "coffee machine"
          },
          "folderId": "<folder_ID>",
          "responseFormat": "FORMAT_XML",
          "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 YaBrowser/25.2.0.0 Safari/537.36"
      }
      ```

    {% endlist %}

    For more information about the request body parameters, see [{#T}](../concepts/web-search.md#parameters).
1. Send your HTTP request by specifying the API key created earlier and the path to the request body file:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Api-Key <API_key>" \
        --data "@body.json" \
        "https://searchapi.{{ api-host }}/v2/web/searchAsync"
      ```

      Result:

      ```text
      {
      "done": false,
      "id": "sprqjo0kf40j********",
      "description": "WEB search async",
      "createdAt": "2025-05-05T18:10:44Z",
      "createdBy": "ajegtlf2q28a********",
      "modifiedAt": "2025-05-05T18:10:44Z"
      }
      ```

      This will return the [Operation object](../../api-design-guide/concepts/operation.md) ID (`id` value), by which you can retrieve the result of the operation. Save the ID for later.

## Make sure the request was executed successfully and get the result {#verify-operation}

Wait until {{ search-api-name }} executes the request and generates a response. This may take from a few minutes to a few hours.

To make sure your search query was executed successfully, send the following HTTP request:

  ```bash
  curl \
    --request GET \
    --header "Authorization: Api-Key <API_key>" \
    https://operation.{{ api-host }}/operations/<request_ID> \
    > result.json
  ```

  Where:

  * `<API_key>`: API key you created earlier.
  * `<request_ID>`: The Operation object ID you saved in the previous step.

  The response will be saved to the `result.json` file. Open the file to make sure its `done` field is set to `true`, and the `response` field contains the result of the search query.

## Decode the result {#decode}

The `result.json` file stores the [Base64](https://en.wikipedia.org/wiki/Base64)-encoded search query result in its `response` field. To decode the result, run this command:

{% list tabs group=search_api_request %}

- HTML {#html}

  ```bash
  echo "$(< result.json)" | \
    jq -r .response.rawData | \
    base64 --decode > result.html
  ```

  The HTML response to the query will be saved to a file named `result.html`.

- XML {#xml}

  ```bash
  echo "$(< result.json)" | \
    jq -r .response.rawData | \
    base64 --decode > result.xml
  ```

  The XML response to the query will be saved to a file named `result.xml`.

{% endlist %}

#### See also {#see-also}

* [{#T}](../api-ref/authentication.md)
* [{#T}](../operations/web-search.md)
* [{#T}](../operations/web-search-sync.md)
* [{#T}](../concepts/web-search.md)
* [{#T}](../pricing.md)
