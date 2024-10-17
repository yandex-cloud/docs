---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Network/getUsed.md
---

# Cloud Functions Service, gRPC: NetworkService.GetUsed {#GetUsed}

Returns the specified network used in serverless resources.

## gRPC request

**rpc GetUsed ([GetUsedNetworkRequest](#yandex.cloud.serverless.functions.v1.GetUsedNetworkRequest)) returns ([UsedNetwork](#yandex.cloud.serverless.functions.v1.UsedNetwork))**

## GetUsedNetworkRequest {#yandex.cloud.serverless.functions.v1.GetUsedNetworkRequest}

```json
{
  "networkId": "string"
}
```

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network to return. ||
|#

## UsedNetwork {#yandex.cloud.serverless.functions.v1.UsedNetwork}

```json
{
  "networkId": "string",
  "cloudId": "string",
  "folderId": "string",
  "status": "Status",
  "willBeCleanedUpAt": "google.protobuf.Timestamp",
  "connectionsCount": "int64"
}
```

A VPC network used in serverless resources.

#|
||Field | Description ||
|| networkId | **string**

ID of the VPC network. ||
|| cloudId | **string**

ID of the cloud that the network belongs to. ||
|| folderId | **string**

ID of the folder that the network belongs to. ||
|| status | enum **Status**

Status of the network.

- `STATUS_UNSPECIFIED`
- `CREATING`: Network is connecting to its first serverless resource.
- `ACTIVE`: Network is already being used by some serverless resources.
- `OBSOLETE`: Network is no longer used by any serverless resources.
It will be cleaned-up after a while. ||
|| willBeCleanedUpAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Clean-up timestamp of the obsolete network. ||
|| connectionsCount | **int64**

Number of serverless resources connected to the network. ||
|#