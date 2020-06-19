---
editable: false
---

# VersionService



| Call | Description |
| --- | --- |
| [List](#List) |  |

## Calls VersionService {#calls}

## List {#List}



**rpc List ([ListVersionsRequest](#ListVersionsRequest)) returns ([ListVersionsResponse](#ListVersionsResponse))**

### ListVersionsRequest {#ListVersionsRequest}



### ListVersionsResponse {#ListVersionsResponse}

Field | Description
--- | ---
available_versions[] | **[AvailableVersions](#AvailableVersions)**<br> 


### AvailableVersions {#AvailableVersions}

Field | Description
--- | ---
release_channel | enum **ReleaseChannel**<br> <ul><ul/>
versions[] | **string**<br> 


