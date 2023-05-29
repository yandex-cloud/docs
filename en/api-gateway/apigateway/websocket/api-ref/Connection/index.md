---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/Connection/index.md
---

# API Gateway WebSocket Connection Service, REST: Connection methods
A set of methods for managing API Gateway WebSocket connections.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "gatewayId": "string",
  "identity": {
    "sourceIp": "string",
    "userAgent": "string"
  },
  "connectedAt": "string",
  "lastActiveAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the connection.</p> 
gatewayId | **string**<br><p>ID of the API Gateway.</p> 
identity | **object**<br><p>The information about the caller making the request to API Gateway.</p> 
identity.<br>sourceIp | **string**<br><p>The source IP address of the caller making the request to API Gateway.</p> 
identity.<br>userAgent | **string**<br><p>The User Agent of the caller making the request to API Gateway.</p> 
connectedAt | **string** (date-time)<br><p>The timestamp at which connection was established.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
lastActiveAt | **string** (date-time)<br><p>The timestamp at which connection was last accessed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 

## Methods {#methods}
Method | Description
--- | ---
[disconnect](disconnect.md) | Disconnects the specified connection.
[get](get.md) | Returns the specified connection info.
[send](send.md) | Sends data to the specified connection.