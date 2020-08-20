---
editable: false
---

# Method list
Returns list of available ClickHouse versions.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/versions
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListVersions requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListVersions request to get the next page of results.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "version": [
    {
      "id": "string",
      "name": "string",
      "deprecated": true,
      "updatableTo": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
version[] | **object**<br><p>Requested list of available versions.</p> 
version[].<br>id | **string**<br><p>Version ID</p> 
version[].<br>name | **string**<br><p>Version name</p> 
version[].<br>deprecated | **boolean** (boolean)<br><p>Is version deprecated</p> 
version[].<br>updatableTo[] | **string**<br><p>List of versions that can be updated from current</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListVersions requests, if the number of results is larger than <code>page_size</code> specified in the request. To get the next page, specify the value of <code>next_page_token</code> as a value for the <code>page_token</code> parameter in the next ListVerions request. Subsequent ListVersions requests will have their own <code>next_page_token</code> to continue paging through the results.</p> 