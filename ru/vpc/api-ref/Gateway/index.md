---
editable: false
sourcePath: en/_api-ref/vpc/api-ref/Gateway/index.md
---

# Virtual Private Cloud API, REST: Gateway methods

## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the gateway. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the gateway belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the gateway. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the gateway.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
sharedEgressGateway | **object**<br><p>Shared Egress Gateway configuration</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a gateway in the specified folder.
[delete](delete.md) | Deletes the specified gateway.
[get](get.md) | Returns the specified Gateway resource.
[list](list.md) | Retrieves the list of Gateway resources in the specified folder.
[listOperations](listOperations.md) | List operations for the specified gateway.
[move](move.md) | Move a gateway to another folder
[update](update.md) | Updates the specified gateway.