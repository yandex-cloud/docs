---
editable: false
---

# Managed Service for YDB API, REST: Location.list
Returns the list of available locations.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/locations
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than ``page_size``, the service returns a ``next_page_token`` that can be used to get the next page of results in subsequent ListLocations requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. Set ``page_token`` to the ``next_page_token`` returned by a previous ListLocations request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "locations": [
    {
      "id": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
locations[] | **object**<br><p>Requested list of locations.</p> 
locations[].<br>id | **string**
locations[].<br>description | **string**
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListLocations requests, if the number of results is larger than ``page_size`` specified in the request. To get the next page, specify the value of ``next_page_token`` as a value for the ``page_token`` parameter in the next ListLocations request. Subsequent ListLocations requests will have their own ``next_page_token`` to continue paging through the results.</p> 