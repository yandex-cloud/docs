---
editable: false
sourcePath: en/_api-ref/vpc/api-ref/RouteTable/index.md
---

# RouteTable
A set of methods for managing RouteTable resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "staticRoutes": [
    {
      "labels": "object",
      "destinationPrefix": "string",
      "nextHopAddress": "string"
    }
  ]
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the route table.</p> 
folderId | **string**<br><p>ID of the folder that the route table belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the route table. The name is unique within the project. 3-63 characters long.</p> 
description | **string**<br><p>Optional description of the route table. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
networkId | **string**<br><p>ID of the network the route table belongs to.</p> 
staticRoutes[] | **object**<br><p>List of static routes.</p> 
staticRoutes[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
staticRoutes[].<br>destinationPrefix | **string**<br><p>Destination subnet in CIDR notation</p> 
staticRoutes[].<br>nextHopAddress | **string**<br><p>Next hop IP address</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a route table in the specified folder and network. Method starts an asynchronous operation that can be cancelled while it is in progress.
[delete](delete.md) | Deletes the specified route table.
[get](get.md) | Returns the specified RouteTable resource.
[list](list.md) | Retrieves the list of RouteTable resources in the specified folder.
[listOperations](listOperations.md) | List operations for the specified route table.
[move](move.md) | Move route table to another folder.
[update](update.md) | Updates the specified route table. Method starts an asynchronous operation that can be cancelled while it is in progress.