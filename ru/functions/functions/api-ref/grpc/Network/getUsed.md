---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Network/getUsed.md
---

# Cloud Functions Service, gRPC: NetworkService.GetUsed

Returns the specified network used in serverless resources.

## gRPC request

**rpc GetUsed ([GetUsedNetworkRequest](#yandex.cloud.serverless.functions.v1.GetUsedNetworkRequest)) returns ([UsedNetwork](#yandex.cloud.serverless.functions.v1.UsedNetwork))**

## GetUsedNetworkRequest {#yandex.cloud.serverless.functions.v1.GetUsedNetworkRequest}

```json
{
  "network_id": "string"
}
```

#|
||Field | Description ||
|| network_id | **string**

Required field. ID of the network to return. ||
|#

## UsedNetwork {#yandex.cloud.serverless.functions.v1.UsedNetwork}

```json
{
  "network_id": "string",
  "cloud_id": "string",
  "folder_id": "string",
  "status": "Status",
  "will_be_cleaned_up_at": "google.protobuf.Timestamp",
  "connections_count": "int64"
}
```

A VPC network used in serverless resources.

#|
||Field | Description ||
|| network_id | **string**

ID of the VPC network. ||
|| cloud_id | **string**

ID of the cloud that the network belongs to. ||
|| folder_id | **string**

ID of the folder that the network belongs to. ||
|| status | enum **Status**

Status of the network.

- `STATUS_UNSPECIFIED`
- `CREATING`: Network is connecting to its first serverless resource.
- `ACTIVE`: Network is already being used by some serverless resources.
- `OBSOLETE`: Network is no longer used by any serverless resources.
It will be cleaned-up after a while. ||
|| will_be_cleaned_up_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Clean-up timestamp of the obsolete network. ||
|| connections_count | **int64**

Number of serverless resources connected to the network. ||
|#