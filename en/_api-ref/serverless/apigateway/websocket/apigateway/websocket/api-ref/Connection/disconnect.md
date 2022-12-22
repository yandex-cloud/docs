---
editable: false
---

# API Gateway WebSocket Connection Service, REST: Connection.disconnect
Disconnects the specified connection.
 

 
## HTTP request {#https-request}
```
DELETE https://apigateway-connections.{{ api-host }}/apigateways/websocket/v1/connections/{connectionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
connectionId | <p>Required. ID of the connection to disconnect.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{}
```

 
Field | Description
--- | ---