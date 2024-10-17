---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostType/list.md
---

# Compute Cloud API, gRPC: HostTypeService.List {#List}

List avaliable host types.

## gRPC request

**rpc List ([ListHostTypesRequest](#yandex.cloud.compute.v1.ListHostTypesRequest)) returns ([ListHostTypesResponse](#yandex.cloud.compute.v1.ListHostTypesResponse))**

## ListHostTypesRequest {#yandex.cloud.compute.v1.ListHostTypesRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListHostTypesResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostTypesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListHostTypesResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostTypesResponse)
returned by a previous list request. ||
|#

## ListHostTypesResponse {#yandex.cloud.compute.v1.ListHostTypesResponse}

```json
{
  "hostTypes": [
    {
      "id": "string",
      "cores": "int64",
      "memory": "int64",
      "disks": "int64",
      "diskSize": "int64"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hostTypes[] | **[HostType](#yandex.cloud.compute.v1.HostType)**

Lists host types. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListHostTypesRequest.pageSize](#yandex.cloud.compute.v1.ListHostTypesRequest), use `next_page_token` as the value
for the [ListHostTypesRequest.pageToken](#yandex.cloud.compute.v1.ListHostTypesRequest) parameter in the next list request.

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
|| diskSize | **int64**

Size of each local disk ||
|#