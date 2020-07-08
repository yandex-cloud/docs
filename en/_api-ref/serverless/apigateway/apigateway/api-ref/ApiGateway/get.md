---
editable: false
---

# Method get
Returns the specified api-gateway. Note that only api-gateway basic attributes are returned.
To get associated openapi specification, make a [getOpenapiSpec](/docs/functions/apigateway/api-ref/ApiGateway/getOpenapiSpec) request.
 
To get the list of all available api-gateways, make a [list](/docs/functions/apigateway/api-ref/ApiGateway/list) request.
 
## HTTP request {#https-request}
```
GET https://serverless-apigateway.api.cloud.yandex.net/apigateways/v1/apigateways/{apiGatewayId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
apiGatewayId | Required. ID of the api-gateway to return.  To get a api-gateway ID make a [list](/docs/functions/apigateway/api-ref/ApiGateway/list) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "domain": "string",
  "logGroupId": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the api-gateway. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the api-gateway belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the api-gateway.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the api-gateway. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the api-gateway.</p> 
labels | **object**<br><p>Api-gateway labels as <code>key:value</code> pairs.</p> 
status | **string**<br><p>Status of the api-gateway.</p> <ul> <li>CREATING: Api-gateway is being created.</li> <li>ACTIVE: Api-gateway is ready for use.</li> <li>DELETING: Api-gateway is being deleted.</li> <li>ERROR: Api-gateway failed. The only allowed action is delete.</li> </ul> 
domain | **string**<br><p>Default domain for the api-gateway. Generated at creation time.</p> 
logGroupId | **string**<br><p>ID of the log group for the api-gateway.</p> 