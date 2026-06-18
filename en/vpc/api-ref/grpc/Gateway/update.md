---
editable: false
---

# Virtual Private Cloud API, gRPC: GatewayService.Update

Updates the specified gateway.

## gRPC request

**rpc Update ([UpdateGatewayRequest](#yandex.cloud.vpc.v1.UpdateGatewayRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateGatewayRequest {#yandex.cloud.vpc.v1.UpdateGatewayRequest}

```json
{
  "gateway_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  // Includes only one of the fields `shared_egress_gateway_spec`
  "shared_egress_gateway_spec": "SharedEgressGatewaySpec"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| gateway_id | **string**

ID of the gateway to update.
To get the gateway ID make a [GatewayService.List](/docs/vpc/api-ref/grpc/Gateway/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the Gateway should be updated. ||
|| name | **string**

New name for the gateway.
The name must be unique within the folder.
The value must match the regular expression: ```|[a-z]([-a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

New description of the gateway.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Gateway labels as `key:value` pairs.
Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [GatewayService.Get](/docs/vpc/api-ref/grpc/Gateway/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| shared_egress_gateway_spec | **[SharedEgressGatewaySpec](#yandex.cloud.vpc.v1.SharedEgressGatewaySpec)**

Includes only one of the fields `shared_egress_gateway_spec`.

New Gateway configuration specification ||
|#

## SharedEgressGatewaySpec {#yandex.cloud.vpc.v1.SharedEgressGatewaySpec}

#|
||Field | Description ||
|| Empty | > ||
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