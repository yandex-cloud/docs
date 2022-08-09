---
editable: false
---

# Method list
Retrieves the list of RouteTable resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/routeTables
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder that the route table belongs to. To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/vpc/api-ref/RouteTable/list#query_params">pageSize</a>, the service returns a <a href="/docs/vpc/api-ref/RouteTable/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/vpc/api-ref/RouteTable/list#query_params">pageToken</a> to the <a href="/docs/vpc/api-ref/RouteTable/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/vpc/api-ref/RouteTable#representation">RouteTable.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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

          // `routeTables[].staticRoutes[]` includes only one of the fields `nextHopAddress`, `gatewayId`
          "nextHopAddress": "string",
          "gatewayId": "string",
          // end of the list of possible fields`routeTables[].staticRoutes[]`

        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
routeTables[] | **object**<br><p>List of RouteTable resources.</p> 
routeTables[].<br>id | **string**<br><p>ID of the route table.</p> 
routeTables[].<br>folderId | **string**<br><p>ID of the folder that the route table belongs to.</p> 
routeTables[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
routeTables[].<br>name | **string**<br><p>Name of the route table. The name is unique within the project. 3-63 characters long.</p> 
routeTables[].<br>description | **string**<br><p>Optional description of the route table. 0-256 characters long.</p> 
routeTables[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
routeTables[].<br>networkId | **string**<br><p>ID of the network the route table belongs to.</p> 
routeTables[].<br>staticRoutes[] | **object**<br><p>List of static routes.</p> 
routeTables[].<br>staticRoutes[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
routeTables[].<br>staticRoutes[].<br>destinationPrefix | **string**<br><p>Destination subnet in CIDR notation</p> 
routeTables[].<br>staticRoutes[].<br>nextHopAddress | **string** <br>`routeTables[].staticRoutes[]` includes only one of the fields `nextHopAddress`, `gatewayId`<br><br><p>Next hop IP address</p> 
routeTables[].<br>staticRoutes[].<br>gatewayId | **string** <br>`routeTables[].staticRoutes[]` includes only one of the fields `nextHopAddress`, `gatewayId`<br><br><p>Next hop gateway id</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/vpc/api-ref/RouteTable/list#query_params">pageSize</a>, use the <a href="/docs/vpc/api-ref/RouteTable/list#responses">nextPageToken</a> as the value for the <a href="/docs/vpc/api-ref/RouteTable/list#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/vpc/api-ref/RouteTable/list#responses">nextPageToken</a> to continue paging through the results.</p> 