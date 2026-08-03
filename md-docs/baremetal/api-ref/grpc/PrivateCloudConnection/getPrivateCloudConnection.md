[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [PrivateCloudConnection](index.md) > GetPrivateCloudConnection

# BareMetal API, gRPC: PrivateCloudConnectionService.GetPrivateCloudConnection

Returns the specific Private cloud connection resource.
To get the list of available Private cloud connection resources, make a [List] request.

https://google.aip.dev/130 --)

## gRPC request

**rpc GetPrivateCloudConnection ([GetPrivateCloudConnectionRequest](#yandex.cloud.baremetal.v2.GetPrivateCloudConnectionRequest)) returns ([PrivateCloudConnection](#yandex.cloud.baremetal.v2.PrivateCloudConnection))**

## GetPrivateCloudConnectionRequest {#yandex.cloud.baremetal.v2.GetPrivateCloudConnectionRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "private_cloud_connection_id": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../../resource-manager/api-ref/grpc/Cloud/list.md#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| private_cloud_connection_id | **string**

ID of the Private cloud connection resource to return.
To get the server ID, use a [PrivateCloudConnectionService.List] request.

The maximum string length in characters is 20. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|#

## PrivateCloudConnection {#yandex.cloud.baremetal.v2.PrivateCloudConnection}

```json
{
  "private_cloud_connection_id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "vrf_id": "string",
  "routing_instance_id": "string",
  "state": "State",
  "name": "string",
  "create_time": "google.protobuf.Timestamp",
  "update_time": "google.protobuf.Timestamp"
}
```

A Private cloud connection resource.

#|
||Field | Description ||
|| private_cloud_connection_id | **string**

ID of the private cloud connection. ||
|| cloud_id | **string**

ID of the cloud that the private cloud connection belongs to. ||
|| folder_id | **string**

ID of the folder that the private cloud connection belongs to. ||
|| vrf_id | **string**

ID of VRF that is connected to routing Instance. ||
|| routing_instance_id | **string**

ID of Cloud Router Routing Instance. ||
|| state | enum **State**

State of the private cloud connection.

- `CREATING`: Private cloud connection is waiting for network resources to be allocated.
- `READY`: Private cloud connection is ready to use.
- `ERROR`: Private cloud connection encountered a problem and cannot operate.
- `DELETING`: Private cloud connection is being deleted.
- `UPDATING`: Private cloud connection is being updated. ||
|| name | **string**

Name of the private cloud connection. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Updafe timestamp. ||
|#