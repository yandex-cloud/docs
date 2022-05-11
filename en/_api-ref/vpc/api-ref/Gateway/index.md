---
editable: false
---

# Gateway

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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
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