---
editable: false
sourcePath: en/_api-ref-grpc/compute/api-ref/grpc/disk_type_service.md
---

# Compute Cloud API, gRPC: DiskTypeService

A set of methods to retrieve information about disk types.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the information about specified disk type. |
| [List](#List) | Retrieves the list of disk types for the specified folder. |

## Calls DiskTypeService {#calls}

## Get {#Get}

Returns the information about specified disk type. <br>To get the list of available disk types, make a [List](#List) request.

**rpc Get ([GetDiskTypeRequest](#GetDiskTypeRequest)) returns ([DiskType](#DiskType))**

### GetDiskTypeRequest {#GetDiskTypeRequest}

Field | Description
--- | ---
disk_type_id | **string**<br>Required. ID of the disk type to return information about. To get the disk type ID use a [DiskTypeService.List](#List) request. 


### DiskType {#DiskType}

Field | Description
--- | ---
id | **string**<br>ID of the disk type. 
description | **string**<br>Description of the disk type. 0-256 characters long. 
zone_ids[] | **string**<br>Array of availability zones where the disk type is available. 


## List {#List}

Retrieves the list of disk types for the specified folder.

**rpc List ([ListDiskTypesRequest](#ListDiskTypesRequest)) returns ([ListDiskTypesResponse](#ListDiskTypesResponse))**

### ListDiskTypesRequest {#ListDiskTypesRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDiskTypesResponse.next_page_token](#ListDiskTypesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDiskTypesResponse.next_page_token](#ListDiskTypesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListDiskTypesResponse {#ListDiskTypesResponse}

Field | Description
--- | ---
disk_types[] | **[DiskType](#DiskType1)**<br>List of disk types. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDiskTypesRequest.page_size](#ListDiskTypesRequest), use the `next_page_token` as the value for the [ListDiskTypesRequest.page_token](#ListDiskTypesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### DiskType {#DiskType1}

Field | Description
--- | ---
id | **string**<br>ID of the disk type. 
description | **string**<br>Description of the disk type. 0-256 characters long. 
zone_ids[] | **string**<br>Array of availability zones where the disk type is available. 


