---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostType/list.md
---

# Compute Cloud API, gRPC: HostTypeService.List

List avaliable host types.

## gRPC request

**rpc List ([ListHostTypesRequest](#yandex.cloud.compute.v1.ListHostTypesRequest)) returns ([ListHostTypesResponse](#yandex.cloud.compute.v1.ListHostTypesResponse))**

## ListHostTypesRequest {#yandex.cloud.compute.v1.ListHostTypesRequest}

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
the service returns a [ListHostTypesResponse.next_page_token](#yandex.cloud.compute.v1.ListHostTypesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListHostTypesResponse.next_page_token](#yandex.cloud.compute.v1.ListHostTypesResponse)
returned by a previous list request. ||
|#

## ListHostTypesResponse {#yandex.cloud.compute.v1.ListHostTypesResponse}

```json
{
  "host_types": [
    {
      "id": "string",
      "cores": "int64",
      "memory": "int64",
      "disks": "int64",
      "disk_size": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| host_types[] | **[HostType](#yandex.cloud.compute.v1.HostType)**

Lists host types. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListHostTypesRequest.page_size](#yandex.cloud.compute.v1.ListHostTypesRequest), use `next_page_token` as the value
for the [ListHostTypesRequest.page_token](#yandex.cloud.compute.v1.ListHostTypesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## HostType {#yandex.cloud.compute.v1.HostType}

Represents host resources.
Note: Platform can use hosts with different number of memory and cores.
TODO: Do we need sockets here?

#|
||Field | Description ||
|| id | **string**

Unique type identifier. ||
|| cores | **int64**

Total number of cores available for instances. ||
|| memory | **int64**

Ammount of memory available for instances. ||
|| disks | **int64**

Number of local disks available for instances ||
|| disk_size | **int64**

Size of each local disk ||
|#