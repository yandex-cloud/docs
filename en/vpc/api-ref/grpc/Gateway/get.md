---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Gateway/get.md
---

# Virtual Private Cloud API, gRPC: GatewayService.Get

Returns the specified Gateway resource.

To get the list of all available Gateway resources, make a [List](/docs/vpc/api-ref/grpc/Gateway/list#List) request.

## gRPC request

**rpc Get ([GetGatewayRequest](#yandex.cloud.vpc.v1.GetGatewayRequest)) returns ([Gateway](#yandex.cloud.vpc.v1.Gateway))**

## GetGatewayRequest {#yandex.cloud.vpc.v1.GetGatewayRequest}

```json
{
  "gateway_id": "string"
}
```

#|
||Field | Description ||
|| gateway_id | **string**

Required field. ID of the Gateway resource to return.

To get Gateway resource ID make a [GatewayService.List](/docs/vpc/api-ref/grpc/Gateway/list#List) request. ||
|#

## Gateway {#yandex.cloud.vpc.v1.Gateway}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  // Includes only one of the fields `shared_egress_gateway`
  "shared_egress_gateway": "SharedEgressGateway"
  // end of the list of possible fields
}
```

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
|| labels | **string**

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