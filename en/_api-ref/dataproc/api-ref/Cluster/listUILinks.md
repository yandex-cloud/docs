---
editable: false
---

# Method listUILinks
Retrieves a list of links to web interfaces being proxied by Data Proc UI Proxy.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/ui_links
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Hadoop cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "links": [
    {
      "name": "string",
      "url": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
links[] | **object**<br><p>Requested list of ui links.</p> 
links[].<br>name | **string**
links[].<br>url | **string**