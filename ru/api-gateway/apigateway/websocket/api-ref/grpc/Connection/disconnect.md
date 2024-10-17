---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/grpc/Connection/disconnect.md
---

# API Gateway WebSocket Connection Service, gRPC: ConnectionService.Disconnect {#Disconnect}

Disconnects the specified connection.

## gRPC request

**rpc Disconnect ([DisconnectRequest](#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectRequest)) returns ([DisconnectResponse](#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectResponse))**

## DisconnectRequest {#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectRequest}

```json
{
  "connectionId": "string"
}
```

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to disconnect. ||
|#

## DisconnectResponse {#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#