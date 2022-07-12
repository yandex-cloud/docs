---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-clickhouse/v1/clusters/{clusterId}/formatSchemas
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum value is 1000.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "formatSchemas": [
    {
      "name": "string",
      "clusterId": "string",
      "type": "string",
      "uri": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
formatSchemas[] | **object**<br>
formatSchemas[].<br>name | **string**<br>
formatSchemas[].<br>clusterId | **string**<br>
formatSchemas[].<br>type | **string**<br>
formatSchemas[].<br>uri | **string**<br>
nextPageToken | **string**<br>