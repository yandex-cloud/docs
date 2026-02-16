---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Gateway/create.md
---

# Virtual Private Cloud API, gRPC: GatewayService.Create

Creates a gateway in the specified folder.

## gRPC request

**rpc Create ([CreateGatewayRequest](#yandex.cloud.vpc.v1.CreateGatewayRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateGatewayRequest {#yandex.cloud.vpc.v1.CreateGatewayRequest}

```json
{
  "folder_id": "string",
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
|| folder_id | **string**

Required field. ID of the folder to create a gateway in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the gateway.
The name must be unique within the folder. ||
|| description | **string**

Description of the gateway. ||
|| labels | **object** (map<**string**, **string**>)

Gateway labels as `key:value` pairs. ||
|| shared_egress_gateway_spec | **[SharedEgressGatewaySpec](#yandex.cloud.vpc.v1.SharedEgressGatewaySpec)**

Includes only one of the fields `shared_egress_gateway_spec`.

Gateway configuration specification ||
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
  "metadata": {
    "gateway_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    // Includes only one of the fields `shared_egress_gateway`
    "shared_egress_gateway": "SharedEgressGateway"
    // end of the list of possible fields
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
|| metadata | **[CreateGatewayMetadata](#yandex.cloud.vpc.v1.CreateGatewayMetadata)**

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
|| response | **[Gateway](#yandex.cloud.vpc.v1.Gateway)**

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

## CreateGatewayMetadata {#yandex.cloud.vpc.v1.CreateGatewayMetadata}

#|
||Field | Description ||
|| gateway_id | **string**

ID of the gateway that is being created. ||
|#

## Gateway {#yandex.cloud.vpc.v1.Gateway}

A Gateway resource. For more information, see [Gateway](/docs/vpc/concepts/gateways).

#|
||Field | Description ||
|| id | **string**

ID of the gateway. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the gateway belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the gateway.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``. ||
|| description | **string**

Description of the gateway. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Gateway labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_./\\@0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_./\\@0-9a-z]*`. ||
|| shared_egress_gateway | **[SharedEgressGateway](#yandex.cloud.vpc.v1.SharedEgressGateway)**

Includes only one of the fields `shared_egress_gateway`.

Gateway specification ||
|#

## SharedEgressGateway {#yandex.cloud.vpc.v1.SharedEgressGateway}

Shared Egress Gateway configuration

#|
||Field | Description ||
|| Empty | > ||
|#