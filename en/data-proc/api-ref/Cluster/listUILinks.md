---
editable: false
sourcePath: en/_api-ref/dataproc/api-ref/Cluster/listUILinks.md
---


# Method listUILinks
Retrieves a list of links to web interfaces being proxied by Data Proc UI Proxy.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/ui_links
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Hadoop cluster.  The maximum string length in characters is 50.
 
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
links[].<br>name | **string**<br>
links[].<br>url | **string**<br>