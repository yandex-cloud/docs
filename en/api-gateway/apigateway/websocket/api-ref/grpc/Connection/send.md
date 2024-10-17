---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/grpc/Connection/send.md
---

# API Gateway WebSocket Connection Service, gRPC: ConnectionService.Send {#Send}

Sends data to the specified connection.

## gRPC request

**rpc Send ([SendToConnectionRequest](#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionRequest)) returns ([SendToConnectionResponse](#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionResponse))**

## SendToConnectionRequest {#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionRequest}

```json
{
  "connectionId": "string",
  "data": "bytes",
  "type": "DataType"
}
```

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to which send. ||
|| data | **bytes**

Required field. Data to send. ||
|| type | enum **DataType**

Type of the sending data.

- `DATA_TYPE_UNSPECIFIED`
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