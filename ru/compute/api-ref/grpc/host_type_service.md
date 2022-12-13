---
editable: false
sourcePath: en/_api-ref-grpc/compute/api-ref/grpc/host_type_service.md
---

# Compute Cloud API, gRPC: HostTypeService

Set of methods to view possible host configurations.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns information about specified host type. |
| [List](#List) | List avaliable host types. |

## Calls HostTypeService {#calls}

## Get {#Get}

Returns information about specified host type.

**rpc Get ([GetHostTypeRequest](#GetHostTypeRequest)) returns ([HostType](#HostType))**

### GetHostTypeRequest {#GetHostTypeRequest}

Field | Description
--- | ---
host_type_id | **string**<br>Required. ID of the host type to return. <br>To get a host type ID make a [HostTypeService.List](#List) request. The maximum string length in characters is 50.


### HostType {#HostType}

Field | Description
--- | ---
id | **string**<br>Unique type identifier. 
cores | **int64**<br>Total number of cores available for instances. 
memory | **int64**<br>Ammount of memory available for instances. 
disks | **int64**<br>Number of local disks available for instances 
disk_size | **int64**<br>Size of each local disk 


## List {#List}

List avaliable host types.

**rpc List ([ListHostTypesRequest](#ListHostTypesRequest)) returns ([ListHostTypesResponse](#ListHostTypesResponse))**

### ListHostTypesRequest {#ListHostTypesRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListHostTypesResponse.next_page_token](#ListHostTypesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListHostTypesResponse.next_page_token](#ListHostTypesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListHostTypesResponse {#ListHostTypesResponse}

Field | Description
--- | ---
host_types[] | **[HostType](#HostType1)**<br>Lists host types. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListHostTypesRequest.page_size](#ListHostTypesRequest), use `next_page_token` as the value for the [ListHostTypesRequest.page_token](#ListHostTypesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### HostType {#HostType1}

Field | Description
--- | ---
id | **string**<br>Unique type identifier. 
cores | **int64**<br>Total number of cores available for instances. 
memory | **int64**<br>Ammount of memory available for instances. 
disks | **int64**<br>Number of local disks available for instances 
disk_size | **int64**<br>Size of each local disk 


