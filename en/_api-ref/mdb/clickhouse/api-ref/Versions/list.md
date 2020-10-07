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
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than [pageSize](/docs/managed-clickhouse/api-ref/Versions/list#query_params), the service returns a [nextPageToken](/docs/managed-clickhouse/api-ref/Versions/list#responses) that can be used to get the next page of results in subsequent ListVersions requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. Set [pageToken](/docs/managed-clickhouse/api-ref/Versions/list#query_params) to the [nextPageToken](/docs/managed-clickhouse/api-ref/Versions/list#responses) returned by a previous ListVersions request to get the next page of results.  The maximum string length in characters is 100.
 
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
version[].<br>id | **string**<br><p>ID of the version.</p> 
version[].<br>name | **string**<br><p>Name of the version.</p> 
version[].<br>deprecated | **boolean** (boolean)<br><p>Whether version is deprecated.</p> 
version[].<br>updatableTo[] | **string**<br><p>List of versions that can be updated from current.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListVersions requests, if the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/Versions/list#query_params">pageSize</a> specified in the request. To get the next page, specify the value of <a href="/docs/managed-clickhouse/api-ref/Versions/list#responses">nextPageToken</a> as a value for the <a href="/docs/managed-clickhouse/api-ref/Versions/list#query_params">pageToken</a> parameter in the next ListVerions request. Subsequent ListVersions requests will have their own <a href="/docs/managed-clickhouse/api-ref/Versions/list#responses">nextPageToken</a> to continue paging through the results.</p> 