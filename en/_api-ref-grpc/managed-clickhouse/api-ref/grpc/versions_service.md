---
editable: false
---

# VersionsService



| Call | Description |
| --- | --- |
| [List](#List) | Returns list of available ClickHouse versions. |

## Calls VersionsService {#calls}

## List {#List}

Returns list of available ClickHouse versions.

**rpc List ([ListVersionsRequest](#ListVersionsRequest)) returns ([ListVersionsResponse](#ListVersionsResponse))**

### ListVersionsRequest {#ListVersionsRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListVersions requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListVersions request to get the next page of results. The maximum string length in characters is 100.


### ListVersionsResponse {#ListVersionsResponse}

Field | Description
--- | ---
version[] | **[Version](../version.proto#Version)**<br>Requested list of available versions. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListVersions requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListVerions request. Subsequent ListVersions requests will have their own `next_page_token` to continue paging through the results. 


### Version {#Version}

Field | Description
--- | ---
id | **string**<br>Version ID 
name | **string**<br>Version name 
deprecated | **bool**<br>Is version deprecated 
updatable_to[] | **string**<br>List of versions that can be updated from current 


