---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PrivateCloudConnection/get.md
---

# BareMetal API, gRPC: PrivateCloudConnectionService.Get

Returns the specific Private cloud connection resource.

To get the list of available Private cloud connection resources, make a [List](/docs/baremetal/api-ref/grpc/PrivateCloudConnection/list#List) request.

## gRPC request

**rpc Get ([GetPrivateCloudConnectionRequest](#yandex.cloud.baremetal.v1alpha.GetPrivateCloudConnectionRequest)) returns ([PrivateCloudConnection](#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection))**

## GetPrivateCloudConnectionRequest {#yandex.cloud.baremetal.v1alpha.GetPrivateCloudConnectionRequest}

```json
{
  "private_cloud_connection_id": "string"
}
```

#|
||Field | Description ||
|| private_cloud_connection_id | **string**

ID of the Private cloud connection resource to return.

To get the server ID, use a [PrivateCloudConnectionService.List](/docs/baremetal/api-ref/grpc/PrivateCloudConnection/list#List) request. ||
|#

## PrivateCloudConnection {#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection}

```json
{
  "id": "string",
  "folder_id": "string",
  "cloud_id": "string",
  "routing_instance_id": "string",
  "vrf_id": "string",
  "status": "Status",
  "name": "string",
  "created_at": "google.protobuf.Timestamp"
}
```

A Private cloud connection resource.

#|
||Field | Description ||
|| id | **string**

ID of the private cloud connection. ||
|| folder_id | **string**

ID of the folder that the private cloud connection belongs to. ||
|| cloud_id | **string**

ID of the cloud that the private cloud connection belongs to. ||
|| routing_instance_id | **string**

ID of Cloud Router Routing Instance. ||
|| vrf_id | **string**

ID of VRF that is connected to routing Instance. ||
|| status | enum **Status**

Status of the private cloud connection.

- `STATUS_UNSPECIFIED`: Unspecified private cloud connection status.
- `CREATING`: Private cloud connection is waiting for network resources to be allocated.
- `READY`: Private cloud connection is ready to use.
- `ERROR`: Private cloud connection encountered a problem and cannot operate.
- `DELETING`: Private cloud connection is being deleted.
- `UPDATING`: Private cloud connection is being updated. ||
|| name | **string**

Name of the private cloud connection. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#