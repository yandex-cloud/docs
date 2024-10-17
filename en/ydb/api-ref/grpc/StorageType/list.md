---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/StorageType/list.md
---

# Managed Service for YDB API, gRPC: StorageTypeService.List {#List}

Returns the list of available storage types.

## gRPC request

**rpc List ([ListStorageTypesRequest](#yandex.cloud.ydb.v1.ListStorageTypesRequest)) returns ([ListStorageTypesResponse](#yandex.cloud.ydb.v1.ListStorageTypesResponse))**

## ListStorageTypesRequest {#yandex.cloud.ydb.v1.ListStorageTypesRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListStorageTypes requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListStorageTypes
request to get the next page of results. ||
|#

## ListStorageTypesResponse {#yandex.cloud.ydb.v1.ListStorageTypesResponse}

```json
{
  "storageTypes": [
    {
      "id": "string",
      "deviceType": "string",
      "redundancyType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| storageTypes[] | **[StorageType](#yandex.cloud.ydb.v1.StorageType)**

Requested list of storage types. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListStorageTypes requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListStorageTypes request. Subsequent ListStorageTypes
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## StorageType {#yandex.cloud.ydb.v1.StorageType}

#|
||Field | Description ||
|| id | **string** ||
|| deviceType | **string** ||
|| redundancyType | **string** ||
|#