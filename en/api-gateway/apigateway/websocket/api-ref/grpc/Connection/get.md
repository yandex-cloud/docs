---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/grpc/Connection/get.md
---

# API Gateway WebSocket Connection Service, gRPC: ConnectionService.Get

Returns the specified connection info.

## gRPC request

**rpc Get ([GetConnectionRequest](#yandex.cloud.serverless.apigateway.websocket.v1.GetConnectionRequest)) returns ([Connection](#yandex.cloud.serverless.apigateway.websocket.v1.Connection))**

## GetConnectionRequest {#yandex.cloud.serverless.apigateway.websocket.v1.GetConnectionRequest}

```json
{
  "connection_id": "string"
}
```

#|
||Field | Description ||
|| connection_id | **string**

Required field. ID of the connection to get. ||
|#

## Connection {#yandex.cloud.serverless.apigateway.websocket.v1.Connection}

```json
{
  "id": "string",
  "gateway_id": "string",
  "identity": {
    "source_ip": "string",
    "user_agent": "string"
  },
  "connected_at": "google.protobuf.Timestamp",
  "last_active_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the connection. ||
|| gateway_id | **string**

ID of the API Gateway. ||
|| identity | **[Identity](#yandex.cloud.serverless.apigateway.websocket.v1.Identity)**

The information about the caller making the request to API Gateway. ||
|| connected_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp at which connection was established. ||
|| last_active_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The timestamp at which connection was last accessed. ||
|#

## Identity {#yandex.cloud.serverless.apigateway.websocket.v1.Identity}

#|
||Field | Description ||
|| source_ip | **string**

The source IP address of the caller making the request to API Gateway. ||
|| user_agent | **string**

The User Agent of the caller making the request to API Gateway. ||
|#