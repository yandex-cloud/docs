---
editable: false
sourcePath: en/_api-ref/searchapi/v2/api-ref/WebSearchAsync/search.md
---

# Web Search API, REST: WebSearchAsync.search

 

 
## HTTP request {#https-request}
```
POST https://searchapi.{{ api-host }}/v2/web/searchAsync
```
 
## Body parameters {#body_params}
 
```json 
{
  "query": {
    "searchType": "string",
    "queryText": "string",
    "familyMode": "string",
    "page": "string"
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
  "l10N": "string",
  "folderId": "string"
}
```

 
Field | Description
--- | ---
query | **object**<br><p>Required. Search query.</p> 
query.<br>searchType | **string**<br><p>Required. Search type that determines the domain name that will be used for the search queries.</p> <ul> <li>SEARCH_TYPE_RU: Russian search type (default), yandex.ru search domain name will be used.</li> <li>SEARCH_TYPE_TR: Turkish search type, yandex.tr search domain name will be used.</li> <li>SEARCH_TYPE_COM: International search type, yandex.com search domain name will be used.</li> </ul> 
query.<br>queryText | **string**<br><p>Required. Search query text</p> <p>The maximum string length in characters is 400.</p> 
query.<br>familyMode | **string**<br><p>Rule for filtering search results and determines whether any documents should be excluded.</p> <ul> <li>FAMILY_MODE_NONE: Filtering is disabled. Search results include any documents regardless of their contents.</li> <li>FAMILY_MODE_MODERATE: Moderate filter (default value). Documents of the Adult category are excluded from search results unless a query is explicitly made for searching resources of this category.</li> <li>FAMILY_MODE_STRICT: Regardless of a search query, documents of the Adult category and those with profanity are excluded from search results.</li> </ul> 
query.<br>page | **string** (int64)<br><p>The number of a requested page with search results</p> <p>The minimum value is 0.</p> 
sortSpec | **object**<br><p>The rules for sorting search results that define the sequence of the returned search results.</p> 
sortSpec.<br>sortMode | **string**<br><p>Documents sorting mode.</p> <ul> <li>SORT_MODE_BY_RELEVANCE: Sort documents by relevance (default value).</li> <li>SORT_MODE_BY_TIME: Sort documents by update time.</li> </ul> 
sortSpec.<br>sortOrder | **string**<br><p>Documents sorting order.</p> <ul> <li>SORT_ORDER_ASC: Direct order from most recent to oldest (default)..</li> <li>SORT_ORDER_DESC: Reverse order from oldest to most recent.</li> </ul> 
groupSpec | **object**<br><p>Grouping settings that are used to group documents from a single domain into a container.</p> 
groupSpec.<br>groupMode | **string**<br><p>Grouping method.</p> <ul> <li>GROUP_MODE_FLAT: Flat grouping. Each group contains a single document.</li> <li>GROUP_MODE_DEEP: Grouping by domain. Each group contains documents from one domain.</li> </ul> 
groupSpec.<br>groupsOnPage | **string** (int64)<br><p>Maximum number of groups that can be returned per page with search results.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
groupSpec.<br>docsInGroup | **string** (int64)<br><p>Maximum number of documents that can be returned per group.</p> <p>Acceptable values are 1 to 3, inclusive.</p> 
maxPassages | **string** (int64)<br><p>The maximum number of passages that can be used when generating a document snippet.</p> <p>Acceptable values are 1 to 5, inclusive.</p> 
region | **string**<br><p>ID of the search country or region that impacts the document ranking rules.</p> 
l10N | **string**<br><p>The notification language for a search response.</p> <ul> <li>LOCALIZATION_RU: Russian (default value)</li> <li>LOCALIZATION_UK: Ukrainian</li> <li>LOCALIZATION_BE: Belarusian</li> <li>LOCALIZATION_KK: Kazakh</li> <li>LOCALIZATION_TR: Turkish</li> <li>LOCALIZATION_EN: English</li> </ul> 
folderId | **string**<br><p>ID of the folder.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 