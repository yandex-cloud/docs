---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/v2/api-ref/grpc/GenSearch/search.md
---

# Web Search API, gRPC: GenSearchService.Search

## gRPC request

**rpc Search ([GenSearchRequest](#yandex.cloud.searchapi.v2.GenSearchRequest)) returns (stream [GenSearchResponse](#yandex.cloud.searchapi.v2.GenSearchResponse))**

## GenSearchRequest {#yandex.cloud.searchapi.v2.GenSearchRequest}

```json
{
  "messages": [
    {
      "content": "string",
      "role": "Role"
    }
  ],
  "folder_id": "string",
  // Includes only one of the fields `site`, `host`, `url`
  "site": {
    "site": [
      "string"
    ]
  },
  "host": {
    "host": [
      "string"
    ]
  },
  "url": {
    "url": [
      "string"
    ]
  },
  // end of the list of possible fields
  "fix_misspell": "bool",
  "enable_nrfm_docs": "bool",
  "search_filters": [
    {
      // Includes only one of the fields `date`, `lang`, `format`
      "date": "string",
      "lang": "string",
      "format": "DocFormat"
      // end of the list of possible fields
    }
  ]
}
```

#|
||Field | Description ||
|| messages[] | **[GenSearchMessage](#yandex.cloud.searchapi.v2.GenSearchMessage)**

Single search query or a search query with context in the form of chat with the model. ||
|| folder_id | **string**

Required field. ID of the folder. ||
|| site | **[SiteOption](#yandex.cloud.searchapi.v2.GenSearchRequest.SiteOption)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages. ||
|| host | **[HostOption](#yandex.cloud.searchapi.v2.GenSearchRequest.HostOption)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages. ||
|| url | **[UrlOption](#yandex.cloud.searchapi.v2.GenSearchRequest.UrlOption)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages. ||
|| fix_misspell | **bool**

Fix query misspells. ||
|| enable_nrfm_docs | **bool**

Use the documents inaccessible from the site's front page. ||
|| search_filters[] | **[SearchFilter](#yandex.cloud.searchapi.v2.GenSearchRequest.SearchFilter)**

Restricts the search by date, document formats or language. ||
|#

## GenSearchMessage {#yandex.cloud.searchapi.v2.GenSearchMessage}

#|
||Field | Description ||
|| content | **string**

Required field. Text of user query or the model's response (depending on the role value). ||
|| role | enum **Role**

Required field. Message sender's role

- `ROLE_UNSPECIFIED`
- `ROLE_USER`: The message is sent by the user.
- `ROLE_ASSISTANT`: The message is sent by the model. ||
|#

## SiteOption {#yandex.cloud.searchapi.v2.GenSearchRequest.SiteOption}

#|
||Field | Description ||
|| site[] | **string**

Restricts the search to the specific websites. ||
|#

## HostOption {#yandex.cloud.searchapi.v2.GenSearchRequest.HostOption}

#|
||Field | Description ||
|| host[] | **string**

Restricts the search to the specific hosts. ||
|#

## UrlOption {#yandex.cloud.searchapi.v2.GenSearchRequest.UrlOption}

#|
||Field | Description ||
|| url[] | **string**

Restricts the search to the specific pages. ||
|#

## SearchFilter {#yandex.cloud.searchapi.v2.GenSearchRequest.SearchFilter}

#|
||Field | Description ||
|| date | **string**

Restrict by document date. See https://yandex.ru/support/search/ru/query-language/search-operators details.

Includes only one of the fields `date`, `lang`, `format`. ||
|| lang | **string**

Restrict by document language. Use ISO 639-1 language codes.

Includes only one of the fields `date`, `lang`, `format`. ||
|| format | enum **DocFormat**

Restrict by document format.

Includes only one of the fields `date`, `lang`, `format`.

- `DOC_FORMAT_UNSPECIFIED`
- `DOC_FORMAT_PDF`
- `DOC_FORMAT_XLS`
- `DOC_FORMAT_ODS`
- `DOC_FORMAT_RTF`
- `DOC_FORMAT_PPT`
- `DOC_FORMAT_ODP`
- `DOC_FORMAT_SWF`
- `DOC_FORMAT_ODT`
- `DOC_FORMAT_ODG`
- `DOC_FORMAT_DOC` ||
|#

## GenSearchResponse {#yandex.cloud.searchapi.v2.GenSearchResponse}

```json
{
  "message": {
    "content": "string",
    "role": "Role"
  },
  "sources": [
    {
      "url": "string",
      "title": "string",
      "used": "bool"
    }
  ],
  "search_queries": [
    {
      "text": "string",
      "req_id": "string"
    }
  ],
  "fixed_misspell_query": "string",
  "is_answer_rejected": "bool",
  "is_bullet_answer": "bool"
}
```

#|
||Field | Description ||
|| message | **[GenSearchMessage](#yandex.cloud.searchapi.v2.GenSearchMessage2)**

The text of the generative response. ||
|| sources[] | **[Source](#yandex.cloud.searchapi.v2.GenSearchResponse.Source)**

The documents used to form the generative response. ||
|| search_queries[] | **[SearchQuery](#yandex.cloud.searchapi.v2.GenSearchResponse.SearchQuery)**

The search queries, refined by the YandexGPT model and used for the generative response. ||
|| fixed_misspell_query | **string**

The text of the search query with fixed misspells. ||
|| is_answer_rejected | **bool**

The model failed to answer due to the ethical concerns. ||
|| is_bullet_answer | **bool**

A bullet answer in case the model cannot give a proper response and returns a set of bullets with various data. ||
|#

## GenSearchMessage {#yandex.cloud.searchapi.v2.GenSearchMessage2}

#|
||Field | Description ||
|| content | **string**

Required field. Text of user query or the model's response (depending on the role value). ||
|| role | enum **Role**

Required field. Message sender's role

- `ROLE_UNSPECIFIED`
- `ROLE_USER`: The message is sent by the user.
- `ROLE_ASSISTANT`: The message is sent by the model. ||
|#

## Source {#yandex.cloud.searchapi.v2.GenSearchResponse.Source}

#|
||Field | Description ||
|| url | **string**

Document URL. ||
|| title | **string**

Document title. ||
|| used | **bool**

The document was used in the answer. ||
|#

## SearchQuery {#yandex.cloud.searchapi.v2.GenSearchResponse.SearchQuery}

#|
||Field | Description ||
|| text | **string**

Query text. ||
|| req_id | **string**

Query ID in Yandex Search. ||
|#