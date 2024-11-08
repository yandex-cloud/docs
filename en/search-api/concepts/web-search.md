---
title: Deferred search queries in {{ search-api-full-name }}
description: In this section, you will learn about deferred search queries in {{ search-api-name }}.
---

# Deferred search queries in {{ search-api-name }}

_This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage._

{{ search-api-name }} allows you to run queries to the Yandex search database and get a response in deferred mode. You can run queries using {{ search-api-name }} [REST API](../api-ref/) and [gPRC API](../api-ref/grpc/). Search results depend on the [parameters](#parameters) specified in the query.

[Queries](../../iam/concepts/users/service-accounts.md) can be submitted by a user or [service account](../operations/web-search.md) with the `search-api.webSearch.user` [role](../../iam/concepts/access-control/roles.md).

In response to a deferred query to {{ search-api-name }}, you get an [Operation object](#response-format) containing information about the operation: its status, ID, call time, etc. 

If you know the Operation object ID, you can [track](../operations/web-search.md#verify-operation) the query processing status and [get the result](../operations/web-search.md#get-response) as soon as processing is completed.

## Request body format {#parameters}

The [REST API](../api-ref/) and [gPRC API](../api-ref/grpc/) query body field names are different: REST API uses [CamelCase](https://en.wikipedia.org/wiki/Camel_case), and gPRC API uses [snake_case](https://en.wikipedia.org/wiki/Snake_case).

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [http-body-v2](../../_includes/search-api/http-body-v2.md) %}

  Where:

  {% include [http-v2-body-params](../../_includes/search-api/http-v2-body-params.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-v2](../../_includes/search-api/grpc-body-v2.md) %}

  Where:

  {% include [grpc-v2-body-params](../../_includes/search-api/grpc-v2-body-params.md) %}

{% endlist %}

## Response format {#response-format}

In response to the deferred query, {{ search-api-name }} returns an [Operation object](../../api-design-guide/concepts/operation.md) in the following format:

{% list tabs group=api_type %}

- REST API {#rest-api}

  ```json
  {
   "done": true,
   "response": {
    "@type": "type.googleapis.com/yandex.cloud.searchapi.v2.WebSearchResponse",
    "rawData": "<Base64-encoded_XML_response_body>"
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
      "rawData": "<Base64-encoded_XML_response_body>"
    }
  }
  ```

{% endlist %}

The `response` object inside the [Operation object](../../api-design-guide/concepts/operation.md) becomes available only after the query has been executed on the {{ search-api-name }} side, and the `done` field (operation status) changes to `true`.

The `rawData` field value of the `response` object contains the [Base64-encoded](https://en.wikipedia.org/wiki/Base64) [XML response](./response.md).

For more information about the Operation object and its fields, see [{#T}](../../api-design-guide/concepts/operation.md).

#### See also {#see-also}

* [{#T}](../operations/web-search.md)
* [{#T}](./response.md)
* [{#T}](../api-ref/authentication.md)
* [{#T}](../security/index.md)