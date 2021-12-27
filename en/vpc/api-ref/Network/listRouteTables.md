---
editable: false
sourcePath: en/_api-ref/vpc/api-ref/Network/listRouteTables.md
---


# Method listRouteTables
Lists route tables from the specified network.
 

 
## HTTP request {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/networks/{networkId}/route_tables
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkId | Required. ID of the Network resource to list route tables for.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than [pageSize](/docs/vpc/api-ref/Network/listRouteTables#query_params), the service returns a [nextPageToken](/docs/vpc/api-ref/Network/listRouteTables#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set [pageToken](/docs/vpc/api-ref/Network/listRouteTables#query_params) to the [nextPageToken](/docs/vpc/api-ref/Network/listRouteTables#responses) returned by a previous list request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "routeTables": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
routeTables[] | **object**<br><p>A RouteTable resource. For more information, see <a href="/docs/vpc/concepts/static-routes">Static Routes</a>.</p> 
routeTables[].<br>id | **string**<br><p>ID of the route table.</p> 
routeTables[].<br>folderId | **string**<br><p>ID of the folder that the route table belongs to.</p> 
routeTables[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
routeTables[].<br>name | **string**<br><p>Name of the route table. The name is unique within the project. 3-63 characters long.</p> 
routeTables[].<br>description | **string**<br><p>Optional description of the route table. 0-256 characters long.</p> 
routeTables[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
routeTables[].<br>networkId | **string**<br><p>ID of the network the route table belongs to.</p> 
routeTables[].<br>staticRoutes[] | **object**<br><p>A StaticRoute resource. For more information, see <a href="/docs/vpc/concepts/static-routes">Static Routes</a>.</p> 
routeTables[].<br>staticRoutes[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
routeTables[].<br>staticRoutes[].<br>destinationPrefix | **string**<br><p>Destination subnet in CIDR notation</p> 
routeTables[].<br>staticRoutes[].<br>nextHopAddress | **string**<br><p>Next hop IP address</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/vpc/api-ref/Network/listRouteTables#query_params">pageSize</a>, use the <a href="/docs/vpc/api-ref/Network/listRouteTables#responses">nextPageToken</a> as the value for the <a href="/docs/vpc/api-ref/Network/listRouteTables#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/vpc/api-ref/Network/listRouteTables#responses">nextPageToken</a> to continue paging through the results.</p> 