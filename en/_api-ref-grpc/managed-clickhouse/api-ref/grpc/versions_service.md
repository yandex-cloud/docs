---
editable: false
---

# Managed Service for ClickHouse API, gRPC: VersionsService

A set of methods for managing ClickHouse versions.

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
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListVersionsResponse.next_page_token](#ListVersionsResponse) that can be used to get the next page of results in subsequent ListVersions requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the [ListVersionsResponse.next_page_token](#ListVersionsResponse) returned by a previous ListVersions request to get the next page of results. The maximum string length in characters is 100.


### ListVersionsResponse {#ListVersionsResponse}

Field | Description
--- | ---
version[] | **[Version](#Version)**<br>Requested list of available versions. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListVersions requests, if the number of results is larger than [ListVersionsRequest.page_size](#ListVersionsRequest) specified in the request. To get the next page, specify the value of `next_page_token` as a value for the [ListVersionsRequest.page_token](#ListVersionsRequest) parameter in the next ListVerions request. Subsequent ListVersions requests will have their own `next_page_token` to continue paging through the results. 


### Version {#Version}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
name | **string**<br>Name of the version. 
deprecated | **bool**<br>Whether version is deprecated. 
updatable_to[] | **string**<br>List of versions that can be updated from current. 


