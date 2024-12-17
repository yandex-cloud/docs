---
editable: false
sourcePath: en/_api-ref/searchapi/v2/api-ref/WebSearchAsync/search.md
---

# Web Search API, REST: WebSearchAsync.Search

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/web/searchAsync
```

## Body parameters {#yandex.cloud.searchapi.v2.WebSearchRequest}

```json
{
  "query": {
    "searchType": "string",
    "queryText": "string",
    "familyMode": "string",
    "page": "string",
    "fixTypoMode": "string"
  },
  "sortSpec": {
    "sortMode": "string",
    "sortOrder": "string"
  },
  "groupSpec": {
    "groupMode": "string",
    "groupsOnPage": "string",
    "docsInGroup": "string"
  },
  "maxPassages": "string",
  "region": "string",
  "l10n": "string",
  "folderId": "string",
  "responseFormat": "string",
  "userAgent": "string"
}
```

#|
||Field | Description ||
|| query | **[SearchQuery](#yandex.cloud.searchapi.v2.SearchQuery)**

Required field. Search query. ||
|| sortSpec | **[SortSpec](#yandex.cloud.searchapi.v2.SortSpec)**

The rules for sorting search results that define the sequence of the returned search results. ||
|| groupSpec | **[GroupSpec](#yandex.cloud.searchapi.v2.GroupSpec)**

Grouping settings that are used to group documents from a single domain into a container. ||
|| maxPassages | **string** (int64)

The maximum number of passages that can be used when generating a document snippet. ||
|| region | **string**

ID of the search country or region that impacts the document ranking rules. ||
|| l10n | **enum** (Localization)

The notification language for a search response.

- `LOCALIZATION_UNSPECIFIED`
- `LOCALIZATION_RU`: Russian (default value)
- `LOCALIZATION_UK`: Ukrainian
- `LOCALIZATION_BE`: Belarusian
- `LOCALIZATION_KK`: Kazakh
- `LOCALIZATION_TR`: Turkish
- `LOCALIZATION_EN`: English ||
|| folderId | **string**

ID of the folder. ||
|| responseFormat | **enum** (Format)

Search results format.

- `FORMAT_UNSPECIFIED`
- `FORMAT_XML`: XML format (default value)
- `FORMAT_HTML`: HTML format ||
|| userAgent | **string**

User-Agent request header value. ||
|#

## SearchQuery {#yandex.cloud.searchapi.v2.SearchQuery}

#|
||Field | Description ||
|| searchType | **enum** (SearchType)

Required field. Search type that determines the domain name that will be used for the search queries.

- `SEARCH_TYPE_UNSPECIFIED`
- `SEARCH_TYPE_RU`: Russian search type (default), yandex.ru search domain name will be used.
- `SEARCH_TYPE_TR`: Turkish search type, yandex.tr search domain name will be used.
- `SEARCH_TYPE_COM`: International search type, yandex.com search domain name will be used. ||
|| queryText | **string**

Required field. Search query text ||
|| familyMode | **enum** (FamilyMode)

Rule for filtering search results and determines whether any documents should be excluded.

- `FAMILY_MODE_UNSPECIFIED`
- `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
- `FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results
unless a query is explicitly made for searching resources of this category.
- `FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category
and those with profanity are excluded from search results. ||
|| page | **string** (int64)

The number of a requested page with search results ||
|| fixTypoMode | **enum** (FixTypoMode)

Typos autocorrections mode

- `FIX_TYPO_MODE_UNSPECIFIED`
- `FIX_TYPO_MODE_ON`: Automatically correct typos (default value).
- `FIX_TYPO_MODE_OFF`: Autocorrection is off. ||
|#

## SortSpec {#yandex.cloud.searchapi.v2.SortSpec}

#|
||Field | Description ||
|| sortMode | **enum** (SortMode)

Documents sorting mode.

- `SORT_MODE_UNSPECIFIED`
- `SORT_MODE_BY_RELEVANCE`: Sort documents by relevance (default value).
- `SORT_MODE_BY_TIME`: Sort documents by update time. ||
|| sortOrder | **enum** (SortOrder)

Documents sorting order.

- `SORT_ORDER_UNSPECIFIED`
- `SORT_ORDER_ASC`: Reverse order from oldest to most recent.
- `SORT_ORDER_DESC`: Direct order from most recent to oldest (default). ||
|#

## GroupSpec {#yandex.cloud.searchapi.v2.GroupSpec}

#|
||Field | Description ||
|| groupMode | **enum** (GroupMode)

Grouping method.

- `GROUP_MODE_UNSPECIFIED`
- `GROUP_MODE_FLAT`: Flat grouping. Each group contains a single document.
- `GROUP_MODE_DEEP`: Grouping by domain. Each group contains documents from one domain. ||
|| groupsOnPage | **string** (int64)

Maximum number of groups that can be returned per page with search results. ||
|| docsInGroup | **string** (int64)

Maximum number of documents that can be returned per group. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "rawData": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## WebSearchResponse {#yandex.cloud.searchapi.v2.WebSearchResponse}

#|
||Field | Description ||
|| rawData | **string** (bytes)

Required field. Search results, either in XML or HTML format depending on the request settings. ||
|#