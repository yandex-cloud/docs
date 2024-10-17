---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/Connection/disconnect.md
---

# API Gateway WebSocket Connection Service, REST: Connection.Disconnect {#Disconnect}

Disconnects the specified connection.

## HTTP request

```
DELETE https://apigateway-connections.{{ api-host }}/apigateways/websocket/v1/connections/{connectionId}
```

## Path parameters

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to disconnect. ||
|#

## Response {#yandex.cloud.serverless.apigateway.websocket.v1.DisconnectResponse}

**HTTP Code: 200 - OK**