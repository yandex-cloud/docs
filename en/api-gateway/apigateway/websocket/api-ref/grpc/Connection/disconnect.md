---
editable: false
---

# API Gateway WebSocket Connection Service, gRPC: ConnectionService.Disconnect

Disconnects the specified connection.

## gRPC request

**rpc Disconnect ([DisconnectRequest](#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectRequest)) returns ([DisconnectResponse](#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectResponse))**

## DisconnectRequest {#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectRequest}

```json
{
  "connection_id": "string"
}
```

#|
||Field | Description ||
|| connection_id | **string**

Required field. ID of the connection to disconnect.

The maximum string length in characters is 50. ||
|#

## DisconnectResponse {#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#