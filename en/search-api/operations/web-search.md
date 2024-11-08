---
title: How to search using {{ search-api-name }} in deferred mode
description: Follow this guide to learn how to use {{ search-api-name }} to submit search queries and get search results in XML format in deferred (asynchronous) mode.
---

# Performing search queries in {{ search-api-name }} in deferred mode

With {{ search-api-name }}, you can perform text search through the Yandex search database and get search results in [XML format](../concepts/response.md) in [deferred mode](../concepts/web-search.md). You can run queries using the {{ search-api-name }} [REST API](../api-ref/) and [gPRC API](../api-ref/grpc/). Search results depend on the parameters specified in the query.

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

To use the examples, install [cURL](https://curl.haxx.se) and [jq](https://stedolan.github.io/jq), as well as [gRPCurl](https://github.com/fullstorydev/grpcurl) (if you plan on using [gRPC API](../api-ref/grpc/)).

## Prepare your cloud {#initial-setup}

1. [Create](../../iam/operations/sa/create.md) a service account to authenticate as one.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) the `search-api.webSearch.user` role to the user or [service account](../../iam/concepts/users/service-accounts.md) you will use to run queries.
1. [Get an IAM token](../../iam/operations/index.md#iam-tokens) required for [authentication](../api-ref/authentication.md). 

    The following examples show authentication using an IAM token. Edit the `Authorization` header in the query examples to use service account's [API key](../../iam/concepts/authorization/api-key.md) for authentication. For more information, see [{#T}](../api-ref/authentication.md).

## Create a search query {#form-request}

{% list tabs group=api_type %}

- REST API {#rest-api}

  1. Create a file with the request body, e.g., `body.json`:

      **body.json**

      {% include [http-body-v2](../../_includes/search-api/http-body-v2.md) %}

      {% cut "Description of fields" %}

      {% include [http-v2-body-params](../../_includes/search-api/http-v2-body-params.md) %}

      {% endcut %}

  1. Run an HTTP query by specifying the IAM token you got earlier:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer <IAM_token>" \
        --data "@body.json" \
        "https://searchapi.{{ api-host }}/v2/web/searchAsync"
      ```

      Result:

      ```text
      {
       "done": false,
       "id": "sppger465oq1********",
       "description": "WEB search async",
       "createdAt": "2024-10-02T19:51:02Z",
       "createdBy": "bfbud0oddqp4********",
       "modifiedAt": "2024-10-02T19:51:03Z"
      }
      ```

- gRPC API {#grpc-api}

  1. Create a file with the request body, e.g., `body.json`:

      **body.json**

      {% include [grpc-body-v2](../../_includes/search-api/grpc-body-v2.md) %}

      {% cut "Description of fields" %}

      {% include [grpc-v2-body-params](../../_includes/search-api/grpc-v2-body-params.md) %}

      {% endcut %}

  1. Run a gRPC call by specifying the IAM token you got earlier:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d @ < body.json \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WebSearchAsyncService/Search
      ```

      Result:

      ```text
      {
        "id": "spp3gp3vhna6********",
        "description": "WEB search async",
        "createdAt": "2024-10-02T19:14:41Z",
        "createdBy": "bfbud0oddqp4********",
        "modifiedAt": "2024-10-02T19:14:42Z"
      }
      ```

{% endlist %}

Save the obtained [Operation object](../../api-design-guide/concepts/operation.md) ID (`id` value) for later use.

## Make sure the query was executed successfully {#verify-operation}

Wait until {{ search-api-name }} runs a query and generates a response. This may take from five minutes to a few hours.

Make sure the query was executed successfully:

{% list tabs group=api_type %}

- REST API {#rest-api}

  Run an HTTP query:

  ```bash
  curl \
    --request GET \
    --header "Authorization: Bearer <IAM_token>" \
    https://operation.{{ api-host }}/operations/<query_ID>
  ```

  Where:

  * `<IAM_token>`: Previously obtained IAM token.
  * `<query_ID>`: Operation object ID you saved in the previous step.

  Result:

  ```text
  {
   "done": true,
   "response": {
    "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
    "rawData": "<Base64-encoded_XML_response_body>"
   },
   "id": "spp82pc07ebl********",
   "description": "WEB search async",
   "createdAt": "2024-10-03T08:07:07Z",
   "createdBy": "bfbud0oddqp4********",
   "modifiedAt": "2024-10-03T08:12:09Z"
  }
  ```

- gRPC API {#grpc-api}

  Run a gRPC call:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \
    -d '{"operation_id": "<query_ID>"}' \
    operation.{{ api-host }}:443 yandex.cloud.operation.OperationService/Get
  ```

  Where:

  * `<IAM_token>`: Previously obtained IAM token.
  * `<query_ID>`: Operation object ID you saved in the previous step.

  Result:

  ```text
  {
    "id": "spp82pc07ebl********",
    "description": "WEB search async",
    "createdAt": "2024-10-03T08:07:07Z",
    "createdBy": "bfbud0oddqp4********",
    "modifiedAt": "2024-10-03T08:12:09Z",
    "done": true,
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
      "rawData": "<Base64-encoded_XML_response_body>"
    }
  }
  ```

{% endlist %}

If the `done` field says `true` and the `response` object is present in the output, the query has been completed successfully, so you can move on to the next step. Otherwise, repeat the check later.

## Get a response {#get-response}

After {{ search-api-name }} has successfully processed the query:

1. Get the result:

    {% list tabs group=api_type %}

    - REST API {#rest-api}

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer <IAM_token>" \
        https://operation.{{ api-host }}/operations/<query_ID> \
        > result.json
      ```

    - gRPC API {#grpc-api}

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d '{"operation_id": "<query_ID>"}' \
        operation.{{ api-host }}:443 yandex.cloud.operation.OperationService/Get \
        > result.json
      ```

    {% endlist %}

    Eventually the search query result will be saved to a file named `result.json` containing [Base64-encoded](https://en.wikipedia.org/wiki/Base64) [XML response](../concepts/response.md) in the `response.rawData` field.

1. Decode the result from `Base64`:

    ```bash
    echo "$(< result.json)" | \
      jq -r .response.rawData | \
      base64 --decode > result.xml
    ```

    The query XML response will be saved to the `result.xml` file.

#### See also {#see-also}

* [{#T}](../concepts/web-search.md)
* [{#T}](../api-ref/authentication.md)