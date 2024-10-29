---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/grpc/Connection/get.md
---

# API Gateway WebSocket Connection Service, gRPC: ConnectionService.Get {#Get}

Returns the specified connection info.

## gRPC request

**rpc Get ([GetConnectionRequest](#yandex.cloud.serverless.apigateway.websocket.v1.GetConnectionRequest)) returns ([Connection](#yandex.cloud.serverless.apigateway.websocket.v1.Connection))**

## GetConnectionRequest {#yandex.cloud.serverless.apigateway.websocket.v1.GetConnectionRequest}

```json
{
  "connectionId": "string"
}
```

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to get. ||
|#

## Connection {#yandex.cloud.serverless.apigateway.websocket.v1.Connection}

```json
{
  "id": "string",
  "gatewayId": "string",
  "identity": {
    "sourceIp": "string",
    "userAgent": "string"
  },
  "connectedAt": "google.protobuf.Timestamp",
  "lastActiveAt": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the connection. ||
|| gatewayId | **string**

ID of the API Gateway. ||
|| identity | **[Identity](#yandex.cloud.serverless.apigateway.websocket.v1.Identity)**

The information about the caller making the request to API Gateway. ||
|| connectedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp at which connection was established. ||
|| lastActiveAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp at which connection was last accessed. ||
|#

## Identity {#yandex.cloud.serverless.apigateway.websocket.v1.Identity}

#|
||Field | Description ||
|| sourceIp | **string**

The source IP address of the caller making the request to API Gateway. ||
|| userAgent | **string**

The User Agent of the caller making the request to API Gateway. ||
|#