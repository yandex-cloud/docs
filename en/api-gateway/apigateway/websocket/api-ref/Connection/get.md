---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/websocket/apigateway/websocket/api-ref/Connection/get.md
---

# Method get
Returns the specified connection info.
 

 
## HTTP request {#https-request}
```
GET https://apigateway-connections.{{ api-host }}/apigateways/websocket/v1/connections/{connectionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
connectionId | <p>Required. ID of the connection to get.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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