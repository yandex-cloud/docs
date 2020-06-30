---
editable: false
---

# ApiGateway

## JSON Representation {#representation}
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates an api-gateway in the specified folder.
[delete](delete.md) | Deletes the specified api-gateway.
[get](get.md) | Returns the specified api-gateway. Note that only api-gateway basic attributes are returned. To get associated openapi specification, make a [getOpenapiSpec](/docs/functions/apigateway/api-ref/ApiGateway/getOpenapiSpec) request.
[getOpenapiSpec](getOpenapiSpec.md) | Returns the Openapi specification of specified api-gateway.
[list](list.md) | Retrieves the list of api-gateways in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified api-gateway.
[listOperations](listOperations.md) | Lists operations for the specified api-gateway.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified api-gateway.
[update](update.md) | Updates the specified api-gateway.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified api-gateway.