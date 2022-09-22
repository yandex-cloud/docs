---
editable: false
---

# Connection
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
connectedAt | **string** (date-time)<br><p>The timestamp at which connection was established.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
lastActiveAt | **string** (date-time)<br><p>The timestamp at which connection was last accessed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[disconnect](disconnect.md) | Disconnects the specified connection.
[get](get.md) | Returns the specified connection info.
[send](send.md) | Sends data to the specified connection.