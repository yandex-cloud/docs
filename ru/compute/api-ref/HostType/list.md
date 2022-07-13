---
editable: false
sourcePath: en/_api-ref/compute/api-ref/HostType/list.md
---

# Method list
List avaliable host types.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/hostTypes
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/HostType/list#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/HostType/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/HostType/list#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/HostType/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hostTypes": [
    {
      "id": "string",
      "cores": "string",
      "memory": "string",
      "disks": "string",
      "diskSize": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hostTypes[] | **object**<br><p>Lists host types.</p> 
hostTypes[].<br>id | **string**<br><p>Unique type identifier.</p> 
hostTypes[].<br>cores | **string** (int64)<br><p>Total number of cores available for instances.</p> 
hostTypes[].<br>memory | **string** (int64)<br><p>Ammount of memory available for instances.</p> 
hostTypes[].<br>disks | **string** (int64)<br><p>Number of local disks available for instances</p> 
hostTypes[].<br>diskSize | **string** (int64)<br><p>Size of each local disk</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/compute/api-ref/HostType/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/compute/api-ref/HostType/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 