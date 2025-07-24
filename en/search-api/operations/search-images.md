---
title: How to search for an image in {{ search-api-name }} based on a text description via API v2
description: Follow this guide to learn how to use {{ search-api-full-name }}'s API v2 interface to send text search queries and get search results in XML or HTML format in deferred (asynchronous) mode.
---

# Searching by text description via API v2

With {{ search-api-name }}'s [API v2](../concepts/index.md#api-v2), you can search through the [Yandex Images](https://yandex.ru/images) index by text description and get search results in [XML format](../concepts/image-search.md#xml-response-format). You can run queries using [REST API](../api-ref/) and [gPRC API](../api-ref/grpc/). The search results you get depend on the parameters specified in your query.

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

To use the examples, install the [cURL](https://curl.haxx.se) and [jq](https://stedolan.github.io/jq) utilities, plus [gRPCurl](https://github.com/fullstorydev/grpcurl) if you are going to use [gRPC API](../api-ref/grpc/).

## Get your cloud ready {#initial-setup}

{% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

## Send a search query {#execute-request}

1. Send a query and get a [Base64](https://en.wikipedia.org/wiki/Base64)-encoded result:

    {% list tabs group=instructions %}

    - REST API {#api}

      1. Create a file with the request body, e.g., `body.json`:

          **body.json**

          {% include [http-body-imagesearch](../../_includes/search-api/http-body-imagesearch.md) %}

          {% cut "Description of fields" %}

          {% include [http-body-params-imagesearch](../../_includes/search-api/http-body-params-imagesearch.md) %}

          {% endcut %}

          {% cut "Request body example" %}

          **body.json**

          ```json
          {
            "query": {
              "searchType": "SEARCH_TYPE_RU",
              "queryText": "cats"
            },
            "folderId": "b1gt6g8ht345********"
          }
          ```

          {% endcut %}

      1. Send an HTTP request specifying the IAM token you got earlier and a path to the request body file:

          ```bash
          curl \
            --request POST \
            --header "Authorization: Bearer <IAM_token>" \
            --data "@body.json" \
            "https://searchapi.{{ api-host }}/v2/image/search" \
            > result.json
          ```

    - gRPC API {#grpc-api}

      1. Create a file with the request body, e.g., `body.json`:

          **body.json**

          {% include [grpc-body-imagesearch](../../_includes/search-api/grpc-body-imagesearch.md) %}

          {% cut "Description of fields" %}

          {% include [grpc-body-params-imagesearch](../../_includes/search-api/grpc-body-params-imagesearch.md) %}

          {% endcut %}

          {% cut "Request body example" %}

          **body.json**

          ```json
          {
            "query": {
              "search_type": "SEARCH_TYPE_RU",
              "query_text": "cats"
            },
            "folder_id": "b1gt6g8ht345********"
          }
          ```

          {% endcut %}

      1. Run a gRPC call specifying the IAM token you got earlier and a path to the request body file:

          ```bash
          grpcurl \
            -rpc-header "Authorization: Bearer <IAM_token>" \
            -d @ < body.json \
            searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.ImageSearchService/Search \
            > result.json
          ```

    {% endlist %}

    The search query result will be saved to a file named `result.json` containing a Base64-encoded [XML response](../concepts/image-search.md#xml-response-format) in the `rawData` field.

1. Decode the result from `Base64`:

    ```bash
    echo "$(< result.json)" | \
      jq -r .rawData | \
      base64 --decode > result.xml
    ```

    The [XML response](../concepts/image-search.md#xml-response-format) to the query will be saved to a file named `result.xml`.

#### See also {#see-also}

* [{#T}](./search-images-by-pic.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)