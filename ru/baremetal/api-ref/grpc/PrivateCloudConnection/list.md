---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PrivateCloudConnection/list.md
---

# BareMetal API, gRPC: PrivateCloudConnectionService.List

Retrieves the list of Private cloud connection resources in the specified folder.

## gRPC request

**rpc List ([ListPrivateCloudConnectionRequest](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionRequest)) returns ([ListPrivateCloudConnectionResponse](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse))**

## ListPrivateCloudConnectionRequest {#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list private cloud connections in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPrivateCloudConnectionResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPrivateCloudConnectionResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse) returned by a previous list request. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "createdAt", "updatedAt"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["id", "name", "status", "vrfId", "routingInstanceId"].
Both snake_case and camelCase are supported for fields. ||
|#

## ListPrivateCloudConnectionResponse {#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionResponse}

```json
{
  "private_cloud_connections": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| private_cloud_connections[] | **[PrivateCloudConnection](#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection)**

List of Private cloud connection resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPrivateCloudConnectionRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionRequest), use `next_page_token` as the value
for the [ListPrivateCloudConnectionRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListPrivateCloudConnectionRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PrivateCloudConnection {#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection}

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