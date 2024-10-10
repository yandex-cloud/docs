---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/api-ref/grpc/search_service.md
---

# Web Search API, gRPC: WebSearchAsyncService

A set of methods for async search the Yandex search database.

| Call | Description |
| --- | --- |
| [Search](#Search) |  |

## Calls WebSearchAsyncService {#calls}

## Search {#Search}



**rpc Search ([WebSearchRequest](#WebSearchRequest)) returns ([operation.Operation](#Operation))**

Response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[WebSearchResponse](#WebSearchResponse)<br>

### WebSearchRequest {#WebSearchRequest}

Field | Description
--- | ---
query | **[SearchQuery](#SearchQuery)**<br>Required. Search query. 
sort_spec | **[SortSpec](#SortSpec)**<br>The rules for sorting search results that define the sequence of the returned search results. 
group_spec | **[GroupSpec](#GroupSpec)**<br>Grouping settings that are used to group documents from a single domain into a container. 
max_passages | **int64**<br>The maximum number of passages that can be used when generating a document snippet. Acceptable values are 1 to 5, inclusive.
region | **string**<br>ID of the search country or region that impacts the document ranking rules. 
l10n | enum **Localization**<br>The notification language for a search response. <ul><li>`LOCALIZATION_RU`: Russian (default value)</li><li>`LOCALIZATION_UK`: Ukrainian</li><li>`LOCALIZATION_BE`: Belarusian</li><li>`LOCALIZATION_KK`: Kazakh</li><li>`LOCALIZATION_TR`: Turkish</li><li>`LOCALIZATION_EN`: English</li></ul>
folder_id | **string**<br>ID of the folder. The maximum string length in characters is 50.


### SearchQuery {#SearchQuery}

Field | Description
--- | ---
search_type | enum **SearchType**<br>Required. Search type that determines the domain name that will be used for the search queries. <ul><li>`SEARCH_TYPE_RU`: Russian search type (default), yandex.ru search domain name will be used.</li><li>`SEARCH_TYPE_TR`: Turkish search type, yandex.tr search domain name will be used.</li><li>`SEARCH_TYPE_COM`: International search type, yandex.com search domain name will be used.</li></ul>
query_text | **string**<br>Required. Search query text The maximum string length in characters is 400.
family_mode | enum **FamilyMode**<br>Rule for filtering search results and determines whether any documents should be excluded. <ul><li>`FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.</li><li>`FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results unless a query is explicitly made for searching resources of this category.</li><li>`FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category and those with profanity are excluded from search results.</li></ul>
page | **int64**<br>The number of a requested page with search results The minimum value is 0.


### SortSpec {#SortSpec}

Field | Description
--- | ---
sort_mode | enum **SortMode**<br>Documents sorting mode. <ul><li>`SORT_MODE_BY_RELEVANCE`: Sort documents by relevance (default value).</li><li>`SORT_MODE_BY_TIME`: Sort documents by update time.</li></ul>
sort_order | enum **SortOrder**<br>Documents sorting order. <ul><li>`SORT_ORDER_ASC`: Direct order from most recent to oldest (default)..</li><li>`SORT_ORDER_DESC`: Reverse order from oldest to most recent.</li></ul>


### GroupSpec {#GroupSpec}

Field | Description
--- | ---
group_mode | enum **GroupMode**<br>Grouping method. <ul><li>`GROUP_MODE_FLAT`: Flat grouping. Each group contains a single document.</li><li>`GROUP_MODE_DEEP`: Grouping by domain. Each group contains documents from one domain.</li></ul>
groups_on_page | **int64**<br>Maximum number of groups that can be returned per page with search results. Acceptable values are 1 to 100, inclusive.
docs_in_group | **int64**<br>Maximum number of documents that can be returned per group. Acceptable values are 1 to 3, inclusive.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[WebSearchResponse](#WebSearchResponse)>**<br>if operation finished successfully. 


### WebSearchResponse {#WebSearchResponse}

Field | Description
--- | ---
raw_data | **bytes**<br>Required. Search results, usually in XML format. 


