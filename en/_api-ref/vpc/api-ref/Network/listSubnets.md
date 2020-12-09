---
editable: false
---

# Method listSubnets
Lists subnets from the specified network.
 

 
## HTTP request {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/networks/{networkId}/subnets
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkId | Required. ID of the Network resource to list subnets for.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than [pageSize](/docs/vpc/api-ref/Network/listSubnets#query_params), the service returns a [nextPageToken](/docs/vpc/api-ref/Network/listSubnets#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set [pageToken](/docs/vpc/api-ref/Network/listSubnets#query_params) to the [nextPageToken](/docs/vpc/api-ref/Network/listSubnets#responses) returned by a previous list request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "subnets": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "networkId": "string",
      "zoneId": "string",
      "v4CidrBlocks": [
        "string"
      ],
      "v6CidrBlocks": [
        "string"
      ],
      "routeTableId": "string",
      "dhcpOptions": {
        "domainNameServers": [
          "string"
        ],
        "domainName": "string",
        "ntpServers": [
          "string"
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
subnets[] | **object**<br><p>A Subnet resource. For more information, see <a href="/docs/vpc/concepts/subnets">Subnets</a>.</p> 
subnets[].<br>id | **string**<br><p>ID of the subnet.</p> 
subnets[].<br>folderId | **string**<br><p>ID of the folder that the subnet belongs to.</p> 
subnets[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
subnets[].<br>name | **string**<br><p>Name of the subnet. The name is unique within the project. 3-63 characters long.</p> 
subnets[].<br>description | **string**<br><p>Optional description of the subnet. 0-256 characters long.</p> 
subnets[].<br>labels | **object**<br><p>Resource labels as `` key:value `` pairs. Мaximum of 64 per resource.</p> 
subnets[].<br>networkId | **string**<br><p>ID of the network the subnet belongs to.</p> 
subnets[].<br>zoneId | **string**<br><p>ID of the availability zone where the subnet resides.</p> 
subnets[].<br>v4CidrBlocks[] | **string**<br><p>CIDR block. The range of internal addresses that are defined for this subnet. This field can be set only at Subnet resource creation time and cannot be changed. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16.</p> 
subnets[].<br>v6CidrBlocks[] | **string**<br><p>IPv6 not available yet.</p> 
subnets[].<br>routeTableId | **string**<br><p>ID of route table the subnet is linked to.</p> 
subnets[].<br>dhcpOptions | **object**<br>
subnets[].<br>dhcpOptions.<br>domainNameServers[] | **string**<br>
subnets[].<br>dhcpOptions.<br>domainName | **string**<br>
subnets[].<br>dhcpOptions.<br>ntpServers[] | **string**<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/vpc/api-ref/Network/listSubnets#query_params">pageSize</a>, use the <a href="/docs/vpc/api-ref/Network/listSubnets#responses">nextPageToken</a> as the value for the <a href="/docs/vpc/api-ref/Network/listSubnets#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/vpc/api-ref/Network/listSubnets#responses">nextPageToken</a> to continue paging through the results.</p> 