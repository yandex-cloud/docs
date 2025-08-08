---
editable: false
apiPlayground:
  - url: https://apigateway-connections.{{ api-host }}/apigateways/websocket/v1/connections/{connectionId}
    method: delete
    path:
      type: object
      properties:
        connectionId:
          description: |-
            **string**
            Required field. ID of the connection to disconnect.
          type: string
      required:
        - connectionId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/Connection/disconnect.md
---

# API Gateway WebSocket Connection Service, REST: Connection.Disconnect

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