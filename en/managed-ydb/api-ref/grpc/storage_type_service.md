---
editable: false
sourcePath: en/_api-ref-grpc/ydb/api-ref/grpc/storage_type_service.md
---

# StorageTypeService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified storage types. |
| [List](#List) | Returns the list of available storage types. |

## Calls StorageTypeService {#calls}

## Get {#Get}

Returns the specified storage types.

**rpc Get ([GetStorageTypeRequest](#GetStorageTypeRequest)) returns ([StorageType](#StorageType))**

### GetStorageTypeRequest {#GetStorageTypeRequest}

Field | Description
--- | ---
storage_type_id | **string**<br>Required. Required. ID of the storage type to return. 


### StorageType {#StorageType}

Field | Description
--- | ---
id | **string**<br> 
device_type | **string**<br> 
redundancy_type | **string**<br> 


## List {#List}

Returns the list of available storage types.

**rpc List ([ListStorageTypesRequest](#ListStorageTypesRequest)) returns ([ListStorageTypesResponse](#ListStorageTypesResponse))**

### ListStorageTypesRequest {#ListStorageTypesRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListStorageTypes requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListStorageTypes request to get the next page of results. The maximum string length in characters is 100.


### ListStorageTypesResponse {#ListStorageTypesResponse}

Field | Description
--- | ---
storage_types[] | **[StorageType](#StorageType1)**<br>Requested list of storage types. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListStorageTypes requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListStorageTypes request. Subsequent ListStorageTypes requests will have their own `next_page_token` to continue paging through the results. 


### StorageType {#StorageType1}

Field | Description
--- | ---
id | **string**<br> 
device_type | **string**<br> 
redundancy_type | **string**<br> 


