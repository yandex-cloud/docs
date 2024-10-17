---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/Connection/send.md
---

# API Gateway WebSocket Connection Service, REST: Connection.Send {#Send}

Sends data to the specified connection.

## HTTP request

```
POST https://apigateway-connections.{{ api-host }}/apigateways/websocket/v1/connections/{connectionId}:send
```

## Path parameters

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to which send. ||
|#

## Body parameters {#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionRequest}

```json
{
  "data": "string",
  "type": "string"
}
```

#|
||Field | Description ||
|| data | **string** (bytes)

Required field. Data to send. ||
|| type | **enum** (DataType)

Type of the sending data.

- `DATA_TYPE_UNSPECIFIED`
- `BINARY`: Binary data.
- `TEXT`: Text data. ||
|#

## Response {#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionResponse}

**HTTP Code: 200 - OK**