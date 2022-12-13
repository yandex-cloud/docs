---
editable: false
sourcePath: en/_api-ref/vpc/api-ref/Network/get.md
---

# Virtual Private Cloud API, REST: Network.get
Returns the specified Network resource.
 
Get the list of available Network resources by making a [list](/docs/vpc/api-ref/Network/list) request.
 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkId | <p>Required. ID of the Network resource to return. To get the network ID, use a <a href="/docs/vpc/api-ref/Network/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the network. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the network. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
defaultSecurityGroupId | **string**<br><p>ID of default security group for network.</p> 