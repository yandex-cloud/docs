---
editable: false
sourcePath: en/_api-ref/vpc/api-ref/RouteTable/get.md
---

# Method get
Returns the specified RouteTable resource.
 
To get the list of available RouteTable resources, make a [list](/docs/vpc/api-ref/RouteTable/list) request.
 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/routeTables/{routeTableId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
routeTableId | <p>Required. ID of the RouteTable resource to return. To get the route table ID use a <a href="/docs/vpc/api-ref/RouteTable/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
A RouteTable resource. For more information, see [Static Routes](/docs/vpc/concepts/static-routes).
 
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