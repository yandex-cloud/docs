---
editable: false
---

# Method get
Returns the specified Network resource.
 
Get the list of available Network resources by making a [list](/docs/vpc/api-ref/Network/list) request.
 
## HTTP request {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/networks/{networkId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkId | Required. ID of the Network resource to return. To get the network ID, use a [list](/docs/vpc/api-ref/Network/list) request.  The maximum string length in characters is 50.
 
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
  "defaultSecurityGroupId": "string"
}
```
A Network resource. For more information, see [Networks](/docs/vpc/concepts/network).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the network.</p> 
folderId | **string**<br><p>ID of the folder that the network belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the network. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the network. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as `` key:value `` pairs. Мaximum of 64 per resource.</p> 
defaultSecurityGroupId | **string**<br><p>ID of default security group for network.</p> 