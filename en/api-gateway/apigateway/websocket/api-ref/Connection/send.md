---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/websocket/apigateway/websocket/api-ref/Connection/send.md
---

# API Gateway WebSocket Connection Service, REST: Connection.send
Sends data to the specified connection.
 

 
## HTTP request {#https-request}
```
POST https://apigateway-connections.{{ api-host }}/apigateways/websocket/v1/connections/{connectionId}:send
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
connectionId | <p>Required. ID of the connection to which send.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "data": "string",
  "type": "string"
}
```

 
Field | Description
--- | ---
data | **string** (byte)<br><p>Required. Data to send.</p> <p>The maximum string length in characters is 131072.</p> 
type | **string**<br><p>Type of the sending data.</p> <ul> <li>BINARY: Binary data.</li> <li>TEXT: Text data.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**



