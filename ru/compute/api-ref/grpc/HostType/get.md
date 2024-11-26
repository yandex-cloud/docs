---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostType/get.md
---

# Compute Cloud API, gRPC: HostTypeService.Get

Returns information about specified host type.

## gRPC request

**rpc Get ([GetHostTypeRequest](#yandex.cloud.compute.v1.GetHostTypeRequest)) returns ([HostType](#yandex.cloud.compute.v1.HostType))**

## GetHostTypeRequest {#yandex.cloud.compute.v1.GetHostTypeRequest}

```json
{
  "host_type_id": "string"
}
```

#|
||Field | Description ||
|| host_type_id | **string**

Required field. ID of the host type to return.

To get a host type ID make a [HostTypeService.List](/docs/compute/api-ref/grpc/HostType/list#List) request. ||
|#

## HostType {#yandex.cloud.compute.v1.HostType}

```json
{
  "id": "string",
  "cores": "int64",
  "memory": "int64",
  "disks": "int64",
  "disk_size": "int64"
}
```

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