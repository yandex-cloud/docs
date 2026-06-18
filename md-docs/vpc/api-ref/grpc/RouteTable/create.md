# Virtual Private Cloud API, gRPC: RouteTableService.Create

Creates a route table in the specified folder and network.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Create ([CreateRouteTableRequest](#yandex.cloud.vpc.v1.CreateRouteTableRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateRouteTableRequest {#yandex.cloud.vpc.v1.CreateRouteTableRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "network_id": "string",
  "static_routes": [
    {
      // Includes only one of the fields `destination_prefix`
      "destination_prefix": "string",
      // end of the list of possible fields
      // Includes only one of the fields `next_hop_address`, `gateway_id`
      "next_hop_address": "string",
      "gateway_id": "string",
      // end of the list of possible fields
      "labels": "map<string, string>"
    }
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder that the route table belongs to.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the route table.
The name must be unique within the folder.
The value must match the regular expression: ```|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?```. ||
|| description | **string**

Description of the route table.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `` key:value `` pairs.
Each map key must match the regular expression: `[a-z][-_0-9a-z]*`.
Each map value must match the regular expression: `[-_0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| network_id | **string**

ID of the network the route table belongs to.
The length must be less than or equal to 50.
This field is required. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.vpc.v1.StaticRoute)**

List of static routes. ||
|#

## StaticRoute {#yandex.cloud.vpc.v1.StaticRoute}

A StaticRoute resource. For more information, see [Static Routes](../../../concepts/routing.md).

#|
||Field | Description ||
|| destination_prefix | **string**

Destination subnet in CIDR notation

Includes only one of the fields `destination_prefix`. ||
|| next_hop_address | **string**

Next hop IP address

Includes only one of the fields `next_hop_address`, `gateway_id`. ||
|| gateway_id | **string**

Next hop gateway id

Includes only one of the fields `next_hop_address`, `gateway_id`. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#