---
title: How to search in {{ search-api-name }} by image via API v2
description: Follow this guide to learn how to use {{ search-api-full-name }}'s API v2 interface to send search queries for images based on a source image.
---

# Searching by image via API v2

With {{ search-api-name }}'s [API v2](../concepts/index.md#api-v2), you can search through the [Yandex Images](https://yandex.ru/images) index by image and get search results in [JSON format](../concepts/image-search.md#json-response-format). You can run queries using [REST API](../api-ref/) and [gPRC API](../api-ref/grpc/). The search results you get depend on the [parameters](../concepts/image-search.md#request-body-by-pic) specified in your query.

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

To use the examples, install [cURL](https://curl.haxx.se) and [gRPCurl](https://github.com/fullstorydev/grpcurl) (if planning to use the [gRPC API](../api-ref/grpc/)).

## Get your cloud ready {#initial-setup}

{% include [prepare-cloud-v2](../../_includes/search-api/prepare-cloud-v2.md) %}

## Send a search query {#execute-request}

{% list tabs group=instructions %}

- REST API {#api}

  1. Create a file with the request body, e.g., `body.json`:

      **body.json**

      {% include [http-body-image-bypic-search](../../_includes/search-api/http-body-image-bypic-search.md) %}

      {% cut "Description of fields" %}

      {% include [http-body-params-image-bypic-search](../../_includes/search-api/http-body-params-image-bypic-search.md) %}

      {% endcut %}

      {% cut "Request body example" %}

      **body.json**

      ```json
      {
        "folderId": "b1gt6g8ht345********",
        "data": "<base64-encoded_image>",
        "page": "1"
      }
      ```

      {% endcut %}

  1. Send an HTTP request specifying the IAM token you got earlier and a path to the request body file:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer <IAM_token>" \
        --data "@body.json" \
        "https://searchapi.{{ api-host }}/v2/image/search_by_image" \
        > result.json
      ```

- gRPC API {#grpc-api}

  1. Create a file with the request body, e.g., `body.json`:

      **body.json**

      {% include [grpc-body-image-bypic-search](../../_includes/search-api/grpc-body-image-bypic-search.md) %}

      {% cut "Description of fields" %}

      {% include [grpc-body-params-image-bypic-search](../../_includes/search-api/grpc-body-params-image-bypic-search.md) %}

      {% endcut %}

      {% cut "Request body example" %}

      **body.json**

      ```json
      {
        "folder_id": "b1gt6g8ht345********",
        "data": "<base64-encoded_image>",
        "page": "1"
      }
      ```

      {% endcut %}

  1. Run a gRPC call specifying the IAM token you got earlier and a path to the request body file:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d @ < body.json \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.ImageSearchService/SearchByImage \
        > result.json
      ```

{% endlist %}

The search results in [JSON format](../concepts/image-search.md#json-response-format) will be saved to a file named `result.json`.

#### See also {#see-also}

* [{#T}](./search-images.md)
* [{#T}](../concepts/image-search.md)
* [{#T}](../api-ref/authentication.md)