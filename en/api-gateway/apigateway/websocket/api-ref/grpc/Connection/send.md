---
editable: false
---

# API Gateway WebSocket Connection Service, gRPC: ConnectionService.Send

Sends data to the specified connection.

## gRPC request

**rpc Send ([SendToConnectionRequest](#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionRequest)) returns ([SendToConnectionResponse](#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionResponse))**

## SendToConnectionRequest {#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionRequest}

```json
{
  "connection_id": "string",
  "data": "bytes",
  "type": "DataType"
}
```

#|
||Field | Description ||
|| connection_id | **string**

Required field. ID of the connection to which send.

The maximum string length in characters is 50. ||
|| data | **bytes**

Required field. Data to send.

The maximum string length in characters is 131072. ||
|| type | enum **DataType**

Type of the sending data.

- `BINARY`: Binary data.
- `TEXT`: Text data. ||
|#

## SendToConnectionResponse {#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#