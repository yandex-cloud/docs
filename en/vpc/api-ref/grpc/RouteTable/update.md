---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/RouteTable/update.md
---

# Virtual Private Cloud API, gRPC: RouteTableService.Update

Updates the specified route table.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Update ([UpdateRouteTableRequest](#yandex.cloud.vpc.v1.UpdateRouteTableRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateRouteTableRequest {#yandex.cloud.vpc.v1.UpdateRouteTableRequest}

```json
{
  "route_table_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "static_routes": [
    {
      // Includes only one of the fields `destination_prefix`
      "destination_prefix": "string",
      // end of the list of possible fields
      // Includes only one of the fields `next_hop_address`, `gateway_id`
      "next_hop_address": "string",
      "gateway_id": "string",
      // end of the list of possible fields
      "labels": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| route_table_id | **string**

Required field. ID of the RouteTable resource to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the RouteTable resource are going to be updated. ||
|| name | **string**

Name of the route table.
The name must be unique within the folder. ||
|| description | **string**

Description of the route table. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.vpc.v1.StaticRoute)**

List of static routes. ||
|#

## StaticRoute {#yandex.cloud.vpc.v1.StaticRoute}

A StaticRoute resource. For more information, see [Static Routes](/docs/vpc/concepts/routing).

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
|| labels | **string**

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
  "metadata": {
    "route_table_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
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
        "labels": "string"
      }
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

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
|| metadata | **[UpdateRouteTableMetadata](#yandex.cloud.vpc.v1.UpdateRouteTableMetadata)**

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
|| response | **[RouteTable](#yandex.cloud.vpc.v1.RouteTable)**

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

## UpdateRouteTableMetadata {#yandex.cloud.vpc.v1.UpdateRouteTableMetadata}

#|
||Field | Description ||
|| route_table_id | **string**

ID of the RouteTable resource that is being updated. ||
|#

## RouteTable {#yandex.cloud.vpc.v1.RouteTable}

A RouteTable resource. For more information, see [Static Routes](/docs/vpc/concepts/routing).

#|
||Field | Description ||
|| id | **string**

ID of the route table. ||
|| folder_id | **string**

ID of the folder that the route table belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the route table.
The name must be unique within the folder.
Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`. ||
|| description | **string**

Optional description of the route table. 0-256 characters long. ||
|| labels | **string**

Resource labels, `key:value` pairs.
No more than 64 per resource.
The string length in characters for each key must be 1-63.
Each value must match the regular expression `[-_0-9a-z]*`.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| network_id | **string**

ID of the network the route table belongs to. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.vpc.v1.StaticRoute2)**

List of static routes. ||
|#

## StaticRoute {#yandex.cloud.vpc.v1.StaticRoute2}

A StaticRoute resource. For more information, see [Static Routes](/docs/vpc/concepts/routing).

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
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#