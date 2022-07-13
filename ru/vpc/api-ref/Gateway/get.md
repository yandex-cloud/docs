---
editable: false
sourcePath: en/_api-ref/vpc/api-ref/Gateway/get.md
---

# Method get
Returns the specified Gateway resource.
 
To get the list of all available Gateway resources, make a [list](/docs/vpc/api-ref/Gateway/list) request.
 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/gateways/{gatewayId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
gatewayId | <p>Required. ID of the Gateway resource to return.</p> <p>To get Gateway resource ID make a <a href="/docs/vpc/api-ref/Gateway/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "sharedEgressGateway": {}
}
```
A Gateway resource. For more information, see [Gateway](/docs/vpc/concepts/gateway).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the gateway. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the gateway belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the gateway. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the gateway.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
sharedEgressGateway | **object**<br><p>Shared Egress Gateway configuration</p> 