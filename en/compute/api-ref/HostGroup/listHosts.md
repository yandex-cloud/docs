---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method listHosts
Lists hosts that belongs to the specified host group.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/hostGroups/{hostGroupId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
hostGroupId | Required. ID of the host group to list hosts for. To get the host group ID, use [list](/docs/compute/api-ref/HostGroup/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/compute/api-ref/HostGroup/listHosts#query_params), the service returns a [nextPageToken](/docs/compute/api-ref/HostGroup/listHosts#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/compute/api-ref/HostGroup/listHosts#query_params) to the [nextPageToken](/docs/compute/api-ref/HostGroup/listHosts#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "id": "string",
      "status": "string",
      "serverId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>Represents a dedicated host</p> 
hosts[].<br>id | **string**<br><p>ID of the host.</p> 
hosts[].<br>status | **string**<br><p>Current status of the host. New instances are unable to start on host in DOWN status.</p> 
hosts[].<br>serverId | **string**<br><p>ID of the physical server that the host belongs to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is more than <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/HostGroup/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/HostGroup/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 