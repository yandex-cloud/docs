---
title: Search queries via {{ search-api-full-name }}'s API v2 interface
description: This section describes the specificities and format of text queries when accessing {{ search-api-name }} via API v2.
---

# Text search

With {{ search-api-name }} v2, you can run queries to the Yandex search database and get a response in [synchronous](#sync-mode) or [deferred](#async-mode) mode. The search results you get depend on the [parameters](#parameters) specified in your query.

Queries can be submitted by a user or [service account](../../iam/concepts/users/service-accounts.md) with the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user).

Depending on the specified query parameters, you will get the result in [XML](./response.md) or [HTML](./html-response.md) format.

## Request body format {#parameters}

{% include [rest-grpc-fields-differ](../../_includes/search-api/rest-grpc-fields-differ.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  {% include [http-body-v2](../../_includes/search-api/http-body-v2.md) %}

  Where:

  {% include [http-v2-body-params](../../_includes/search-api/http-v2-body-params.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-v2](../../_includes/search-api/grpc-body-v2.md) %}

  Where:

  {% include [grpc-v2-body-params](../../_includes/search-api/grpc-v2-body-params.md) %}

{% endlist %}

## Synchronous search mode {#sync-mode}

You can [run](../operations/web-search-sync.md) queries in synchronous mode using the [REST API](../api-ref/) and [gRPC API](../api-ref/grpc/).

In response to a synchronous mode query, depending on the query [parameters](#parameters) you provide, {{ search-api-name }} will return the result in [XML](./response.md) or [HTML](./html-response.md) format. The result is returned in the `rawData` response field as a [Base64-encoded](https://en.wikipedia.org/wiki/Base64) string.

{% include [empty-response-notice](../../_includes/search-api/empty-response-notice.md) %}

## Deferred (asynchronous) search mode {#async-mode}

You can [run](../operations/web-search.md) queries in deferred mode using the [REST API](../api-ref/) and [gRPC API](../api-ref/grpc/). 

In response to a deferred query, {{ search-api-name }} returns an [Operation object](#response-format) containing the operation info: status, ID, call time, etc. 

With the Operation object ID, you can [track](../operations/web-search.md#verify-operation) the query execution status and [get the results](../operations/web-search.md#get-response) once the processing is complete.

Depending on the specified query [parameters](#parameters), you will get the [result](#response-format) in the `response.rawData` response field in [XML](./response.md) or [HTML](./html-response.md) format.

### Response format for asynchronous search {#response-format}

In response to a deferred query, {{ search-api-name }} returns an [Operation object](../../api-design-guide/concepts/operation.md) in the following format:

{% include [empty-response-notice](../../_includes/search-api/empty-response-notice.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  ```json
  {
   "done": true,
   "response": {
    "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
    "rawData": "<Base64_encoded_XML_response_body>"
   },
   "id": "<operation_object_ID>",
   "description": "WEB search async",
   "createdAt": "2024-10-03T08:07:07Z",
   "createdBy": "<subject_ID>",
   "modifiedAt": "2024-10-03T08:12:09Z"
  }
  ```

- gRPC API {#grpc-api}

  ```json
  {
    "id": "<operation_object_ID>",
    "description": "WEB search async",
    "createdAt": "2024-10-03T08:07:07Z",
    "createdBy": "<subject_ID>",
    "modifiedAt": "2024-10-03T08:12:09Z",
    "done": true,
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
      "rawData": "<Base64_encoded_XML_response_body>"
    }
  }
  ```

{% endlist %}

The `response` object within the [Operation object](../../api-design-guide/concepts/operation.md) becomes available only after the query is executed on the {{ search-api-name }} side and the `done` (operation status) field value changes to `true`.

The `rawData` value in the `response` object contains a [Base64](https://en.wikipedia.org/wiki/Base64)-encoded response in [XML](./response.md) or [HTML](./html-response.md) format, depending on the query parameters.

For more information about the Operation object and its fields, see [{#T}](../../api-design-guide/concepts/operation.md).

#### See also {#see-also}

* [{#T}](../operations/web-search-sync.md)
* [{#T}](../operations/web-search.md)
* [{#T}](./response.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../security/index.md)