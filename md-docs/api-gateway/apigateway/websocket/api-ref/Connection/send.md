# API Gateway WebSocket Connection Service, REST: Connection.Send

Sends data to the specified connection.

## HTTP request

```
POST https://apigateway-connections.api.cloud.yandex.net/apigateways/websocket/v1/connections/{connectionId}:send
```

## Path parameters

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to which send.

The maximum string length in characters is 50. ||
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

Required field. Data to send.

The maximum string length in characters is 131072. ||
|| type | **enum** (DataType)

Type of the sending data.

- `BINARY`: Binary data.
- `TEXT`: Text data. ||
|#

## Response {#yandex.cloud.serverless.apigateway.websocket.v1.SendToConnectionResponse}

**HTTP Code: 200 - OK**