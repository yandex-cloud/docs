[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [PrivateCloudConnection](index.md) > ListPrivateCloudConnections

# BareMetal API, gRPC: PrivateCloudConnectionService.ListPrivateCloudConnections

Retrieves the list of Private cloud connection resources in the specified folder.


## gRPC request

**rpc ListPrivateCloudConnections ([ListPrivateCloudConnectionsRequest](#yandex.cloud.baremetal.v2.ListPrivateCloudConnectionsRequest)) returns ([ListPrivateCloudConnectionsResponse](#yandex.cloud.baremetal.v2.ListPrivateCloudConnectionsResponse))**

## ListPrivateCloudConnectionsRequest {#yandex.cloud.baremetal.v2.ListPrivateCloudConnectionsRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../../resource-manager/api-ref/grpc/Cloud/list.md#List) request. ||
|| folder_id | **string**

ID of the folder to list private cloud connections in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.

The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPrivateCloudConnectionResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPrivateCloudConnectionResponse.next_page_token] returned by a previous list request. ||
|| order_by | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `privateCloudConnectionId`, `createTime`, `updateTime`.
Default order: `privateCloudConnectionId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `privateCloudConnectionId`, `name`, `vrfId`, `routingInstanceId` - `=`, `!=`, `:` (contains)
- `state` - `=`, `!=`

Example: `state = "ACTIVE" AND vrfId = "enp1234abcd"`. ||
|#

## ListPrivateCloudConnectionsResponse {#yandex.cloud.baremetal.v2.ListPrivateCloudConnectionsResponse}

```json
{
  "private_cloud_connections": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| private_cloud_connections[] | **[PrivateCloudConnection](#yandex.cloud.baremetal.v2.PrivateCloudConnection)**

List of Private cloud connection resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPrivateCloudConnectionRequest.page_size], use `next_page_token` as the value
for the [ListPrivateCloudConnectionRequest.page_token] parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PrivateCloudConnection {#yandex.cloud.baremetal.v2.PrivateCloudConnection}

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