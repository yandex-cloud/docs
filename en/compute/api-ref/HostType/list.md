---
editable: false
---

# Method list
List avaliable host types.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/hostTypes
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/compute/api-ref/HostType/list#query_params), the service returns a [nextPageToken](/docs/compute/api-ref/HostType/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/compute/api-ref/HostType/list#query_params) to the [nextPageToken](/docs/compute/api-ref/HostType/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hostTypes": [
    {
      "id": "string",
      "cores": "string",
      "memory": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hostTypes[] | **object**<br><p>Represents host resources. Note: Platform can use hosts with different number of memory and cores. TODO: Do we need sockets here?</p> 
hostTypes[].<br>id | **string**<br><p>Unique type identifier.</p> 
hostTypes[].<br>cores | **string** (int64)<br><p>Total number of cores available for instances.</p> 
hostTypes[].<br>memory | **string** (int64)<br><p>Ammount of memory available for instances.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/compute/api-ref/HostType/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/compute/api-ref/HostType/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 