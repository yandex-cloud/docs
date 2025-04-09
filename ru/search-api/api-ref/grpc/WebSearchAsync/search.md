---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/v2/api-ref/grpc/WebSearchAsync/search.md
---

# Web Search API, gRPC: WebSearchAsyncService.Search

## gRPC request

**rpc Search ([WebSearchRequest](#yandex.cloud.searchapi.v2.WebSearchRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## WebSearchRequest {#yandex.cloud.searchapi.v2.WebSearchRequest}

```json
{
  "query": {
    "search_type": "SearchType",
    "query_text": "string",
    "family_mode": "FamilyMode",
    "page": "int64",
    "fix_typo_mode": "FixTypoMode"
  },
  "sort_spec": {
    "sort_mode": "SortMode",
    "sort_order": "SortOrder"
  },
  "group_spec": {
    "group_mode": "GroupMode",
    "groups_on_page": "int64",
    "docs_in_group": "int64"
  },
  "max_passages": "int64",
  "region": "string",
  "l10n": "Localization",
  "folder_id": "string",
  "response_format": "Format",
  "user_agent": "string"
}
```

#|
||Field | Description ||
|| query | **[SearchQuery](#yandex.cloud.searchapi.v2.SearchQuery)**

Required field. Search query. ||
|| sort_spec | **[SortSpec](#yandex.cloud.searchapi.v2.SortSpec)**

The rules for sorting search results that define the sequence of the returned search results. ||
|| group_spec | **[GroupSpec](#yandex.cloud.searchapi.v2.GroupSpec)**

Grouping settings that are used to group documents from a single domain into a container. ||
|| max_passages | **int64**

The maximum number of passages that can be used when generating a document snippet. ||
|| region | **string**

ID of the search country or region that impacts the document ranking rules. ||
|| l10n | enum **Localization**

The notification language for a search response.

- `LOCALIZATION_UNSPECIFIED`
- `LOCALIZATION_RU`: Russian (default value)
- `LOCALIZATION_UK`: Ukrainian
- `LOCALIZATION_BE`: Belarusian
- `LOCALIZATION_KK`: Kazakh
- `LOCALIZATION_TR`: Turkish
- `LOCALIZATION_EN`: English ||
|| folder_id | **string**

ID of the folder. ||
|| response_format | enum **Format**

Search results format.

- `FORMAT_UNSPECIFIED`
- `FORMAT_XML`: XML format (default value)
- `FORMAT_HTML`: HTML format ||
|| user_agent | **string**

User-Agent request header value. ||
|#

## SearchQuery {#yandex.cloud.searchapi.v2.SearchQuery}

#|
||Field | Description ||
|| search_type | enum **SearchType**

Required field. Search type that determines the domain name that will be used for the search queries.

- `SEARCH_TYPE_UNSPECIFIED`
- `SEARCH_TYPE_RU`: Russian search type (default), yandex.ru search domain name will be used.
- `SEARCH_TYPE_TR`: Turkish search type, yandex.tr search domain name will be used.
- `SEARCH_TYPE_COM`: International search type, yandex.com search domain name will be used.
- `SEARCH_TYPE_KK`: Kazakh search type, yandex.kz search domain name will be used.
- `SEARCH_TYPE_BE`: Belarusian search type, yandex.by search domain name will be used. ||
|| query_text | **string**

Required field. Search query text ||
|| family_mode | enum **FamilyMode**

Rule for filtering search results and determines whether any documents should be excluded.

- `FAMILY_MODE_UNSPECIFIED`
- `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
- `FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results
unless a query is explicitly made for searching resources of this category.
- `FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category
and those with profanity are excluded from search results. ||
|| page | **int64**

The number of a requested page with search results ||
|| fix_typo_mode | enum **FixTypoMode**

Typos autocorrections mode

- `FIX_TYPO_MODE_UNSPECIFIED`
- `FIX_TYPO_MODE_ON`: Automatically correct typos (default value).
- `FIX_TYPO_MODE_OFF`: Autocorrection is off. ||
|#

## SortSpec {#yandex.cloud.searchapi.v2.SortSpec}

#|
||Field | Description ||
|| sort_mode | enum **SortMode**

Documents sorting mode.

- `SORT_MODE_UNSPECIFIED`
- `SORT_MODE_BY_RELEVANCE`: Sort documents by relevance (default value).
- `SORT_MODE_BY_TIME`: Sort documents by update time. ||
|| sort_order | enum **SortOrder**

Documents sorting order.

- `SORT_ORDER_UNSPECIFIED`
- `SORT_ORDER_ASC`: Reverse order from oldest to most recent.
- `SORT_ORDER_DESC`: Direct order from most recent to oldest (default). ||
|#

## GroupSpec {#yandex.cloud.searchapi.v2.GroupSpec}

#|
||Field | Description ||
|| group_mode | enum **GroupMode**

Grouping method.

- `GROUP_MODE_UNSPECIFIED`
- `GROUP_MODE_FLAT`: Flat grouping. Each group contains a single document.
- `GROUP_MODE_DEEP`: Grouping by domain. Each group contains documents from one domain. ||
|| groups_on_page | **int64**

Maximum number of groups that can be returned per page with search results. ||
|| docs_in_group | **int64**

Maximum number of documents that can be returned per group. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "raw_data": "bytes"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[WebSearchResponse](#yandex.cloud.searchapi.v2.WebSearchResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## WebSearchResponse {#yandex.cloud.searchapi.v2.WebSearchResponse}

#|
||Field | Description ||
|| raw_data | **bytes**

Required field. Search results, either in XML or HTML format depending on the request settings. ||
|#