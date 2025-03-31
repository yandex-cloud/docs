---
editable: false
sourcePath: en/_api-ref/searchapi/v2/api-ref/GenSearch/search.md
---

# Web Search API, REST: GenSearch.Search

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/gen/search
```

## Body parameters {#yandex.cloud.searchapi.v2.GenSearchRequest}

```json
{
  "messages": [
    {
      "content": "string",
      "role": "string"
    }
  ],
  "folderId": "string",
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
  "fixMisspell": "boolean",
  "enableNrfmDocs": "boolean",
  "searchFilters": [
    {
      // Includes only one of the fields `date`, `lang`, `format`
      "date": "string",
      "lang": "string",
      "format": "string"
      // end of the list of possible fields
    }
  ]
}
```

#|
||Field | Description ||
|| messages[] | **[GenSearchMessage](#yandex.cloud.searchapi.v2.GenSearchMessage)**

Single search query or a search query with context in the form of chat with the model. ||
|| folderId | **string**

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
|| fixMisspell | **boolean**

Fix query misspells. ||
|| enableNrfmDocs | **boolean**

Use the documents inaccessible from the site's front page. ||
|| searchFilters[] | **[SearchFilter](#yandex.cloud.searchapi.v2.GenSearchRequest.SearchFilter)**

Restricts the search by date, document formats or language. ||
|#

## GenSearchMessage {#yandex.cloud.searchapi.v2.GenSearchMessage}

#|
||Field | Description ||
|| content | **string**

Required field. Text of user query or the model's response (depending on the role value). ||
|| role | **enum** (Role)

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
|| format | **enum** (DocFormat)

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

## Response {#yandex.cloud.searchapi.v2.GenSearchResponse}

**HTTP Code: 200 - OK**

```json
{
  "message": {
    "content": "string",
    "role": "string"
  },
  "sources": [
    {
      "url": "string",
      "title": "string",
      "used": "boolean"
    }
  ],
  "searchQueries": [
    {
      "text": "string",
      "reqId": "string"
    }
  ],
  "fixedMisspellQuery": "string",
  "isAnswerRejected": "boolean",
  "isBulletAnswer": "boolean"
}
```

#|
||Field | Description ||
|| message | **[GenSearchMessage](#yandex.cloud.searchapi.v2.GenSearchMessage2)**

The text of the generative response. ||
|| sources[] | **[Source](#yandex.cloud.searchapi.v2.GenSearchResponse.Source)**

The documents used to form the generative response. ||
|| searchQueries[] | **[SearchQuery](#yandex.cloud.searchapi.v2.GenSearchResponse.SearchQuery)**

The search queries, refined by the YandexGPT model and used for the generative response. ||
|| fixedMisspellQuery | **string**

The text of the search query with fixed misspells. ||
|| isAnswerRejected | **boolean**

The model failed to answer due to the ethical concerns. ||
|| isBulletAnswer | **boolean**

A bullet answer in case the model cannot give a proper response and returns a set of bullets with various data. ||
|#

## GenSearchMessage {#yandex.cloud.searchapi.v2.GenSearchMessage2}

#|
||Field | Description ||
|| content | **string**

Required field. Text of user query or the model's response (depending on the role value). ||
|| role | **enum** (Role)

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
|| used | **boolean**

The document was used in the answer. ||
|#

## SearchQuery {#yandex.cloud.searchapi.v2.GenSearchResponse.SearchQuery}

#|
||Field | Description ||
|| text | **string**

Query text. ||
|| reqId | **string**

Query ID in Yandex Search. ||
|#