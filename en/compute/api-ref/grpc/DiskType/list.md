---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/DiskType/list.md
---

# Compute Cloud API, gRPC: DiskTypeService.List

Retrieves the list of disk types for the specified folder.

## gRPC request

**rpc List ([ListDiskTypesRequest](#yandex.cloud.compute.v1.ListDiskTypesRequest)) returns ([ListDiskTypesResponse](#yandex.cloud.compute.v1.ListDiskTypesResponse))**

## ListDiskTypesRequest {#yandex.cloud.compute.v1.ListDiskTypesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListDiskTypesResponse.next_page_token](#yandex.cloud.compute.v1.ListDiskTypesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDiskTypesResponse.next_page_token](#yandex.cloud.compute.v1.ListDiskTypesResponse) returned by a previous list request. ||
|#

## ListDiskTypesResponse {#yandex.cloud.compute.v1.ListDiskTypesResponse}

```json
{
  "disk_types": [
    {
      "id": "string",
      "description": "string",
      "zone_ids": [
        "string"
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| disk_types[] | **[DiskType](#yandex.cloud.compute.v1.DiskType)**

List of disk types. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDiskTypesRequest.page_size](#yandex.cloud.compute.v1.ListDiskTypesRequest), use
the `next_page_token` as the value
for the [ListDiskTypesRequest.page_token](#yandex.cloud.compute.v1.ListDiskTypesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## DiskType {#yandex.cloud.compute.v1.DiskType}

#|
||Field | Description ||
|| id | **string**

ID of the disk type. ||
|| description | **string**

Description of the disk type. 0-256 characters long. ||
|| zone_ids[] | **string**

Array of availability zones where the disk type is available. ||
|#